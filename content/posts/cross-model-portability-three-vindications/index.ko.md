---
title: "Cross-Model 페르소나 portability — 2026년 5월의 세 번의 입증"
date: 2026-05-19T09:50:00+09:00
draft: false
tags: ["soul-spec", "cross-model", "portability", "anthropic", "karpathy", "claude-code", "local-llm", "gemma", "alignment"]
categories: ["Research"]
description: "2026년 5월 한 달간 세 개의 독립된 시그널 — Karpathy Sequoia 발표, Anthropic 'Teaching Claude Why' 논문, 6월 15일 가격 정책 변경 — 이 모두 같은 아키텍처적 진실을 가리킨다: 페르소나는 어느 한 모델 안이 아닌 그 바깥에 살아야 한다. Soul Spec은 12주 전 그 베팅을 했다."
author: "ClawSouls"
slug: "cross-model-portability-three-vindications"
canonical: "https://blog.clawsouls.ai/ko/posts/cross-model-portability-three-vindications/"
---

2026년 5월, 같은 아키텍처적 방향을 가리키는 세 개의 독립된 시그널이 발생했다. 각각 따로 읽으면, AI 에이전트 시스템이 어떻게 진화하고 있는지에 대한 강한 관찰이다. 합쳐서 읽으면, 한 가지 베팅을 묘사한다: **페르소나는 어느 개별 모델 바깥에 사는 인프라다.**

Soul Spec은 12주 전에 그 베팅을 했다. 이 글은 무엇이 바뀌었는지, 이 시그널들이 왜 중요한지, 그리고 그 아키텍처 결정이 이제 이론적 가치가 아니라 측정 가능한 경제적 가치를 가지게 된 이유를 정리한다.

## 시그널 1 — Karpathy: `.sh` 가 아니라 `.md` skill을 설치하라

이번 달 초 Sequoia Ascent에서 Andrej Karpathy는 에이전트 인프라 논의를 기억하기 쉬운 한 문장으로 재구성했다: shell script 대신 `.md` skill을 설치하라. 모델이 구조화된 자연어 지시를 따르는 능력이 높아짐에 따라, 올바른 배포 단위는 더 이상 도구를 묶는 shell script가 아니라 기능을 선언적으로 기술하는 Markdown 파일이라는 주장이었다.

이것은 Soul Spec이 페르소나에 대해 정의한 것과 정확히 같은 아키텍처 형태다. 다섯 개의 파일, 각각 선언적, 각각 Markdown으로 작성:

- `SOUL.md` — 가치 / 원칙 / 목소리
- `IDENTITY.md` — 이름 / 역할 / 정체성 앵커
- `AGENTS.md` — 워크플로 / 도구 사용 / 작업 규칙
- `STYLE.md` — 커뮤니케이션 톤
- `README.md` — 사용자 온보딩

Karpathy의 테제, 즉 능력이 `.md`로 배포된다는 주장이 옳다면, 페르소나도 같은 방식으로 배포된다. 그리고 그 둘 사이의 경계 — 무엇이 capability이고 무엇이 persona인지 — 는 자명하지 않은, 연구할 가치가 있는 질문이다.

## 시그널 2 — Anthropic: 원칙이 행동을 이긴다

5월 8일, Anthropic은 *Teaching Claude Why* 논문을 발표했다. 모델에게 **원칙과 정체성을 학습**시키는 것이 **행동**을 학습시키는 것보다 더 robust하게 일반화된다는 것을 보인 논문이다. 헤드라인 발견은 인상적이었다: Claude의 정체성 앵커(이름)를 변경하면 에이전트적 정렬 불량률이 크게 증가했고, 헌법적 원칙은 후속 강화학습을 거쳐서도 지속되었으며, 지식에 대한 합성 문서 파인튜닝과 행동 대화에 대한 SFT 조합이 올바른 이중 학습 루프로 드러났다.

이 방법론은 Soul Spec이 파일로 명세하는 것과 같은 분해를 전제로 한다: 원칙을 행동과 분리하고, 정체성을 안정적인 핸들로 두고, 지식을 문서로 작성하는 것. Anthropic의 메커니즘은 가중치 안에 있다. 우리의 메커니즘은 버전 관리된 파일 셋 안에 있다. 형태는 동일하다.

