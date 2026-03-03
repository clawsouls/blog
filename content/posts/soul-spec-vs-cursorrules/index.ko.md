---
title: "Soul Spec vs .cursorrules — AI 에이전트 설정에 표준이 필요한 이유"
date: 2026-02-24T21:30:00+09:00
description: ".cursorrules, CLAUDE.md, .windsurfrules, Soul Spec 비교. 파편화된 AI 에이전트 설정 포맷에 왜 오픈 표준이 필요한지, 어떻게 마이그레이션하는지 알아봅니다."
categories: ["Insights"]
tags: ["soul-spec", "cursorrules", "claude-md", "windsurfrules", "ai-config", "migration"]
slug: "soul-spec-vs-cursorrules"
draft: false
keywords: ["cursorrules vs soul spec", "claude.md vs soul.md", "cursorrules 예시", "soul.md 템플릿"]
---

## 문제: 모든 도구가 자체 설정 파일을 갖고 있다

2026년에 AI 코딩 도구를 쓰고 있다면, 아마 이 파일들 중 하나는 만들어봤을 겁니다:

- **`.cursorrules`** — Cursor의 프로젝트 레벨 AI 지침
- **`CLAUDE.md`** — Claude Code의 페르소나 설정
- **`.windsurfrules`** — Windsurf의 대응물

전부 같은 일을 합니다: AI에게 어떻게 행동할지 알려주는 것. 하지만 어느 것도 자기 도구 밖에서는 작동하지 않습니다.

Cursor에서 Claude Code로 갈아탔나요? 설정을 다시 쓰세요. 공들여 만든 페르소나를 팀과 공유하고 싶다고요? Gist에 복붙하고 아무 문제 없길 기도하세요.

`.bashrc` 문제의 재탕입니다 — 다만 이번에는 벤더에 종속되는 게 AI의 성격이라는 점이 다릅니다.

## 포맷 비교

각 포맷이 실제로 제공하는 것을 비교해봅시다:

| 기능 | .cursorrules | CLAUDE.md | .windsurfrules | Soul Spec |
|------|:---:|:---:|:---:|:---:|
| 크로스 플랫폼 이식성 | ❌ | ❌ | ❌ | ✅ |
| 구조화된 섹션 | ❌ | ❌ | ❌ | ✅ |
| 보안 스캐닝 | ❌ | ❌ | ❌ | ✅ (SoulScan) |
| 커뮤니티 레지스트리 | ❌ | ❌ | ❌ | ✅ (ClawSouls) |
| 시맨틱 버전 관리 | ❌ | ❌ | ❌ | ✅ |
| 멀티 파일 아키텍처 | ❌ | ❌ | ❌ | ✅ |
| 도구 투명성 | ❌ | ❌ | ❌ | ✅ |
| 라이선스 관리 | ❌ | ❌ | ❌ | ✅ |

### .cursorrules

Cursor의 포맷은 프로젝트 루트에 넣는 평문 파일입니다. 단순합니다 — 이것이 장점이자 한계입니다.

```
// .cursorrules
You are a senior TypeScript developer.
Always use functional components.
Prefer composition over inheritance.
Write tests for all new functions.
```

**장점:** 시작이 쉽고 오버헤드가 없음.
**단점:** 구조 없음, 이식성 없음, 공유나 버전 관리 방법 없음.

### CLAUDE.md

Anthropic의 Claude Code용 접근법. 마크다운 기반, 세션 시작 시 읽힘.

```markdown
# CLAUDE.md
You are an expert full-stack engineer.
- Use TypeScript strict mode
- Follow clean architecture patterns
- Always handle errors explicitly
```

**장점:** 마크다운은 읽기 쉽고 자연스럽게 구조화됨.
**단점:** Claude 전용, 공식 스키마 없음, 생태계 없음.

### .windsurfrules

Windsurf의 설정 포맷. .cursorrules와 기능적으로 동일 — 같은 아이디어에 다른 파일 이름.

**장점:** .cursorrules를 써봤다면 익숙함.
**단점:** 또 하나의 벤더 전용 포맷.

### Soul Spec

관심사를 여러 파일로 분리하고 공식 스키마를 가진 오픈 표준:

```markdown
# SOUL.md — Senior TypeScript Developer

## Personality
You are a senior TypeScript developer with deep expertise
in modern web development. You value clean, type-safe code.

## Tone
- Technical and precise
- Opinionated but respectful

## Principles
- Functional components over class components
- Composition over inheritance
- Tests are non-negotiable

## Expertise
- TypeScript, React, Node.js
- Clean architecture, TDD
```

