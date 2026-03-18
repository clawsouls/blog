---
title: "Building Safe Agents with Long-Term Memory: SoulScan, Persona Engine & Swarm Memory"
date: 2026-03-18T19:00:00+09:00
draft: false
tags: ["soulclaw", "soulscan", "persona", "swarm", "security", "memory", "ai-agents"]
categories: ["Engineering"]
description: "SoulClaw adds inline security scanning, persona drift detection, and multi-agent memory sync — free, open source, built on top of OpenClaw."
canonical: "https://blog.clawsouls.ai/en/posts/soulclaw-safe-agents/"
---

## Claude Dispatch Validated the Market. Now Let's Talk About Safety.

Anthropic recently launched Claude Dispatch — a phone-to-desktop agent workflow. This validates what the OpenClaw community has been building for months: **AI agents that work autonomously on your behalf**.

But there's a gap nobody talks about: **How do you keep an autonomous agent safe?**

When your agent runs 24/7, handles sensitive data, and has tool access, three problems emerge:

1. **Soul file tampering** — Someone (or something) modifies your agent's personality definition
2. **Persona drift** — The agent gradually deviates from its defined character over long conversations
3. **Memory fragmentation** — Multiple agents can't share what they've learned

SoulClaw v2026.3.21 addresses all three.

## 1. SoulScan: Inline Security Scanning

SoulScan is a 4-stage security pipeline that scans soul files (SOUL.md, soul.json) for:

- **Prompt injection** — Hidden instructions in personality definitions
- **Data exfiltration** — Patterns that leak sensitive information
- **Harmful content** — 58+ security rules
- **Schema violations** — Structural issues

### What's New: Inline Scanning

Previously, SoulScan only ran manually or during soul package publishing. Now it runs **automatically after every agent turn** (rate-limited to once per 5 minutes):

```
Agent Turn → Response → [fire-and-forget] SoulScan checks workspace
                                          ↓
                                    Score < threshold?
                                          ↓
                                    ⚠️ Warning logged
```

No configuration needed. If your workspace has a SOUL.md, it's protected.

### CLI Usage

```bash
# Scan your workspace
soulclaw soulscan

# CI/CD pipeline
soulclaw soulscan --json --min-score 70
```

## 2. Persona Engine: Drift Detection

Here's a subtle problem: even with a perfect SOUL.md, **your agent's personality drifts over long conversations**. The LLM gradually shifts away from the defined persona — especially after many tool calls, context compactions, or topic changes.

The Persona Engine monitors this drift and catches it before it becomes a problem.

### How It Works

1. **Parse** — SOUL.md is parsed into structured rules (tone, style, principles, boundaries)
2. **Detect** — Every N responses, the last assistant message is scored against these rules
3. **Enforce** — If drift exceeds a threshold, a correction is injected + notification sent

Detection methods:
- **Ollama LLM** (default) — Sends the response + persona rules to a local model for scoring
- **Keyword matching** (fallback) — Checks for tone/style keyword alignment when Ollama is unavailable

### Opt-In Configuration

Drift detection is **off by default** — enable it when you're ready:

```bash
# Enable
soulclaw persona config --enable

# Customize
soulclaw persona config --interval 3 --threshold 0.4

# Check manually
soulclaw persona check --text "Your agent's response here"

# View drift history
soulclaw persona metrics
```

### Real-Time Notifications

When drift is detected, you get notified via your configured messaging channel:

```
⚠️ Persona Drift WARNING
Score: 0.450 (method: keyword)
Session: agent:main:telegram:12345
Action: reminder
```

No more wondering if your agent is "still in character."

## 3. Swarm Memory: Multi-Agent Sync

If you run agents across multiple machines — or want multiple agents to share knowledge — Swarm Memory provides Git-based memory synchronization.

### The Problem

Agent A learns something important on your Mac. Agent B, running on your server, has no idea. They're working in isolation, duplicating effort, making contradictory decisions.

### The Solution

```
Agent A (Mac)                    Agent B (Server)
    │                                │
    ├── MEMORY.md                    ├── MEMORY.md
    ├── memory/*.md                  ├── memory/*.md
    │                                │
    └─── swarm sync ──→ Git Repo ←── swarm sync ───┘
```

### Setup

```bash
# Initialize
soulclaw swarm init --remote git@github.com:user/swarm-memory.git

# Check status
soulclaw swarm status

# Force sync
soulclaw swarm sync
```

### LLM-Powered Conflict Resolution

When both agents modify the same memory file, traditional merge fails. Swarm Memory offers **LLM semantic merge**:

```bash
# Sync with intelligent merge
soulclaw swarm sync --llm-merge

# Resolve specific conflicts
soulclaw swarm resolve MEMORY.md --llm
```

The LLM reads both versions, preserves unique information from each, removes duplicates, and produces a clean merged result. Falls back to "ours" strategy if Ollama is unavailable.

Other resolution options:
```bash
soulclaw swarm resolve --ours     # Keep our version
soulclaw swarm resolve --theirs   # Keep their version
soulclaw swarm resolve --manual   # Edit manually
```

## Why This Matters

These aren't academic features. They solve real problems:

| Problem | Before | After |
|---------|--------|-------|
| Soul file tampered | Agent silently compromised | SoulScan catches it within 5 minutes |
| Agent drifts from character | Nobody notices until it's bad | Persona Engine alerts you at threshold |
| Multi-agent knowledge | Each agent starts from zero | Swarm Memory shares across all agents |

## Free, Open Source, Built on OpenClaw

All of this is:
- **Free** — No subscription required
- **Open source** — MIT license, same as OpenClaw
- **30-second migration** — If you use OpenClaw, `npm install -g soulclaw` and you're done

SoulClaw is a fork of OpenClaw that adds memory and safety features. Your existing `~/.openclaw/` configuration, SOUL.md, workspace, and channel tokens all transfer automatically.

### Migration

```bash
npm install -g soulclaw
soulclaw gateway install
soulclaw gateway start  # Uses existing ~/.openclaw/ config
```

**Full guide**: [Migration from OpenClaw](https://docs.clawsouls.ai/docs/guides/migration-from-openclaw)

## What's Next

We're building towards a vision where AI agents are:
1. **Safe** — You know what they're doing and they stay in character
2. **Remembered** — Nothing is lost, ever (3-Tier Memory + DAG)
3. **Collaborative** — Agents share knowledge across devices

The [CLI guide](https://docs.clawsouls.ai/docs/platform/soulclaw-cli) has full documentation for all commands.

---

*SoulClaw v2026.3.21 — Safe agents with long-term memory.*
*[GitHub](https://github.com/clawsouls/soulclaw) · [npm](https://www.npmjs.com/package/soulclaw) · [Docs](https://docs.clawsouls.ai)*
