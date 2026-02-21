---
title: "Cursor에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Soul Spec으로 Cursor AI에 지속적인 페르소나를 부여하는 방법. Soul을 설치하고 .cursor/rules/에 넣으면 자동 적용."
categories: ["Guides"]
tags: ["soul-spec", "cursor", "persona", "guide", "tutorial"]
slug: "cursor-soul-spec-guide"
---

## 개요

[Cursor](https://cursor.com)는 VS Code 기반의 AI 코드 에디터다. 프로젝트 루트의 `.cursor/rules/` 디렉토리나 `.cursorrules` 파일로 커스텀 지침을 지원한다.

**Soul Spec으로 Cursor에 진짜 페르소나를 줄 수 있다.** ClawSouls에서 Soul을 설치하고 Cursor의 rules 디렉토리에 넣으면 된다. 세션 간에 일관된 정체성이 유지된다.

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

### 3단계: Cursor 포맷으로 변환

```bash
# 단일 .cursorrules 파일로 변환
clawsouls export cursorrules --dir ./surgical-coder -o ./my-project/.cursorrules
```

또는 Soul Spec 파일을 rules 디렉토리에 직접 배치:

```bash
mkdir -p ./my-project/.cursor/rules/
cp ./surgical-coder/SOUL.md ./my-project/.cursor/rules/
cp ./surgical-coder/IDENTITY.md ./my-project/.cursor/rules/
cp ./surgical-coder/STYLE.md ./my-project/.cursor/rules/
```

### 4단계: Cursor에서 열기

```bash
cursor ./my-project
```

Cursor가 rules를 자동으로 읽는다. AI 어시스턴트에 페르소나가 적용됐다.

## 작동 원리

Cursor는 두 위치에서 커스텀 지침을 로드한다:

1. **`.cursorrules`** — 프로젝트 루트의 단일 파일 (레거시, 여전히 지원)
2. **`.cursor/rules/`** — 마크다운 파일 디렉토리 (권장)

Soul Spec은 OpenClaw 같은 프레임워크에서 사용하는 멀티파일 페르소나 패턴을 표준화한다:

| Soul Spec 파일 | Cursor가 받는 것 |
|---|---|
| `SOUL.md` | 핵심 성격 & 원칙 |
| `IDENTITY.md` | 에이전트 이름, 역할, 특성 |
| `STYLE.md` | 커뮤니케이션 톤 & 선호 |
| `AGENTS.md` | 워크플로우 & 행동 규칙 |

## .cursor/rules/ 사용 (권장)

rules 디렉토리 방식이 더 깔끔하다 — 각 Soul Spec 파일이 별도의 rule이 된다:

```
my-project/
├── .cursor/
│   └── rules/
│       ├── SOUL.md        # 성격
│       ├── IDENTITY.md    # 정체성
│       ├── STYLE.md       # 스타일
│       └── AGENTS.md      # 워크플로우
├── src/
└── ...
```

Cursor가 `.cursor/rules/`의 모든 파일을 커스텀 지침으로 읽는다.

## MCP 서버 옵션

Cursor는 MCP 서버를 지원한다. soul-spec-mcp를 설치하면 에디터 안에서 페르소나를 관리할 수 있다:

Cursor의 MCP 설정에 추가:

```json
{
  "soul-spec": {
    "command": "npx",
    "args": ["-y", "soul-spec-mcp"]
  }
}
```

그다음 Cursor에서: *"surgical-coder 페르소나 적용해줘"*.

## 팁

- **프로젝트별 페르소나.** 프로젝트마다 다른 `.cursor/rules/`로 다른 페르소나 사용 가능.
- **Git 친화적.** `.cursor/rules/`를 커밋하면 팀과 페르소나 공유.
- **프로젝트 규칙과 병용.** `.cursor/rules/`에 페르소나 파일과 함께 기술 규칙도 추가 가능.
- **SoulScan.** `npx clawsouls soulscan`으로 사용 전 페르소나 패키지 검증.

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- 보안 검증: [SoulScan](https://clawsouls.ai/soulscan)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
