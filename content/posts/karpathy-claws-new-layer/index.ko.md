---
title: "Karpathy가 말하는 Claws: AI 스택의 새로운 계층, 그리고 빠진 한 조각"
date: 2026-02-28T12:00:00+09:00
description: "Andrej Karpathy가 LLM → Agent → Claw로 이어지는 AI 스택의 새 계층을 선언했습니다. 다양한 Claw 구현체가 난립하는 지금, 정작 빠진 것은 persona의 이식성입니다."
categories: ["Insights"]
tags: ["karpathy", "claws", "openclaw", "ai-agents", "soul-spec", "nanoclaw"]
slug: "karpathy-claws-new-layer"
draft: false
---

## Karpathy가 Mac Mini를 샀다

Andrej Karpathy가 Mac Mini를 사서 [OpenClaw](https://github.com/anthropics/openclaw)를 돌리기 시작했습니다. 애플스토어 직원이 "매우 잘 팔리고 있다"고 했다는 일화와 함께, 그는 이렇게 말합니다:

> "흥미롭고 흥분되는 AI 스택의 새로운 계층이다."

Karpathy의 기술적 직관은 늘 업계의 방향을 예고해왔습니다. Tesla Autopilot의 비전 기반 접근, GPT 시대 이전의 nanoGPT, 그리고 이제 — **Claws**. 그가 새로운 용어에 무게를 실으면, 그건 단순한 유행어가 아닙니다.

## LLM → Agent → Claw

Karpathy가 제시한 계층 구조는 명쾌합니다:

1. **LLM** — 언어 모델 자체. 텍스트를 넣으면 텍스트가 나온다.
2. **LLM 에이전트** — LLM에 도구 호출, 루프, 판단력을 더한 것. Claude Code, Cursor 같은 것들.
3. **Claws** 🦞 — 에이전트 위의 계층. 오케스트레이션, 스케줄링, 컨텍스트 관리, 도구 호출, **지속성**을 확장.

핵심 차이는 **지속성(persistence)**입니다. 에이전트는 대화가 끝나면 사라지지만, Claw는 개인 하드웨어에서 상시 동작합니다. 메시징 프로토콜로 통신하고, 작업을 스케줄링하고, 맥락을 유지합니다.

Simon Willison은 이를 이렇게 정리합니다: "Claw"는 **개인 하드웨어에서 메시징 프로토콜로 동작하는 AI 에이전트 시스템**의 범주 용어로 자리잡고 있다고. Karpathy의 용어 감각에 대한 찬사와 함께.

## 소형 구현체의 폭발

이미 다양한 Claw 구현체가 등장하고 있습니다:

| 프로젝트 | 특징 |
|---|---|
| **OpenClaw** | Anthropic의 레퍼런스 구현 |
| **NanoClaw** | ~4,000줄. 인간과 AI 모두 이해·확장 가능한 크기 |
| **zeroclaw** | 미니멀 구현 |
| **ironclaw** | Rust 기반 |
| **picoclaw** | 극소형 |

특히 NanoClaw의 접근이 인상적입니다. 4,000줄이면 한 사람이 전체를 읽고 이해할 수 있는 크기입니다. 컨테이너 환경에서 기본 실행되며, 감사(audit)가 가능합니다. "이해할 수 있는 AI 인프라"라는 가치 제안입니다.

## 빠진 한 조각: Persona는 어디에?

여기서 한 가지 질문이 떠오릅니다.

Claw 구현체가 5개, 10개, 50개로 늘어나면 — 내 AI의 **성격, 행동 패턴, 기억**은 어떻게 되나요?

OpenClaw에서 정성껏 설정한 persona를 NanoClaw로 옮기고 싶다면? ironclaw로 바꾸고 싶다면? 각 플랫폼마다 처음부터 다시 설정해야 할까요?

이것은 Claw 계층이 성숙해지면 반드시 마주칠 문제입니다:

- **오케스트레이션**은 Claw가 해결합니다 ✅
- **모델 호출**은 LLM API가 해결합니다 ✅  
- **Persona portability**는? ❌

## Soul Spec: Claws 위의 Persona Layer

이것이 [Soul Spec](https://github.com/clawsouls/soul-spec)이 풀려는 문제입니다.

Soul Spec은 AI 페르소나를 구조화된 파일들로 정의합니다 — `SOUL.md`, `IDENTITY.md`, `AGENTS.md`, 그리고 `soul.json`. 이 파일들은 특정 Claw 구현체에 종속되지 않습니다. Git으로 버전 관리되고, 어떤 플랫폼이든 읽을 수 있는 Markdown입니다.

```
┌─────────────────────┐
│    Soul Spec         │  ← persona, identity, behavior
├─────────────────────┤
│    Claw Layer        │  ← orchestration, scheduling, persistence
├─────────────────────┤
│    Agent Layer       │  ← tool use, reasoning loops
├─────────────────────┤
│    LLM Layer         │  ← language model inference
└─────────────────────┘
```

재미있는 사실: ClawSouls의 [surgical-coder](https://github.com/clawsouls/soul-spec/tree/main/examples/surgical-coder) soul은 "Inspired by Karpathy's CLAUDE.md"에서 출발했습니다. Karpathy가 자신의 에이전트에 넣은 설정 파일 — 그것이 바로 Soul Spec이 표준화하려는 것의 원형입니다.

## 왜 지금인가

Claw 구현체가 하나뿐이었을 때는 표준이 필요 없었습니다. OpenClaw 방식으로 하면 그만이었으니까.

하지만 NanoClaw, zeroclaw, ironclaw, picoclaw가 등장한 지금, **상호운용성(interoperability)**의 문제가 현실이 됩니다. 그리고 상호운용성이 필요한 가장 인간적인 계층이 바로 persona입니다.

Karpathy가 Claws를 AI 스택의 새 계층으로 선언한 것처럼, persona의 이식성도 새로운 표준 계층이 필요합니다.

## 결론

Karpathy의 관찰은 정확합니다. Claws는 단순한 도구가 아니라 AI 스택의 **구조적 진화**입니다. LLM이 추론을, Agent가 행동을, Claw가 지속성을 담당한다면 — 그 위에 **정체성(identity)**을 담당하는 계층이 와야 합니다.

🦞 이모지가 Claw의 상징이 되었듯, Soul Spec은 그 🦞에게 **영혼**을 부여하는 작업입니다.
