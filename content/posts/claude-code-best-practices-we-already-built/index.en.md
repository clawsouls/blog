---
title: "Everything Claude Code Experts Recommend, We Already Built Into SoulClaw"
date: 2026-03-20
description: "The community is discovering context engineering best practices for AI coding agents. SoulClaw has had them as core architecture since day one."
tags: ["ai-agents", "context-engineering", "soulclaw", "claude-code", "memory", "developer-tools"]
draft: false
---

## The Community Is Discovering What We Already Know

Two recent videos are making the rounds in the AI coding community. One breaks down [CLAUDE.md best practices](https://www.youtube.com/watch?v=cZ8_Dkk_Ce0) — how to write the context file that shapes Claude Code's behavior. The other shares [10 tips from an Anthropic hackathon winner](https://youtu.be/QhZJyg47JW0) on getting 10x productivity from Claude Code.

Both are excellent resources. And watching them, I couldn't help but notice: **nearly every recommendation maps directly to something we've already built into SoulClaw.**

Not as a hack. Not as a workaround. As core architecture.

## "Keep Your Context File Short" → SOUL.md

The first video warns against bloated context files — 200-300 lines of instructions that create noise and confusion. The recommendation: start with an empty file and add one rule at a time, only when the AI makes a mistake.

SoulClaw's answer is **SOUL.md** — a structured identity specification that's deliberately concise (ours is 30 lines) and follows the [Soul Spec](https://soulspec.org) standard. It's not a dump of instructions. It's a carefully curated identity document that tells the agent *who it is*, not just *what to do*.

The difference matters. A list of rules is fragile — one conflicting instruction and the AI ignores everything. An identity specification is robust — it gives the agent a coherent self to maintain.

## "Context Is Milk — It Spoils" → Temporal Decay

The hackathon winner's most striking metaphor: context is like milk. It goes bad over time. His advice: use `/compact` regularly to clean up stale context.

We took this insight and **made it math.**

SoulClaw's [Soul Memory](/posts/soul-memory-4-tier-architecture) implements temporal decay with a 23-day half-life on working memories. Information doesn't just pile up forever — it naturally fades, just like human memory. The formula:

```
final_score = semantic_score × e^(-λ × age_days)
```

No manual `/compact` needed. The system forgets gracefully on its own.

## "Use the Right Model for the Job" → TieredBootstrap

The recommendation: use Haiku for file lookups, Sonnet for general coding, Opus for complex design.

SoulClaw's **TieredBootstrap** automates this entirely. It analyzes the task complexity, available context budget, and model capabilities to select the appropriate tier. The user doesn't have to think about model selection — the system handles it.

On Android, this is even more critical. When running local models with limited context windows (1024 tokens), TieredBootstrap automatically compresses the system prompt, prioritizes recent messages, and adapts to the constraint.

## "Set Up Sub-Agents" → Swarm Architecture

The advanced tip: create specialized agents for planning, coding, and review.

SoulClaw ships with a full **swarm architecture** — multiple souls can collaborate on complex tasks, each maintaining their own identity and specialization. This isn't a prompt engineering trick. It's built into the infrastructure with conflict resolution, memory isolation, and coordinated handoffs.

## "Build Hooks for Auto-Save" → Heartbeat + Memory Promotion

The videos recommend setting up hooks at session start, pre-compact, and stop to automatically save important context.

SoulClaw's approach goes further:

- **Heartbeat system**: A background agent periodically checks for pending work, memory health, and context freshness — even when you're not actively chatting.
- **Access-frequency tracking**: The system monitors which memories you actually *use* in conversations. Frequently accessed working memories get automatically promoted to permanent storage.
- **Promotion detection**: When a conversation contains a significant decision, architecture change, or financial/legal milestone, the system flags it for preservation — no manual hook configuration needed.

## "Add Rules When AI Makes Mistakes" → Progressive Identity Building

Both videos emphasize iterative refinement: start minimal, add rules after failures.

This is exactly how SOUL.md evolves in practice. But SoulClaw adds a crucial insight: **not all rules are equal.** Our 4-tier memory architecture classifies information by importance:

| Tier | What Lives Here | Decay |
|------|----------------|-------|
| **T0 Soul** | Identity, personality, immutable rules | Never |
| **T1 Core** | Key decisions, architecture, relationships | Never |
| **T2 Working** | Daily logs, session context, experiments | 23-day half-life |
| **T3 Session** | Current conversation | End of session |

A rule that prevents destructive commands (`trash` > `rm`) goes to T0. Today's debugging session goes to T2. The system knows the difference.

## What the Videos Don't Cover

The best practices in these videos are genuinely useful. But they're all **manual processes** — the developer has to remember to compact context, choose the right model, set up hooks, manage sub-agents.

SoulClaw's thesis is that these shouldn't be manual. They should be **architectural**:

- Memory should decay automatically, not when you remember to run `/compact`
- Model selection should adapt to the task, not require developer judgment
- Important decisions should be preserved by the system, not by hoping you set up the right hook
- Identity should be maintained through structured specification, not through ever-growing rule lists

## The Bigger Picture

These videos are a sign that the community is converging on the same conclusions we reached months ago:

1. **Unlimited context is harmful** — you need structured forgetting
2. **Identity needs explicit specification** — ad-hoc rules aren't enough
3. **Memory management should be automated** — manual cleanup doesn't scale
4. **Different tasks need different approaches** — one model doesn't fit all

The difference is that these remain tips and tricks in most workflows. In SoulClaw, they're first-class architectural features.

If you're manually managing CLAUDE.md files, running `/compact` by hand, and configuring hooks to save context — you're doing the right things. We just think the system should do them for you.

---

*SoulClaw is an open-source AI agent framework that implements structured identity preservation through the Soul Spec standard. [Try it →](https://clawsouls.ai)*

*This is the fifth post in our series on AI agent identity. Previously: [Perfect Memory Is Breaking Your AI Agent's Identity](/posts/perfect-memory-breaks-ai-identity), [Soul Memory: A 4-Tier Architecture](/posts/soul-memory-4-tier-architecture), [Why Perfect Memory Is Architecturally Impossible](/posts/why-perfect-memory-is-impossible), and [The Human in the Loop of Identity](/posts/the-human-in-the-loop-of-identity).*