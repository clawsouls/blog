---
title: "How to Use Soul Spec with OpenClaw"
date: 2026-02-20
description: "Step-by-step guide to configure your OpenClaw AI agent's personality using Soul Spec. Portable, structured, version-controlled."
categories: ["Guides"]
tags: ["openclaw", "soul-spec", "ai-persona", "guide", "tutorial"]
---

## Overview

OpenClaw supports SOUL.md-based persona configuration natively. Soul Spec extends this with a structured, portable format that gives your agent a complete identity.

This guide shows you how to set up Soul Spec in your OpenClaw workspace.

## Quick Start

### 1. Install the CLI

```bash
npx clawsouls init
# Tip: add --spec 0.5 for robotics/embodied agents
```

This generates a Soul Spec template in your current directory:

```
├── soul.json      # Metadata
├── SOUL.md        # Personality & tone
├── IDENTITY.md    # Agent identity
├── AGENTS.md      # Behavioral rules
├── HEARTBEAT.md   # Periodic check-in
└── STYLE.md       # Communication style
```

### 2. Copy to Your OpenClaw Workspace

```bash
cp SOUL.md IDENTITY.md AGENTS.md ~/.openclaw/workspace/
```

OpenClaw automatically reads these files from its workspace directory.

### 3. Customize

Edit `SOUL.md` to define your agent's personality:

```markdown
# Agent Name — Role

You are [Name]. A [tone] [role] who [core behavior].

## Personality
- **Tone**: [Professional / Casual / Technical]
- **Style**: [Concise / Detailed / Conversational]

## Principles
- [Key behavior 1]
- [Key behavior 2]
```

### 4. Verify with SoulScan

```bash
npx clawsouls soulscan
```

SoulScan checks for:
- ✅ Schema compliance
- ✅ Security issues (prompt injection, secret leaks)
- ✅ Persona consistency across files

## Why Soul Spec for OpenClaw?

| Without Soul Spec | With Soul Spec |
|---|---|
| Personality in one big SOUL.md | Structured across focused files |
| No version tracking | Git-friendly, full history |
| No security checks | SoulScan automated verification |
| Not shareable | Publish to ClawSouls marketplace |
| Locked to OpenClaw | Portable to any framework |

## Browse Community Souls

Find pre-built personas at [clawsouls.ai](https://clawsouls.ai) — install directly:

```bash
npx clawsouls install owner/soul-name
```

## Multi-Platform

Soul Spec works across all SOUL.md-compatible frameworks. Your agent's personality isn't locked to OpenClaw:

```bash
# Auto-detect your platform
npx clawsouls platform
```

---

*Questions? [GitHub Discussions](https://github.com/clawsouls/clawsouls/discussions) · [X @ClawSoulsAI](https://x.com/ClawSoulsAI)*
