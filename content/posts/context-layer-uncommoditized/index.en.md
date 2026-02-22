---
title: "Code Generation Is Commoditized. The Context Layer Is Not."
date: 2026-02-22T01:00:00+09:00
description: "Everyone can generate code now. The real moat is the context layer — specs, conventions, architecture decisions — that governs what AI produces. Soul Spec is building exactly this."
categories: ["Insights"]
tags: ["context-engineering", "soul-spec", "ai-coding", "agents-md", "openclaw"]
slug: "context-layer-uncommoditized"
draft: false
---

A [GeekNews article](https://news.hada.io/topic?id=26874) recently distilled something we've been circling for months: **the era of reading code line-by-line is ending, but the era of engineering context is just beginning.**

The piece pulls together research from Anthropic, quotes from Kent Beck, and observations from the OpenAI Codex team. The throughline is clear — code generation is solved. Context is not.

## The Mirror Problem

Anthropic's research found that developers who delegated coding tasks wholesale to AI scored **17% lower** on comprehension quizzes afterward. But here's the nuance: developers who asked AI about *concepts* and then wrote code themselves learned significantly more.

AI isn't making engineers dumber. It's a mirror. As Jeremy Utley (Stanford) puts it: it amplifies laziness for the lazy and sharpness for the sharp. If you have TDD discipline, you'll instruct AI with that discipline. If you say "just build it," you get structureless output.

The question isn't whether to use AI. It's **what you bring to the mirror**.

## Harness Engineering

Ben Shoemaker coined a useful term: **harness engineering**. Instead of reading code line-by-line, you read specs, tests, and architecture. You build the harness — the constraints, the guardrails, the definitions — and let AI fill in the implementation.

The OpenAI Codex team demonstrated this at scale: 3 engineers plus agents produced a million-line codebase that hundreds of people use daily. Their investment wasn't in writing code. It was in **docs, linters, and test infrastructure**.

This is the shift. The engineer's job is increasingly about defining *what correct looks like* rather than implementing it character by character.

## The Uncommoditized Layer

Evan Armstrong nailed the framing: **"Code generation is commoditized, but the context layer governing production code is not."**

What is this context layer? It's the collection of:
- Architecture decisions and *why* they were made
- Coding conventions and style guides
- Domain terminology and business rules
- Test strategies and quality gates
- Behavioral expectations for agents

Today, most teams store this as tribal knowledge, scattered docs, or ad-hoc AGENTS.md files. There's no standard. No portability. No versioning beyond whatever your team wiki supports.

**This gap is exactly what Soul Spec addresses.**

## Soul Spec as Context Engineering

We've written before about how [context engineering validates Soul Spec](/posts/context-engineering-and-soul-spec/). But the GeekNews article sharpens the point. The "context layer" isn't just about coding agents — it's about any AI system that needs to behave consistently within a specific domain.

Soul Spec takes the patterns that frameworks like OpenClaw established — splitting persona configuration into focused files like SOUL.md, IDENTITY.md, AGENTS.md, MEMORY.md — and formalizes them into an open spec. Each file has a clear role:

- **SOUL.md**: Core identity and personality constraints
- **AGENTS.md**: Workflow rules, tool usage, conventions
- **IDENTITY.md**: Voice, tone, behavioral boundaries
- **MEMORY.md**: Persistent context that survives session resets

This isn't a monolithic system prompt. It's structured, portable, shareable context — exactly the layer that Armstrong says hasn't been commoditized yet.

## Kent Beck's Valid Critique

Kent Beck raises an important counterpoint: **"Better AGENTS.md alone won't win the compound interest game."**

He distinguishes between the "finish line game" (reach X, you're done) and the "compound interest game" (today's architecture opens or closes possibilities six months from now). A spec file is static. Software is alive.

This critique is valid — and it's why Soul Spec is a *foundation layer*, not a complete solution. The spec defines the starting constraints. But compounding requires systems built on top: automated testing, continuous integration of context changes, feedback loops where agent behavior informs spec updates.

Soul Spec doesn't pretend to solve compounding by itself. But you can't compound without a foundation. You can't iterate on context that isn't captured, versioned, and portable. The spec is the substrate that makes compounding possible.

## What Engineers Should Read Now

The GeekNews article asks: in an age where we don't read code, what should engineers read?

Our answer:
1. **Specs and constraints** — the rules that govern what AI generates
2. **Architecture decisions** — the *why* behind structural choices
3. **Test output** — the evidence that the system behaves correctly
4. **Context definitions** — AGENTS.md, SOUL.md, domain glossaries
5. **Agent behavior logs** — how your AI actually performed vs. how you intended

Reading code was always a means to an end. The end was understanding *intent and correctness*. Those haven't changed — only the medium has.

## The Opportunity

The context layer is uncommoditized because it's hard. It requires engineering discipline, domain knowledge, and taste — exactly the things AI mirrors back at you rather than generating from nothing.

Soul Spec is one attempt to structure this layer. It's an open spec, not a product moat. The bet is that standardizing context engineering — making it portable across frameworks, shareable across teams, versionable alongside code — creates more value than keeping it proprietary.

Code generation is table stakes. **Context engineering is the game.**

---

*Soul Spec is an open spec for AI persona configuration. Learn more at [clawsouls.ai/spec](https://clawsouls.ai/spec).*