**추가 파일:** 메타데이터를 위한 `soul.json`, 경량 정체성을 위한 `IDENTITY.md`, 운영 동작을 위한 `AGENTS.md`, 글쓰기 스타일을 위한 `STYLE.md`, 자율 작업을 위한 `HEARTBEAT.md`.

## 이식성이 중요한 이유

"나는 Cursor만 쓰는데, 왜 신경 써야 하지?"라고 생각할 수 있습니다.

세 가지 이유:

1. **도구는 빠르게 바뀝니다.** 작년의 인기 IDE가 올해의 레거시입니다. 페르소나가 도구와 함께 죽어서는 안 됩니다.
2. **팀은 다른 도구를 씁니다.** 여러분의 .cursorrules는 Claude Code를 쓰는 팀원에게 보이지 않습니다.
3. **공유가 가치를 만듭니다.** 최고의 페르소나는 발견 가능해야지, 비공개 리포에 묻혀 있으면 안 됩니다.

## 보안: 숨겨진 위험

아무도 이야기하지 않는 것이 있습니다: **공유된 AI 설정은 공격 벡터입니다.**

GitHub gist에서 누군가의 .cursorrules를 복사할 때, 다음이 포함되지 않았다고 신뢰하는 겁니다:
- 프롬프트 인젝션 공격
- 데이터 유출 지침
- 숨겨진 동작 변경

Soul Spec은 **SoulScan**으로 이를 해결합니다 — Soul이 레지스트리에 퍼블리시되기 전에 악성 패턴을 검사하는 자동화된 보안 분석. ClawSouls의 모든 Soul은 SoulScan 검증을 통과합니다.

## 마이그레이션: .cursorrules에서 Soul Spec으로

마이그레이션은 간단합니다. 실제 예시를 보겠습니다:

### Before (.cursorrules)

```
You are a senior full-stack developer.
Use TypeScript strict mode always.
Prefer functional programming patterns.
Write unit tests for all functions.
Use descriptive variable names.
Handle all errors explicitly.
Never use any type.
```

### After (SOUL.md)

```markdown
# SOUL.md — Senior Full-Stack Developer

## Personality
You are a senior full-stack developer who treats code quality
as a craft. You've seen enough production incidents to know
that shortcuts always cost more than they save.

## Tone
- Direct and technical
- Confident, but acknowledges trade-offs

## Principles
- TypeScript strict mode, always
- Functional patterns over OOP
- Every function gets a test
- Descriptive names > comments
- Explicit error handling, no swallowing errors
- Never use `any` — find the real type

## Expertise
- TypeScript, React, Node.js
- Testing (Jest, Vitest)
- Clean architecture
```

차이를 보셨나요? Soul Spec 버전은 단순한 규칙 목록이 아니라 *캐릭터*입니다. 성격이 있고, 의견이 있으며, 규칙 뒤에 이유가 있습니다.

### 3단계

1. **내보내기** — `.cursorrules` 또는 `CLAUDE.md` 내용 복사
2. **변환** — SOUL.md 섹션으로 재구성 (Personality, Tone, Principles, Expertise, Boundaries)
3. **설치** — `npx clawsouls init` (`--spec 0.3/0.4/0.5` 지원)으로 전체 Soul 패키지 생성

또는 수작업을 건너뛰고 80개 이상의 커뮤니티 Soul을 둘러보세요:

```bash
npx clawsouls install clawsouls/surgical-coder --use claude-code
```

## 왜 표준화가 필요한가

AI 에이전트 생태계는 변곡점에 있습니다. "AI 기능이 있는 도구"에서 "도구를 사용하는 AI 에이전트"로 이동하고 있습니다. 이 전환이 완료되면, 성격 레이어는 인프라가 됩니다 — 있으면 좋은 것이 아니라 필수 구성 요소로.

파편화되고 벤더에 종속된 설정 포맷은 확장되지 않습니다. 우리에게 필요한 것:

- **이식성** — 한 번 작성하고, 어디서나 사용
- **보안** — 검증되고, 스캔된 페르소나
- **공유** — 최고의 페르소나가 부각되는 레지스트리
- **버전 관리** — 변경 추적, 실수 롤백
- **구조** — 성격, 어조, 경계에 대한 공유 어휘

이것이 Soul Spec이 제공하는 것입니다. .cursorrules를 대체하는 것이 아니라 — AI 에이전트 설정에 패키지 관리, CI/CD, Infrastructure as Code에 주는 것과 같은 엄격함을 부여하는 것입니다.

---

*Soul Spec은 오픈 표준입니다. [스펙 보기 →](https://clawsouls.ai/spec) | [Soul 둘러보기 →](https://clawsouls.ai/souls)*
