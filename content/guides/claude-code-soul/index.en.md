---
title: "How to Add a Persona to Claude Code Using Soul Spec"
date: 2026-02-21T06:00:00+09:00
description: "Give Claude Code a persistent identity using Soul Spec. Install a soul, export to CLAUDE.md, and Claude Code adopts it automatically."
categories: ["Guides"]
tags: ["soul-spec", "claude-code", "persona", "guide", "tutorial", "anthropic"]
---

## Overview

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) is Anthropic's terminal-based AI coding agent. It reads `CLAUDE.md` from your project root as persistent instructions — but by default, it has no personality.

**Soul Spec gives Claude Code an identity.** Install a soul from ClawSouls, export it to `CLAUDE.md`, and Claude Code becomes your customized agent.

## Prerequisites

- Claude Code CLI installed
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

Or create your own:

```bash
clawsouls init my-agent
```

### Step 3: Export to CLAUDE.md

```bash
clawsouls export claude-md --dir ./my-agent -o ./my-project/CLAUDE.md
```

### Step 4: Use Claude Code

```bash
cd my-project && claude
```

Claude Code reads `CLAUDE.md` automatically and adopts the persona. That's it.

## How It Works

Claude Code reads `CLAUDE.md` from the working directory as persistent instructions. It also reads supporting files referenced within. Soul Spec standardizes the multi-file persona pattern used by frameworks like OpenClaw:

| Soul Spec File | Purpose |
|---|---|
| `SOUL.md` | Core personality & principles |
| `IDENTITY.md` | Name, role, traits |
| `STYLE.md` | Communication tone & language |
| `AGENTS.md` | Workflow & behavioral rules |
| `HEARTBEAT.md` | Periodic check-in behaviors |

The `export claude-md` command merges these into a single `CLAUDE.md` that Claude Code understands natively.

## Alternative: Place Files Directly

Instead of exporting, you can place Soul Spec files directly in your project:

```bash
clawsouls install TomLeeLive/brad
cp ~/.openclaw/souls/TomLeeLive/brad/SOUL.md ./my-project/
cp ~/.openclaw/souls/TomLeeLive/brad/IDENTITY.md ./my-project/
```

Then reference them from your `CLAUDE.md`:

```markdown
# Project Instructions

See SOUL.md and IDENTITY.md for persona configuration.
```

Claude Code reads all markdown files in the project root.

## Even Easier: Use the MCP Server

Install the [Soul Spec MCP server](/blog/guides/soul-spec-mcp-guide/) and apply personas from inside Claude Code:

```bash
claude mcp add soul-spec -- npx -y soul-spec-mcp
```

Then just say: *"Apply the TomLeeLive/brad persona"* — instant persona switch.

## Tips

- **One CLAUDE.md per project.** Use different projects for different personas.
- **Version control.** Commit `CLAUDE.md` to your repo so team members share the same agent persona.
- **SoulScan.** Run `npx clawsouls soulscan` to verify persona integrity before use.
- **Update easily.** When a soul updates: `clawsouls install <name> -f && clawsouls export claude-md --dir ...`

## What's Next

- Browse souls: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- Create your own: [Soul Spec documentation](https://clawsouls.ai/spec)
- Security scan: [SoulScan](https://clawsouls.ai/soulscan)
- CLI reference: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
