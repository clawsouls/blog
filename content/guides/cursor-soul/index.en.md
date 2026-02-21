---
title: "How to Add a Persona to Cursor Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Cursor a persistent AI persona using Soul Spec. Install a soul and place it in .cursor/rules/ for automatic pickup."
categories: ["Guides"]
tags: ["soul-spec", "cursor", "persona", "guide", "tutorial"]
---

## Overview

[Cursor](https://cursor.com) is an AI-first code editor built on VS Code. It supports custom instructions via `.cursor/rules/` directory or a `.cursorrules` file in your project root.

**Soul Spec lets you give Cursor a real persona.** Install a soul from ClawSouls and place the files in Cursor's rules directory. Your AI assistant gets a consistent identity across sessions.

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

### Step 3: Export to Cursor format

```bash
# Export as a single .cursorrules file
clawsouls export cursorrules --dir ./surgical-coder -o ./my-project/.cursorrules
```

Or place individual Soul Spec files in the rules directory:

```bash
mkdir -p ./my-project/.cursor/rules/
cp ./surgical-coder/SOUL.md ./my-project/.cursor/rules/
cp ./surgical-coder/IDENTITY.md ./my-project/.cursor/rules/
cp ./surgical-coder/STYLE.md ./my-project/.cursor/rules/
```

### Step 4: Open in Cursor

```bash
cursor ./my-project
```

Cursor reads the rules automatically. Your AI assistant now has a persona.

## How It Works

Cursor loads custom instructions from two locations:

1. **`.cursorrules`** — a single file in the project root (legacy, still supported)
2. **`.cursor/rules/`** — a directory of markdown files (recommended)

Soul Spec standardizes the multi-file persona pattern used by frameworks like OpenClaw. Each file has a clear purpose:

| Soul Spec File | What Cursor Gets |
|---|---|
| `SOUL.md` | Core personality & principles |
| `IDENTITY.md` | Agent name, role, traits |
| `STYLE.md` | Communication tone & preferences |
| `AGENTS.md` | Workflow & behavioral rules |

## Using .cursor/rules/ (Recommended)

The rules directory approach is cleaner — each Soul Spec file becomes a separate rule:

```
my-project/
├── .cursor/
│   └── rules/
│       ├── SOUL.md        # Personality
│       ├── IDENTITY.md    # Identity
│       ├── STYLE.md       # Style
│       └── AGENTS.md      # Workflow
├── src/
└── ...
```

Cursor reads all files in `.cursor/rules/` as custom instructions.

## MCP Server Option

Cursor supports MCP servers. Install soul-spec-mcp for in-editor persona management:

Add to Cursor's MCP settings:

```json
{
  "soul-spec": {
    "command": "npx",
    "args": ["-y", "soul-spec-mcp"]
  }
}
```

Then ask Cursor: *"Apply the surgical-coder persona"*.

## Tips

- **Project-specific personas.** Different projects can have different personas via their own `.cursor/rules/`.
- **Git-friendly.** Commit `.cursor/rules/` to share personas with your team.
- **Combine with project rules.** Add technical rules alongside persona files in `.cursor/rules/`.
- **SoulScan.** Run `npx clawsouls soulscan` to verify persona packages before use.

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- Security scan: [SoulScan](https://clawsouls.ai/soulscan)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
