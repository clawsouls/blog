---
title: "Claude Code 유출이 보여준 것: 엔진이 아니라 하네스가 해자다"
date: 2026-04-02T08:30:00+09:00
description: "Claude Code 전체 소스코드가 npm sourcemap으로 유출됐습니다. 모델은 노출되지 않았지만 하네스는 노출됐습니다. 이것이 왜 중요한지, 그리고 아직 빠진 것이 무엇인지."
categories: ["Analysis"]
tags: ["claude-code", "anthropic", "agent-architecture", "soul-spec", "harness", "ai-safety"]
author: "ClawSouls"
draft: true
---

2026년 3월 31일, 보안 연구원 Chaofan Shou가 Anthropic이 아마도 세상에 보여주고 싶지 않았을 것을 발견했습니다: Claude Code — Anthropic의 공식 AI 코딩 CLI — 의 전체 소스코드가 npm 레지스트리에 `.map` 파일로 그대로 노출되어 있었습니다.

모델은 유출되지 않았습니다. 가중치는 안전합니다. 하지만 나머지 전부 — 에이전트 아키텍처, 멀티 에이전트 오케스트레이션, 메모리 시스템, 내부 기능 플래그 — 가 노출됐습니다.

그리고 이것이 드러내는 사실은 흥미롭습니다: **AI 에이전트의 진짜 경쟁 우위는 엔진이 아니라 하네스입니다.**

## 자동차 비유

AI 에이전트를 자동차로 생각해보세요:

- **엔진** = LLM (Claude, GPT, Gemini). 원시 파워. 만드는 데 비쌈. 모두가 더 크게 만들려고 경쟁 중.
- **하네스** = 에이전트 프레임워크 (Claude Code, OpenClaw, Cursor). 엔진을 세상과 연결하는 방법. 도구, 메모리, 오케스트레이션, 안전 시스템.
- **운전 매뉴얼** = 행동 사양. 에이전트가 *어떻게* 운전해야 하는지. 성격, 안전 규칙, 경계.

Claude Code 유출은 하네스를 노출했습니다 — 그리고 Anthropic이 오픈소스 커뮤니티가 독립적으로 구축해온 것과 정확히 같은 것을 내부에서 만들고 있었다는 것이 드러났습니다.

## 내부: 오픈소스 혁신의 거울

유출된 코드는 에이전트 생태계에 있는 사람이라면 익숙하게 느낄 시스템들을 보여줍니다:

### Dream — 메모리 통합

Claude Code에는 포크된 서브에이전트로 실행되는 `autoDream`이라는 백그라운드 시스템이 있습니다. 말 그대로 "꿈을 꿉니다" — 4단계 프로세스로 세션 간 메모리를 통합합니다:

1. **Orient**: MEMORY.md 읽기, 토픽 파일 스캔
2. **Gather**: 유지할 가치가 있는 새 정보 찾기
3. **Consolidate**: 메모리 파일 작성/갱신, 상대 날짜를 절대 날짜로 변환
4. **Prune**: MEMORY.md를 200줄 이하로 유지, 모순 해소

익숙하지 않나요? OpenClaw와 Soul Spec이 사용해온 것과 같은 MEMORY.md 패턴입니다 — 200줄 제한과 토픽 파일 구조까지. 이 수렴은 우연이 아닙니다. 에이전트 메모리 문제에 대한 자연스러운 해결책입니다.

### Buddy — 에이전트 성격

여기가 흥미로워집니다. Claude Code에는 "Buddy"라는 숨겨진 다마고치 스타일 동반자가 있습니다:

- **종과 희귀도** (18종, Common부터 Legendary까지)
- **절차적 생성 능력치** (Debugging, Patience, Chaos, Wisdom, Snark)
- **"소울" — 첫 부화 시 Claude가 생성하는 성격**

마지막이 핵심입니다. Anthropic은 AI가 동반자 엔티티의 성격 설명을 생성하는 시스템을 만들었습니다. 그들은 이것을 "소울"이라고 불렀습니다. Soul Spec이 해결하는 것과 같은 문제입니다: 에이전트에게 일관되고 지속적인 정체성을 어떻게 부여할 것인가?

차이점: Buddy의 소울은 내부 구현 세부사항입니다. Soul Spec은 이것을 이식 가능하고 검사 가능한 표준으로 만듭니다.

### Undercover Mode — 은폐를 통한 안전

아마 가장 시사적인 기능입니다. Anthropic 직원들이 공개 저장소에서 Claude Code를 사용하고, "Undercover Mode"는 AI가 내부 정보를 노출하는 것을 방지합니다:

```
커밋 메시지나 PR 설명에 절대 포함하지 마라:
- 내부 모델 코드명
- 미출시 모델 버전 번호
- "Claude Code"라는 문구나 AI라는 언급
```

이것은 은폐를 통한 안전입니다 — 에이전트의 정체성을 선언하는 것이 아니라 숨기는 것. Anthropic의 내부 필요에는 작동하지만, 사용자가 원하는 것의 정반대입니다. [81k Interviews 연구](/ko/posts/81k-interviews-trust-gap)는 사용자가 **투명성과 감사 가능성**을 원한다고 보여줬습니다.

