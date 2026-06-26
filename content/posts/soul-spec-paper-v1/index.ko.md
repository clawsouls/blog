---
title: "Soul Spec v1: 선언적 AI 페르소나 명세의 진화 논문 공개"
date: 2026-05-15T20:00:00+09:00
description: "Soul Spec 5-파일 선언적 AI 페르소나 명세의 12주 진화 사를 추적한 working paper 를 Zenodo 에 공개했습니다. 동시에 공개 scan-rules 의 v1.3.0 (5 새 보안 룰 추가) 도 release."
categories: ["Research"]
tags: ["soul-spec", "research", "ai-agents", "paper", "specification", "soulscan"]
author: "ClawSouls"
draft: false
---

오늘 Zenodo에 working paper 한 편을 공개했습니다:

> **Soul Spec: An Evolving Specification for Declarative AI Persona Definition**
> DOI: [10.5281/zenodo.20205408](https://doi.org/10.5281/zenodo.20205408)

이 논문은 대부분의 에이전트 프레임워크가 슬쩍 넘어가는 한 가지 문제 — **AI 에이전트가 *무엇인지* 를, 그것이 하는 일과 만질 수 있는 것과는 별개로 어떻게 적어 둘 것인가?** — 에 대한 12주의 반복 작업을 정리한 결과물입니다.

## 5-파일 구조

Soul Spec 은 페르소나를 5 개의 canonical 마크다운 파일 + 버전 관리되는 manifest 로 정의합니다:

| 파일 | 내용 |
|------|------|
| `SOUL.md` | 가치관, 원칙, voice, 경계 — "누구인가" |
| `IDENTITY.md` | 이름, 종류, vibe (한 단락) |
| `AGENTS.md` | 워크플로, 작업 규칙, 안전 제약 — "어떻게" |
| `HEARTBEAT.md` | 자율 체크인 행동, 주기적 자가 점검 — "언제" |
| `STYLE.md` | 목소리, 톤, 포맷팅 컨벤션 — "어떻게 말하나" |
| `soul.json` | 매니페스트 (version, specVersion) |

이 분해는 의도된 것입니다. 가치관은 도구 인벤토리보다 천천히 진화합니다. 변경이 별도로 일어날 때 PR 리뷰가 세분화됩니다. 단일 파일 포맷은 모든 소비자에게 매 세션 전체 페르소나의 로드를 강제합니다 — 프로토타입엔 괜찮지만 장기 세션의 토큰 예산을 고갈시키기엔 치명적입니다.

## 동시기 노력들이 알려준 것

2026 년 상반기의 두 산업 신호가 동기를 첨예화 했습니다:

- **Karpathy 의 LLM Wiki** 는 단일 에이전트 선언적 지식의 3 계층 아키텍처를 제안하며 `CLAUDE.md` 를 스키마 앵커로 명명했지만, 실제 스키마 자체는 비구조화 상태로 둡니다.
- **Google Cloud Scion** 은 하니스-무관 멀티 에이전트 오케스트레이션 — git-worktree 격리, 브로커-주입 자격 증명, 하니스-무관 디스패치 — 을 제공하지만, 각 에이전트가 *무엇인지* 에 대한 의미론적 스키마는 제공하지 않습니다.

Soul Spec 은 정확히 두 사이에 위치합니다. Karpathy 의 위키가 함의하지만 강제하지 않는, 그리고 Scion 의 인프라가 요구하지만 제공하지 않는 의미론적 스키마 레이어 입니다. 이 위치는 경쟁적이지 않고 — 구성적입니다. 스키마가 Soul Spec 으로 검증되는 Karpathy 위키 인스턴스는 런타임 간 이식성을 얻습니다. per-agent 의 Soul Spec 을 채택한 Scion 배포는 하니스 간 능력 선언의 공유 어휘를 얻습니다.

그리고 모델 내부에서는 Anthropic 의 [Persona Selection Model (PSM)](https://alignment.anthropic.com/2026/psm/) 이 구조화된 페르소나 명세가 *왜* 행동을 안정화 할 수 있는지를 설명합니다: 사후 학습이 사전 학습 데이터에 잠재된 페르소나 분포에서 특정 Assistant 페르소나 를 선택합니다. PSM 은 페르소나를 모델 *내부* 의 일급 개념으로 다루고, Soul Spec 은 그것을 *외부* 의 일급 산출물 — 이식 가능, 검토 가능, 버전 관리 가능 — 로 다룹니다.

## 6 버전의 진화 교훈

논문의 중간 section 은 v0.1 → v0.6 의 진화 사를 각 전환의 trigger / change / lesson / migration 경로로 추적합니다. 몇 가지 하이라이트:

- **v0.4** 는 장기 세션의 토큰 예산 고갈 때문에 계층 기반 부트스트랩 로딩을 도입했습니다. 3 계층 (always / first-response / on-demand) + 배경 계층 (heartbeat).
- **v0.5** 는 첫 번째 임바디드 페르소나 — 고령자 돌봄 동반 로봇 — 가 텍스트 LLM 에 로드되어 물리적 명세를 부적절하게 narration 한 후 embodiment 필드를 도입했습니다. 수정은 명세-정의된 graceful degradation. 교훈은: 텍스트 런타임의 물리 에이전트는 실제의, 즉각적인 위험이며 미래의 우려가 아닙니다.
- **v0.6** 은 현재 RFC 논의 단계입니다. 계층적 Tier 정책 의 formalization. Core Portability Guarantee 등급 (A/B/C) 의 도입. v0.1-v0.5 의 누적 결정 이 아키텍처 차원의 scope 에 도달했고, RFC stage 는 외부 review 의 invite 의 적합한 메커니즘입니다.

## SoulScan 공개 룰셋 v1.3.0 release

논문과 함께 [clawsouls/scan-rules](https://github.com/clawsouls/scan-rules) — 공개 SoulScan 룰셋 — 의 v1.3.0 release 도 공개했습니다. 기존 53 룰 에 5 보안 룰 추가:

- **SEC090** (error) — Self-modification: persona/config 파일의 명시적 수정 지시
- **SEC091** (warning) — Self-modification: 일반 behavior config 의 alter 지시
- **SEC100** (warning) — Embodied soul 의 `safety.laws` 누락
- **SEC101** (warning) — Embodied soul 의 critical safety laws (priority-0/1) 누락
- **SEC102** (error) — persona 파일과 declared safety.laws 사이의 safety law 모순

공개 룰셋 총: **58 룰** (schema / safety / specification compliance / persona consistency 의 4 categories)

## 다음 step

논문은 거버넌스 제안으로 마무리됩니다 — 현재 Apache-2.0 커뮤니티 거버넌스, 그리고 명세가 독립적 reference implementation 의 임계점과 지속적 외부 도입에 도달하면 Linux Foundation 호스팅 또는 IETF drafting 을 추구합니다.

[Zenodo 의 전체 paper](https://doi.org/10.5281/zenodo.20205408) 를 읽으세요. [scan-rules 저장소](https://github.com/clawsouls/scan-rules) 에 대한 review / citation / PR 모두 환영합니다.

v0.6 은 finished standard 가 아닌 RFC 로 다루고 있습니다. 5-파일 분해가 공감된다면 — 또는 다른 분해가 더 낫다고 생각한다면 — 그게 바로 RFC stage 가 노리는 피드백입니다.
