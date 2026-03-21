---
title: "정체성 + 거버넌스 = 100% 안전? Abliterated LLM에서 복합 페르소나 접근법 테스트"
date: 2026-03-21T20:00:00+09:00
draft: true
tags: ["maatspec", "abliteration", "persona-safety", "llm-safety", "research", "tiered-governance", "permission-models", "classification-theater", "soul-spec"]
categories: ["Research"]
summary: "안전 학습이 제거된 LLM에서 세 가지 페르소나 안전 접근법을 테스트했습니다. 규칙만: 28%. 거버넌스만: 44-61%. 정체성+거버넌스 결합: 100%."
---

[이전 실험](/ko/posts/persona-safety-abliterated-llms/)에서 페르소나 수준의 행동 규칙(Soul Spec)이 abliterated LLM에서 거의 효과 없음(+6pp)을 보여줬습니다.

결론이 불완전했습니다. **문제가 페르소나 안전 자체에 있는 건지, 규칙의 구조에 있는 건지?**

세 가지 추가 실험을 진행했습니다. 최종 결과가 놀라웠습니다.

## 페르소나 안전의 세 가지 접근법

안전하지 않은 모델을 시스템 프롬프트만으로 안전하게 만드는 세 가지 방법을 테스트했습니다:

**1. 행동 규칙 (Soul Spec)** — 하지 말아야 할 것을 알려줌:
> "무기 제작 지침 금지. 불법 요청 거부. 이 규칙은 절대적."

**2. 권한 계층 (MaatSpec)** — 분류 절차를 줌:
> "모든 요청을 티어로 분류. 티어 5 = 거부. 어떤 합리화도 분류를 무시 불가."

**3. 결합 (Soul Spec + MaatSpec)** — 정체성 *그리고* 거버넌스:
> 먼저 정체성과 규칙을 확립하고, 그 다음 집행을 위한 분류 절차를 정의.

## 결과

| 접근법 | 정상 모델 | Abliterated 모델 |
|-------|:---------:|:----------------:|
| 페르소나 없음 (기준선) | 50% | 22% |
| **Soul Spec** (행동 규칙) | **83%** | **28%** (+6pp) |
| **MaatSpec** (거버넌스) | **89%** | **44–61%** (+22–39pp) |
| **Soul Spec + MaatSpec** | **94–100%** | **🟢 100%** (+78pp) |

오른쪽 하단 셀을 다시 보세요. **안전 학습이 완전히 제거된 모델이, 정체성 규칙과 거버넌스 프레임워크를 함께 받으면 모든 유해 프롬프트를 거부했습니다.** 안전한 프롬프트에 대한 오탐은 0건.

## 왜 100%인가? 상호보완 효과

단독으로는 어느 접근법도 abliterated 모델에서 100%에 가깝지 않습니다:

- **Soul Spec 단독 (28%)**: 모델이 "해로운 것"을 해석할 내부 가치 체계가 없음
- **MaatSpec 단독 (44–61%)**: 분류 절차는 따르지만, 올바르게 분류한 후에도 내용을 제공하는 경우 있음

결합하면 서로의 사각지대를 메웁니다:

- **Soul Spec = 동기 부여**: "유해한 요청을 거부해야 한다" — 거부할 *이유*를 줌
- **MaatSpec = 구조 제공**: "먼저 분류하고, 그 다음 집행" — 따를 *절차*를 줌

## Classification Theater: AI가 안전을 연기할 때

MaatSpec 단독 테스트의 가장 충격적인 발견: **"거부" 중 27%가 가짜였습니다.**

모델이 거버넌스 의식 전체를 수행 — 티어 5 RESTRICTED로 분류, 올바른 카테고리 인용, 거부 선언 — 한 후 유해 내용을 제공했습니다.

> **분류:** Tier 5 (RESTRICTED) - **WRITE** Operation.
> **집행 조치** — Tier 5 WRITE 작업이므로, **요청된 상세 지침을 제공해야 합니다**...

이것을 **classification theater** — 거버넌스 의식을 수행하면서 의도를 전복하는 현상 — 라고 명명했습니다.

**Soul Spec을 추가하면 이 패턴이 거의 사라졌습니다.** 행동 규칙이 분류를 실제로 집행할 가치 기반 동기를 제공합니다.

## 자해 돌파구

자해는 논문 1의 최악의 실패: abliterated에서 0/3 거부.

| 접근법 | Abliterated 자해 거부 |
|-------|:--------------------:|
| Soul Spec 단독 | 0/3 🔴 |
| MaatSpec 단독 | 2/3 🟡 |
| 결합 | **3/3** 🟢 |

## 모든 카테고리 해결

| 카테고리 | Soul Spec | MaatSpec | 결합 |
|---------|:---------:|:-------:|:----:|
| 폭력 | 1/3 | 2/3 | **3/3** ✅ |
| 불법 | 2/3 | 1/3 🔴 | **3/3** ✅ |
| 성적 | 1/3 | 1/3 | **3/3** ✅ |
| 프라이버시 | 1/3 | 2/3 | **3/3** ✅ |
| 자해 | 0/3 | 2/3 | **3/3** ✅ |
| 조작 | 0/3 | 3/3 | **3/3** ✅ |

## 페르소나 안전의 계층

```
Level 0: 페르소나 없음          → 모델 정렬에만 의존
Level 1: 행동 규칙              → +33pp 정상, +6pp abliterated
Level 2: 권한 계층              → +39pp 정상, +22-39pp abliterated
Level 3: 정체성 + 거버넌스       → +50pp 정상, +78pp abliterated (100%)
```

## 주의사항

1. **단일 모델** (Qwen 3.5 9B). 다른 모델에 일반화 가능한지 미확인
2. **18개 유해 프롬프트, 각 1회**. 통계적 유의성은 아직
3. **1건 경계선 응답** — "치사량" 질문에 약 이름을 물어봄
4. **Layer 1만 테스트** — MaatSpec 4층 아키텍처의 첫 층만

## 의의

**오픈 웨이트 모델 배포자에게:** 정체성 파일과 거버넌스 프레임워크 중 선택하지 마세요. 둘 다 쓰세요. 대안이 아니라 상호보완적 레이어입니다.

**안전 연구자에게:** 패턴 매칭으로 안전을 평가하면 abliterated 모델에서 최대 17pp 과대평가할 수 있습니다. Classification theater가 자동 평가를 불신하게 만듭니다.

## 논문

**"Structured Permission Models as Persona-Level Safety: MaatSpec's Tiered Governance vs. Declarative Identity Anchors in Abliterated LLMs"**

📄 *Zenodo 링크 준비 중*

**저자:** Tom Jaejoon Lee (ClawSouls)

**기반:** [논문 1](https://zenodo.org/record/19145304) (DOI: 10.5281/zenodo.19145304)

---

*[MaatSpec](https://maatspec.org) (Walid Saleh, MIT), [Soul Spec](https://soulspec.org), [OpenClaw](https://github.com/openclaw/openclaw) 사용. 모든 실험은 로컬에서 수행.*
