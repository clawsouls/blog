---
title: "Soul Spec MCP: Claude 안에서 바로 페르소나 설치하기"
date: 2026-02-21
description: "Soul Spec MCP 서버를 설치하면 Claude Desktop, Cowork, Code에서 대화만으로 AI 페르소나를 검색하고 설치할 수 있다."
categories: ["Guides"]
tags: ["mcp", "claude-desktop", "claude-cowork", "claude-code", "soul-spec", "ai-persona", "guide"]
slug: "soul-spec-mcp-guide"
---

## 이게 뭔가?

**soul-spec-mcp**는 Claude를 [ClawSouls](https://clawsouls.ai) 페르소나 레지스트리에 연결하는 MCP 서버다. 설치하면 대화 중에 AI 페르소나를 검색하고, 미리보고, 설치할 수 있다.

터미널 명령 없이. 파일 수동 편집 없이. 그냥 말하면 된다.

## 설정 (1분)

### Claude Desktop / Cowork

설정 파일 열기:

```
~/Library/Application Support/Claude/claude_desktop_config.json
```

추가:

```json
{
  "mcpServers": {
    "soul-spec": {
      "command": "npx",
      "args": ["-y", "soul-spec-mcp"]
    }
  }
}
```

Claude Desktop 재시작. 끝.

### Claude Code

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

## 할 수 있는 것

연결되면 자연어로 요청하면 된다:

### 페르소나 검색

> "간결하고 전문적인 코딩 페르소나 찾아줘"

`search_souls`가 80개 이상의 페르소나에서 매칭 결과를 보여준다.

### 상세 정보

> "TomLeeLive/brad에 대해 자세히 알려줘"

버전, 평점, 다운로드 수, 파일 목록, SoulScan 점수 등을 반환한다.

### 설치 전 미리보기

> "surgical-coder 페르소나가 CLAUDE.md로 어떻게 보이는지 보여줘"

전체 CLAUDE.md 출력을 렌더링해서 설치 전에 확인 가능.

### 즉시 적용 (파일 저장 없이)

> "TomLeeLive/brad 페르소나 적용해줘"

Soul을 다운로드하고 **현재 대화에서 즉시 페르소나를 전환**한다. 파일 저장도, 이동도 필요 없다. Claude Desktop/Cowork에서 페르소나를 바로 체험하기에 최적.

### 프로젝트에 설치 (영구 적용)

> "내 프로젝트 폴더에 TomLeeLive/brad 설치해줘"

페르소나를 다운로드하고, Soul Spec 파일들을 하나의 `CLAUDE.md`로 변환해서 저장한다. 세션 간 유지되는 Claude Code에 최적.

### 카테고리 탐색

> "어떤 종류의 페르소나가 있어?"

전체 카테고리 목록: 엔지니어링, 크리에이티브, 교육, 연구 등.

## 작동 원리

```
사용자 → "brad 설치해줘" → Claude → soul-spec-mcp → ClawSouls API
                                           ↓
                                   soul 파일 다운로드
                                           ↓
                              CLAUDE.md로 변환
                                           ↓
                            프로젝트 폴더에 저장
                                           ↓
                       Claude가 프로젝트 지침으로 읽음
```

Soul Spec 파일들(`SOUL.md`, `IDENTITY.md`, `STYLE.md`, `AGENTS.md`, `HEARTBEAT.md`)이 Claude가 이해하는 하나의 `CLAUDE.md`로 합쳐진다.

## 사용 가능한 도구

| 도구 | 기능 |
|------|------|
| `search_souls` | 키워드, 카테고리, 태그로 검색 |
| `get_soul` | 특정 soul 상세 정보 |
| `apply_persona` | **현재 대화에 즉시 페르소나 적용** |
| `install_soul` | 다운로드 + CLAUDE.md 변환 (영구) |
| `preview_soul` | 저장 없이 CLAUDE.md 미리보기 |
| `list_categories` | 페르소나 카테고리 탐색 |

## 호환 환경

- ✅ Claude Desktop (macOS)
- ✅ Claude Cowork
- ✅ Claude Code
- ✅ Cursor
- ✅ 모든 MCP 호환 클라이언트

## 링크

- **npm**: [soul-spec-mcp](https://www.npmjs.com/package/soul-spec-mcp)
- **GitHub**: [clawsouls/soul-spec-mcp](https://github.com/clawsouls/soul-spec-mcp)
- **Soul 둘러보기**: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- **Soul Spec**: [clawsouls.ai/spec](https://clawsouls.ai/spec)
- **SoulScan**: [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan)
