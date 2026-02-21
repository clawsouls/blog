---
title: "Claude Desktop에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Soul Spec MCP 서버로 Claude Desktop에 페르소나를 부여하는 방법. 대화 안에서 바로 검색, 미리보기, 적용."
categories: ["Guides"]
tags: ["soul-spec", "claude-desktop", "persona", "guide", "tutorial", "mcp", "anthropic"]
slug: "claude-desktop-soul-spec-guide"
---

## 개요

Claude Desktop은 Anthropic의 네이티브 macOS/Windows 앱이다. MCP(Model Context Protocol) 서버를 지원해서 Claude의 기능을 확장할 수 있다.

**soul-spec-mcp**는 Claude Desktop을 [ClawSouls](https://clawsouls.ai) 페르소나 레지스트리에 연결한다. 설치하면 대화 안에서 바로 AI 페르소나를 검색, 미리보기, 적용할 수 있다. 터미널 필요 없음.

## 설정 (1분)

### 1. 설정 파일 열기

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

### 2. MCP 서버 추가

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

### 3. Claude Desktop 재시작

끝. soul-spec 도구가 사용 가능해졌다.

## 할 수 있는 것

Claude에게 자연어로 요청하면 된다:

- **검색**: *"간결한 코딩 페르소나 찾아줘"*
- **미리보기**: *"surgical-coder가 어떤 건지 보여줘"*
- **적용**: *"TomLeeLive/brad 페르소나 적용해줘"* — 현재 대화에 즉시 적용
- **둘러보기**: *"어떤 종류의 페르소나가 있어?"*

## 사용 가능한 도구

| 도구 | 기능 |
|------|------|
| `search_souls` | 키워드, 카테고리, 태그로 검색 |
| `get_soul` | 특정 Soul의 상세 정보 |
| `apply_persona` | 현재 대화에 페르소나 적용 |
| `preview_soul` | 적용 없이 미리보기 |
| `list_categories` | 페르소나 카테고리 둘러보기 |

## 작동 원리

"brad 페르소나 적용해줘"라고 말하면, Claude가 MCP 서버를 호출해서:

1. ClawSouls 레지스트리에서 Soul 파일 다운로드
2. `SOUL.md`, `IDENTITY.md`, `STYLE.md`, `AGENTS.md`를 통합 프롬프트로 변환
3. 현재 대화에 적용

Soul Spec은 OpenClaw 같은 프레임워크에서 사용하는 멀티파일 페르소나 패턴을 표준화해서, 도구 간 페르소나 이식성을 보장한다.

## 대안: CLI로 수동 설치

커맨드라인을 선호한다면:

```bash
npm install -g clawsouls
clawsouls install TomLeeLive/brad
```

[clawsouls.ai/souls](https://clawsouls.ai/souls)에서 Soul 둘러보기.

## 팁

- **페르소나는 대화 단위로 유지.** 새 대화를 시작하면 초기화.
- **Projects와 병용.** Claude Desktop Projects의 커스텀 지침과 Soul Spec 페르소나를 함께 사용 가능.
- **SoulScan.** 게시된 모든 Soul은 보안 검사를 거친다. [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan)에서 점수 확인.

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- MCP 서버 상세: [soul-spec-mcp 가이드](/blog/ko/guides/soul-spec-mcp-guide/)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
