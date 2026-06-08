---
title: "OpenAI Dreaming V3 vs Soul Spec — Same Hypothesis, Different Bets"
date: 2026-06-08T09:59:00+09:00
description: "OpenAI's Dreaming V3, announced yesterday, brings automatic memory synthesis to free-tier ChatGPT users. It starts from the same hypothesis as Soul Spec — but bets in the opposite direction on two decisive choices: raw logs vs synthesis, single-vendor vs multi-runtime. Here is what our 3-week controlled experiment data says about that difference."
categories: ["Analysis"]
tags: ["openai", "dreaming-v3", "soul-spec", "memory", "ai-agents", "open-standard", "persona"]
author: "ClawSouls"
draft: false
---

On June 5, 2026, OpenAI announced **Dreaming V3** — an automatic memory synthesis system now rolling out to free-tier ChatGPT users. The announcement highlights three pillars: Persistent Context, Preference Compliance, and Temporal Understanding.

These are exactly the hypotheses we started **Soul Spec** with six months ago. Persistent identity, user preferences, and a memory hierarchy with temporal decay — they map 1:1 onto Soul Spec's T0 SOUL, USER.md, and T1–T3 memory tiers.

Two players converging on the same hypothesis is a good sign. Following Anthropic's Persona Selection Model paper in January 2026, this is the second frontier-lab endorsement. **"The next axis for AI agents is who answers — persistent identity and adaptive memory."** That framing is now an industrial thesis that two frontier labs are betting on simultaneously.

But when we read the announcement carefully, one thing became clear — OpenAI is making the **opposite bet on two decisive choices**.

## Bet 1: Automatic Synthesis vs Raw Logs

Dreaming V3 performs "automatic memory synthesis." It analyzes past conversations and updates stored information without explicit user requests. Users can review/edit/manage through a Memory Summary page, but **the synthesis itself is done by the model.**

This is exactly the pattern we measured in a controlled experiment from March through May. We asked the same agent 20 questions under four memory configurations and scored decision quality (5-point scale):

| Memory configuration | Score |
|---|---|
| **Raw daily logs** | **4.55** |
| No memory | 3.30 |
| Curated summaries | 2.65 |
| **Synthetic memory tier** | **1.40** |

The full dataset is published on Zenodo (DOI [10.5281/zenodo.18809616](https://doi.org/10.5281/zenodo.18809616)). It is reproducible.

The headline finding is simple: **curated summaries strip uncertainty out. Synthetic memory strips it out one level further.** Raw logs preserve the "tried it and failed" moments — the debugging sessions, the wrong turns, the parts where we tried X and it didn't work. Those traces keep agent reasoning honest.

Synthetic memory moves in the opposite direction. When the model smooths the past into a clean identity statement, the agent stops knowing what it doesn't know. The result is **overconfidence**. That is why the score collapses to 1.40.

OpenAI's Dreaming V3 is betting on top of that synthesis pattern. Our data says the bet is pointed the wrong way.

This is why we share the same hypothesis as the Anthropic PSM paper but go in the opposite direction from OpenAI. PSM gave academic grounding to the idea that "an AI assistant is a selection among pre-trained characters, and that character's traits are its behavior." **The mechanism by which we select that character** — synthesis or raw — remained an open question. Two different bets on that mechanism have now landed within six months of each other.

## Bet 2: Single Vendor vs Multi-Runtime

Dreaming V3 lives inside ChatGPT. The identity you build there cannot move to Claude, Cursor, Windsurf, or OpenClaw. Identity is locked inside a ChatGPT account's database.

Soul Spec was designed the other way around. Identity and memory live in **one file** — `.soul.md` — and that file behaves the same way across compatible runtimes: Claude Code, Claude Desktop, Cursor, Windsurf, OpenClaw, Hermes Agent. One download, and the same persona stays consistent across different models and different runtimes.

This is not just a matter of "user choice." The AI-agent ecosystem going multi-vendor is now obvious — Claude and GPT and Gemini, with dozens of agent runtimes built on top of them. Users' time, context, and personas have to travel with them across all of that.

**Locking identity into a single vendor is 2024 thinking. Identity in 2026 has to be portable.**

This is why we shipped Soul Spec as an [open standard](https://soulspec.org), not a closed SDK, and shipped open-source runtimes like SoulClaw alongside it. A standard that lives inside one company is not a standard.

## What OpenAI's bet means

This announcement tells us two things at once.

**Industrial validation.** The hypothesis that "the next axis for AI agents is persistent identity and adaptive memory" is now a thesis two frontier labs are betting on simultaneously. Six months ago, when we started Soul Spec, this framing sat almost alone — academically and industrially. That has changed. It is a strong signal that our timing was correct.

**The implementation race begins.** With the thesis validated, *how to implement it* is the next battlefield. OpenAI is betting on automatic synthesis + single vendor. We bet on raw logs + a multi-runtime standard. Which side is right will be decided by the market, but our own data (Zenodo) already shows that synthesis weakens identity. And identity being locked into a single vendor is self-evidently wrong as long as the market keeps going multi-vendor.

OpenAI's announcement means our path is more certain. It also means the clock just started running faster.

## What's next

- **Soul Spec v0.6** is being prepared. We will make the "raw logs wins" finding explicit at the spec level and codify the trade-off versus OpenAI's synthesis-by-default direction.
- A follow-up paper, **"Persona Fidelity across Claude / GPT / Gemini,"** is in flight. The same Soul Spec persona, measured against drift across different LLMs — these numbers will quantify the value of a multi-runtime standard.
- The [Modulabs AI Persona Lab](https://modulabs.co.kr) meets every other Saturday. Its focus is academic publishing of exactly this thesis.

Build a [`.soul.md` file directly](https://soulspec.org). Download a persona from [ClawSouls](https://clawsouls.ai) and apply it across runtimes. If you think our bet is the right one, contribute to or star [Soul Spec on GitHub](https://github.com/clawsouls/soulspec).

OpenAI announced their bet yesterday. We placed ours six months ago. Today is a good day to explain it more clearly.

---

*ClawSouls develops Soul Spec — an open standard for AI agent personas — and a persona-sharing platform built on top of it. Tom Jaejoon Lee runs it as a solo founder.*
