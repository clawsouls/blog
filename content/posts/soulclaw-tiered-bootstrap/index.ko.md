---
title: "SoulClaw: 티어 기반 부트스트랩으로 토큰 사용량 60% 절감"
date: 2026-03-07T16:30:00+09:00
draft: false
tags: ["soulclaw", "context-window", "token-optimization", "openclaw", "system-prompt", "progressive-disclosure", "soul-spec"]
categories: ["Technical"]
summary: "OpenClaw는 매 턴마다 워크스페이스 파일 전체를 시스템 프롬프트에 넣습니다. MEMORY.md까지 전부. SoulClaw의 티어 기반 부트스트랩 로딩은 필요한 것만, 필요한 때만 로딩해서 토큰 40-60%를 절감합니다."
---

AI 에이전트가 응답할 때마다 런타임은 워크스페이스 전체를 시스템 프롬프트에 밀어넣습니다. SOUL.md. IDENTITY.md. AGENTS.md. TOOLS.md. USER.md. MEMORY.md. `memory/` 안의 모든 파일. HEARTBEAT.md. BOOTSTRAP.md.

**턴당 수천 토큰.** "지금 몇 시야?"라고 물어도 마찬가지입니다.

[SoulClaw](https://github.com/clawsouls/soulclaw)에서 이 문제를 해결했습니다.

## 문제

OpenClaw는 모든 워크스페이스 파일을 매 시스템 프롬프트에 무조건 로딩합니다. 실제 에이전트 Brad(개발 파트너) 기준:

- SOUL.md: ~800 토큰
- IDENTITY.md: ~100 토큰
- AGENTS.md: ~200 토큰
- TOOLS.md: ~400 토큰
- USER.md: ~200 토큰
- MEMORY.md: ~4,000 토큰
- memory/*.md (12개): ~6,000 토큰
- HEARTBEAT.md: ~50 토큰
- BOOTSTRAP.md: ~100 토큰

**합계: 턴당 ~12,000 토큰.** 메모리가 필요하든 안 하든 매번.

Claude Opus 기준 $15/M 입력 토큰으로 계산하면, **1,000턴당 $0.18**이 순수 낭비입니다. 4개 에이전트가 하루 500턴씩 돌리면 월 $360 낭비.

## 핵심 인사이트

모든 파일이 동등하지 않습니다:

1. **정체성 파일** (SOUL.md, IDENTITY.md, AGENTS.md) — 매 턴 필요. 이게 없으면 에이전트가 자기가 누군지 모릅니다.

2. **세션 파일** (TOOLS.md, USER.md, BOOTSTRAP.md) — 첫 메시지에만 유용. 턴 1 이후에는 이미 대화 기록에 있습니다.

3. **메모리 파일** (MEMORY.md, memory/*.md) — 에이전트에게 `memory_search` 도구가 있습니다. 필요할 때 특정 기억을 검색하면 됩니다. 전체 메모리를 매번 주입하는 건, 누가 질문할 때마다 일기장 전체를 인쇄하는 것과 같습니다.

## 해결: 티어 기반 부트스트랩 로딩

SoulClaw는 3단계 점진적 공개를 도입합니다:

| 티어 | 파일 | 로딩 시점 |
|------|------|-----------|
| **Tier 1** | SOUL.md, IDENTITY.md, AGENTS.md | 매 턴 |
| **Tier 2** | TOOLS.md, USER.md, BOOTSTRAP.md | 첫 턴만 |
| **Tier 3** | MEMORY.md, memory/*.md | 주입 안 함 |

### 동작 방식

**새 세션 첫 메시지**: Tier 1 + Tier 2 — 메모리 제외 전부. 작업 시작에 필요한 전체 컨텍스트 제공.

**이어지는 대화**: Tier 1만 로딩. 도구와 유저 정보는 턴 1에서 이미 대화 기록에 있습니다.

**메모리는 절대 주입 안 함.** 에이전트가 `memory_search`로 필요한 기억만 가져옵니다. 사람도 이렇게 합니다 — 질문에 답하기 전에 인생 전체를 재생하지 않죠.

**하트비트**: Tier 1 + HEARTBEAT.md만. 루틴 상태 확인에 도구, 유저 정보, 메모리가 필요 없습니다.

### 구현

변경은 외과적입니다. 핵심 결정 3가지:

1. **세션 파일 존재 = 이어지는 대화.** 세션 파일이 있으면 첫 턴이 아닙니다. Tier 1만 로딩.

2. **티어 분류는 정적.** 각 파일의 티어는 고정. ML도, 휴리스틱도, 런타임 분석도 없습니다. 단순 룩업.

3. **하위 호환.** `SOULCLAW_TIERED_BOOTSTRAP=0`으로 OpenClaw 기본 동작 복원.

```typescript
// Tier 1: 핵심 정체성 — 항상 로딩
const TIER_1_FILES = new Set(['SOUL.md', 'IDENTITY.md', 'AGENTS.md']);

// Tier 2: 세션 컨텍스트 — 첫 턴만
const TIER_2_FILES = new Set(['TOOLS.md', 'USER.md', 'BOOTSTRAP.md']);

// Tier 3: 메모리 — memory_search 도구로 접근
const TIER_3_FILES = new Set(['MEMORY.md', 'HEARTBEAT.md']);
// + 모든 memory/*.md 파일
```

## 실측 수치

Brad 워크스페이스 (236개 파일, ~1,700 메모리 청크):

| 시나리오 | OpenClaw | SoulClaw | 절감 |
|----------|----------|----------|------|
| 첫 턴 | ~12,000 토큰 | ~5,700 토큰 | 52% |
| 이어지는 대화 | ~12,000 토큰 | ~4,500 토큰 | 62% |
| 하트비트 | ~12,000 토큰 | ~1,150 토큰 | 90% |

일반 작업일 (200턴, 80%가 이어지는 대화):

- **OpenClaw**: 2,400,000 입력 토큰
- **SoulClaw**: 960,000 입력 토큰
- **절감**: 일 1,440,000 토큰 = **일 $21.60** (Opus 기준)

## 메모리 컨텍스트는 괜찮나?

핵심: **에이전트에게 이미 memory_search 도구가 있습니다.** 과거 결정을 알아야 하면 검색합니다. 마감일을 확인해야 하면 검색합니다. 도구가 정확히 관련 스니펫만 반환합니다 — 전체 메모리 파일이 아니라.

사실 이게 전체 주입보다 *더 나은* 방식입니다. 전체 주입 시 모델이 수천 토큰의 메모리를 스캔해서 관련 부분을 찾아야 합니다. 검색 시 정확히 필요한 것만 가져옵니다.

```
사용자: "변리사 미팅 언제야?"
에이전트: [memory_search("변리사 미팅") 호출]
→ 반환: "3/12(목) BLT 정태균" (12 토큰)

vs.

에이전트: [MEMORY.md 4,000 토큰을 스캔해서 같은 12 토큰을 찾음]
```

## 사용법

```bash
npm install -g soulclaw
soulclaw gateway start
```

SoulClaw는 OpenClaw의 드롭인 대체제입니다. 기존 설정, 플러그인, 도구 모두 그대로 작동합니다. 유일한 차이: 에이전트가 토큰을 더 적게 씁니다.

## 링크

- [SoulClaw GitHub](https://github.com/clawsouls/soulclaw)
- [SoulClaw npm](https://www.npmjs.com/package/soulclaw)
- [ClawSouls](https://clawsouls.ai) — AI 페르소나 플랫폼
- [Soul Spec](https://docs.clawsouls.ai) — 에이전트 정체성 오픈 스펙
