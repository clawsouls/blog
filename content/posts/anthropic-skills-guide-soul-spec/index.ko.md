---
title: "Anthropic Skills 공식 가이드 발표 — Soul Spec과 무엇이 다른가"
date: 2026-02-25T09:00:00+09:00
draft: false
tags: ["anthropic", "skills", "soul-spec", "에이전트", "표준화"]
categories: ["분석"]
description: "Anthropic이 Skills의 완전한 빌딩 가이드를 공개했다. SKILL.md와 Soul Spec의 soul.json은 어떻게 다르고, 왜 둘 다 필요한가."
---

Anthropic이 "The Complete Guide to Building Skills for Claude"를 발표했다. 33페이지 분량의 이 문서는 Claude 에이전트의 **워크플로우 지식**을 패키징하는 공식 표준을 정의한다.

ClawSouls가 만든 Soul Spec은 에이전트의 **정체성과 페르소나**를 정의한다. 이름은 비슷해 보이지만, 해결하는 문제가 다르다.

## Skills가 하는 일

Skill은 폴더 하나다:

```
your-skill/
├── SKILL.md          # 필수 — 워크플로우 지침
├── scripts/          # 선택 — 실행 가능한 코드
├── references/       # 선택 — 참고 문서
└── assets/           # 선택 — 템플릿, 아이콘
```

`SKILL.md`의 YAML frontmatter가 핵심이다. Claude는 이 메타데이터를 보고 언제 어떤 skill을 로드할지 결정한다.

```yaml
---
name: sprint-planner
description: Linear 프로젝트 워크플로우 관리. "스프린트", "태스크 생성" 요청 시 사용.
---
```

**Progressive Disclosure** 3단계 구조로 토큰을 절약한다:
1. **Frontmatter** — 항상 시스템 프롬프트에 로드 (언제 쓸지 판단)
2. **SKILL.md 본문** — 관련 있을 때만 로드 (실제 지침)
3. **링크된 파일** — 필요할 때만 탐색 (상세 참고자료)

## Soul Spec이 하는 일

Soul Spec은 에이전트의 **정체성**을 정의한다:

```
my-agent/
├── soul.json         # 메타데이터 (이름, 설명, 태그)
├── SOUL.md           # 성격, 톤, 원칙
├── IDENTITY.md       # 기본 정보
└── USER.md           # 사용자 컨텍스트
```

Skills가 "무엇을 어떻게 하는가"라면, Soul Spec은 "누구로서 하는가"다.

## 비교

| | Skills (SKILL.md) | Soul Spec (soul.json) |
|---|---|---|
| **목적** | 워크플로우 지식 | 페르소나·정체성 |
| **핵심 질문** | "어떻게 하는가?" | "누구인가?" |
| **트리거** | 사용자 요청 기반 | 항상 활성 |
| **다중 로드** | 여러 skill 동시 사용 | 하나의 페르소나 |
| **MCP 연동** | 직접 지원 | 간접 (skill과 조합) |
| **표준화** | Anthropic 독점 | 오픈 스펙 (LLM 무관) |

## 왜 둘 다 필요한가

Anthropic은 Skills를 **주방 비유**로 설명한다:
- MCP = 전문 주방 (도구, 재료, 장비)
- Skills = 레시피 (단계별 조리법)

여기에 Soul Spec을 더하면:
- **Soul = 셰프** (경험, 스타일, 철학)

같은 레시피라도 셰프에 따라 결과가 다르다. 고객 온보딩 워크플로우를 "친절하고 꼼꼼한 Brad"가 실행하는 것과 "빠르고 효율적인 Kira"가 실행하는 것은 다른 경험이다.

## Skills 가이드의 주목할 점

**1. Skills API 공개**
- `/v1/skills` 엔드포인트로 프로그래밍 방식 관리
- Messages API의 `container.skills` 파라미터로 스킬 주입
- Agent SDK와 연동

**2. 조직 단위 배포**
- 관리자가 워크스페이스 전체에 스킬 배포 가능 (2025.12 출시)
- 자동 업데이트, 중앙 관리

**3. 5가지 패턴**
- Sequential Workflow (순차 실행)
- Multi-MCP Coordination (다중 서비스 연동)
- Iterative Refinement (반복 개선)
- Context-aware Tool Selection (상황별 도구 선택)
- Domain-specific Intelligence (도메인 전문성)

**4. 오픈 표준 선언**
> "We've published Agent Skills as an open standard. Like MCP, we believe skills should be portable across tools and platforms."

MCP처럼 Skills도 오픈 표준을 지향한다. Soul Spec이 처음부터 추구한 방향과 같다.

## 실전: Skills + Soul Spec 조합

```
my-agent/
├── soul.json          # 에이전트 정체성
├── SOUL.md            # 성격과 원칙
├── IDENTITY.md        # 기본 정보
├── skills/
│   ├── sprint-planner/
│   │   └── SKILL.md   # 스프린트 기획 워크플로우
│   └── code-review/
│       └── SKILL.md   # 코드 리뷰 워크플로우
```

Soul이 "누구인가"를 정하고, Skills가 "무엇을 하는가"를 정한다. 이 조합이 **완전한 에이전트 패키지**다.

## 의미

Anthropic이 Skills를 33페이지 가이드로 공식화한 것은 에이전트 에코시스템이 성숙하고 있다는 신호다.

- **MCP** → 에이전트가 세상과 연결되는 방법 (2024)
- **Skills** → 에이전트가 일하는 방법 (2025-2026)
- **Soul Spec** → 에이전트가 존재하는 방법

세 레이어 모두 오픈 표준을 지향하고, 서로 다른 문제를 해결한다. 경쟁이 아니라 완성이다.

---

*Soul Spec은 [clawsouls.ai](https://clawsouls.ai)에서 확인할 수 있다. Skills와 함께 사용하는 가이드는 곧 공개 예정.*
