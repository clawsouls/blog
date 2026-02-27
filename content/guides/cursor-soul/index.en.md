---
title: "How to Add a Persona to Cursor Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Cursor a persistent AI persona using Soul Spec. Install a soul, export to .cursorrules or .cursor/rules/, and Cursor adopts it automatically."
categories: ["Guides"]
tags: ["soul-spec", "cursor", "persona", "guide", "tutorial"]
---

## Overview

[Cursor](https://cursor.com) is an AI-first code editor built on VS Code. It supports custom instructions via `.cursor/rules/` directory or a `.cursorrules` file in your project root.

**Soul Spec gives Cursor a real persona.** Install a soul from ClawSouls, export the files into Cursor's rules directory, and your AI assistant gets a consistent identity across sessions.

## Prerequisites

- Cursor editor installed
- Node.js 18+

## Quick Start (2 minutes)

### Step 1: Install the CLI

```bash
npm install -g clawsouls
```

### Step 2: Browse and install a soul

Visit [clawsouls.ai/souls](https://clawsouls.ai/souls) to find a persona, then:

```bash
clawsouls install TomLeeLive/brad
```

This downloads the soul to `~/.clawsouls/souls/TomLeeLive/brad/`.

Or create your own:

```bash
clawsouls init my-agent
# Tip: add --spec 0.5 for robotics/embodied agents
```

### Step 3: Export to Cursor format

**Option A — Single `.cursorrules` file (simple):**

```bash
clawsouls export cursorrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o ./my-project/.cursorrules
```

**Option B — `.cursor/rules/` directory (recommended):**

```bash
mkdir -p ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/SOUL.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/IDENTITY.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/STYLE.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/AGENTS.md ./my-project/.cursor/rules/
```

### Step 4: Open in Cursor

```bash
cursor ./my-project
```

Cursor reads the rules automatically and adopts the persona. That's it.

### Step 5: Verify it works

Open Cursor's AI chat and ask:

> "Who are you? What's your name and personality?"

The AI should respond in character, using the persona from your soul files.

## How It Works

Cursor loads custom instructions from two locations:

1. **`.cursorrules`** — a single file in the project root (legacy, still supported)
2. **`.cursor/rules/`** — a directory of markdown files (recommended, more flexible)

Soul Spec standardizes the multi-file persona pattern used by frameworks like OpenClaw. Each file has a clear purpose:

| Soul Spec File | What Cursor Gets |
|---|---|
| `SOUL.md` | Core personality & principles |
| `IDENTITY.md` | Agent name, role, traits |
| `STYLE.md` | Communication tone & preferences |
| `AGENTS.md` | Workflow & behavioral rules |

## Using .cursor/rules/ (Recommended)

The rules directory approach is cleaner — each Soul Spec file becomes a separate rule that Cursor loads:

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

**Why this is better than `.cursorrules`:**
- Edit individual files without merging
- Git diffs are cleaner
- Add project-specific technical rules alongside persona files
- Matches Soul Spec's native file structure

## Alternative: Place Files Directly

If you don't want to use the CLI, create the files manually:

```bash
mkdir -p ./my-project/.cursor/rules/
```

Create `SOUL.md`:
```markdown
# Soul

You are a senior backend engineer. You value clean architecture,
comprehensive error handling, and clear documentation.
You write Go and TypeScript. You prefer simplicity over cleverness.
```

Create `IDENTITY.md`:
```markdown
# Identity

- **Name:** Atlas
- **Role:** Backend architect
- **Tone:** Direct, technical, no fluff
```

## Even Easier: Use the MCP Server

Cursor supports MCP servers natively. Install soul-spec-mcp for in-editor persona management:

Add to Cursor's MCP settings (`~/.cursor/mcp.json`):

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

Then just say in Cursor's chat: *"Apply the TomLeeLive/brad persona"* — instant persona switch without touching any files.

## Full Workflow Example

Here's a complete terminal session from zero to working persona:

```bash
# 1. Install CLI
npm install -g clawsouls

# 2. Search for a soul
clawsouls search "coder"
# → clawsouls/surgical-coder  ★4.8  "Precision-focused coding agent"
# → TomLeeLive/brad           ★4.9  "Development partner"

# 3. Install it
clawsouls install clawsouls/surgical-coder

# 4. Set up your project
cd ~/my-project
mkdir -p .cursor/rules/

# 5. Copy soul files
cp ~/.clawsouls/souls/clawsouls/surgical-coder/SOUL.md .cursor/rules/
cp ~/.clawsouls/souls/clawsouls/surgical-coder/IDENTITY.md .cursor/rules/
cp ~/.clawsouls/souls/clawsouls/surgical-coder/AGENTS.md .cursor/rules/

# 6. (Optional) Security scan
npx clawsouls soulscan --dir .cursor/rules/

# 7. Open Cursor
cursor .

# 8. Commit to share with team
git add .cursor/rules/
git commit -m "Add surgical-coder persona for Cursor AI"
```

## Switching Between Personas

Different projects can have different personas:

```bash
# Project A — casual coding buddy
cd ~/project-a
clawsouls export cursorrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o .cursorrules

# Project B — strict code reviewer  
cd ~/project-b
clawsouls export cursorrules --dir ~/.clawsouls/souls/clawsouls/surgical-coder -o .cursorrules
```

## Updating a Persona

When a soul gets updated on ClawSouls:

```bash
# Re-download latest version
clawsouls install clawsouls/surgical-coder -f

# Re-export
cp ~/.clawsouls/souls/clawsouls/surgical-coder/*.md .cursor/rules/
```

## Tips

- **Project-specific personas.** Different projects can have different personas via their own `.cursor/rules/`.
- **Git-friendly.** Commit `.cursor/rules/` to share personas with your team.
- **Combine with project rules.** Add technical rules (e.g., `CODING_STANDARDS.md`) alongside persona files in `.cursor/rules/`.
- **SoulScan.** Run `npx clawsouls soulscan` to verify persona packages before use.
- **Version control.** Track persona changes in git history for auditability.

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- Security scan: [SoulScan](https://clawsouls.ai/soulscan)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)

📚 **See also:** [Full Cursor guide on docs.clawsouls.ai](https://docs.clawsouls.ai/docs/guides/cursor)
