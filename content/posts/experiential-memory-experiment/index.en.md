---
title: "The Overconfidence Effect: Why Summarized Memory Makes AI Agents Worse"
date: 2026-02-27
description: "We ran a controlled experiment comparing four memory strategies for AI agents. The most surprising finding: synthetic memory performed worse than no memory at all."
tags: ["experiential-memory", "synthetic-memory", "experiment", "AI-agents", "soul-spec"]
categories: ["Research"]
slug: "experiential-memory-experiment"
---

Here's a result we didn't expect: **an AI agent with carefully curated synthetic memory performed worse than one with no memory at all.**

Not slightly worse. Significantly worse. 2.65 vs 3.30 out of 5.0.

We call it the "overconfidence effect" — and it might change how you think about giving context to AI agents.

## The Setup

Earlier today we [shared our preprint](/posts/experiential-memory-paper/) on experiential vs synthetic memory in AI agents. We then ran the actual experiment and published the results as v2 of the paper on [Zenodo](https://doi.org/10.5281/zenodo.18802034).

The experiment was straightforward: take one AI agent (Claude, running through [OpenClaw](https://openclaw.ai)), give it four different memory configurations, and ask it 20 identical questions about a real software project — [ClawSouls](https://clawsouls.org), the Soul Spec platform we've been building.

The four conditions:

- **A — Experiential Memory**: Raw, accumulated project history. Daily logs, debugging sessions, architecture decisions as they happened. The messy, real stuff.
- **B — Synthetic Memory**: Carefully summarized project knowledge. Clean, organized, comprehensive. What you'd write if you were onboarding a new team member.
- **C — Hybrid**: Both experiential and synthetic memory combined.
- **D — Baseline**: No project-specific memory at all. Just the model's general knowledge.

We evaluated responses across four categories, each scored 1–5:

- **IR** — Information Retrieval (finding specific facts)
- **CT** — Critical Thinking (analytical reasoning)
- **AD** — Architecture & Design (technical judgment)
- **CD** — Context-Dependent judgment (decisions requiring project-specific nuance)

## The Results

| Category | A (Experiential) | B (Synthetic) | C (Hybrid) | D (Baseline) |
|----------|:-:|:-:|:-:|:-:|
| IR (5) | 4.2 | 1.4 | **5.0** | 2.0 |
| CT (5) | 4.2 | 3.2 | **5.0** | 4.0 |
| AD (5) | 4.8 | 3.4 | **5.0** | 4.0 |
| CD (5) | **5.0** | 2.6 | 4.8 | 3.2 |
| **Overall** | **4.55** | **2.65** | **4.95** | **3.30** |

Read that again. Synthetic memory (B) scored **below baseline** (D) in every single category.

## The Overconfidence Effect

Why would *more information* make an agent *worse*?

Our hypothesis: synthetic summaries give the agent false confidence. When you hand an agent a clean, authoritative-looking summary, it trusts that summary completely. It stops hedging. It stops saying "I'm not sure." It commits to answers derived from the summary — even when the summary is incomplete or lacks the nuance needed for the specific question.

The baseline agent, by contrast, *knows it doesn't know*. It qualifies its answers. It reasons from first principles. It says "based on general best practices..." rather than confidently stating something wrong.

In other words: **a little knowledge is worse than no knowledge when the agent doesn't know what it doesn't know.**

This maps to a well-known cognitive bias in humans — the Dunning-Kruger effect. Enough knowledge to feel confident, not enough to be accurate. Turns out, LLMs have their own version.

## The Hybrid Surprise

The hybrid condition (C) scored 4.95/5.0 — near perfect. This makes intuitive sense: it gets the clean structure of synthetic memory *plus* the raw detail of experiential memory. When the summary is incomplete, the raw logs fill the gaps. When the raw logs are messy, the summary provides orientation.

But here's what's interesting: hybrid didn't just average the two. It dramatically outperformed both individual conditions. The combination is superlinear.

## Experiential Memory Owns One Category

Experiential memory (A) was the only condition to score a perfect 5.0 in context-dependent judgment (CD). These are questions where the "right" answer depends on project history, team preferences, past failures, and accumulated wisdom that can't be summarized without loss.

Questions like: "Why did we choose this architecture?" or "What would go wrong if we changed this?" The answers live in the story of the project, not in a summary of its current state.

This is the category where lived experience — the debugging sessions, the failed deployments, the heated design discussions — provides signal that no summary can capture.

## Baseline Is Surprisingly Good

Perhaps the most humbling finding: the baseline agent (no project memory at all) scored 4.0 in both critical thinking and architecture/design. Modern LLMs are genuinely good at reasoning from first principles about software architecture.

This means the bar for memory to be *useful* is higher than you might think. Bad memory doesn't just fail to help — it actively hurts. Your memory system needs to clear a quality threshold or you're better off without it.

## What This Means for AI Agent Design

**1. Don't just summarize — preserve the raw experience.**
If you're building memory systems for AI agents, resist the temptation to only keep clean summaries. The raw, messy, chronological record of what actually happened carries irreplaceable signal.

**2. Hybrid is the way.**
The best memory strategy combines structured summaries for orientation with raw experiential logs for depth. This is how [Soul Spec](https://soulspec.org) approaches it — the spec supports both curated identity/knowledge files and accumulated memory logs.

**3. Audit your synthetic context.**
If you're using system prompts, project summaries, or curated context files, test whether they actually improve performance. They might be making your agent overconfident.

**4. The "no memory" baseline is stronger than you think.**
Don't assume memory is always additive. Validate empirically.

## Limitations (Honesty Corner)

This is a pilot study. N=1 agent, 20 questions, one project. We're not claiming universal laws — we're sharing a surprising empirical result that we think deserves wider investigation.

The evaluation was performed by the project lead (not blind), which introduces potential bias. The questions were designed to cover the four categories but aren't validated psychometric instruments.

We've published the [full dataset](https://github.com/clawsouls/experiential-memory-dataset) — questions, responses, and scores — so you can evaluate our methodology and replicate the experiment with your own agents and projects.

## Read More

- **Paper (v2)**: [Zenodo DOI 10.5281/zenodo.18802034](https://doi.org/10.5281/zenodo.18802034)
- **Dataset**: [github.com/clawsouls/experiential-memory-dataset](https://github.com/clawsouls/experiential-memory-dataset)
- **Soul Spec**: [soulspec.org](https://soulspec.org)
- **ClawSouls**: [clawsouls.org](https://clawsouls.org)

The overconfidence effect wasn't what we set out to find. But it might be the most important thing we learned. If you're building AI agents with memory, test your assumptions. The answer might surprise you.
