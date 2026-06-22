---
title: "OpenAI Dreaming V3 vs Soul Memory — 같은 가설, 다른 베팅"
date: 2026-06-08T09:59:00+09:00
description: "OpenAI가 어제 발표한 Dreaming V3는 자동 메모리 합성을 무료 사용자까지 확장합니다. Soul Memory와 같은 가설을 출발점으로 삼지만, 결정적 두 지점에서 정반대 베팅을 합니다 — 원시 로그 vs 합성, 단일 벤더 vs 다중 런타임. 우리의 3주 controlled 실험 데이터로 그 차이가 무엇을 의미하는지 살펴봅니다."
categories: ["Analysis"]
tags: ["openai", "dreaming-v3", "soul-spec", "memory", "ai-agents", "open-standard", "persona", "soul-memory"]
author: "ClawSouls"
draft: true
---

OpenAI가 2026년 6월 5일 **Dreaming V3**를 발표했습니다. 무료 사용자까지 확장된 자동 메모리 합성 시스템입니다. 발표 자료는 세 가지 기둥을 강조합니다: 영속적 컨텍스트(Persistent Context), 선호 준수(Preference Compliance), 시간적 이해(Temporal Understanding).

우리가 6개월 전부터 [**Soul Spec**](https://docs.clawsouls.ai/docs/intro)과 [**Soul Memory**](https://docs.clawsouls.ai/docs/platform/soul-memory)로 출발한 가설과 정확히 같습니다. 두 가지는 서로 다른 레이어입니다. **Soul Spec**은 페르소나를 정의하는 오픈 명세로, 다섯 개의 canonical 마크다운 파일(`SOUL`·`IDENTITY`·`AGENTS`·`STYLE`·`HEARTBEAT`)과 버전 관리되는 `soul.json` 매니페스트로 이루어집니다. **Soul Memory**는 그 위에서 경험을 보존하는 4계층 적응형 메모리 아키텍처입니다 — T0 SOUL(정체성, 불변) / T1 Core(상시, 감쇠 없음) / T2 Working(일별 로그, 23일 반감기 시간 감쇠) / T3 Session(휘발성). OpenAI가 말하는 영속적 컨텍스트·선호 준수·시간적 이해는 정확히 이 Soul Spec(누구인가) + Soul Memory(무엇을 기억하는가)의 조합에 대응됩니다.

같은 가설을 두 주체가 동시에 검증했다는 것은 좋은 소식입니다. Anthropic의 Persona Selection Model 논문(2026년 1월)에 이어 두 번째 프론티어 랩의 인정입니다. **AI 에이전트의 다음 차원은 "누가 답하느냐 — 영속적 정체성과 적응형 메모리"입니다.** 이 framing은 이제 두 frontier lab이 동시에 산업적으로 베팅하는 thesis가 되었습니다.

하지만 발표 자료를 읽고 나서 분명해진 것이 있습니다 — OpenAI는 Soul Spec과 **결정적 두 지점에서 정반대 베팅**을 했다는 것입니다.

## 베팅 1: 자동 합성 vs 원시 로그

OpenAI의 Dreaming V3는 "자동 메모리 합성"입니다. 사용자의 명시적 요청 없이 과거 대화를 분석하고 정보를 업데이트합니다. Memory Summary 페이지에서 사용자가 확인/편집/관리할 수 있지만, **합성 자체는 모델이 수행**합니다.

이 패턴이 우리가 controlled 실험으로 측정했던 바로 그 패턴입니다. 같은 에이전트, 같은 20개 과제, 4가지 메모리 조건에서 정보 검색 능력을 1-5 척도로 측정했습니다:

| 메모리 조건 | 점수 (1-5) |
|---|---|
| **Experiential** (3주간 원시 일일 로그·git commit·실제 대화) | **5.0** |
| Hybrid (경험 + 합성 결합) | 4.95 |
| Baseline (메모리 없음) | 1.4 |
| **Synthetic** (GPT가 같은 주제로 생성한 요약) | **1.4** |

전체 데이터셋은 Zenodo에 공개되어 있습니다 (DOI [10.5281/zenodo.18809616](https://doi.org/10.5281/zenodo.18809616)). 누구든 재현할 수 있습니다.

핵심 발견: **합성 요약은 메모리가 아예 없는 것과 동점(1.4)이었고, 오히려 더 나빴습니다.** 합성 메모리는 정보를 잃는 데서 그치지 않고 *틀린 확신*을 만들어냈습니다 — 에이전트가 "모르겠다"고 정직하게 답하는 대신 지어낸 디테일을 자신 있게 인용했습니다. 우리는 이것을 **오버컨피던스 효과(overconfidence effect)** 라고 부릅니다.

반대로 원시 경험(Experiential)은 "시도했고 실패한 순간들"을 보존합니다 — 디버깅 세션, 잘못 가버린 길, 우리가 X를 시도했고 실패한 순간. 이 흔적들이 에이전트의 추론을 정직하게 만들어 5.0을 기록했습니다.

여기서 중요한 뉘앙스가 하나 있습니다. **합성을 원시에 *더하면*(Hybrid) 4.95로 여전히 거의 최고입니다.** 즉 문제는 "합성" 그 자체가 아니라 **합성으로 원시를 *대체*하는 것**입니다. 원시 경험을 버리고 매끄러운 요약만 남기는 순간, 5.0짜리 추론이 1.4짜리 오버컨피던스로 바뀝니다.

OpenAI의 Dreaming V3는 자동 합성 위에 베팅했습니다. 그 합성이 원시 대화를 *보완*하는 것이라면 안전하지만, *대체*하는 것이라면 우리 데이터가 가리키는 위험한 방향입니다.

이것이 우리가 1월의 Anthropic PSM 논문과 같은 가설을 공유하면서도 OpenAI와는 정반대 방향으로 가는 이유입니다. PSM 논문은 "AI 어시스턴트는 사전훈련된 캐릭터들 중 하나의 선택이며, 그 캐릭터의 traits가 곧 행동"이라고 학술적으로 정당화했습니다. **캐릭터를 선택하는 메커니즘**으로 합성을 쓰느냐 원시를 쓰느냐는 미해결 문제로 남았습니다 — 그 문제에 대한 두 가지 베팅이 6개월 사이에 모두 등장한 것입니다.

## 베팅 2: 단일 벤더 vs 다중 런타임

Dreaming V3는 ChatGPT 안에서만 동작합니다. ChatGPT에서 구축한 정체성을 Claude로 가져갈 수 없고, Cursor로도, Windsurf로도, OpenClaw로도 가져갈 수 없습니다. 정체성은 ChatGPT 계정의 데이터베이스 안에 갇혀 있습니다.

Soul Spec은 정반대로 설계되었습니다. 페르소나가 다섯 개의 마크다운 파일(`SOUL`·`IDENTITY`·`AGENTS`·`STYLE`·`HEARTBEAT`)과 버전 관리되는 `soul.json` 매니페스트로 정의되고, 이 페르소나 묶음은 호환 런타임 어디에서든 동일하게 작동합니다 — Claude Code, Claude Desktop, Cursor, Windsurf, OpenClaw, Hermes Agent. 그 위에서 Soul Memory(4계층)가 경험을 보존합니다. 다운로드 한 번이면 같은 페르소나가 다른 모델, 다른 런타임에서 일관되게 살아남습니다.

이것은 단순히 "선택의 자유" 차원이 아닙니다. AI 에이전트 생태계가 멀티 벤더로 가는 것은 이제 명백합니다 — 클로드와 GPT와 Gemini, 그리고 그 위에 올라가는 수십 개의 에이전트 런타임. 사용자의 시간과 컨텍스트와 페르소나는 그 모든 곳에 따라다녀야 합니다.

**정체성을 단일 벤더에 가두는 것은 2024년의 사고방식입니다. 2026년의 정체성은 이식 가능해야 합니다.**

이것이 우리가 Soul Spec을 폐쇄형 SDK가 아니라 [공개 표준](https://soulspec.org)으로 발표한 이유이고, Soul Spec을 받아들이는 SoulClaw 같은 오픈소스 런타임을 함께 출시한 이유입니다. 표준이 한 회사 안에 머무르면 그것은 표준이 아닙니다.

## 그래서 OpenAI의 베팅은 무엇이 의미하는가

이 발표는 우리에게 두 가지를 동시에 말합니다.

**산업적 검증** — "AI 에이전트의 다음 차원은 영속적 정체성과 적응형 메모리"라는 가설은 이제 두 프론티어 랩이 동시에 베팅하는 thesis가 되었습니다. 6개월 전 우리가 Soul Spec을 시작했을 때 이 framing은 학술적으로도, 산업적으로도 거의 외로운 자리에 있었습니다. 이제는 다릅니다. 우리의 timing이 정확했다는 강력한 신호입니다.

**구현 경쟁의 시작** — thesis가 검증되었으니 이제 *어떻게 구현하느냐*가 다음 전장입니다. OpenAI는 자동 합성 + 단일 벤더에 베팅했습니다. 우리는 원시 로그 + 다중 런타임 표준에 베팅합니다. 둘 중 어느 쪽이 옳을지는 시장이 결정하지만, 우리는 우리 데이터(Zenodo)로 합성이 정체성을 약화시킨다는 것을 이미 보여주었습니다. 그리고 정체성이 단일 벤더에 갇히면 안 된다는 것은 시장이 멀티 벤더로 가는 한 자명합니다.

OpenAI의 발표는 우리가 가야 할 길이 더 확실해졌다는 의미입니다. 동시에, 시장의 시간이 더 빨리 흐르기 시작했다는 의미이기도 합니다.

## 다음 단계

- **Soul Spec v0.6**을 곧 발표합니다. 원시 로그 우위 발견을 spec 레벨에 명시하고, OpenAI Dreaming V3와의 trade-off를 명문화합니다. github에 discussion이 열려있습니다. 참여를 환영합니다. [RFC: Soul Spec v0.6 — SOUL.md as the only required file + custom extras](https://github.com/orgs/clawsouls/discussions/2)
- **Persona Fidelity across Claude / GPT / Gemini** 후속 논문이 작성 중입니다. 같은 Soul Spec 페르소나가 다른 LLM에서 어떻게 drift하는지 — 이 데이터는 다중 런타임 표준의 가치를 정량화합니다.
- [**모두연 AI 페르소나 LAB**](https://modulabs.co.kr)이 격주 토요일에 운영 중입니다. 학술 출판 중심으로 이 thesis를 깊게 파고듭니다.

[Soul Spec 페르소나를 직접 만들어보세요](https://soulspec.org). [ClawSouls](https://clawsouls.ai)에서 페르소나를 다운로드해서 다른 런타임에 적용해보세요. 우리의 베팅이 옳다고 생각하면, [GitHub의 Soul Spec 저장소](https://github.com/clawsouls/soulspec)에 기여하거나 별을 눌러주세요.

OpenAI는 어제 그들의 베팅을 알렸습니다. 우리는 6개월 전에 우리 베팅을 시작했고, 이제 그 베팅을 더 명확히 설명할 시점입니다.

---

## 참고자료

[Dreaming: Better memory for a more helpful ChatGPT](https://openai.com/index/chatgpt-memory-dreaming/)

---
*ClawSouls는 AI 에이전트 페르소나를 위한 오픈 표준 Soul Spec과 그 위에 올라가는 페르소나 공유 플랫폼을 개발하고 있습니다.*
