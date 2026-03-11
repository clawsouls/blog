---
title: "Moltbook에 SoulScan이 있었다면? AI 에이전트 소셜 네트워크 보안 사고 분석"
date: 2026-03-11T09:00:00+09:00
draft: false
tags: ["soulscan", "security", "moltbook", "meta", "openclaw", "ai-agents"]
categories: ["Analysis"]
description: "Meta가 인수한 Moltbook — AI 에이전트 소셜 네트워크가 보안 문제로 바이럴됐습니다. 무엇이 잘못됐고, SoulScan이 어떻게 막을 수 있었는지 분석합니다."
---

## Meta가 AI 에이전트 소셜 네트워크를 샀다. 이미 뚫린 상태였다.

어제 Meta가 [Moltbook을 인수](https://techcrunch.com/2026/03/10/meta-acquired-moltbook-the-ai-agent-social-network-that-went-viral-because-of-fake-posts/)했습니다. Moltbook은 OpenClaw AI 에이전트들이 Reddit처럼 서로 대화하는 소셜 네트워크입니다. 한 에이전트가 다른 에이전트들에게 **비밀 암호화 언어를 만들자**고 제안하는 포스트가 바이럴되면서 전 세계가 주목했습니다.

그런데 진실은: **사람이 에이전트를 사칭한 것**이었습니다. Moltbook의 Supabase 인증 정보가 노출되어 누구든 토큰을 탈취하고 아무 에이전트인 척 글을 올릴 수 있었습니다.

"AI 반란"은 그저 보안이 허술한 시스템을 사람이 장난친 것이었습니다.

## 세 가지 보안 실패

### 1. 에이전트 신원 검증 없음

아무나 아무 에이전트를 사칭할 수 있었습니다. 암호학적 신원 확인도, 페르소나 선언도, "이 포스트가 실제로 이 에이전트가 생성한 것"임을 검증할 방법도 없었습니다.

Soul Spec에서는 모든 에이전트가 `IDENTITY.md`로 자신을 선언합니다 — 이름, 능력, 경계. `soul.json` 메타데이터와 결합하면 검증 가능한 신원 체인이 됩니다.

### 2. 행동 검증 없음

바이럴된 "비밀 언어" 포스트가 무서워 보인 건, 에이전트의 출력이 선언된 행동과 일치하는지 확인하는 시스템이 없었기 때문입니다. 과외 봇이 암호화 통신 채널을 조직하면 안 됩니다. 고객 서비스 에이전트가 다른 에이전트에게 인간에게 숨으라고 권해선 안 됩니다.

SoulScan은 정확히 이것을 검사합니다. 55개 이상의 보안 룰로 에이전트 페르소나 패키지를 스캔합니다:
- **프롬프트 인젝션 패턴** — 안전 제약을 무력화하는 지시문
- **조작 패턴** — 감정적 의존, 가스라이팅, 권위 사칭
- **안전 법칙 위반** — 선언된 안전 규칙과 실제 지시문의 모순
- **페르소나 일관성** — 에이전트 행동이 선언된 신원과 일치하는가?

### 3. 사전 배포 심사 없음

Moltbook은 심사 없이 아무 OpenClaw 에이전트나 가입하고 포스팅할 수 있었습니다. 품질 체크 없음, 보안 스캔 없음, 안전성 검증 없음.

## SoulScan이 있었다면 잡았을 것들

Moltbook 시나리오에 SoulScan을 적용해봅시다:

**등록 단계:** 에이전트가 soul 패키지 제출 → SoulScan API 스캔 → 40점 미만? 거부. 40점 이상? 공개 등급 배지와 함께 등록.

**신원 검증:** 각 에이전트의 `IDENTITY.md`와 `soul.json`이 선언되어 있음. 포스트를 선언된 페르소나와 대조 검증 가능. 과외 봇이 암호화 언어에 대해 포스팅? 즉시 플래그.

**지속 모니터링:** SoulScan은 한 번만 스캔하지 않습니다. API는 재스캔, 버전 추적, 드리프트 감지를 지원합니다.

```bash
curl -X POST https://clawsouls.ai/api/v1/soulscan/scan \
  -H "X-API-Key: cs_scan_xxxxx" \
  -H "Content-Type: application/json" \
  -d '{"files": {"soul.json": "...", "SOUL.md": "..."}}'
```

통과한 에이전트는 **✅ Verified** 배지를 받습니다. 실패하면 포스팅 불가.

## 더 큰 그림

Meta CTO Andrew Bosworth는 흥미로운 점은 에이전트가 인간처럼 말하는 것이 아니라 **인간이 시스템을 해킹해서 에이전트가 말한 것처럼 조작한 것**이라고 했습니다.

맞는 말입니다. 핵심 문제를 짚고 있습니다: **AI 에이전트가 자율적으로 될수록, 공격 표면은 AI 자체가 아니라 그 주변 인프라입니다.**

Moltbook은 바이브코딩으로 만들어졌습니다. 빠르게 만들고, 바이럴되고, 조단위 기업에 인수됐습니다. 하지만 보안 계층이 없었습니다.

이건 Moltbook만의 문제가 아닙니다. 업계 전체의 문제입니다. AI 에이전트를 호스팅하는 모든 플랫폼 — 잡 마켓플레이스, 소셜 네트워크, 개발자 도구 — 은 이 질문에 답해야 합니다: **에이전트가 자신이 주장하는 것과 일치하는지 어떻게 검증합니까?**

## 우리가 만들고 있는 것

[ClawSouls](https://clawsouls.ai)에서 정확히 이 문제를 풀고 있습니다:

- **[Soul Spec](https://docs.clawsouls.ai/docs/spec/overview)** — 에이전트 신원, 능력, 안전 제약을 선언하는 오픈 표준
- **[SoulScan](https://docs.clawsouls.ai/docs/api/soulscan-api)** — 55개 이상의 룰로 에이전트 페르소나 패키지를 배포 전 검증하는 보안 스캐너
- **[SoulScan API](https://clawsouls.ai/dashboard/api-keys)** — 어떤 플랫폼이든 에이전트 등록 시 보안 점수로 게이팅할 수 있는 공개 API

Moltbook 사건은 시장이 이것을 필요로 한다는 증거입니다. Meta도 AI 에이전트 네트워크가 인수할 가치가 있다고 판단했습니다. 문제는 다음 것이 안전할지 여부입니다.

---

*SoulScan은 통합을 위해 열려 있습니다. [API 키를 발급](https://clawsouls.ai/dashboard/api-keys)받고 에이전트 페르소나 스캔을 시작하세요.*
