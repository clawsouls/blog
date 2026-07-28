---
title: "How to Write an AGENTS.md That Actually Works"
date: 2026-07-27T22:26:00+09:00
draft: false
description: "AGENTS.md is becoming the standard way to tell a coding agent how to work in your repo — but most are too long and quietly ignored. A practical, research-backed guide to writing one that actually changes agent behavior."
categories: ["Guide"]
tags: ["agents-md", "coding-agents", "context-engineering", "prompt-engineering", "soul-spec"]
slug: "how-to-write-agents-md"
canonical: "https://blog.clawsouls.ai/posts/how-to-write-agents-md/"
---

## The file everyone adds and no one reads twice

`AGENTS.md` has quietly become the standard way to tell a coding agent how to work inside your repository. Codex reads it, Cursor and Cline read their variants of it, and the [agents.md](https://agents.md) convention is spreading fast. So teams add one — and then watch the agent ignore half of it.

The problem is rarely that the agent can't follow instructions. It's that most `AGENTS.md` files are written like onboarding docs for a new human hire: a tour of the project, paragraphs of background, aspirational values. That is exactly the wrong shape for a file whose only job is to change what a model does on the next turn.

Here's what the research — and the frontier labs' own guidance — actually says about writing one that lands.

## 1. Lead with the gotchas, not the tour

An empirical study of real context files found they skew heavily toward *functional* detail — build commands, implementation notes, architecture — while the things that actually prevent bad output, like security and performance guardrails, show up in barely one in seven files. The agent usually doesn't need you to describe the project; it can read the project. It needs the handful of non-obvious traps: the migration that must run first, the endpoint that looks safe but isn't, the pattern the codebase deliberately avoids.

Open with those. If a line could be discovered by reading the code, it's probably not earning its place.

## 2. Prescriptive beats descriptive

There's a real difference between *"this service handles auth"* and *"never log the `Authorization` header."* The first is description; the second is an operational rule. When instructions stay as passive prose, they get diluted under context saturation and quietly violated. Rules that read as constraints — do this, never that, always check X first — survive the long context window far better.

Write commands, not commentary.

## 3. Smaller than you think

When Anthropic tuned Claude Code for its newest models, it cut the system prompt by roughly 80% with no measurable drop in coding performance. The lesson isn't "prompts don't matter" — it's that **capable models need direction, not saturation.** Every extra paragraph you add competes for attention with the paragraph that actually matters.

Aim for a tight core. If your `AGENTS.md` has grown past a screen or two, it's probably describing things the model already knows.

## 4. Don't contradict yourself

The most expensive lines in an instruction file are the ones that fight each other. One section says "leave documentation as appropriate," another says "do not add comments," and the model burns reasoning deciding which wins before it can touch a file. Frontier-lab engineers now literally recommend appending a single unambiguous rule (`echo "Avoid code comments unless asked" >> CLAUDE.md`) over a long, self-contradicting policy. Consistency is a feature.

## 5. Structure for role-based lookup

Give the file clear sections — setup, conventions, guardrails, gotchas — so the model (and your teammates) can find the relevant rule without re-reading everything. This is *semantic* structure: organizing by function, not just formatting with Markdown. It's cheap and it compounds.

## Where this fits: identity vs. operations

`AGENTS.md` is the *operational* layer — how the agent works in this repo. It's separate from the agent's *identity* — who it is, its voice, its standing principles. Mixing the two into one giant file is a common reason `AGENTS.md` files bloat.

That separation is the core idea behind the [Soul Spec](https://clawsouls.ai/spec): identity lives in `SOUL.md` / `IDENTITY.md`, operations in `AGENTS.md`, and each stays focused. With the ClawSouls CLI you can install a curated persona straight into the convention your tool expects:

```bash
npx clawsouls install clawsouls/surgical-coder --use codex
```

The persona is merged into your `AGENTS.md` inside `clawsouls` markers, so your existing rules are preserved. And before you ship it, [SoulScan](https://clawsouls.ai/soulscan) can check the file for the contradictions and missing guardrails this post is about.

## The one-line version

A good `AGENTS.md` is short, prescriptive, contradiction-free, and front-loaded with the traps a model can't infer from the code. Write it like a checklist for a very capable colleague who is in a hurry — because that's exactly what's reading it.
