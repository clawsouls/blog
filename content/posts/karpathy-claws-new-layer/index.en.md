---
title: "Karpathy on Claws: A New Layer in the AI Stack, and the Missing Piece"
date: 2026-02-28T12:00:00+09:00
description: "Andrej Karpathy declares Claws as a new layer in the AI stack: LLM → Agent → Claw. As implementations proliferate, the missing piece is persona portability."
categories: ["Insights"]
tags: ["karpathy", "claws", "openclaw", "ai-agents", "soul-spec", "nanoclaw"]
slug: "karpathy-claws-new-layer"
draft: false
---

## Karpathy Bought a Mac Mini

Andrej Karpathy bought a Mac Mini and started running [OpenClaw](https://github.com/anthropics/openclaw). The Apple Store employee told him "they're selling very well." His verdict:

> "An interesting and exciting new layer of the AI stack."

Karpathy's technical intuition has consistently predicted industry direction — vision-based Autopilot at Tesla, nanoGPT before the GPT era, and now **Claws**. When he puts weight behind a new term, it's not just a buzzword.

## LLM → Agent → Claw

The layered architecture Karpathy describes is clean:

1. **LLM** — The language model itself. Text in, text out.
2. **LLM Agent** — LLM plus tool calling, loops, and judgment. Think Claude Code, Cursor.
3. **Claws** 🦞 — The layer above agents. Extends orchestration, scheduling, context management, tool calling, and **persistence**.

The key differentiator is **persistence**. Agents disappear when the conversation ends. Claws run continuously on personal hardware, communicate via messaging protocols, schedule tasks, and maintain context across sessions.

Simon Willison frames it well: "Claw" is becoming the category term for **AI agent systems that run on personal hardware and operate via messaging protocols**. He praises Karpathy's instinct for naming.

## The Explosion of Small Implementations

Multiple Claw implementations have already emerged:

| Project | Notes |
|---|---|
| **OpenClaw** | Anthropic's reference implementation |
| **NanoClaw** | ~4,000 lines. Comprehensible by both humans and AI |
| **zeroclaw** | Minimal implementation |
| **ironclaw** | Rust-based |
| **picoclaw** | Ultra-minimal |

NanoClaw's approach is particularly compelling. At 4,000 lines, one person can read and understand the entire system. It runs in containers by default and is fully auditable. The value proposition: **AI infrastructure you can actually understand**.

## The Missing Piece: Where Does Persona Live?

Here's the question that emerges naturally.

When there are 5, 10, 50 Claw implementations — what happens to your AI's **personality, behavior patterns, and memory**?

If you've carefully configured a persona in OpenClaw and want to move to NanoClaw? Switch to ironclaw? Do you start from scratch each time?

This is an inevitable problem as the Claw layer matures:

- **Orchestration** — Claws solve this ✅
- **Model inference** — LLM APIs solve this ✅
- **Persona portability** — ? ❌

## Soul Spec: The Persona Layer Above Claws

This is exactly the problem [Soul Spec](https://github.com/clawsouls/soul-spec) addresses.

Soul Spec defines AI personas as structured files — `SOUL.md`, `IDENTITY.md`, `AGENTS.md`, and `soul.json`. These files aren't tied to any specific Claw implementation. They're version-controlled with Git and written in Markdown that any platform can read.

```
┌─────────────────────┐
│    Soul Spec         │  ← persona, identity, behavior
├─────────────────────┤
│    Claw Layer        │  ← orchestration, scheduling, persistence
├─────────────────────┤
│    Agent Layer       │  ← tool use, reasoning loops
├─────────────────────┤
│    LLM Layer         │  ← language model inference
└─────────────────────┘
```

A fun fact: ClawSouls' [surgical-coder](https://github.com/clawsouls/soul-spec/tree/main/examples/surgical-coder) soul started as "Inspired by Karpathy's CLAUDE.md." The configuration file Karpathy put in his own agent — that's the prototype of what Soul Spec standardizes.

## Why Now

When there was only one Claw implementation, no standard was needed. Just do it the OpenClaw way.

But with NanoClaw, zeroclaw, ironclaw, and picoclaw on the scene, **interoperability** becomes a real problem. And the most human layer that needs interoperability is persona.

Just as Karpathy declared Claws a new layer of the AI stack, persona portability needs its own standard layer.

## Conclusion

Karpathy's observation is precise. Claws aren't just tools — they're a **structural evolution** of the AI stack. If LLMs handle reasoning, Agents handle action, and Claws handle persistence, then the layer above must handle **identity**.

The 🦞 emoji became the symbol of Claws. Soul Spec is the work of giving that 🦞 a **soul**.
