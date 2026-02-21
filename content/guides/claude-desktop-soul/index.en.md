---
title: "How to Add a Persona to Claude Desktop Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Claude Desktop a persistent persona using the Soul Spec MCP server. Search, preview, and apply AI personalities without leaving the conversation."
categories: ["Guides"]
tags: ["soul-spec", "claude-desktop", "persona", "guide", "tutorial", "mcp", "anthropic"]
slug: "claude-desktop-soul-spec-guide"
---

## Overview

Claude Desktop is Anthropic's native macOS/Windows app for Claude. It supports MCP (Model Context Protocol) servers — external tools that extend what Claude can do.

**soul-spec-mcp** connects Claude Desktop to the [ClawSouls](https://clawsouls.ai) persona registry. Once installed, you can search, preview, and apply AI personas directly from the conversation. No terminal needed.

## Setup (1 minute)

### 1. Open your config file

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

### 2. Add the MCP server

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

### 3. Restart Claude Desktop

Done. The soul-spec tools are now available.

## What You Can Do

Just ask Claude in natural language:

- **Search**: *"Find me a concise coding persona"*
- **Preview**: *"Show me what surgical-coder looks like"*
- **Apply**: *"Apply the TomLeeLive/brad persona"* — instant persona switch in the current conversation
- **Browse**: *"What kinds of personas are available?"*

## Available Tools

| Tool | What it does |
|------|-------------|
| `search_souls` | Search by keyword, category, or tag |
| `get_soul` | Detailed info about a specific soul |
| `apply_persona` | Apply persona to current conversation |
| `preview_soul` | Preview without applying |
| `list_categories` | Browse persona categories |

## How It Works

When you say "Apply the brad persona", Claude calls the MCP server which:

1. Downloads soul files from the ClawSouls registry
2. Converts `SOUL.md`, `IDENTITY.md`, `STYLE.md`, `AGENTS.md` into a unified prompt
3. Applies it to the current conversation

Soul Spec standardizes the multi-file persona pattern used by frameworks like OpenClaw, making personas portable across tools.

## Alternative: Manual Install via CLI

If you prefer the command line:

```bash
npm install -g clawsouls
clawsouls install TomLeeLive/brad
```

Browse souls at [clawsouls.ai/souls](https://clawsouls.ai/souls).

## Tips

- **Persona persists per conversation.** Start a new conversation to reset.
- **Combine with Projects.** Claude Desktop Projects have custom instructions — Soul Spec personas complement these.
- **SoulScan.** All published souls are scanned for security issues. Check scores at [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan).

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- MCP server details: [soul-spec-mcp guide](/blog/guides/soul-spec-mcp-guide/)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
