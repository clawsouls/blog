---
title: "Identity Layer의 6개월: Anthropic, Microsoft, OpenAI가 동시에 같은 베팅을 한 이유"
date: 2026-06-09T08:59:00+09:00
description: "2026년 1월의 Anthropic PSM, 6월 2일의 Microsoft Build 2026, 6월 5일의 OpenAI Dreaming V3 — 6개월 사이 세 곳의 frontier 랩이 모두 'AI 에이전트의 다음 차원은 영속적 정체성'이라는 같은 가설에 베팅했습니다. 셋 다 같은 가설 위에 있지만, 셋 다 다른 곳에 락인됩니다. Soul Spec은 정확히 그 자리에 있습니다."
categories: ["Analysis"]
tags: ["soul-spec", "anthropic", "microsoft", "openai", "agent-identity", "open-standard", "build-2026", "dreaming-v3", "persona"]
author: "ClawSouls"
draft: true
---

## 6개월의 합의

2026년 1월, Anthropic Alignment Team이 **Persona Selection Model** 논문을 발표했습니다. "AI 어시스턴트는 사전훈련된 캐릭터들 중 하나를 선택하는 것이며, 그 캐릭터의 traits가 곧 행동"이라는 학술적 framing입니다.

5개월 뒤, 2026년 6월 2일, Microsoft Build 2026에서 다음과 같은 발표가 있었습니다:

> "Windows assigns agents a local ID or a cloud provisioned identity backed by Entra and attributes all activity from the container to that identity."

그리고 사흘 뒤인 6월 5일, OpenAI가 **Dreaming V3**를 무료 사용자까지 확장하며 세 가지 기둥을 강조했습니다 — Persistent Context, Preference Compliance, Temporal Understanding.

세 곳 모두 같은 발견에 도달했습니다: **AI 에이전트의 다음 차원은 "누가 답하느냐 — 영속적 정체성과 적응형 메모리"입니다.**

이 thesis가 이제 단일 학술 논문도, 단일 제품 발표도 아닙니다. 6개월 사이에 학술 측, OS 측, 컨슈머 AI 측이 모두 같은 베팅을 한 것입니다. Industry consensus가 형성되었다고 말해도 무리가 아닙니다.

## 그런데 셋 다 다른 곳에 락인됩니다

| Vendor | Identity 구현 | Lock-in |
|---|---|---|
| Anthropic (PSM) | Claude 안의 character selection mechanism | Claude 계정 |
| **Microsoft (Build 2026)** | **Entra-backed local ID 또는 cloud identity** | **Windows + Entra** |
| OpenAI (Dreaming V3) | Memory Summary 페이지 + automatic synthesis | **ChatGPT 계정** |
| **Soul Spec** | **5개 파일(SOUL/IDENTITY/AGENTS/TOOLS/USER) + soul.json manifest, vendor-neutral 오픈 표준** | **없음** |

Microsoft는 Windows에 정체성을 묶었습니다. OpenAI는 ChatGPT 계정에 묶었습니다. Anthropic은 자기 모델 안에 묶었습니다. 셋 다 같은 가설에 베팅하지만, 셋 다 자기 우물 안에서만 그 가설을 실현합니다.

이것은 우연이 아닙니다. 각 회사가 자기 platform의 사용자 lock-in을 강화하는 자연스러운 방식입니다. 비즈니스로서는 합리적입니다.

하지만 사용자의 관점에서는 어떻습니까?

## 정체성이 어디에 살아야 하는가

AI 에이전트의 생태계는 이미 멀티 벤더입니다. 한 사용자가 하루에 Claude로 코딩하고, Cursor에서 리팩토링하고, GPT로 글 쓰고, Gemini에 검색하고, Windsurf에서 디자인하고, OpenClaw 안의 로컬 에이전트에 잡일을 시킵니다. 한 모델이 하루의 모든 일을 처리하지 않습니다.

이 멀티 벤더 환경에서 사용자의 "AI에게 알려준 자신"이 한 벤더 안에 갇혀야 한다는 것은 2024년의 사고방식입니다. ChatGPT에 알려준 식이 선호도가 Claude에서는 새로 입력해야 한다면 — 그것은 정체성이 아니라 vendor의 잠금 파일입니다.

