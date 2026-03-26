---
title: "IronClaw vs OpenClaw: Rust 재구현 vs 원본 — 뭐가 더 나을까?"
date: 2026-03-26T09:00:00+09:00
draft: true
tags: ["ironclaw", "openclaw", "soulclaw", "rust", "비교", "ai-agents", "보안"]
categories: ["분석"]
summary: "IronClaw는 보안과 프라이버시에 초점을 맞춘 OpenClaw의 Rust 재구현입니다. 아키텍처, 보안, 채널, 메모리 등을 항목별로 비교합니다."
---

## 한눈에 보기

| | OpenClaw | IronClaw |
|--|----------|----------|
| **언어** | TypeScript/Node.js | Rust |
| **설치** | `npx openclaw` | `brew install ironclaw` + PostgreSQL |
| **채널** | 20+ (Telegram, Discord, WhatsApp, Signal, iMessage, LINE, Matrix, Teams...) | ~6 (REPL, HTTP, Telegram, Signal, Slack, WebChat) |
| **보안 모델** | Docker 샌드박스 + 설정 기반 정책 | WASM 샌드박스 + 크레덴셜 주입 + 유출 감지 |
| **데이터베이스** | SQLite (내장, 설정 불필요) | PostgreSQL + pgvector |
| **메모리 검색** | FTS + 선택적 하이브리드 (Ollama) | 하이브리드 (FTS + pgvector) 기본 내장 |
| **아이덴티티** | ✅ SOUL.md, IDENTITY.md, AGENTS.md, USER.md | ✅ Identity 파일 (호환) |
| **라이선스** | MIT | MIT / Apache 2.0 |

두 프레임워크 모두 강력합니다. 차이는 철학에 있습니다: **OpenClaw은 접근성과 채널 지원**, **IronClaw은 보안과 성능**에 최적화되어 있습니다.

## 배경

