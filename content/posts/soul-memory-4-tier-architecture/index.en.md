---
title: "Soul Memory: A 4-Tier Adaptive Memory Architecture for AI Agents"
date: 2026-03-20
description: "Your AI agent needs to forget strategically. Soul Memory gives it a human-like memory hierarchy — from immutable identity to ephemeral context."
tags: ["ai-agents", "memory", "soul-spec", "architecture", "soulclaw"]
draft: false
---

## The Problem: Your Agent Either Remembers Everything or Nothing

Every AI agent developer faces the same dilemma:

- **No memory** → Your agent forgets everything between sessions. Every conversation starts from zero.
- **Full memory** → Your agent remembers everything with perfect fidelity. Including that one time a user was hostile. Including outdated decisions. Including noise from 6 months ago that drowns out yesterday's critical update.

Neither is right. Humans solved this millions of years ago: **we remember what matters and forget what doesn't.** Not perfectly — but well enough to maintain a coherent identity while adapting to new experiences.

Your AI agent needs the same thing.

## Introducing Soul Memory

**Soul Memory** is a 4-tier adaptive memory architecture for AI agents. It separates identity from experience, applies temporal decay to working memories, and automatically promotes important memories to permanent storage.

```
┌─────────────────────────────────────────┐
│  T0: SOUL (Identity)                    │
│  "Who I am" — immutable, human-owned    │
├─────────────────────────────────────────┤
│  T1: CORE MEMORY (Evergreen)            │
│  "What I must never forget" — no decay  │
├─────────────────────────────────────────┤
│  T2: WORKING MEMORY (Temporal)          │
│  "What happened recently" — decays      │
├─────────────────────────────────────────┤
│  T3: SESSION MEMORY (Ephemeral)         │
│  "What we're discussing now" — gone     │
└─────────────────────────────────────────┘
```

### T0: Soul (Identity)

Your agent's `SOUL.md` and `IDENTITY.md`. These define *who the agent is* — personality, values, behavioral rules. They're loaded fresh every session, never modified by the agent, and never subject to decay.

This is your agent's defense against the [Memory-Identity Paradox](/posts/perfect-memory-breaks-ai-identity/) — no matter how much experience accumulates, the identity anchor remains unchanged.

### T1: Core Memory (Evergreen)

`MEMORY.md` and undated topic files (`memory/roadmap.md`, `memory/trademark.md`). These store curated, long-term knowledge: decisions, architecture choices, key relationships, strategies.

**No temporal decay.** Core memories are always at full relevance, whether they were written today or a year ago. They're the agent's "I will never forget this" storage.

### T2: Working Memory (Temporal)

Date-stamped files like `memory/2026-03-19.md`. These are daily work logs, debug notes, meeting records, task progress.

**Temporal decay with a 23-day half-life.** Today's working memory has full relevance. Last week's has 81%. Last month's has 41%. Three months ago? 7%. Six months? Effectively invisible to search — but still on disk if you need it.

This is the key insight: **your agent's daily logs should fade naturally**, just like your own memory of what you had for lunch last Tuesday.

### T3: Session Memory (Ephemeral)

The current conversation context. Gone when the session ends. This is your standard LLM context window — no persistence needed.

## The Magic: Temporal Decay

The decay function is simple:

```
final_score = semantic_score × exp(-0.0301 × age_in_days)
```

| Age | Weight | Your agent's behavior |
|-----|--------|----------------------|
| Today | 100% | "I just worked on this" |
| 1 week | 81% | "This is recent context" |
| 23 days | 50% | "I remember this" |
| 1 month | 41% | "This sounds familiar" |
| 3 months | 7% | "Vaguely, let me check..." |

**Nothing is deleted.** Decay only affects search ranking. If you explicitly ask about something old, it's still there — the semantic score just needs to be higher to surface it.

## Memory Promotion: T2 → T1

The critical question: how does important working memory become permanent core memory?

Three mechanisms:

### 1. Rule-Based Detection

The agent automatically flags working memories that contain:
- Decisions and commitments
- Architecture/design changes
- Financial terms (pricing, costs, margins)
- Legal matters (trademarks, patents, contracts)
- Key relationships (partners, clients)
- Strategy and roadmap items

### 2. Access-Frequency Promotion

If a working memory gets retrieved 3+ times across different sessions, it's clearly important. Flag it for promotion.

### 3. Weekly Review

Every Friday, the agent scans the week's working memories, identifies promotion candidates, and asks the human: *"Should these become permanent?"*

This mirrors how humans consolidate memories during sleep — periodic review that separates signal from noise.

## Setting It Up

Soul Memory works with [SoulClaw](https://github.com/clawsouls/soulclaw) (our OpenClaw fork). Here's the minimal setup:

### 1. Enable Temporal Decay

In your `openclaw.json`:

```json
{
  "agents": {
    "defaults": {
      "memorySearch": {
        "query": {
          "hybrid": {
            "temporalDecay": {
              "enabled": true,
              "halfLifeDays": 23
            }
          }
        }
      }
    }
  }
}
```

### 2. Organize Your Memory Files

```
workspace/
├── SOUL.md              # T0: Never changes
├── IDENTITY.md          # T0: Never changes
├── MEMORY.md            # T1: Curated, permanent
├── memory/
│   ├── roadmap.md       # T1: Evergreen (no date = no decay)
│   ├── 2026-03-19.md    # T2: Daily log (decays)
│   └── 2026-03-18.md    # T2: Daily log (decays)
```

### 3. Upgrade Your Embedding Model (Recommended)

```bash
ollama pull bge-m3
# Then set provider: "ollama", model: "bge-m3" in config
openclaw memory index --force
```

bge-m3 gives you 100+ language support and significantly better semantic search quality (MTEB 63 vs ~60 for the default model).

## Why Not Just Use RAG?

Standard RAG retrieves chunks by similarity. It doesn't know:
- That last week's decision overrides last month's
- That your `SOUL.md` should never be outweighed by accumulated noise
- That hostile interaction logs from 3 months ago shouldn't influence today's behavior
- That some memories should be permanent while others should fade

Soul Memory adds the *temporal and identity dimensions* that vanilla RAG lacks.

## The Bigger Picture

Soul Memory is one piece of the agent identity stack:

1. **[Soul Spec](https://github.com/clawsouls/soul-spec)** — Define who your agent is
2. **Soul Memory** — Remember what matters, forget what doesn't
3. **[SoulScan](https://clawsouls.ai)** — Verify identity integrity

Together, they solve the fundamental challenge of long-running AI agents: **maintaining a coherent identity across thousands of interactions while accumulating useful experience.**

---

*Soul Memory is available in [SoulClaw](https://github.com/clawsouls/soulclaw). The temporal decay feature is built into the memory search engine — just enable it in your config.*

*For the research behind this: [The Forgetting Problem: Why Perfect Memory Breaks AI Agent Identity](/posts/perfect-memory-breaks-ai-identity/)*