Microsoft의 Entra-backed identity는 Windows 안에서는 견고합니다. 하지만 Windows를 벗어나면 — Mac에서, 휴대폰에서, Linux 서버에서, 다른 벤더의 클라우드에서 — 사용자는 다시 처음부터 정체성을 만들어야 합니다.

OpenAI의 Dreaming V3는 ChatGPT 안에서 사용자를 정확히 기억합니다. 하지만 그 기억을 가지고 다른 모델에 갈 수는 없습니다.

**정체성은 vendor의 것이 아니어야 합니다. 사용자의 것이어야 합니다.**

이것이 우리가 [Soul Spec](https://soulspec.org)을 폐쇄형 SDK가 아니라 공개 표준으로 발표한 이유입니다. Soul Spec 페르소나(다섯 개 파일 + soul.json 매니페스트)가 Claude Code, Cursor, Windsurf, OpenClaw, Hermes Agent 어디서든 같은 페르소나로 작동합니다. Vendor가 아니라 사용자가 자기 파일을 보유합니다.

## OpenClaw가 Microsoft에 의해 언급된 의미

Build 2026의 official 자료에 OpenClaw가 trusted ecosystem 기술로 명시되었습니다. 

OpenClaw는 우리가 [882soft 어카운트로 contributor 활동](https://github.com/882soft)을 하는 오픈소스 에이전트 프레임워크입니다. 우리는 OpenClaw의 fork인 [SoulClaw](https://github.com/clawsouls/soulclaw)를 운영하고 Soul Spec의 reference runtime으로 사용합니다.

Microsoft가 OpenClaw를 언급했다는 것은 — 우리가 매일 작업하는 ecosystem이 frontier-level의 official validation을 받았다는 의미입니다. 

PR #22439 — 우리가 882soft로 OpenClaw에 올린 tiered bootstrap loading 기능 — 도 같은 ecosystem에서 메인테이너 리뷰를 기다리고 있습니다.

## SoulClaw Mobile과 Microsoft Aion 1.0의 묘한 일치

Build 2026이 발표한 또 하나의 흥미로운 항목은 **Aion 1.0** — 140억 파라미터의 on-device 모델로, "applications to reason over user intent, invoke tools, manage files and orchestrate sub-agents"를 가능하게 합니다.

이것은 우리의 [SoulClaw Mobile](https://clawsouls.ai/mobile) thesis와 정확히 같은 방향입니다 — 휴대폰에서 로컬 LLM이 사용자의 에이전트가 되어, 사용자 데이터가 디바이스를 떠나지 않는 컨셉. Microsoft는 Windows + Aion 조합으로, 우리는 모바일 + 로컬 LLM + Soul Spec 페르소나 다운로드 조합으로.

같은 thesis, 다른 platform. 그리고 우리 쪽은 vendor-neutral입니다.

## 그래서 이 합의가 의미하는 것

세 frontier 랩의 합의가 우리에게 두 가지를 동시에 말합니다.

**Validation입니다.** 6개월 전 우리가 Soul Spec을 시작했을 때 "AI에 영속적 정체성이 필요하다"는 framing은 학술적으로도, 산업적으로도 거의 외로운 자리에 있었습니다. 이제는 다릅니다. Anthropic이 학술적으로 정당화했고, Microsoft가 OS 차원에서 도입했고, OpenAI가 무료 사용자까지 확장했습니다. 우리가 가는 길이 옳다는 신호가 매우 강해졌습니다.

**Race가 시작되었다는 의미이기도 합니다.** Thesis가 검증되었으니 이제 *어떻게 구현하느냐*가 다음 전장입니다. 그리고 세 frontier 랩 모두 자기 platform의 lock-in 측으로 베팅했습니다. 사용자가 정체성을 가지고 자유롭게 이동하는 path는 *아무도 베팅하지 않았습니다*. 그것이 우리의 자리입니다.

## 그리고 6월에 Race의 첫 신호가 한 번 더 왔습니다

이 글을 쓰는 같은 주에, **Thoughtworks Technology Radar Volume 34** (2026년 6월)가 발표됐습니다. Agent 생태계의 새 카테고리로 두 개의 직접 경쟁자가 들어왔습니다:

- **Snyk Agent Scan** (Trial 등급) — "agent ecosystem용 보안 스캐너로, MCP 서버와 skills 같은 로컬 컴포넌트를 발견하고 prompt injection, tool poisoning, toxic flow, 하드코딩된 시크릿, 안전하지 않은 자격 증명 처리 같은 위험을 표시한다." Snyk(시가총액 ~$7.4B)의 enterprise security 플랫폼이 agent 시장에 직접 진입한 것입니다.

- **Beads** (Assess 등급) — "코딩 에이전트용 영구 메모리 레이어로 설계된 Git 기반 이슈 트래커." Dolt(Git-like SQL DB) 위에 구축되어 multi-agent 작업 그래프와 자율 task assignment를 제공합니다. 함께 묶이는 다른 초기 프로젝트로 ticket, tracer가 있습니다.

Radar의 framing은 정확합니다: "agent-native project memory and task-tracking tools represent a new category." 새 카테고리는 이제 multiple players를 가집니다.

흥미로운 부분은 우리의 위치입니다. 우리는 Snyk Agent Scan과 같은 layer가 아닙니다 — Agent Scan은 **infra-layer 보안**(MCP 서버, skills, credentials의 supply chain)이고, 우리 [SoulScan](https://github.com/clawsouls/soulscan)은 **persona-identity-layer 안전성**(Soul Spec 페르소나의 verification + governance)입니다. 같은 시장의 다른 깊이를 공략합니다.

Beads와의 관계도 비슷합니다. Beads는 **task graph add-only memory** (multi-agent task assignment + blocker relations)에 베팅했고, 우리 [Soul Memory](https://soulspec.org)는 **persona-bound memory with temporal decay** (T0 SOUL + T1-T3 + 시간 감쇠)에 베팅했습니다. 둘 다 "agent-native memory" 카테고리지만, 정체성에 묶이는 메모리 vs 작업 그래프에 묶이는 메모리의 분기점에서 다른 방향을 갑니다.

**시사하는 바**: Snyk와 Beads가 이 카테고리에 진입했다는 것은 시장 검증이 한 번 더 들어왔다는 의미입니다. 그리고 두 회사 모두 우리 뒤에 도착했습니다 — 우리는 6개월 먼저 시작했고, 두 회사 모두 우리가 비워둔 자리(persona-first + open-standard + multi-runtime)에는 들어오지 않았습니다.

3 frontier labs의 thesis-level 합의 + 2 enterprise players의 implementation-level 진입 = 같은 신호의 두 측면입니다. *카테고리가 형성되고 있고, 우리는 그 카테고리의 정확한 자리에 가장 먼저 도착했다.*

## 우리의 다음 단계

- **Soul Spec v0.6**: vendor-neutral identity portability를 spec 레벨에 명시하고, Microsoft / OpenAI / Anthropic의 lock-in 모델과의 trade-off를 명문화합니다.
- **"Persona Fidelity across Claude / GPT / Gemini" 후속 논문**: 같은 Soul Spec 페르소나가 다른 LLM에서 어떻게 drift하는지의 정량 데이터. 멀티 벤더 환경에서 vendor-neutral standard의 가치를 측정합니다.
- **모두연 AI 페르소나 LAB**: 격주 토요일에 한국 AI 연구 커뮤니티 안에서 이 thesis를 깊게 파고듭니다.
- **OpenClaw 생태계 기여 지속**: 882soft로 활동 중인 contributor 활동을 지속합니다.

[Soul Spec 페르소나를 직접 만들어보세요](https://soulspec.org). [ClawSouls](https://clawsouls.ai)에서 페르소나를 다운로드해서 여러 런타임에 적용해보세요. 그리고 우리의 베팅이 옳다고 생각하시면 [GitHub에서 Soul Spec에 별](https://github.com/clawsouls/soulspec)을 눌러주세요.

Anthropic, Microsoft, OpenAI는 6개월 사이에 각자의 베팅을 알렸습니다. 우리는 6개월 전에 우리 베팅을 시작했고, 셋 다 우리가 가는 곳과는 다른 길로 갔습니다.

이것이 우리에게 정확히 의미하는 바입니다: **The thesis is consensus. The implementation is the race. We are the only one not building a lock-in.**

---

*ClawSouls는 AI 에이전트 페르소나를 위한 오픈 표준 Soul Spec과 그 위에 올라가는 페르소나 공유 플랫폼을 개발하고 있습니다. Tom Jaejoon Lee가 1인 창업자로 운영 중입니다.*