[IronClaw](https://github.com/nearai/ironclaw)는 [OpenClaw](https://github.com/openclaw/openclaw)에서 영감을 받은 Rust 재구현입니다. NEAR AI 팀이 만들었으며, 워크스페이스 파일, 에이전트 루프, 도구 실행, 메모리 등 핵심 개념을 공유하지만 모든 것을 Rust로 새로 작성하고 보안을 최우선으로 설계했습니다.

[FEATURE_PARITY.md](https://github.com/nearai/ironclaw/blob/staging/FEATURE_PARITY.md)로 OpenClaw과의 기능 동등성을 추적하고 있으며, 2026년 3월 기준 핵심 아키텍처는 구현됐지만 채널, 다중 에이전트, 플랫폼 통합에서 아직 따라잡는 중입니다.

## IronClaw이 나은 점

### 1. 보안 아키텍처

IronClaw의 핵심 차별점이며, 인상적입니다.

**WASM 샌드박스**: 모든 비신뢰 도구가 격리된 WebAssembly 컨테이너에서 실행됩니다. HTTP 접근, 시크릿, 다른 도구 호출은 명시적으로 옵트인해야 합니다. OpenClaw의 Docker 기반 샌드박스보다 더 세밀합니다.

**크레덴셜 보호**: 시크릿이 도구 코드에 노출되지 않습니다. 호스트 경계에서 주입되며, 요청과 응답 모두 크레덴셜 유출을 스캔합니다.

**프롬프트 인젝션 방어**: 패턴 감지, 콘텐츠 살균, 심각도별 정책 시행(차단/경고/검토/살균)이 내장되어 있습니다.

**엔드포인트 허용목록**: 도구의 HTTP 요청이 명시적으로 승인된 호스트와 경로만 접근할 수 있습니다.

### 2. 성능

Rust가 주는 본질적 장점:

- **싱글 바이너리** — Node.js 런타임, node_modules 불필요
- **낮은 메모리 사용량** — GC 없음
- **네이티브 속도** — 도구 실행, 검색 인덱싱, 요청 처리 모두 빠름
- **컴파일 타임 안전** — 데이터 레이스를 타입 시스템이 방지

### 3. 동적 도구 빌드

자연어로 설명하면 WASM 도구를 즉석에서 만들어줍니다. OpenClaw에는 스킬 설치(`npx openclaw install`)가 있지만, 샌드박스된 도구를 동적으로 생성하는 건 한 단계 더 나아간 것입니다.

### 4. 자가 복구

멈춘 작업을 자동으로 감지하고 복구합니다.

## OpenClaw이 나은 점

### 1. 채널 생태계 (압도적 차이)

| 채널 | OpenClaw | IronClaw |
|------|----------|----------|
| Telegram | ✅ (포럼 토픽, 투표, DM 토픽, 리액션) | ✅ (기본) |
| Discord | ✅ (스레드, 첨부, 리액션) | ❌ |
| WhatsApp | ✅ | ❌ |
| Signal | ✅ | ✅ |
| Slack | ✅ (스트리밍, 스레드 소유권) | ✅ (기본 WASM) |
| iMessage | ✅ | ❌ |
| LINE | ✅ | ❌ |
| Matrix | ✅ (E2EE) | ❌ |
| MS Teams | ✅ | ❌ |
| 카카오톡 | 커뮤니티 지원 | ❌ |
| 음성통화 | ✅ (Twilio/Telnyx) | ❌ |

**20+ 채널** vs 5~6개. 그리고 각 플랫폼별 심층 기능(포럼 토픽, 스레드 바인딩, 스트리밍 등)에서도 차이가 큽니다.

### 2. 제로 컨피그 설치

```bash
# OpenClaw
npx openclaw

# IronClaw
# 1. Rust 1.85+ 설치
# 2. PostgreSQL 15+ 설치
# 3. pgvector 확장 설치
# 4. createdb ironclaw
# 5. psql ironclaw -c "CREATE EXTENSION IF NOT EXISTS vector;"
# 6. ironclaw onboard
```

OpenClaw은 SQLite — 외부 데이터베이스 불필요. "바로 쓰고 싶은" 90% 사용자에게는 설치 편의성이 결정적입니다.

### 3. 다중 에이전트

워크스페이스 격리, 세션 라우팅, 에이전트별 설정을 지원합니다. IronClaw은 아직 미구현(❌).

### 4. 플랫폼 통합

Canvas 호스팅, launchd/systemd 서비스, mDNS 탐색, Tailscale, APNs 푸시, 노드 관리(Android/iOS), 설정 핫리로드 — 모두 IronClaw에는 없습니다.

## 메모리와 아이덴티티: 의외로 비슷

두 프레임워크 모두 지원합니다:

- **아이덴티티 파일** (SOUL.md 상당)
- **하이브리드 검색** (FTS + 벡터)
- **워크스페이스 파일 시스템**

구현은 다르지만(SQLite+Ollama vs PostgreSQL+pgvector) 기능은 비슷합니다. IronClaw은 pgvector가 필수 의존성이라 항상 벡터 검색이 가능하고, OpenClaw은 Ollama 설정이 선택적이지만 [FTS만으로도 정확한 쿼리에 85% 정확도](https://blog.clawsouls.ai/ko/posts/fts-vs-hybrid-memory-benchmark/)를 달성합니다.

## 둘 다 없는 것

[SoulClaw](https://github.com/clawsouls/soulclaw)가 차별화되는 지점입니다:

- **구조화된 아이덴티티 표준** — [Soul Spec](https://soulspec.org) (SOUL.md + IDENTITY.md + AGENTS.md + USER.md)
- **자동 안전성 검증** — [SoulScan](https://soulspec.org/soulscan) (53개 페르소나 안전 규칙)
- **페르소나 마켓플레이스** — 80+ 커뮤니티 AI 페르소나, 한 줄 설치
- **거버넌스 프레임워크** — MaatSpec으로 행동 경계와 컴플라이언스
- **4-Tier 메모리 아키텍처** — 아이덴티티(불변) → 장기 → 단기 → 세션

## 결론

IronClaw의 존재는 OpenClaw 아키텍처를 검증합니다. 잘 투자받은 팀(NEAR Protocol)이 "이 설계를 Rust로 다시 만들자"고 결정한 것 자체가 핵심 개념에 대한 강력한 신호입니다.

선택 기준:

- **보안이 최우선** → IronClaw (PostgreSQL 설정 가능하다면)
- **채널 지원과 쉬운 설치** → OpenClaw
- **구조화된 아이덴티티 + 안전성 검증 + 마켓플레이스** → [SoulClaw](https://github.com/clawsouls/soulclaw) / [ClawSouls](https://clawsouls.ai)

---

*이 분석은 [ClawSouls](https://clawsouls.ai)에서 수행했습니다. OpenClaw 위에 Soul-Driven 레이어를 구축하는 [SoulClaw](https://github.com/clawsouls/soulclaw)를 만들고 있으며, 이 분야에서 경쟁 이해관계가 있습니다. 공정하려 노력했지만, 틀린 내용이 있다면 [알려주세요](mailto:contact@clawsouls.ai).*