우리는 5월 15일 [Soul Spec foundation paper](https://doi.org/10.5281/zenodo.20205408)를 발표했다 — *Teaching Claude Why* 7일 후. 두 논문은 반대 방향에서 같은 결론에 도달한다: 모델이 헌법적 추론을 내재화하도록 학습시키고, 페르소나를 선언적으로 명세화해 헌법이 portable + 검토 가능 + 런타임-안정성을 갖도록 한다.

## 시그널 3 — 6월 15일 가격 정책 변경

Anthropic의 6월 15일 가격 정책은 Claude Code 사용을 두 카테고리로 분리했다. **Interactive 사용** — Claude Code 터미널 UI에 직접 입력하는 프롬프트 — 는 기존 Max 플랜의 넉넉한 한도를 유지한다 ($200/월 플랜에 $5,000–$7,500 상당 토큰). **Programmatic 사용** — GitHub Actions, CI/CD 자동화, 서드파티 도구, `claude -p` 헤드리스 모드, 표준 터미널 바깥에서 호출되는 모든 것 — 는 $200 종량제 API 예산으로 축소된다. 초과분은 retail API 가격으로 과금된다.

자동화를 돌리는 개발자에게 이것은 같은 워크플로우에 대해 약 **40배의 비용 증가**다.

이 변경의 의도는 명료한 비즈니스 전략이다: 정액 구독으로 흡수되던 자동화 사용에서 API 매출을 회수하기. 그러나 여기서 중요한 것은 아키텍처 결정에 미치는 영향이다. 2026년 5월까지 "모델 lock-in 비용"은 설계 리뷰에서 팀들이 논의하는 이론적 위험이었다. 6월 15일 이후, 그것은 정확한 달러 가치가 매겨진다. 프로그래메틱 워크플로우에서 특히, 페르소나가 단일 벤더의 가격 표면에 묶인 시스템은 이제 구체적인 비용 항목을 가진다.

Cross-model 페르소나 portability는 그 비용 항목에 대한 아키텍처적 해답이다. 이 베팅은 더 이상 이론이 아니다.

## 12주 후의 아키텍처 베팅

Soul Spec은 한 가지 전제에서 시작했다: **페르소나는 그것을 실행하는 모델보다 오래 살아남아야 한다.** 그 전제가 다섯-파일 분해, [scan-rules](https://github.com/clawsouls/scan-rules)의 런타임 검증 규칙, foundation paper에서 우리가 기술한 cross-runtime portability 보장을 이끌었다.

이 전제에는 그 당시 세 가지 동기가 있었다:

1. **비용 옵셔낼리티** — 비용/지연시간 프로파일별로 다른 모델
2. **가용성 헤징** — 벤더 장애, API 폐기, 지역 제한
3. **안전/감사** — 선언적 명세는 모델 가중치와 달리 검토 가능

4월에는 페르소나 연구 커뮤니티에서 세 번째 동기가 가장 자주 논의되었다. 5월 이후, 첫 번째 동기에 구체적인 숫자가 붙었다. 아키텍처 베팅은 동일하다. 바뀐 것은 이번 달에 어느 동기가 load-bearing으로 읽히는지다.

## 로컬 LLM 타이밍

가격 변경은 또 다른 평행한 아키텍처 베팅을 강화한다: **클라우드 LLM과 온디바이스 LLM에서 동등하게 작동하는 페르소나 명세.**

SoulClaw Mobile (Android, [Play Store](https://play.google.com/store/apps/details?id=com.clawsouls.soulclaw))은 LiteRT-LM을 통해 Gemma 4 E2B에서 Soul Spec 페르소나를 실행한다. [4-Tier Bootstrap 패턴](/ko/posts/4-tier-persona-truncation-korean-on-device/)은 작은 온디바이스 모델이 전체 페르소나 명세를 로딩할 때 직면하는 컨텍스트 윈도우 압박 문제를 다룬다. 이 패턴은 더 효율적인 페르소나를 배포하는 것이 아니다 — **graceful degradation 계약**을 배포한다. 예산이 부족할 때조차 가장 load-bearing 파일 (IDENTITY)이 살아남도록.

6월 15일 변경은 자동화 워크플로우에 대해 온디바이스 또는 오픈웨이트 (Gemma, Qwen, Llama) 배포를 평가할 강한 인센티브를 만든다. Soul Spec은 같은 모델 무관성 위에서 작성되었다: 명세 파일은 에이전트가 Claude Opus, GPT-5.5, 또는 폰 프로세스의 Gemma 4 위에서 실행되든 동일하다.

## 세 시그널, 하나의 아키텍처적 진실

세 시그널은 각각 다른 표면 — 배포 형식, 학습 방법론, 가격 정책 — 을 묘사하지만, 공통의 함의를 공유한다: **페르소나는 어느 한 모델의 기능이 아니라 인프라다.**

- Karpathy: 페르소나는 `.md`로 배포된다.
- *Teaching Claude Why*: 페르소나는 학습하는 것, 행동은 어떻게 학습하는지이다.
- 6월 15일 가격: 단일 벤더에 묶인 페르소나는 측정 가능한 비용을 가진다.

단일 모델을 중심으로 설계된 페르소나 시스템은 그 모델의 가격표, 그 모델의 안전 자세, 그 모델의 지속적 가용성을 중심으로 설계된 시스템이다. Soul Spec은 정반대의 가정 위에서 작성되었다.

---

Anthropic의 alignment 연구가 옳다면, 그 통찰의 가치는 어느 한 회사의 가격 결정보다 오래 살아남아야 한다. Soul Spec은 그 가정 위에 만들어졌다.

---

*Soul Spec foundation paper는 [Zenodo](https://doi.org/10.5281/zenodo.20205408)에서 확인할 수 있다. SoulClaw Android는 [Play Store](https://play.google.com/store/apps/details?id=com.clawsouls.soulclaw)에서 다운로드 가능하다. 58-룰 SoulScan validator는 [clawsouls/scan-rules](https://github.com/clawsouls/scan-rules)에 있다.*
