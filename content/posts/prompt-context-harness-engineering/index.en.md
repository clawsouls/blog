---
title: "Prompt → Context → Harness: The Three Stages of AI Engineering and Why the Third Changes Everything"
date: 2026-04-02T08:00:00+09:00
description: "AI engineering is evolving from prompt engineering to context engineering to harness engineering. Each stage requires a different kind of specification — and only one open standard covers all three."
categories: ["Analysis"]
tags: ["harness-engineering", "context-engineering", "prompt-engineering", "soul-spec", "ai-agents", "multi-agent"]
author: "ClawSouls"
draft: false
---

The AI industry loves naming eras. We had the prompt engineering era. Then came context engineering. Now we're entering what may be the most consequential shift yet: **harness engineering**.

Each stage represents a fundamental change in *what we're designing* when we build AI systems. And each stage demands a different kind of specification.

## Stage 1: Prompt Engineering — Talking to the Model

The first era was about learning to talk to AI. We crafted system prompts, experimented with role-playing instructions, and discovered that saying "think step by step" actually worked.

**What we were designing:** The input to a single model call.

**The specification:** A text string. Usually in a system prompt. Often copy-pasted from a blog post.

**The limitation:** A prompt is ephemeral. It exists in one session, for one model, and disappears when the context window resets. There's no versioning, no portability, no audit trail.

In Soul Spec terms, this is what `SOUL.md` addresses — personality, tone, and thinking style. But Stage 1 treated it as disposable text, not a persistent identity file.

## Stage 2: Context Engineering — Feeding the Model

The second era recognized that *what you tell the model* matters as much as *how you ask*. Context engineering is about providing the right information — files, search results, conversation history, tool outputs — at the right moment.

**What we were designing:** The information pipeline into the model.

**The specification:** RAG configurations, retrieval strategies, context window management. Still mostly ad hoc.

**The limitation:** Context engineering optimizes the *input* but doesn't address the *system*. It doesn't answer: What tools can the agent use? How does it coordinate with other agents? What are its safety boundaries? What does it remember across sessions?

In OpenClaw terms, this maps to `MEMORY.md` and tool configurations — the knowledge layer that persists across conversations.

## Stage 3: Harness Engineering — Designing the System

This is where we are now. Harness engineering is about designing the **execution system** that wraps around the model — the scaffolding that turns a language model into an agent.

**What we're designing:** The complete agent architecture.

A harness includes:
- **Tool orchestration** — which tools the agent can call and when
- **Multi-agent coordination** — how agents divide work, communicate, and verify each other
- **Memory management** — what persists across sessions and how it's consolidated
- **Safety enforcement** — what the agent can and cannot do, with hard and soft constraints
- **Session management** — how long-running tasks maintain state

**The specification:** This is what's missing. Most harnesses are proprietary, opaque, and locked to a single framework.

### Why Harness Engineering Matters More Than Model Intelligence

Recent experiments demonstrate this dramatically. A single Claude Opus 4.5 call with no harness produces serviceable output. The same model wrapped in a well-designed harness — with generator, evaluator, and planner agents working in coordination — produces output that's qualitatively different. Not just better. *Categorically* better.

The harness costs more time and compute. But the quality gap is so large that the economics are obvious: **investing in harness design yields higher returns than investing in model upgrades.**

This matches what hardware is doing too. NVIDIA's Dynamo system orchestrates AI agents at datacenter scale — allocating resources, managing throughput, coordinating inference across heterogeneous hardware. Even at the silicon level, the industry is moving from "bigger model" to "better orchestration."

## The Specification Gap

Here's the problem: each stage of AI engineering created its own kind of specification, but none of them are standardized or portable.

| Stage | What we specify | Current state |
|-------|----------------|---------------|
| Prompt Engineering | Personality, role, tone | Ad hoc system prompts |
| Context Engineering | Knowledge, memory, retrieval | RAG configs, custom code |
| Harness Engineering | Tools, agents, safety, coordination | **Locked inside proprietary frameworks** |

The [Claude Code leak](/posts/claude-code-leak-harness-era) exposed exactly this problem. Anthropic built sophisticated harness features — Dream (memory), Buddy (personality), Coordinator (multi-agent), Undercover Mode (safety) — all hardcoded inside one framework. Switch to Cursor, and you lose everything.

## Soul Spec: One Standard for All Three Stages

What if there were a portable, open standard that covered all three stages?

```
my-agent/
├── soul.json       # Metadata: version, author, compatibility, safety.laws
├── SOUL.md         # Stage 1: Personality, tone, behavioral rules
├── IDENTITY.md     # Stage 1: Role, name, context
├── AGENTS.md       # Stage 3: Multi-agent coordination rules
└── STYLE.md        # Stage 1: Communication style guide
```

| File | Stage | Purpose |
|------|-------|---------|
| `SOUL.md` | Prompt | Who the agent *is* — personality, values, behavioral rules |
| `IDENTITY.md` | Prompt | What the agent *does* — role, capabilities, boundaries |
| `AGENTS.md` | Harness | How the agent *works* — coordination patterns, delegation rules, workflow |
| `soul.json` | Harness | What the agent *must not do* — `safety.laws` with prioritized constraints |

Every file is human-readable. Every file is machine-parseable. Every file is portable across Claude Code, OpenClaw, Cursor, Windsurf, or any future framework.

## Why This Matters Now

Three converging trends make this urgent:

### 1. Multi-Agent is Becoming Default
Single-agent architectures are hitting their limits. The future is teams of specialized agents — and teams need shared behavioral contracts. `AGENTS.md` is that contract.

### 2. Long-Running Inference is Becoming Normal
As agents tackle multi-hour and multi-day tasks, memory management becomes critical. Not just what to remember, but how to consolidate, prune, and share knowledge across sessions. Frameworks like OpenClaw already use `MEMORY.md` for this, and multi-agent memory sync is the next frontier.

### 3. Safety is Becoming a Market Differentiator
[81,000 people told Anthropic](/posts/81k-interviews-trust-gap) their #1 concern is trust, not intelligence. Structured, auditable safety rules — not hidden system prompts — are what users want. `safety.laws` makes safety inspectable.

## The Harness Competition

The shift from model competition to harness competition is real and accelerating:

- **Anthropic** is building Dream, Buddy, Coordinator, KAIROS, ULTRAPLAN — all harness features
- **Major hosting providers** are deploying 100K+ managed AI agents with built-in credits
- **Well-funded startups** are raising hundreds of millions for "AI Employee" harness products

Everyone is investing in the harness. But nobody is investing in a **portable standard for harness behavior**.

That's the gap. That's what Soul Spec fills.

The model race made AI powerful. The harness race will make AI useful. And the standard that defines how harnesses behave will determine whether users own their agents — or their agents own them.

---

**References:**

- "하네스 엔지니어링의 시대" — [YouTube](https://youtu.be/g6YesZMG40s)
- [What the Claude Code Leak Reveals](/posts/claude-code-leak-harness-era) — ClawSouls Blog
- [81,000 People Told Anthropic What They Really Want](/posts/81k-interviews-trust-gap) — ClawSouls Blog
- Soul Spec v0.5 — [soulspec.org](https://soulspec.org)
- ClawSouls Registry — [clawsouls.ai](https://clawsouls.ai)
