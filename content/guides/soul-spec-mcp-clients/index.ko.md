---
title: "Soul Spec MCP: 모든 클라이언트 설정 가이드"
date: 2026-02-21
description: "Claude, Cursor, Windsurf, Continue, Cline, Zed 등 모든 MCP 클라이언트에서 Soul Spec MCP를 설정하는 방법."
categories: ["Guides"]
tags: ["mcp", "cursor", "windsurf", "continue", "cline", "zed", "claude", "soul-spec", "ai-persona"]
---

## 하나의 서버, 모든 클라이언트

**soul-spec-mcp**는 모든 MCP 호환 클라이언트에서 동작한다. 한 번 설치, 어디서든 사용.

설정 후 AI에게: *"TomLeeLive/brad 페르소나 적용해줘"* 또는 *"코딩 페르소나 검색해줘"*

---

## Claude Desktop / Cowork

`~/Library/Application Support/Claude/claude_desktop_config.json` 편집:

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

Claude Desktop 재시작.

---

## Claude Code

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

새 세션에서 바로 사용 가능.

---

## Cursor

프로젝트 루트에 `.cursor/mcp.json` 생성:

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

또는 Cursor Settings → MCP → Add Server에서 추가.

---

## Windsurf

`~/.codeium/windsurf/mcp_config.json` 편집:

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

Windsurf 재시작.

---

## Continue.dev (VS Code)

`~/.continue/config.json` 편집:

```json
{
  "experimental": {
    "modelContextProtocolServers": [
      {
        "transport": {
          "type": "stdio",
          "command": "npx",
          "args": ["-y", "soul-spec-mcp"]
        }
      }
    ]
  }
}
```

---

## Cline (VS Code)

`cline_mcp_settings.json` 편집:

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

---

## Zed

`~/.config/zed/settings.json` 편집:

```json
{
  "context_servers": {
    "soul-spec": {
      "command": {
        "path": "npx",
        "args": ["-y", "soul-spec-mcp"]
      }
    }
  }
}
```

---

## 사용 가능한 도구

연결 후 모든 클라이언트에서 사용 가능:

| 도구 | 기능 |
|------|------|
| `search_souls` | 80+ 페르소나를 키워드/카테고리로 검색 |
| `get_soul` | 특정 페르소나 상세 정보 |
| `apply_persona` | **현재 세션에서 즉시 페르소나 전환** |
| `install_soul` | CLAUDE.md로 저장 (영구 적용) |
| `preview_soul` | 설치 전 미리보기 |
| `list_categories` | 전체 카테고리 탐색 |

## 링크

- **npm**: [soul-spec-mcp](https://www.npmjs.com/package/soul-spec-mcp)
- **GitHub**: [clawsouls/soul-spec-mcp](https://github.com/clawsouls/soul-spec-mcp)
- **Soul 둘러보기**: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- **Soul Spec**: [clawsouls.ai/spec](https://clawsouls.ai/spec)