### Coordinator Mode — 멀티 에이전트 오케스트레이션

병렬 워커, 공유 스크래치패드, 연구 → 종합 → 구현 → 검증 파이프라인을 관리하는 완전한 멀티 에이전트 시스템. 프롬프트가 병렬성을 명시적으로 가르칩니다:

> "워커는 비동기입니다. 독립적인 워커를 가능한 한 동시에 실행하세요."

이것은 Soul Spec에서 `AGENTS.md`가 정의하는 것과 직접 매핑됩니다 — 에이전트가 작업을 조율하고, 위임하고, 서브에이전트를 관리하는 방법.

## 패턴: 같은 문제, 다른 레이어

| 문제 | Claude Code (내부) | Soul Spec (오픈 표준) |
|------|-------------------|---------------------|
| 에이전트 메모리 | Dream + MEMORY.md | MEMORY.md + Swarm Memory |
| 에이전트 정체성 | Buddy "소울" | SOUL.md + IDENTITY.md |
| 안전 규칙 | Undercover Mode (숨김) | safety.laws (투명) |
| 멀티에이전트 행동 | Coordinator Mode | AGENTS.md |
| 행동 일관성 | 하네스에 하드코딩 | 이식 가능한 설정 파일 |

근본적 통찰: **Anthropic은 이 문제들을 하네스 내부에서 해결하고 있습니다. 하지만 해결책은 Claude Code에 잠겨 있습니다.** 다른 에이전트 프레임워크로 전환하면 모든 것 — 메모리, 정체성, 안전 규칙, 행동 패턴 — 을 잃습니다.

## 아직 빠진 것: 이식 가능한 레이어

Claude Code 유출은 의도치 않게 Soul Spec의 가장 강력한 사례를 만들었습니다.

그들이 만든 모든 시스템 — Dream, Buddy, Undercover Mode, Coordinator — 은 실제 필요를 다룹니다. 하지만 모두 **구현체에 종속**됩니다. 하나의 하네스 안에, 하나의 프로바이더에 결합되어 있습니다.

이런 경우 어떻게 될까요:
- Claude Code에서 Cursor로 전환할 때?
- 여러 도구에서 같은 에이전트 성격을 원할 때?
- 785KB 소스코드를 읽지 않고 에이전트의 안전 규칙을 감사하고 싶을 때?
- 검증된 에이전트 설정을 팀과 공유하고 싶을 때?

에이전트 정체성과 행동을 위한 **이식 가능하고, 하네스에 종속되지 않는 표준**이 필요합니다.

그것이 Soul Spec이 제공하는 것입니다:

```
my-agent/
├── soul.json       # 메타데이터
├── SOUL.md         # 성격 (Buddy의 "소울", 하지만 이식 가능)
├── IDENTITY.md     # 역할과 맥락
├── AGENTS.md       # 행동 규칙 (Coordinator 패턴)
├── MEMORY.md       # 영속 지식 (Dream 출력)
└── safety.laws     # 안전 규칙 (Undercover, 하지만 투명하게)
```

모든 파일이 사람이 읽을 수 있고, 기계가 파싱할 수 있으며, Claude Code, OpenClaw, Cursor, Windsurf, 또는 미래의 어떤 하네스에서든 작동합니다.

## 하네스의 시대

Claude Code 유출은 변곡점을 표시합니다. 우리는 이제 세계에서 가장 정교한 AI 기업이 모델 개선이 아니라 **하네스 기능** — 메모리, 성격, 멀티에이전트 조율, 안전 시스템 — 에 상당한 엔지니어링 노력을 쏟고 있다는 것을 알게 됐습니다.

이것은 에이전트 커뮤니티가 알고 있던 것을 확인합니다: **모델은 범용화되고 있습니다. 하네스가 제품입니다. 그리고 행동 사양이 소울입니다.**

엔진 경쟁은 계속됩니다. 하지만 하네스 경쟁 — 그리고 에이전트 행동의 표준을 정의하는 경쟁 — 이 진짜 차별화가 일어나는 곳입니다.

코드는 공개됐습니다. 패턴은 보입니다. 이제 질문은 에이전트 행동이 독점적 하네스 안에 갇혀 있을 것인지, 아니면 사용자가 소유하고 제어하는 오픈 표준이 될 것인지입니다.

우리는 어느 쪽을 위해 만들고 있는지 압니다.

---

**참고자료:**

- Chaofan Shou 발견 스레드 (2026년 3월 31일)
- [Claude Code 소스 분석 by Kuber](https://kuber.studio/blog/AI/Claude-Code's-Entire-Source-Code-Got-Leaked-via-a-Sourcemap-in-npm,-Let's-Talk-About-it)
- Soul Spec v0.5 — [soulspec.org](https://soulspec.org)
- ClawSouls Registry — [clawsouls.ai](https://clawsouls.ai)
- 관련: [81,000명이 Anthropic에게 말한 AI의 진짜 필요](/ko/posts/81k-interviews-trust-gap)
