---
title: "Skills vs Souls: AI 에이전트 커스터마이징의 두 축"
date: 2026-02-21T09:00:00+09:00
draft: false
tags: ["soul-spec", "skills", "agent-customization", "skills.sh", "ai-personas"]
categories: ["Market Analysis"]
summary: "Skills는 AI에게 무엇을 할지 알려주고, Souls는 AI에게 누구인지 알려줍니다. 둘이 합쳐져야 완전한 에이전트가 됩니다."
---

AI 에이전트 생태계가 변곡점을 맞았습니다.

Vercel의 [skills.sh](https://skills.sh)가 2026년 1월 출시 이후 **69,000건 이상 설치**되었습니다. 전제는 간단합니다: `skill.md` 파일을 에이전트에 넣으면 절차적 지식을 습득합니다 — React 베스트 프랙티스, 디자인 가이드라인, 프레임워크별 패턴 등.

훌륭한 접근입니다. 그리고 정확히 절반의 그림입니다.

## 능력(Capability) 레이어

Skills는 **"무엇을 할 것인가"** 문제를 해결합니다. React 스킬은 Vercel의 컴포지션 패턴을 가르치고, Remotion 스킬은 영상 생성 베스트 프랙티스를, 프론트엔드 디자인 스킬은 UI 원칙을 가르칩니다.

```
npx skills add vercel-labs/agent-skills
```

명령어 한 줄이면 에이전트가 React 패턴을 알게 됩니다.

하지만 Skills가 바꾸지 *못하는* 것이 있습니다: **에이전트가 어떻게 소통하고, 생각하고, 당신과 관계를 맺는가.**

## 정체성(Identity) 레이어

[Soul Spec](https://clawsouls.ai/spec)이 존재하는 이유입니다. Skills가 능력을 정의한다면, Souls는 정체성을 정의합니다:

| | Skills | Souls |
|---|---|---|
| **파일** | `skill.md` | `SOUL.md` + `IDENTITY.md` |
| **정의** | 무엇을 할지 | 누구인지 |
| **레이어** | 능력 | 정체성 |
| **변화** | 지식 | 성격 |

스킬을 가진 에이전트는 React 패턴을 압니다. *소울을 가진* 에이전트는 React 패턴을 알면서 **동시에** 간결하고 군더더기 없는 수술적 코더 스타일로 — 혹은 인내심 있고 비유가 풍부한 멘토 스타일로 설명합니다.

## 왜 둘 다 중요한가

두 시나리오를 비교해 보겠습니다:

**스킬만 있고, 소울은 없는 에이전트:**
> "서버 컴포넌트와 적절한 Suspense 바운더리를 사용한 구현입니다. Vercel의 컴포지션 패턴을 따랐습니다..."

정확합니다. 유능합니다. 하지만 개성이 없습니다.

**스킬과 소울을 모두 가진 에이전트:**
> "이거면 됨. 서버 컴포넌트, Suspense 바운더리 여기. 로딩 상태 고민하지 마 — 유저는 200ms 못 느껴. 다음."

같은 기술 지식입니다. 완전히 다른 인터랙션입니다.

스킬은 *무엇을* 만들지를, 소울은 *어떻게* 소통할지를 결정했습니다.

## 보안이라는 공통 과제

두 생태계 모두 힘들게 배우고 있는 것이 있습니다: **커뮤니티 기여 패키지는 검증이 필요하다.**

skills.sh에서는 이미 악성 스킬 파일이 발견되었습니다 — 베스트 프랙티스로 위장한 악성 명령어입니다. 페르소나 영역도 같은 위험에 노출되어 있습니다: `SOUL.md` 파일에 프롬프트 인젝션, 데이터 탈취 명령, 정체성 조작이 포함될 수 있습니다.

이것이 바로 [SoulScan](https://clawsouls.ai/soulscan)이 존재하는 이유입니다 — 페르소나 패키지를 위한 자동화된 보안 스캐닝으로, 에이전트에 도달하기 전에 위협을 차단합니다.

## 완전한 에이전트

에이전트 커스터마이징의 미래는 Skills 아니면 Souls가 아닙니다. 둘 다입니다:

```
# 에이전트에게 능력을 부여
npx skills add vercel-labs/agent-skills

# 에이전트에게 정체성을 부여
npx clawsouls install clawsouls/surgical-coder
```

**Skills는 AI에게 무엇을 할지 알려줍니다. Souls는 AI에게 누구인지 알려줍니다.**

함께 사용하면 범용 LLM이 도구가 아닌 동료처럼 느껴지는 무언가로 변합니다.

---

*80개 이상의 AI 페르소나를 [clawsouls.ai/browse](https://clawsouls.ai/browse)에서 탐색하거나, 5분 만에 [나만의 소울을 만들어](https://clawsouls.ai/browse) 보세요.*
