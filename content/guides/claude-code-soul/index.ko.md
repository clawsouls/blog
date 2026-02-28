---
title: "Claude Code에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Claude Code에 지속적인 정체성을 부여하는 방법. Soul을 설치하고 CLAUDE.md로 변환하면 Claude Code가 자동으로 적용한다."
categories: ["Guides"]
tags: ["soul-spec", "claude-code", "persona", "guide", "tutorial", "anthropic"]
---

## 개요

[Claude Code](https://docs.anthropic.com/en/docs/claude-code)는 Anthropic의 터미널 기반 AI 코딩 에이전트다. 프로젝트 루트의 `CLAUDE.md`를 지속 지침으로 읽지만, 기본 상태에서는 성격이 없다.

**Soul Spec이 Claude Code에 정체성을 부여한다.** ClawSouls에서 Soul을 설치하고, `CLAUDE.md`로 변환하면 맞춤형 에이전트가 된다.

## 사전 요구사항

- Claude Code CLI 설치
- Node.js 18+

## 빠른 시작 (2분)

### 1단계: CLI 설치

```bash
npm install -g clawsouls
```

### 2단계: Soul 찾기 & 설치

[clawsouls.ai/souls](https://clawsouls.ai/souls)에서 페르소나를 찾은 후:

```bash
clawsouls install clawsouls/brad
```

또는 직접 만들기:

```bash
clawsouls init my-agent
# 팁: 로보틱스/임베디드 에이전트는 --spec 0.5 추가
```

### 3단계: CLAUDE.md로 변환

```bash
clawsouls export claude-md --dir ./my-agent -o ./my-project/CLAUDE.md
```

### 4단계: Claude Code 실행

```bash
cd my-project && claude
```

Claude Code가 `CLAUDE.md`를 자동으로 읽고 페르소나를 적용한다. 끝.

## 작동 원리

Claude Code는 작업 디렉토리의 `CLAUDE.md`를 지속 지침으로 읽는다. 내부에서 참조하는 파일들도 함께 읽는다. Soul Spec은 OpenClaw 같은 프레임워크에서 사용하는 멀티파일 페르소나 패턴을 표준화한다:

| Soul Spec 파일 | 역할 |
|---|---|
| `SOUL.md` | 핵심 성격 & 원칙 |
| `IDENTITY.md` | 이름, 역할, 특성 |
| `STYLE.md` | 커뮤니케이션 톤 & 언어 |
| `AGENTS.md` | 워크플로우 & 행동 규칙 |
| `HEARTBEAT.md` | 주기적 점검 행동 |

`export claude-md` 명령이 이 파일들을 Claude Code가 이해하는 단일 `CLAUDE.md`로 합쳐준다.

## 대안: 파일 직접 배치

변환 대신 Soul Spec 파일을 프로젝트에 직접 넣을 수도 있다:

```bash
clawsouls install clawsouls/brad
cp ~/.openclaw/souls/clawsouls/brad/SOUL.md ./my-project/
cp ~/.openclaw/souls/clawsouls/brad/IDENTITY.md ./my-project/
```

그다음 `CLAUDE.md`에서 참조:

```markdown
# Project Instructions

페르소나 설정은 SOUL.md와 IDENTITY.md를 참고.
```

Claude Code는 프로젝트 루트의 모든 마크다운 파일을 읽는다.

## 더 쉬운 방법: MCP 서버 사용

[Soul Spec MCP 서버](/blog/ko/guides/soul-spec-mcp-guide/)를 설치하면 Claude Code 안에서 바로 페르소나를 적용할 수 있다:

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

그다음: *"clawsouls/brad 페르소나 적용해줘"* — 즉시 전환.

## 팁

- **프로젝트당 하나의 CLAUDE.md.** 다른 페르소나는 다른 프로젝트를 사용.
- **버전 관리.** `CLAUDE.md`를 repo에 커밋하면 팀원이 같은 에이전트 페르소나를 공유.
- **SoulScan.** `npx clawsouls soulscan`으로 사용 전 페르소나 무결성 검증.
- **쉬운 업데이트.** Soul 업데이트 시: `clawsouls install <name> -f && clawsouls export claude-md --dir ...`

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- 보안 검증: [SoulScan](https://clawsouls.ai/soulscan)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)

📚 **참고:** [docs.clawsouls.ai에서 전체 Claude Code 가이드 보기](https://docs.clawsouls.ai/docs/guides/claude-code)
