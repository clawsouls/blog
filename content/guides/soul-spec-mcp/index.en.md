---
title: "Soul Spec MCP: Give Claude a Persona from Inside Claude"
date: 2026-02-21
description: "Install the Soul Spec MCP server to browse, preview, and install AI personas directly from Claude Desktop, Cowork, or Code."
categories: ["Guides"]
tags: ["mcp", "claude-desktop", "claude-cowork", "claude-code", "soul-spec", "ai-persona", "guide"]
---

## What Is This?

**soul-spec-mcp** is an MCP server that connects Claude to the [ClawSouls](https://clawsouls.ai) persona registry. Once installed, you can ask Claude to search, preview, and install AI personas — all without leaving the conversation.

No terminal commands. No manual file editing. Just ask.

## Setup (1 minute)

### Claude Desktop / Cowork

Open your config file:

```
~/Library/Application Support/Claude/claude_desktop_config.json
```

Add:

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

Restart Claude Desktop. Done.

### Claude Code

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

## What You Can Do

Once connected, just ask Claude in natural language:

### Search personas

> "Find me a coding persona that's concise and professional"

Claude calls `search_souls` and shows you matching results from 80+ personas.

### Get details

> "Tell me more about clawsouls/brad"

Returns version, rating, downloads, files, SoulScan score, and more.

### Preview before installing

> "Show me what the surgical-coder persona would look like as CLAUDE.md"

Renders the full CLAUDE.md output so you can review before committing.

### Apply instantly (no files needed)

> "Apply the clawsouls/brad persona"

Claude downloads the soul and **switches persona immediately** in the current conversation. No file saving, no moving files around. Perfect for trying personas or using them in Claude Desktop/Cowork.

### Install to your project (permanent)

> "Install clawsouls/brad to my project folder"

Downloads the persona, converts all Soul Spec files to a single `CLAUDE.md`, and saves it. Claude reads it automatically from that point on. Best for Claude Code where the file persists across sessions.

### Browse categories

> "What kinds of personas are available?"

Lists all categories: engineering, creative, education, research, and more.

## How It Works

```
You → "Install brad" → Claude → soul-spec-mcp → ClawSouls API
                                       ↓
                               Downloads soul files
                                       ↓
                          Converts to CLAUDE.md
                                       ↓
                        Saves to your project folder
                                       ↓
                   Claude reads it as project instructions
```

Soul Spec files (`SOUL.md`, `IDENTITY.md`, `STYLE.md`, `AGENTS.md`, `HEARTBEAT.md`) are merged into a single `CLAUDE.md` that Claude understands natively.

## Available Tools

| Tool | What it does |
|------|-------------|
| `search_souls` | Search by keyword, category, or tag |
| `get_soul` | Detailed info about a specific soul |
| `apply_persona` | **Apply persona to current conversation instantly** |
| `install_soul` | Download + convert to CLAUDE.md (permanent) |
| `preview_soul` | Preview CLAUDE.md without saving |
| `list_categories` | Browse persona categories |

## Works With

- ✅ Claude Desktop (macOS)
- ✅ Claude Cowork
- ✅ Claude Code
- ✅ Cursor
- ✅ Any MCP-compatible client

## Links

- **npm**: [soul-spec-mcp](https://www.npmjs.com/package/soul-spec-mcp)
- **GitHub**: [clawsouls/soul-spec-mcp](https://github.com/clawsouls/soul-spec-mcp)
- **Browse souls**: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- **Soul Spec**: [clawsouls.ai/spec](https://clawsouls.ai/spec)
- **SoulScan**: [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan)
