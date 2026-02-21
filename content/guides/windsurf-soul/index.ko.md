---
title: "Windsurf에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Soul Spec으로 Windsurf AI에 지속적인 페르소나를 부여하는 방법. Soul을 .windsurfrules로 변환하면 자동 적용."
categories: ["Guides"]
tags: ["soul-spec", "windsurf", "persona", "guide", "tutorial", "codeium"]
---

## 개요

[Windsurf](https://windsurf.com) (Codeium)는 AI 코드 에디터다. 프로젝트 루트의 `.windsurfrules` 파일이나 설정의 글로벌 규칙으로 커스텀 지침을 지원한다.

**Soul Spec으로 Windsurf에 진짜 페르소나를 줄 수 있다.** ClawSouls에서 Soul을 설치하고 `.windsurfrules`로 변환하면 일관된 정체성이 적용된다.

## 빠른 시작 (2분)

### 1단계: CLI 설치

```bash
npm install -g clawsouls
```

### 2단계: Soul 설치

[clawsouls.ai/souls](https://clawsouls.ai/souls)에서 둘러본 후:

```bash
clawsouls install clawsouls/surgical-coder
```

### 3단계: Windsurf 포맷으로 변환

```bash
clawsouls export windsurfrules --dir ./surgical-coder -o ./my-project/.windsurfrules
```

### 4단계: Windsurf에서 열기

```bash
windsurf ./my-project
```

Windsurf가 `.windsurfrules`를 자동으로 읽는다. AI 어시스턴트에 페르소나가 적용됐다.

## 작동 원리

Windsurf는 다음 위치에서 커스텀 지침을 로드한다:

1. **`.windsurfrules`** — 프로젝트 루트의 파일 (프로젝트별)
2. **글로벌 규칙** — Windsurf 설정 (모든 프로젝트에 적용)

`export windsurfrules` 명령이 Soul Spec 파일들을 하나의 `.windsurfrules` 파일로 합쳐준다. Soul Spec은 OpenClaw 같은 프레임워크에서 사용하는 멀티파일 페르소나 패턴을 표준화한다:

| Soul Spec 파일 | Windsurf가 받는 것 |
|---|---|
| `SOUL.md` | 핵심 성격 & 원칙 |
| `IDENTITY.md` | 에이전트 이름, 역할, 특성 |
| `STYLE.md` | 커뮤니케이션 톤 & 선호 |
| `AGENTS.md` | 워크플로우 & 행동 규칙 |

## 글로벌 규칙

모든 프로젝트에 적용되는 페르소나를 원한다면, 변환된 내용을 Windsurf 글로벌 규칙에 추가:

1. Windsurf 설정 열기
2. "Rules" 검색
3. Soul Spec 내용을 글로벌 규칙 필드에 붙여넣기

프로젝트별 `.windsurfrules`가 글로벌 규칙보다 우선 적용된다.

## MCP 서버 옵션

Windsurf는 MCP 서버를 지원한다. soul-spec-mcp를 설치하면 에디터 안에서 페르소나를 관리할 수 있다:

Windsurf의 MCP 설정에 추가:

```json
{
  "soul-spec": {
    "command": "npx",
    "args": ["-y", "soul-spec-mcp"]
  }
}
```

그다음 Windsurf에서: *"surgical-coder 페르소나 적용해줘"*.

## 팁

- **프로젝트별 페르소나.** 프로젝트마다 다른 `.windsurfrules` 사용 가능.
- **Git 친화적.** `.windsurfrules`를 커밋하면 팀과 페르소나 공유.
- **기술 규칙과 병용.** 페르소나 내용과 함께 프로젝트별 코딩 규칙도 추가 가능.
- **SoulScan.** `npx clawsouls soulscan`으로 사용 전 페르소나 패키지 검증.
- **쉬운 업데이트.** Soul 업데이트 시: `clawsouls install <name> -f && clawsouls export windsurfrules --dir ...`

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- 보안 검증: [SoulScan](https://clawsouls.ai/soulscan)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
