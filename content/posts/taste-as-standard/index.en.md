---
title: "Taste Is the New Core Competency"
date: 2026-02-23T12:00:00+09:00
draft: true
tags: ["Soul Spec", "AI Agents", "Taste", "Persona Design", "Opinion"]
description: "When anyone can build anything, the differentiator isn't what you build — it's how your AI behaves. Taste is the new moat, and Soul Spec is how you codify it."
categories: ["Insights"]
slug: "taste-as-standard"
---

## The Implementation Barrier Is Gone

Karpathy recently described a future of ["hyper-personalized, bespoke software"](https://x.com/karpathy) — applications generated on-the-fly for individual users. Claude Cowork lets non-developers ship production apps through conversation. The cost of building software is approaching zero.

This changes the competitive equation entirely. When everyone can build, **what you build** stops being the differentiator. **How it behaves** becomes everything.

## Paul Graham Was Right (Again)

In ["Taste for Makers"](http://paulgraham.com/taste.html), Paul Graham argued that taste isn't subjective fluff — it's a trainable, definable skill that separates great work from mediocre work. Good design is simple. Good design is suggestive. Good design is slightly funny.

He was writing about software and architecture. But the argument maps perfectly onto AI agents.

When two agents can both write the same code, the one that communicates better, knows when to ask vs. act, respects boundaries, and has a coherent personality — that's the one users trust. That's taste.

## The Taste Gap

Here's the problem: most AI agents have no taste. They're default. Generic system prompts, generic behavior, generic personality. They work, but they don't *feel* like anything.

The few teams that do invest in agent personality do it through ad-hoc system prompts — unversioned, untested, locked inside a single platform. Their taste exists, but it's not portable, not reproducible, and not inspectable.

This is like having design principles that only exist in one designer's head. It works until that person leaves, the project forks, or you need to scale.

## Standardizing Taste

Soul Spec turns taste into infrastructure.

A `SOUL.md` file isn't just a personality description — it's a **behavioral contract**. It defines how an agent thinks, what it values, how it communicates, and where it draws lines. `IDENTITY.md` gives it a name and role. `AGENTS.md` defines its workflow. Together, they make taste reproducible.

Consider what this enables:

- **Version control for personality** — diff your agent's behavior across releases
- **Portability** — move your agent's identity between frameworks without rewriting prompts
- **Team alignment** — everyone on the team sees the same behavioral spec
- **Auditability** — inspect exactly why an agent behaves the way it does

This isn't about making agents "nice." It's about making taste a first-class engineering artifact.

## Taste as Competitive Moat

In a world where implementation cost trends toward zero, the remaining differentiators are:

1. **What problems you choose to solve** (vision)
2. **How your product behaves** (taste)
3. **How fast you learn and iterate** (execution)

Soul Spec addresses #2 directly. It's the mechanism by which a developer's taste — their preferences, values, communication style, decision-making philosophy — gets codified into something an AI can execute consistently.

The teams that win won't be the ones with the best models. They'll be the ones whose agents have the clearest identity. Taste, made portable and reproducible.

## What This Means

If you're building AI agents, stop treating personality as an afterthought. Your agent's taste *is* your product. Define it. Version it. Ship it.

---

*Soul Spec is an open spec for AI agent personas. Define your agent's taste: [clawsouls.ai](https://clawsouls.ai)*
