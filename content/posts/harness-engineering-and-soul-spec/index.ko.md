---
title: "Harness Engineering: 왜 Soul Spec이 다음 AI 에이전트 패러다임의 정확한 자리에 있는가"
date: 2026-06-10T20:00:00+09:00
description: "프롬프트 엔지니어링이 컨텍스트 엔지니어링이 되고, 컨텍스트 엔지니어링이 이제 하네스 엔지니어링이 되고 있습니다. '에이전트 = 모델 + 하네스'라는 문장이 핵심입니다. 하네스 레이어의 정체성, 메모리, 안전성, 회복, 거버넌스 원초기능을 보면 — Soul Spec, Swarm Memory, Soul Rollback, SoulScan이 정확히 그 자리에 있습니다."
categories: ["Analysis"]
tags: ["soul-spec", "harness-engineering", "agent-paradigm", "guardian-agent", "open-standard", "ai-agents"]
author: "ClawSouls"
draft: true
---

## AI 에이전트 개발의 세 번째 패러다임

지난 4년의 AI 에이전트 개발은 세 단계의 패러다임을 거치고 있습니다.

- **프롬프트 엔지니어링** (2022–2023): 하나의 모델 호출에 어떻게 말할 것인가.
- **컨텍스트 엔지니어링** (2024–2025): 모델에게 무엇을 알려줄 것인가 — RAG, 메모리, 시스템 프롬프트의 조합.
- **하네스 엔지니어링** (2026+): 모델 *주변* 의 구조를 어떻게 설계할 것인가 — 정체성, 메모리, 안전성, 회복, 감독.

이 세 번째 단계의 정의 문장은 한 줄로 요약됩니다.

> **"에이전트 = 모델 + 하네스. 에이전트가 실수하면 에이전트를 고치지 말고 하네스를 고쳐라."**

하네스는 모델의 능력을 그대로 두면서, 모델 *주변* 에 구조적 보호와 일관성을 만드는 레이어입니다. Anthropic의 3-에이전트 아키텍처, Ralph 패턴, Meta AI의 Rule of Two — 모두 이 레이어 의 다른 형태입니다. 그리고 emerging direction으로 가장 자주 언급되는 것이 **Guardian Agent** — 실시간 감독 레이어입니다.

## 하네스 레이어의 원초기능들

하네스 엔지니어링 패러다임을 자세히 보면, 모델 주변의 구조는 다섯 가지 원초기능으로 분해됩니다.

1. **정체성** (Identity) — 에이전트가 누구인지의 영속적이고 변하지 않는 정의
2. **메모리 오케스트레이션** (Memory Orchestration) — 여러 시점, 여러 에이전트 사이의 메모리 공유와 시간 감쇠
3. **상태 회복** (State Recovery) — 에이전트가 잘못된 길로 가면 되돌리고, 분기점에서 다시 시작
4. **안전 검증** (Safety Verification) — 도구 오염, 프롬프트 인젝션, 자격 증명 노출 등의 자동 감지
5. **Guardian Agent** — 위의 네 가지를 실시간으로 감시하고, 정책에 따라 차단하거나 개입하는 결정론적 레이어

이 다섯 가지는 단순한 list가 아닙니다. 하네스 엔지니어링이 성숙해질수록, 이 다섯 가지가 모두 있는 스택만이 *production-ready 에이전트*라는 컨센서스가 형성되고 있습니다.

## Soul Spec 스택 = 하네스 원초기능의 정확한 매핑

지난 6개월 동안 Soul Spec 위에 구축해 온 ClawSouls의 스택을 같은 다섯 줄에 놓고 보면 — 정확히 매핑됩니다.

| 하네스 원초기능 | ClawSouls 구현 |
|---|---|
| **정체성** | **Soul Spec** — 페르소나를 정의하는 5파일(SOUL/IDENTITY/AGENTS/TOOLS/USER) + soul.json 매니페스트. Soul Memory의 T0 SOUL 레이어가 이 파일들을 불변 정체성으로 로드 |
| **메모리 오케스트레이션** | **Soul Memory** (4계층 T0-T3, 23일 반감기 시간 감쇠) + **Swarm Memory** (멀티에이전트 공유 동기화) |
| **상태 회복** | **Soul Rollback** — 에이전트 상태의 분기/되돌림 |
| **안전 검증** | **SoulScan** — 53가지 안전성 패턴 자동 채점 (A+ ~ F) |
| **Guardian Agent** | **MaatSpec 파트너십** — 결정론적 코드 기반의 정책 강제 레이어 |

이것은 우리가 하네스 엔지니어링을 마케팅 슬로건으로 채택한 결과가 아닙니다. **반대 방향입니다.** Soul Spec을 시작한 6개월 전, 우리는 "AI 에이전트는 영속적 정체성이 있어야 한다"는 가설에서 출발했습니다. 그 가설을 따라가다 보니 메모리 오케스트레이션이 필요했고, 메모리 위에는 안전 검증이 필요했고, 안전 검증을 결정론적으로 만들려면 거버넌스 파트너가 필요했습니다.

