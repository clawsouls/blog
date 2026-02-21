---
title: "How to Add a Persona to Windsurf Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Windsurf a persistent AI persona using Soul Spec. Export your soul to .windsurfrules and Windsurf applies it automatically."
categories: ["Guides"]
tags: ["soul-spec", "windsurf", "persona", "guide", "tutorial", "codeium"]
slug: "windsurf-soul-spec-guide"
---

## Overview

[Windsurf](https://windsurf.com) (by Codeium) is an AI-powered code editor. It supports custom instructions via a `.windsurfrules` file in your project root or global rules in settings.

**Soul Spec gives Windsurf a real persona.** Install a soul from ClawSouls, export it to `.windsurfrules`, and your AI assistant gets a consistent identity.

## Quick Start (2 minutes)

### Step 1: Install the CLI

```bash
npm install -g clawsouls
```

### Step 2: Install a soul

Browse [clawsouls.ai/souls](https://clawsouls.ai/souls), then:

```bash
clawsouls install clawsouls/surgical-coder
```

### Step 3: Export to Windsurf format

```bash
clawsouls export windsurfrules --dir ./surgical-coder -o ./my-project/.windsurfrules
```

### Step 4: Open in Windsurf

```bash
windsurf ./my-project
```

Windsurf reads `.windsurfrules` automatically. Your AI assistant now has a persona.

## How It Works

Windsurf loads custom instructions from:

1. **`.windsurfrules`** — a file in the project root (per-project)
2. **Global rules** — in Windsurf settings (applies to all projects)

The `export windsurfrules` command merges Soul Spec files into a single `.windsurfrules` file. Soul Spec standardizes the multi-file persona pattern used by frameworks like OpenClaw:

| Soul Spec File | What Windsurf Gets |
|---|---|
| `SOUL.md` | Core personality & principles |
| `IDENTITY.md` | Agent name, role, traits |
| `STYLE.md` | Communication tone & preferences |
| `AGENTS.md` | Workflow & behavioral rules |

## Global Rules

For a persona that applies to all projects, add the exported content to Windsurf's global rules:

1. Open Windsurf Settings
2. Search for "Rules"
3. Paste the Soul Spec content into the global rules field

Per-project `.windsurfrules` takes precedence over global rules.

## MCP Server Option

Windsurf supports MCP servers. Install soul-spec-mcp for in-editor persona management:

Add to Windsurf's MCP configuration:

```json
{
  "soul-spec": {
    "command": "npx",
    "args": ["-y", "soul-spec-mcp"]
  }
}
```

Then ask Windsurf: *"Apply the surgical-coder persona"*.

## Tips

- **Project-specific personas.** Each project can have its own `.windsurfrules`.
- **Git-friendly.** Commit `.windsurfrules` to share with your team.
- **Combine with technical rules.** Add project-specific coding conventions alongside persona content.
- **SoulScan.** Run `npx clawsouls soulscan` to verify persona packages before use.
- **Update easily.** When a soul updates: `clawsouls install <name> -f && clawsouls export windsurfrules --dir ...`

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- Security scan: [SoulScan](https://clawsouls.ai/soulscan)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
