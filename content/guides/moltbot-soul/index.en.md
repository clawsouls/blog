---
title: "How to Use Soul Spec with Moltbot"
date: 2026-02-20
description: "Step-by-step guide to configure your Moltbot AI agent's personality using Soul Spec. Portable, structured, version-controlled."
categories: ["Guides"]
tags: ["moltbot", "soul-spec", "ai-persona", "guide", "tutorial"]
slug: "moltbot-soul-spec-guide"
---

## Overview

Moltbot supports SOUL.md-based persona configuration natively. Soul Spec extends this with a structured, portable format that gives your agent a complete identity.

This guide shows you how to set up Soul Spec in your Moltbot workspace.

## Quick Start

### 1. Install the CLI

```bash
npx clawsouls init
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

### 2. Copy to Your Moltbot Workspace

```bash
cp SOUL.md IDENTITY.md AGENTS.md ~/.moltbot/workspace/
```

Moltbot automatically reads these files from its workspace directory.

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

## Why Soul Spec for Moltbot?

| Without Soul Spec | With Soul Spec |
|---|---|
| Personality in one big SOUL.md | Structured across focused files |
| No version tracking | Git-friendly, full history |
| No security checks | SoulScan automated verification |
| Not shareable | Publish to SOULHUB marketplace |
| Locked to Moltbot | Portable to any framework |

## Browse Community Souls

Find pre-built personas at [clawsouls.ai](https://clawsouls.ai) — install directly:

```bash
npx clawsouls install owner/soul-name
```

## Multi-Platform

Soul Spec works across all SOUL.md-compatible frameworks. Your agent's personality isn't locked to Moltbot:

```bash
# Auto-detect your platform
npx clawsouls platform
```

---

*Questions? [GitHub Discussions](https://github.com/clawsouls/clawsouls/discussions) · [X @ClawSoulsAI](https://x.com/ClawSoulsAI)*