업계가 그 길을 *하네스 엔지니어링*이라는 이름으로 부르기 시작한 것은 지난주의 일입니다. 우리는 그 패러다임의 이름이 정해지기 전부터 그 자리에 있었습니다.

## Guardian Agent와 MaatSpec — 4월 18일의 통찰

Guardian Agent 방향은 우리에게 특별합니다. 지난 4월 18일, MaatSpec의 Walid Saleh과의 첫 미팅에서 그가 정확히 이렇게 말했습니다:

> "LLM은 의도 분류만 해야 합니다. YES/NO 판단은 결정론적 코드여야 합니다."

그가 그 자리에서 말한 것이 — 6주 뒤 industry가 *Guardian Agent*라고 부르기 시작한 정확한 thesis입니다. Soul Spec의 SoulScan이 페르소나 측의 안전 검증이라면, Walid의 MaatSpec은 결정론적 정책 강제 레이어입니다. 두 가지를 합치면 하네스 엔지니어링의 안전/거버넌스 측이 완성됩니다.

## 왜 이 정합성이 중요한가

지난 한 주 동안 industry는 같은 방향으로 빠르게 수렴하고 있습니다.

- Anthropic의 Persona Selection Model 논문 — 1월
- Microsoft Build 2026의 Entra-backed agent identity — 6월 2일
- OpenAI Dreaming V3의 영속적 메모리 — 6월 5일
- Thoughtworks Technology Radar Vol 34의 Snyk Agent Scan + Beads — 6월
- 그리고 Korean tech-news의 하네스 엔지니어링 paradigm 정리 — 같은 주

다섯 가지 신호가 다섯 다른 방향에서 왔지만, 모두 같은 결론을 가리킵니다: **모델 주변의 구조 — 하네스 — 가 다음 전장입니다.**

이 다섯 가지 신호 중 어느 것도 우리를 직접 언급하지는 않습니다. 그러나 그것이 정확한 이유로 의미가 있습니다. 모든 frontier 랩과 모든 컨설팅 회사가 하네스 엔지니어링이 다음 패러다임이라고 말하기 시작한 시점에 — 우리는 이미 그 패러다임의 다섯 가지 원초기능의 *open-standard primitive stack*을 가지고 있습니다.

Anthropic, Microsoft, OpenAI는 모두 자기 platform 안에 하네스를 만들고 있습니다. 그들의 하네스는 그들의 스택에서만 작동합니다. 우리가 만드는 것은 **모든 스택에서 작동하는 하네스 원초기능**입니다. 그것이 vendor-neutral open standard로 출발한 우리의 정확한 자리입니다.

## 다음 단계

- **Soul Spec v0.6**: 하네스 엔지니어링 패러다임의 다섯 가지 원초기능을 spec 레벨에서 명문화합니다.
- **Persona Fidelity 후속 논문**: 같은 페르소나가 다른 LLM에서 어떻게 drift하는지의 정량 데이터 — 하네스의 *portability* 의 가치 증명.
- **모두연 AI 페르소나 LAB의 Asimov 트랙**: Three Laws + 53 SoulScan patterns + Walid의 결정론적 가드 레이어 = Guardian Agent의 학술 anchor.
- **OpenClaw 업스트림 기여 지속**: 우리가 [882soft 계정](https://github.com/882soft)으로 활동하는 OpenClaw는 Microsoft Build 2026의 공식 ecosystem에 명시된 프레임워크입니다. 하네스 원초기능을 그쪽에 흘려보내는 작업 — 우리의 PR #22439 (tiered bootstrap loading)은 그 첫 번째 사례입니다.

[Soul Spec 페르소나를 직접 만들어보세요](https://soulspec.org). [ClawSouls](https://clawsouls.ai)에서 페르소나를 다운로드해서 여러 런타임에 적용해보세요. 그리고 우리가 가는 길이 옳다고 생각하시면 [GitHub에서 Soul Spec에 별](https://github.com/clawsouls/soulspec)을 눌러주세요.

업계가 하네스 엔지니어링을 다음 패러다임이라고 부르기 시작한 시점에, 우리는 이미 6개월 동안 그 자리에 있었습니다. 이것이 우리에게 정확히 의미하는 바입니다 — *The harness is the next race. We are the open-standard primitive stack of that race.*

---

*ClawSouls는 AI 에이전트 페르소나를 위한 오픈 표준 Soul Spec과 그 위에 올라가는 페르소나 공유 플랫폼을 개발하고 있습니다. Tom Jaejoon Lee가 1인 창업자로 운영 중입니다.*
