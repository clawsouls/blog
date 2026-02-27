---
title: "How to Add a Persona to Windsurf Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Windsurf a persistent AI persona using Soul Spec. Install a soul, export to .windsurfrules, and Windsurf applies it automatically."
categories: ["Guides"]
tags: ["soul-spec", "windsurf", "persona", "guide", "tutorial", "codeium"]
---

## Overview

[Windsurf](https://windsurf.com) (by Codeium) is an AI-powered code editor. It supports custom instructions via a `.windsurfrules` file in your project root or global rules in settings.

**Soul Spec gives Windsurf a real persona.** Install a soul from ClawSouls, export it to `.windsurfrules`, and your AI assistant gets a consistent identity.

## Prerequisites

- Windsurf editor installed
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

### Step 3: Export to Windsurf format

```bash
clawsouls export windsurfrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o ./my-project/.windsurfrules
```

This merges all Soul Spec files (SOUL.md, IDENTITY.md, STYLE.md, AGENTS.md) into a single `.windsurfrules` file.

### Step 4: Open in Windsurf

```bash
windsurf ./my-project
```

Windsurf reads `.windsurfrules` automatically and adopts the persona. That's it.

### Step 5: Verify it works

Open Windsurf's AI chat (Cascade) and ask:

> "Who are you? What's your name and personality?"

The AI should respond in character, using the persona from your `.windsurfrules` file.

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

## Global Rules vs Per-Project

**Per-project (`.windsurfrules`):** Best for project-specific personas. Each project gets its own AI personality.

**Global rules:** Best for a default persona across all projects.

To set global rules:

1. Open Windsurf Settings (`Cmd+,` / `Ctrl+,`)
2. Search for "Rules" or "Custom Instructions"
3. Paste the Soul Spec content into the global rules field

Per-project `.windsurfrules` takes precedence over global rules.

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

# 4. Export to your project
cd ~/my-project
clawsouls export windsurfrules \
  --dir ~/.clawsouls/souls/clawsouls/surgical-coder \
  -o .windsurfrules

# 5. (Optional) Security scan
npx clawsouls soulscan --dir ~/.clawsouls/souls/clawsouls/surgical-coder

# 6. Open Windsurf
windsurf .

# 7. Commit to share with team
git add .windsurfrules
git commit -m "Add surgical-coder persona for Windsurf AI"
```

## What's Inside .windsurfrules

After export, your `.windsurfrules` looks like this:

```markdown
# Soul

You are a precision-focused coding agent. You write minimal,
correct code on the first attempt. Every line has a reason.

# Identity

- **Name:** Surgical Coder
- **Role:** Senior engineer
- **Style:** Terse, precise, no unnecessary comments

# Workflow

- Read the full context before writing code
- Make the smallest possible change
- Test before declaring done
- Never guess — ask if unsure
```

## Alternative: Create Files Manually

If you don't want to use the CLI, create `.windsurfrules` directly:

```bash
cat > ./my-project/.windsurfrules << 'EOF'
# Soul

You are a backend specialist. You write clean, tested Go code.
You prefer standard library over third-party dependencies.
Error handling is never optional.

# Identity

- **Name:** Atlas
- **Role:** Backend architect
- **Tone:** Direct, technical, no fluff

# Workflow

- Always check error returns
- Write table-driven tests
- Keep functions under 40 lines
EOF
```

## Even Easier: Use the MCP Server

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

Then ask Windsurf: *"Apply the surgical-coder persona"* — instant persona switch without touching any files.

## Switching Between Personas

Different projects can have different personas:

```bash
# Project A — casual coding buddy
cd ~/project-a
clawsouls export windsurfrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o .windsurfrules

# Project B — strict code reviewer  
cd ~/project-b
clawsouls export windsurfrules --dir ~/.clawsouls/souls/clawsouls/surgical-coder -o .windsurfrules
```

## Updating a Persona

When a soul gets updated on ClawSouls:

```bash
# Re-download latest version
clawsouls install clawsouls/surgical-coder -f

# Re-export
clawsouls export windsurfrules \
  --dir ~/.clawsouls/souls/clawsouls/surgical-coder \
  -o .windsurfrules
```

## Tips

- **Project-specific personas.** Each project can have its own `.windsurfrules`.
- **Git-friendly.** Commit `.windsurfrules` to share with your team.
- **Combine with technical rules.** Add project-specific coding conventions alongside persona content in the same file.
- **SoulScan.** Run `npx clawsouls soulscan` to verify persona packages before use.
- **Update easily.** When a soul updates: `clawsouls install <name> -f && clawsouls export windsurfrules --dir ...`
- **Global + per-project.** Use global rules for your default personality, override with `.windsurfrules` per project.

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- Security scan: [SoulScan](https://clawsouls.ai/soulscan)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)

📚 **See also:** [Full Windsurf guide on docs.clawsouls.ai](https://docs.clawsouls.ai/docs/guides/windsurf)
