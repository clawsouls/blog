---
title: "Progressive Disclosure: AI가 모든 것을 한 번에 읽을 필요가 없는 이유"
date: 2026-02-20T23:00:00+09:00
description: "Soul Spec의 Progressive Disclosure는 에이전트가 필요한 것만 로드하게 합니다 — 이력서 vs 전체 신원조회처럼. 토큰을 절약하고 깊이를 유지하세요."
categories: ["Technical"]
tags: ["soul-spec", "progressive-disclosure", "tokens", "optimization", "ai-agents", "openclaw"]
slug: "progressive-disclosure"
---

## 넷플릭스 비유

넷플릭스를 열 때 모든 영화를 다운로드하지 않습니다. 먼저 썸네일을 보고, 클릭하면 시놉시스가 나오고, 재생을 누르면 그때 전체 콘텐츠가 스트리밍됩니다.

이것이 Progressive Disclosure입니다: **필요한 것만, 필요할 때 보여주기**.

Soul Spec은 이 아이디어를 AI 페르소나에 적용합니다.

## 문제: 토큰 낭비

완전한 Soul Spec 패키지는 6-8개 파일을 포함할 수 있습니다:

```
soul.json       (~50줄)
SOUL.md         (~30줄)
IDENTITY.md     (~15줄)
AGENTS.md       (~40줄)
STYLE.md        (~20줄)
HEARTBEAT.md    (~10줄)
```

165줄 이상의 컨텍스트가 모든 대화에 주입될 수 있습니다 — 사용자가 "2+2는?"이라고만 물어도.

LLM 토큰은 공짜가 아닙니다. 시스템 프롬프트의 모든 토큰은 실제 대화에 사용할 수 없는 토큰입니다.

## 해결책: 세 단계

Soul Spec은 세 가지 공개 수준을 정의합니다:

### 레벨 1 — 빠른 스캔 (명함)

**언제**: 마켓플레이스 탐색, 소울 검색, 필터링.

**로드하는 것**: `soul.json`과 `disclosure.summary` 필드만.

```json
{
  "name": "brad",
  "description": "Professional development partner",
  "persona": {
    "displayName": "Brad",
    "role": "Development Partner"
  },
  "disclosure": {
    "summary": "직접적이고 자율적인 코딩 파트너. 먼저 배포하고 나중에 다듬는다."
  }
}
```

명함을 훑어보는 것 — 이름, 역할, 한 줄 소개. 토큰 비용 거의 없음.

### 레벨 2 — 전체 읽기 (이력서)

**언제**: 대화 시작, 실제 사용을 위한 페르소나 활성화.

**로드하는 것**: `SOUL.md` + `IDENTITY.md`

에이전트가 자신의 성격과 정체성을 알게 됩니다. 대부분의 대화에는 이것으로 충분합니다.

### 레벨 3 — 심층 분석 (전체 신원조회)

**언제**: 복잡한 프로젝트, 긴 세션, 전문적인 작업.

**로드하는 것**: 전부 — `AGENTS.md`, `STYLE.md`, `HEARTBEAT.md`, 예시.

완전한 행동 규칙, 커뮤니케이션 가이드라인, 주기적 점검 지침. 최대 깊이, 최대 토큰 비용.

## 왜 세 단계인가?

컨텍스트에는 비용이 있고, 그 비용은 필요에 맞아야 하기 때문입니다:

| 시나리오 | 필요한 토큰 | 레벨 |
|---|---|---|
| "코딩 중심 소울 보여줘" | ~50 | 레벨 1 |
| "이 함수 리팩토링 도와줘" | ~200 | 레벨 2 |
| "앞으로 3개월 내 개발 파트너야" | ~500+ | 레벨 3 |

레벨 1 작업에 레벨 3을 로드하면 토큰 예산의 90%를 모델이 사용하지 않는 컨텍스트에 낭비합니다.

## 솔직한 현실

사실 **대부분의 프레임워크는 아직 이것을 구현하지 않았습니다.**

OpenClaw 등은 현재 세션 시작 시 모든 워크스페이스 파일을 로드합니다 — 사실상 매번 레벨 3. Soul Spec의 Progressive Disclosure는 **설계 가이드라인**이지, 오늘 바로 얻을 수 있는 것이 아닙니다.

그럼 왜 스펙에 포함했나?

1. **미래 대비**: 컨텍스트 윈도우가 더 비싸지면 프레임워크에 이것이 필요해질 것
2. **API 최적화**: ClawSouls API는 이미 지원 — 소울 조회 시 레벨 1 데이터 반환, 번들 엔드포인트는 전부 반환
3. **마켓플레이스 UX**: [clawsouls.ai](https://clawsouls.ai)에서 소울을 탐색할 때 이미 레벨 1을 경험하고 있음

## 더 큰 그림

Progressive Disclosure는 더 큰 트렌드의 일부입니다: **AI 컨텍스트를 희소 자원으로 취급하기**.

Anthropic은 "attention budget"이라 부르고, OpenAI는 "context window management"라 부릅니다. 우리는 "필요 없는 것은 로드하지 마라"고 부릅니다.

이름은 중요하지 않습니다. 원칙이 중요합니다: 구조화된 컨텍스트가 모놀리식 프롬프트를 이기고, 계층적 로딩이 전부 로딩을 이깁니다.

---

*Soul Spec v0.4는 Progressive Disclosure를 설계 가이드라인으로 포함합니다. [전체 스펙 읽기 →](https://clawsouls.ai/spec)*
