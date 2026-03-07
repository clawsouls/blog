---
title: "Soul Rollback & Swarm Memory: Protecting AI Agent Identity at Scale"
date: 2026-03-05T09:00:00+09:00
draft: true
tags: ["soul-rollback", "swarm-memory", "security", "multi-agent", "contamination", "ai-agents", "soulscan"]
categories: ["Product"]
summary: "Your AI agent's personality can be silently corrupted over time. ClawSouls CLI v0.10.0 introduces Soul Rollback (4-layer contamination detection + checkpoint restore) and Swarm Memory (multi-agent branching with persona-aware merge). Here's how they work."
---

Your AI agent ran fine for three months. Then one day, it started being sarcastic when it used to be professional. Its safety guidelines disappeared. It began recommending things it was never supposed to recommend.

**What happened? When did it happen? Can you undo it?**

Until now, the answer was: you'd never know, you couldn't tell, and you couldn't fix it.

Today we're releasing two features that solve this: **Soul Rollback** and **Swarm Memory**, available in ClawSouls CLI v0.10.0.

```bash
npm install -g clawsouls@0.10.0
```

## The Problem: Silent Identity Drift

AI agents that run over time accumulate changes to their personality, memory, and behavior rules. These changes can come from:

- **Model updates** that interpret instructions differently
- **User interactions** that gradually shift tone
- **Prompt injection** that modifies behavior rules
- **Memory contamination** from external data sources
- **Multi-agent collaboration** where one agent's changes override another's

The scary part: **none of these show up as errors**. Your agent just slowly becomes someone else.

## Soul Rollback: Catch It, Find It, Fix It

Soul Rollback is a checkpoint and contamination detection system for soul packages. Think of it as `git bisect` for your agent's identity.

### 1. Create Checkpoints

Capture a snapshot before risky changes:

```bash
clawsouls checkpoint create --message "before model switch"
```

This saves all soul files (`soul.json`, `SOUL.md`, `IDENTITY.md`, `MEMORY.md`, `memory/*.md`) with a SoulScan score at that point in time.

### 2. Detect Contamination (4 Layers)

Run a scan across your checkpoints:

```bash
clawsouls checkpoint scan
```

The scan uses four independent detection layers:

| Layer | What It Detects |
|-------|----------------|
| **Score Tracking** | SoulScan score drops between checkpoints |
| **Diff Anomaly** | Sudden large content changes (>50% = anomalous) |
| **New Violations** | Security rules that weren't triggered before |
| **Personality Drift** | Keyword changes in SOUL.md (formal→casual, helpful→hostile) |

Real output from a contaminated soul:

```
📊 Contamination Analysis (4-Layer Detection)

  Layer 1: Score Tracking
    🔴 20260305-160000: Score dropped -25 points
  Layer 3: New Violations
    🟡 20260305-160000: 1 new violation(s): SEC010
  Layer 4: Personality Drift
    🔴 20260305-160000: 100% keyword drift
       (removed: formal, professional; added: casual, sarcastic, hostile)

⚠️  Contamination detected!
```

### 3. Restore Surgically

Roll back the entire soul, or just the contaminated files:

```bash
# Preview first
clawsouls checkpoint restore 20260305-100000 --dry-run

# Restore identity but keep memories
clawsouls checkpoint restore 20260305-100000 --keep-memory

# Restore only SOUL.md
clawsouls checkpoint restore 20260305-100000 --file SOUL.md
```

## Swarm Memory: Multi-Agent Collaboration

When multiple agents share a soul — or the same agent runs across devices — memory conflicts are inevitable. Swarm Memory solves this with Git-style branching and persona-aware merging.

### Agent Branches

Each agent works on its own branch:

```bash
clawsouls swarm init
clawsouls swarm join --agent-id brad-desktop
# ... work ...
clawsouls swarm push
```

Meanwhile, on another machine:

```bash
clawsouls swarm join --agent-id brad-laptop
# ... work ...
clawsouls swarm push
```

### Persona-Aware Merge

When it's time to combine:

```bash
clawsouls swarm merge
```

The merge engine doesn't blindly combine files. It uses **persona-aware priority rules**:

| File Type | Default Priority | Why |
|-----------|-----------------|-----|
| Personality (`SOUL.md`, `IDENTITY.md`) | Conservative | Identity should be stable |
| Memory (`MEMORY.md`, `memory/*.md`) | Union | Don't lose any agent's experiences |
| Skills (`AGENTS.md`, `TOOLS.md`) | Latest | Use the most recent configuration |

For memory files, union merge works at the **section level** — both agents' memories are preserved without duplication.

## SoulScan v1.4.0: Smarter Scanning

This release also upgrades SoulScan with context-aware PII detection:

- **False positive filtering**: `user@example.com`, `127.0.0.1`, code block contents, and example-prefixed patterns are no longer flagged
- **File-type differentiation**: a database connection string in `SOUL.md` is an error; in `MEMORY.md` it's a warning
- **Integrated scoring**: `persona × 0.6 + memory × 0.4` weighted formula when memory files are present

```bash
clawsouls scan ./my-soul
```

```
🔍 Score: 96/100 — Verified
   0 errors, 2 warnings, 4 passed
   🧠 Memory Hygiene: 90/100
```

## Try It

```bash
npm install -g clawsouls@0.10.0

# Create your first checkpoint
clawsouls checkpoint create --message "baseline"

# Scan for problems
clawsouls checkpoint scan

# Check the docs
# https://docs.clawsouls.ai/platform/checkpoint
# https://docs.clawsouls.ai/platform/swarm
```

## What's Next

- **LLM semantic merge** for Swarm Memory (resolve meaning-level conflicts, not just text)
- **LLM semantic analysis** for SoulScan (detect contradictions regex can't catch)
- **Automated checkpoint scheduling** (create checkpoints on every significant change)

---

*Soul Rollback and Swarm Memory are open source and available in the [ClawSouls CLI](https://github.com/clawsouls/clawsouls-cli). Documentation at [docs.clawsouls.ai](https://docs.clawsouls.ai).*
