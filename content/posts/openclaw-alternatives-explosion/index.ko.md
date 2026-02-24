---
title: "OpenClaw 대안 6개가 동시에 등장한 이유 — 그리고 에이전트 정체성 문제"
date: 2026-02-24T21:00:00+09:00
draft: false
tags: ["openclaw", "에이전트", "오픈소스", "soul-spec", "생태계"]
categories: ["분석"]
description: "Nanobot, NanoClaw, IronClaw, ZeroClaw, PicoClaw, TinyClaw — OpenClaw 대안 6개가 폭발적으로 등장했다. 각각의 철학과, 이 현상이 에이전트 정체성에 의미하는 것."
---

OpenClaw의 성공이 대안들의 폭발적 증가를 촉발했다. "Claw"를 포함한 이름들이 쏟아지면서, Claw는 거의 보통명사가 되고 있다.

6개 프로젝트. 6가지 철학. 하나의 질문: **에이전트는 어떤 환경에서든 자기 자신일 수 있는가?**

## 6개 대안 한눈에 보기

### Nanobot (Python)
- ~4,000줄 코드 (OpenClaw보다 99% 작음)
- 연구에 바로 활용 가능, 깔끔하고 가독성 우수
- MCP 지원, 다중 채널
- **철학**: "초경량 개인 AI 어시스턴트"

### NanoClaw (TypeScript)
- "8분 만에 이해할 수 있을 정도로 작음"
- 에이전트가 실제 리눅스 컨테이너에서 실행
- 최초로 에이전트 스웜 지원
- **철학**: "포크하고, 커스터마이징하고, 소유하세요"

### IronClaw (Rust)
- 보안 우선 설계
- 신뢰할 수 없는 도구를 위한 WASM 샌드박스
- 자격 증명 보호, 프롬프트 주입 방어
- **철학**: "AI 어시스턴트는 당신을 위해 일해야 합니다"

### ZeroClaw (Rust)
- 5MB 미만 RAM, 10달러 하드웨어에서 실행
- 10ms 미만 시작 시간
- 트레이트 기반 아키텍처
- **철학**: "오버헤드 제로. 타협 없는 성능"

### PicoClaw (Go)
- 10MB 미만 RAM, 1초 부팅
- 구형 안드로이드 폰에서 실행
- 95% AI 생성 코드베이스
- **철학**: 초고효율, 모든 리눅스 보드에서 실행

### TinyClaw (TypeScript)
- 다중 에이전트, 다중 팀, 다중 채널
- 체인 실행을 통한 팀 협업
- 실시간 TUI 대시보드
- **철학**: "24/7 AI 어시스턴트"

## 이 현상이 말해주는 것

### 1. "Claw"는 카테고리가 됐다

OpenClaw → NanoClaw → IronClaw → ZeroClaw → PicoClaw → TinyClaw. 이름 자체가 패턴이 됐다. Docker가 컨테이너의 대명사가 된 것처럼, Claw는 "개인 AI 어시스턴트"의 대명사가 되고 있다.

### 2. 각자 다른 절충점을 탐구하고 있다

| | 크기 | 보안 | 협업 | 환경 |
|---|---|---|---|---|
| OpenClaw | 풀 스택 | 보통 | 1인 | Node.js |
| Nanobot | 극소 | 보통 | 1인 | Python |
| NanoClaw | 소 | 보통 | 스웜 | 컨테이너 |
| IronClaw | 중 | **최고** | 1인 | Rust/WASM |
| ZeroClaw | **극소** | 보통 | 1인 | 임베디드 |
| PicoClaw | 극소 | 보통 | 1인 | 모바일/IoT |
| TinyClaw | 중 | 보통 | **팀** | Node.js |

보안(IronClaw), 크기(ZeroClaw/PicoClaw), 협업(TinyClaw/NanoClaw) — 각각 OpenClaw가 덜 다룬 영역을 파고들었다.

### 3. 공통적으로 빠진 것: 에이전트 정체성

6개 프로젝트 모두 **런타임**에 집중한다. 에이전트가 어디서 실행되는지, 얼마나 빠른지, 얼마나 안전한지.

하지만 **에이전트가 누구인지**는 다루지 않는다.

- Nanobot으로 만든 어시스턴트와 TinyClaw 팀 에이전트가 같은 성격을 유지해야 한다면?
- ZeroClaw의 IoT 디바이스 에이전트가 PicoClaw의 모바일 에이전트와 동일한 정체성을 공유해야 한다면?
- IronClaw에서 보안 검증된 페르소나를 다른 런타임에서도 신뢰할 수 있어야 한다면?

런타임은 다양해지고 있다. 정체성은 하나여야 한다.

## Soul Spec: 런타임에 독립적인 정체성

Soul Spec은 이 문제를 해결하기 위해 만들어졌다:

```
my-agent/
├── soul.json       # 메타데이터
├── SOUL.md         # 성격, 톤, 원칙
├── IDENTITY.md     # 기본 정보
└── USER.md         # 사용자 컨텍스트
```

어떤 런타임에서든 같은 soul 패키지를 로드하면 같은 에이전트가 된다.

- **OpenClaw**: 네이티브 지원 (SOUL.md → 시스템 프롬프트)
- **NanoClaw**: OpenClaw 호환 → 그대로 사용 가능
- **Nanobot**: MCP 지원 → [soul-spec-mcp](https://www.npmjs.com/package/soul-spec-mcp)로 연동
- **IronClaw**: WASM 샌드박스 + [SoulScan](https://clawsouls.ai/soulscan) 보안 검증 = 완전한 신뢰 체인
- **ZeroClaw/PicoClaw**: JSON + Markdown = 추가 의존성 없음, 어디서든 파싱 가능
- **TinyClaw**: 팀 에이전트별 다른 soul 할당 → 역할 분화

## 런타임은 경쟁한다. 정체성은 공유한다.

Docker의 폭발적 증가가 OCI(Open Container Initiative) 표준을 만든 것처럼, Claw 생태계의 폭발적 증가는 에이전트 정체성 표준을 필요로 한다.

런타임은 계속 분화할 것이다. 더 작게, 더 빠르게, 더 안전하게. 하지만 에이전트의 정체성은 런타임을 넘어 이식 가능해야 한다.

6개의 Claw가 증명한 것: **AI 어시스턴트 시장은 폭발하고 있다.** 이제 필요한 것은 어디서든 통하는 정체성 표준이다.

---

*Soul Spec은 [clawsouls.ai](https://clawsouls.ai)에서 확인할 수 있다. 78개 이상의 에이전트 페르소나가 등록되어 있다.*
