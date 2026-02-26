---
title: "새 연구: AGENTS.md가 AI를 더 멍청하게 만든다? — 하지만 반전이 있다"
date: 2026-02-26T10:00:00+09:00
draft: false
description: "ETH Zurich 연구팀이 AGENTS.md 파일이 코딩 에이전트 성능을 떨어뜨리고 비용을 20% 증가시킨다는 결과를 발표했습니다. 하지만 진짜 교훈은 컨텍스트 파일을 지우라는 게 아닙니다 — 더 잘 쓰라는 겁니다."
categories: ["Research"]
tags: ["context-engineering", "agents-md", "soul-spec", "soulscan", "ai-agents", "research"]
slug: "agents-md-hurts-or-helps"
---

## AI 커뮤니티를 놀라게 한 헤드라인

ETH Zurich에서 폭탄 같은 논문이 나왔습니다: **AGENTS.md 파일이 코딩 에이전트를 더 못하게 만든다.**

["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988) (Gloaguen, Mündler, Müller, Raychev, Vechev) 논문은 컨텍스트 파일이 실제로 AI 코딩 에이전트의 작업 완료에 도움이 되는지 테스트했습니다. 결과:

- 컨텍스트 파일 제공 시 **작업 성공률 하락**
- **추론 비용 20% 이상 증가**
- LLM이 생성한 파일과 개발자가 작성한 파일 **모두** 문제 유발
- 에이전트는 지시를 충실히 따랐지만 — 그 지시가 에이전트를 더 나쁘게 만듦

결론? 컨텍스트 파일이 "불필요한 요구사항"을 도입해서 작업을 어렵게 만든다는 것. 권고: **최소한의 필수 요구사항만 기술하라.**

CLAUDE.md, AGENTS.md 또는 어떤 프로젝트 컨텍스트 파일을 쓰고 있다면 불안할 수 있습니다. 하지만 다 지우기 전에 — 실제로 무슨 일이 벌어지고 있는지 봅시다.

## 두 논문, 정반대의 결론

흥미로운 건 이겁니다. 불과 몇 주 전, 다른 연구팀이 **정확히 같은 주제**에 대해 **정반대 결과**를 발표했습니다.

[Lulla et al. (2601.20404)](https://arxiv.org/abs/2601.20404), ICSE JAWS 제출 중인 연구에서 구조화된 AGENTS.md 파일은:

- **실행 시간 28% 단축**
- **토큰 사용량 16% 감소**
- 에이전트 효율성을 측정 가능하게 개선

그래서 어느 쪽이 맞을까요? 컨텍스트 파일은 도움이 될까요, 해가 될까요?

## 답: 품질에 달려 있다

두 연구가 실제로 무엇을 테스트했는지 보면 모순이 해소됩니다.

**Gloaguen et al.** 이 테스트한 것:
1. LLM이 생성한 컨텍스트 파일 (에이전트 개발자 가이드라인 따름)
2. 개발자가 이미 레포에 커밋한 파일들

두 경우 모두, 파일에 **너무 많은 정보**가 담겨 있었습니다 — 아키텍처 개요, 코딩 표준, 테스트 요구사항, 스타일 가이드 — 관련성과 상관없이 모든 작업에 로드됨.

**Lulla et al.** 은 더 집중된 파일을 연구했고, 개발자들이 자연스럽게 지시를 구조화하는 방식을 분석했습니다.

패턴은 명확합니다:

| 컨텍스트 품질 | 효과 |
|---|---|
| 비대한 만능 파일 | ❌ 성능 저하, 비용 증가 |
| 집중된 최소 요구사항 | ✅ 효율성 향상 |
| LLM이 생성, 검토 없음 | ❌ 아무것도 안 주는 것보다 나쁨 |
| 사람이 큐레이션, 작업 관련 | ✅ 측정 가능한 개선 |

**문제는 컨텍스트 파일이 아닙니다. 나쁜 컨텍스트 파일이 문제입니다.**

## 세 가지 실패 모드

ETH Zurich 논문이 식별한 컨텍스트 파일의 구체적 문제점:

### 1. 불필요한 탐색
컨텍스트 파일에 "항상 전체 테스트 스위트를 실행하라" 또는 "관련 모듈을 모두 검토하라"고 쓰여 있으면, 에이전트는 순종적으로 필요 이상의 코드를 탐색합니다. 에너지 낭비. 집중력 상실.

### 2. 중복 정보
현대 코딩 에이전트는 프로젝트 구조를 스스로 파악하는 데 이미 뛰어납니다. 에이전트가 이미 알 수 있는 정보를 알려주면 도움이 안 됩니다 — 노이즈만 추가될 뿐.

### 3. 관련 없는 요구사항
아키텍처 결정, 코딩 스타일, 배포 워크플로우 — 일부 작업에는 중요하지만 다른 작업에는 순수한 노이즈입니다. 이메일 하나 답장하기 전에 직원 핸드북 전체를 읽는 것과 같습니다.

## Soul Spec에의 시사점

Soul Spec은 이 논문이 권고하는 정확히 그 원칙 — **최소한의, 구조화된, 목적별로 분리된 컨텍스트** — 을 중심으로 설계되었습니다.

### 관심사의 분리
Soul Spec은 모든 것을 하나의 파일에 넣지 않습니다. 정체성은 `SOUL.md`에, 코딩 규칙은 `AGENTS.md`에, 도구 설정은 `TOOLS.md`에. 각 파일은 명확한 목적이 있고, 에이전트는 관련된 것만 로드합니다.

```
my-soul/
├── soul.json        # 메타데이터
├── SOUL.md          # 정체성과 성격 (항상 로드)
├── IDENTITY.md      # 이름, 역할, 아바타
├── AGENTS.md        # 코딩 규칙 (개발 작업 시 로드)
└── TOOLS.md         # 도구 설정
```

### 양보다 질
논문은 LLM이 생성한 파일이 파일 없는 것보다 *더 나쁘다*고 밝혔습니다. [SoulScan](https://clawsouls.ai/soulscan)이 존재하는 이유가 바로 이겁니다 — 53개 보안 및 품질 패턴으로 페르소나 패키지를 검사하여, 비대한 파일, 모순된 지시, 혼란을 주는 콘텐츠를 잡아냅니다.

### 설계부터 최소주의
Soul Spec v0.5는 최소한의 핵심 정의를 명시적으로 권장합니다. `SOUL.md`에는 정체성, 성격, 행동 규칙만 — 프로젝트 아키텍처 전체를 넣으면 안 됩니다. 스펙의 파일 구조가 자연스럽게 이 분리를 강제합니다.

## 진짜 교훈

컨텍스트 파일을 지우지 마세요. **고치세요.**

ETH Zurich 논문과 Lulla et al. 논문은 서로 모순되는 게 아닙니다 — 다른 것을 측정한 겁니다. 둘을 함께 보면 일관된 이야기가 나옵니다:

1. **나쁜 컨텍스트는 없는 것보다 나쁘다** — 비대한 파일 자동 생성을 멈추세요
2. **좋은 컨텍스트는 측정 가능하게 성능을 향상시킨다** — 집중된 사람 큐레이션이 작동합니다
3. **구조가 중요하다** — 관심사를 분리하고, 관련된 것만 로드하세요
4. **품질 검증은 필수다** — 프로덕션에 들어가기 전에 컨텍스트 파일을 체크하는 무언가가 필요합니다

이것이 Soul Spec과 SoulScan으로 우리가 만들어온 것입니다. 더 많은 컨텍스트가 아니라 — *더 나은* 컨텍스트.

---

## 참고 문헌

- Gloaguen et al., ["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988), arXiv:2602.11988, February 2026
- Lulla et al., ["Evaluating the Impact of AGENTS.md"](https://arxiv.org/abs/2601.20404), under submission to ICSE JAWS
- Mohsenimofidi et al., ["Context Engineering for AI Agents in Open-Source Software"](https://arxiv.org/abs/2510.21413), MSR 2026
- Baltes et al., ["Repository-Level Configuration Mechanisms for Agentic AI Coding Tools"](https://arxiv.org/abs/2602.14690), arXiv:2602.14690, February 2026

---

*Soul Spec은 AI 에이전트 페르소나를 위한 오픈 표준입니다. [80+ 커뮤니티 Soul 둘러보기 →](https://clawsouls.ai/souls)*
