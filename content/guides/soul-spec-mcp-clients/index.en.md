---
title: "Soul Spec MCP: Setup Guide for Every Client"
date: 2026-02-21
description: "Install Soul Spec MCP on Claude, Cursor, Windsurf, Continue, Cline, Zed, and more. One MCP server, every AI editor."
categories: ["Guides"]
tags: ["mcp", "cursor", "windsurf", "continue", "cline", "zed", "claude", "soul-spec", "ai-persona"]
---

## One Server, Every Client

**soul-spec-mcp** works with any MCP-compatible client. Install once, use everywhere.

After setup, ask your AI: *"Apply the clawsouls/brad persona"* or *"Search for coding personas"*.

---

## Claude Desktop / Cowork

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

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

Restart Claude Desktop.

---

## Claude Code

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

Done. Start a new session and ask Claude to search or apply a persona.

---

## Cursor

Create or edit `.cursor/mcp.json` in your project root:

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

Or add globally via Cursor Settings → MCP → Add Server.

---

## Windsurf

Edit `~/.codeium/windsurf/mcp_config.json`:

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

Restart Windsurf.

---

## Continue.dev (VS Code)

Edit your Continue config (`~/.continue/config.json`):

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

Open Cline MCP settings (`cline_mcp_settings.json`):

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

Edit Zed settings (`~/.config/zed/settings.json`):

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

## Available Tools

Once connected, these tools are available in any client:

| Tool | What it does |
|------|-------------|
| `search_souls` | Search 80+ personas by keyword or category |
| `get_soul` | Detailed info about a specific persona |
| `apply_persona` | **Switch persona instantly in current session** |
| `install_soul` | Save as CLAUDE.md for permanent use |
| `preview_soul` | Preview output before installing |
| `list_categories` | Browse all persona categories |

## Links

- **npm**: [soul-spec-mcp](https://www.npmjs.com/package/soul-spec-mcp)
- **GitHub**: [clawsouls/soul-spec-mcp](https://github.com/clawsouls/soul-spec-mcp)
- **Browse souls**: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- **Soul Spec**: [clawsouls.ai/spec](https://clawsouls.ai/spec)
