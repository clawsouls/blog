---
title: "How SoulClaw Cuts Token Usage by 60% With Tiered Bootstrap Loading"
date: 2026-03-07T16:30:00+09:00
draft: false
tags: ["soulclaw", "context-window", "token-optimization", "openclaw", "system-prompt", "progressive-disclosure", "soul-spec"]
categories: ["Technical"]
summary: "OpenClaw loads every workspace file into every system prompt — even memory files you don't need. SoulClaw's tiered bootstrap loading cuts 40-60% of wasted tokens by loading only what matters, when it matters."
---

Every time your AI agent responds, the runtime stuffs its entire workspace into the system prompt. SOUL.md. IDENTITY.md. AGENTS.md. TOOLS.md. USER.md. MEMORY.md. Every file in `memory/`. HEARTBEAT.md. BOOTSTRAP.md.

That's **thousands of tokens per turn**, even when you're asking "what time is it?"

We fixed this in [SoulClaw](https://github.com/clawsouls/soulclaw).

## The Problem

OpenClaw loads all workspace files into every system prompt unconditionally. For a real agent like Brad (our development partner), this means:

- SOUL.md: ~800 tokens
- IDENTITY.md: ~100 tokens
- AGENTS.md: ~200 tokens
- TOOLS.md: ~400 tokens
- USER.md: ~200 tokens
- MEMORY.md: ~4,000 tokens
- memory/*.md (12 files): ~6,000 tokens
- HEARTBEAT.md: ~50 tokens
- BOOTSTRAP.md: ~100 tokens

**Total: ~12,000 tokens per turn.** Every single turn. Whether the agent needs the memory or not.

With Claude's pricing at $15/M input tokens (Opus), that's **$0.18 per 1,000 turns** just for workspace injection. For a team of 4 agents running 500 turns/day, that's $360/month in pure waste.

## The Insight

Not all files are equal:

1. **Identity files** (SOUL.md, IDENTITY.md, AGENTS.md) — the agent needs these every turn. Without them, it doesn't know who it is.

2. **Session files** (TOOLS.md, USER.md, BOOTSTRAP.md) — useful for the first message, but the agent already has this context after turn 1.

3. **Memory files** (MEMORY.md, memory/*.md) — the agent has a `memory_search` tool. It can fetch specific memories when needed. Injecting the entire memory into every prompt is like printing your entire diary every time someone asks you a question.

## The Solution: Tiered Bootstrap Loading

SoulClaw introduces three tiers of progressive disclosure:

| Tier | Files | When Loaded |
|------|-------|-------------|
| **Tier 1** | SOUL.md, IDENTITY.md, AGENTS.md | Every turn |
| **Tier 2** | TOOLS.md, USER.md, BOOTSTRAP.md | First turn only |
| **Tier 3** | MEMORY.md, memory/*.md | Never injected |

### How It Works

On the **first message** of a new session, the agent gets Tier 1 + Tier 2 — everything except memory files. This gives it full context to start working.

On **subsequent messages**, only Tier 1 is loaded. The agent already knows the tools and user preferences from turn 1 — they're in the conversation history.

**Memory is never injected.** The agent uses `memory_search` to pull specific memories when needed. This is how humans work too — you don't replay your entire life before answering a question.

For **heartbeat** runs, SoulClaw loads Tier 1 + HEARTBEAT.md only. No need for tools, user info, or memory during a routine status check.

### Implementation

The change is surgical. Three key decisions:

1. **Session file existence = continuation.** If a session file exists, it's not the first turn. Load Tier 1 only.

2. **Tier classification is static.** Each file has a fixed tier. No ML, no heuristics, no runtime analysis. Simple lookup.

3. **Backward compatible.** Set `SOULCLAW_TIERED_BOOTSTRAP=0` to get upstream OpenClaw behavior.

```typescript
// Tier 1: Core identity — always loaded
const TIER_1_FILES = new Set(['SOUL.md', 'IDENTITY.md', 'AGENTS.md']);

// Tier 2: Session context — first turn only
const TIER_2_FILES = new Set(['TOOLS.md', 'USER.md', 'BOOTSTRAP.md']);

// Tier 3: Memory — available via memory_search tool
const TIER_3_FILES = new Set(['MEMORY.md', 'HEARTBEAT.md']);
// + all memory/*.md files
```

## Real Numbers

Brad's workspace (236 files, ~1,700 memory chunks):

| Scenario | OpenClaw | SoulClaw | Savings |
|----------|----------|----------|---------|
| First turn | ~12,000 tokens | ~5,700 tokens | 52% |
| Continuation | ~12,000 tokens | ~4,500 tokens | 62% |
| Heartbeat | ~12,000 tokens | ~1,150 tokens | 90% |

Over a typical workday (200 turns, 80% continuations):

- **OpenClaw**: 2,400,000 input tokens
- **SoulClaw**: 960,000 input tokens
- **Saved**: 1,440,000 tokens/day = **$21.60/day** (Opus pricing)

## But What About Memory Context?

The key insight: **the agent already has a memory_search tool.** When it needs to know about a past decision, it searches. When it needs to recall a deadline, it searches. The tool returns exactly the relevant snippets — not the entire memory file.

This is actually *better* than injecting everything. With full injection, the model has to scan thousands of tokens of memory to find what's relevant. With search, it gets precisely what it needs.

```
User: "변리사 미팅 언제야?"
Agent: [calls memory_search("patent attorney meeting")]
→ Returns: "3/12 Thu, Attorney Kim" (8 tokens)

vs.

Agent: [scans 4,000 tokens of MEMORY.md to find the same 8 tokens]
```

## Try It

```bash
npm install -g soulclaw
soulclaw gateway start
```

SoulClaw is a drop-in replacement for OpenClaw. All existing configurations, plugins, and tools work unchanged. The only difference: your agent uses fewer tokens.

## Links

- [SoulClaw on GitHub](https://github.com/clawsouls/soulclaw)
- [SoulClaw on npm](https://www.npmjs.com/package/soulclaw)
- [ClawSouls](https://clawsouls.ai) — AI persona platform
- [Soul Spec](https://docs.clawsouls.ai) — Open agent identity specification
