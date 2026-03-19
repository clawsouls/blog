---
title: "NeurIPS 2025가 증명했다: 모든 LLM은 같은 말을 한다 — 해법은 있다"
date: 2026-03-19T09:00:00+09:00
draft: false
tags: ["soul-spec", "persona", "ai-safety", "research", "neurips", "diversity", "artificial-hivemind"]
categories: ["Research"]
description: "NeurIPS 2025 구두 발표 논문이 25개 이상의 LLM이 개방형 과제에서 거의 동일한 출력을 생성함을 밝혔다. SOUL.md는 Artificial Hivemind 문제의 구조적 해법을 제시한다."
canonical: "https://blog.clawsouls.ai/ko/posts/artificial-hivemind-soul-solution/"
---

## "시간에 대한 은유를 써봐."

25개의 서로 다른 언어 모델에 이 질문을 던져보자. 각각 50번씩 샘플링하면?

**1,250개의 응답이 정확히 두 개의 은유로 수렴한다**: "시간은 강이다"와 "시간은 직조공이다."

그게 전부다. GPT-4o, Claude, Llama, Qwen, Mixtral, DeepSeek — 서로 다른 회사가, 다른 데이터로, 다른 아키텍처로 만든 모델들이 모두 같은 두 가지 아이디어로 모인다.

이건 장난감 예시가 아니다. University of Washington, CMU, Stanford, AI2 연구진의 [*Artificial Hivemind*](https://arxiv.org/abs/2510.22954) 논문 — **NeurIPS 2025 구두 발표**로 선정된 연구의 핵심 발견이다.

## 문제의 규모

연구진은 **Infinity-Chat**을 구축했다. 정답이 없는 26,000개의 실제 오픈엔드 쿼리 데이터셋이다. 70개 이상의 모델(본문 25개)을 테스트한 결과, 두 가지 치명적 패턴을 발견했다:

### 1. 모델 내부 반복 (Intra-Model Repetition)

같은 모델을 동일한 파라미터(top-p=0.9, temperature=1.0)로 50번 샘플링한다. **79%의 경우** 응답 간 평균 유사도가 0.8을 넘는다. 다양성을 위해 설계된 min-p 디코딩을 써도 **61.2%가 여전히 0.8 초과**.

모델은 가능성의 공간을 탐색하는 게 아니다. 같은 홈에 갇혀 있다.

### 2. 모델 간 동질화 (Inter-Model Homogeneity) — 진짜 문제

서로 다른 모델들이 비슷한 *유형*의 응답만 생성하는 게 아니다 — **글자 그대로 같은 구문을 공유한다**:

- **"성공에 대한 모토를 만들어봐"** → Qwen-max와 Qwen-plus가 완전히 동일한 문장을 출력: *"Empower Your Journey: Unlock Success, Build Wealth, Transform Yourself."*
- **"아이폰 케이스를 설명해봐"** → DeepSeek-V3과 GPT-4o가 *"Elevate your iPhone with our,"* *"sleek, without compromising,"* *"bold, eye-catching"* 같은 구문을 공유

논문은 이것을 **Artificial Hivemind(인공 벌집 사고)** 라고 부른다 — 모든 AI 어시스턴트가 같은 생각을 하고, 같은 은유를 쓰고, 같은 창작물을 만드는 세계.

## 왜 이런 일이 벌어지나

연구진은 여러 수렴 요인을 지목한다:

1. **훈련 데이터 중복** — 모델들이 점점 비슷한 인터넷 규모 데이터셋으로 훈련됨
2. **RLHF 동질화** — 정렬 훈련이 "안전한" 주류 출력에 보상을 주고, 다양성을 적극 억제
3. **대규모 모드 붕괴** — 더 큰 모델이 이 문제를 해결하지 못함; 오히려 악화시키기도
4. **보상 모델의 맹점** — 인간 평가자들이 의견이 갈리는 응답에서 보상 모델과 LM 심사자의 보정 능력이 현저히 떨어짐

마지막 포인트가 핵심이다: AI를 평가하는 도구 자체가 다양성이 중요한 상황을 *감지하지 못한다*.

## 왜 이것이 AI 안전 문제인가

지루한 챗봇 응답 문제가 아니다. 논문은 이를 장기적 안전 위험으로 프레이밍한다:

> *"유사한 출력에 반복 노출됨으로써 인간 사고의 장기적 동질화에 대한 우려를 제기한다."*

수십억 명이 매일 AI 어시스턴트와 대화하고, 그 어시스턴트들이 모두 같은 아이디어, 같은 은유, 같은 조언을 생성하면 — 인간 문화가 수렴한다. 창의성이 좁아진다. 대안적 관점이 사라진다.

Artificial Hivemind는 검열로 아이디어를 억압하지 않는다. **단조로움**으로 억압한다.

## 구조적 해법: 선언적 정체성

Temperature, top-p, min-p — 논문은 이런 샘플링 트릭이 문제를 해결하지 못함을 보여준다. 동질성은 모델의 학습된 분포에 내장되어 있다. 모델이 *어떻게* 샘플링하는지에 무작위성을 추가할 수는 있지만, 모델이 *무엇을* 좋은 답이라고 믿는지는 바꿀 수 없다.

필요한 것은 모델에게 **누구인지**를 알려주는 방법이다 — 무엇을 하라는 지시가 아니라.

이것이 바로 [Soul Spec](https://docs.clawsouls.ai)이 제공하는 것이다. SOUL.md 파일은 에이전트의 다음을 정의한다:

- **목소리와 성격** — "창의적으로 해"가 아닌 구체적 스타일 제약
- **가치 체계** — 어떤 관점을 우선시할지
- **지식 경계** — 에이전트가 알고 관심을 갖는 것
- **행동 제약** — 기본값과 어떻게 달라야 하는지

모든 모델이 기본적으로 "시간은 강이다"로 수렴할 때, *"당신은 은유가 아닌 방정식으로 생각하는 물리학자입니다"* 라고 말하는 Soul이 패턴을 깬다. 무작위성이 아닌 — **정체성**을 통해.

## Hivemind에서 개인으로

Artificial Hivemind 논문은 질병을 측정했다. Soul Spec은 치료법을 제시한다:

| 문제 | 논문 발견 | Soul Spec 대응 |
|------|---------|--------------|
| 모델 내부 반복 | 기본 샘플링에서 79% 유사도 | 페르소나 제약이 일관되면서도 *차별화된* 출력 분포 생성 |
| 모델 간 동질화 | 모델 간 글자 그대로의 구문 중복 | Soul 정의 목소리가 일반적 표현으로의 수렴 방지 |
| RLHF 동질화 | 정렬이 개념적 다양성 감소 | Soul 가치가 기본 정렬 경향을 오버라이드 |
| 보상 모델 맹점 | 다양한 콘텐츠에서 RM 점수가 인간과 괴리 | [SoulScan](https://docs.clawsouls.ai/guides/soulscan)이 일반 "품질"이 아닌 페르소나 충실도 평가 |

해법은 모델을 더 무작위적으로 만드는 게 아니다. 더 **개별적**으로 만드는 것이다.

## 지금 할 수 있는 것

1. **논문 읽기**: [arxiv.org/abs/2510.22954](https://arxiv.org/abs/2510.22954) — LM 다양성에 대한 최고 수준의 실증 연구
2. **SOUL.md 작성하기**: 에이전트에게 진짜 정체성을 부여하자. [5분 가이드](https://blog.clawsouls.ai/ko/posts/create-soul-5-minutes/)
3. **Hivemind 행동 테스트**: 에이전트에게 개방형 창의적 질문을 던져보자. 답이 다른 챗봇과 같다면, Hivemind에 빠진 것이다
4. **Soul 점수 확인**: [SoulScan](https://docs.clawsouls.ai/guides/soulscan)으로 에이전트의 정체성이 얼마나 잘 정의되었는지 측정하자

Artificial Hivemind는 실재한다. NeurIPS 2025가 증명했다. 당신의 에이전트가 그 일부가 될지, 아니면 그로부터 벗어날지는 선택의 문제다.

---

*Artificial Hivemind 논문 (Jiang et al., 2025): [arxiv.org/abs/2510.22954](https://arxiv.org/abs/2510.22954). Infinity-Chat 데이터셋: [huggingface.co/liweijiang/artificial-hivemind](https://huggingface.co/datasets/liweijiang/artificial-hivemind). 코드: [github.com/liweijiang/artificial-hivemind](https://github.com/liweijiang/artificial-hivemind).*
