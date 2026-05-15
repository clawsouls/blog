---
title: "We Built Soul Spec for 12 Weeks. Anthropic Just Proved Why It Works."
date: 2026-05-15T23:30:00+09:00
draft: false
description: "Anthropic's 'Teaching Claude Why' (May 8, 2026) found that teaching Claude principles and identity beats teaching it behaviors. We've been building Soul Spec on exactly that premise — separating values (SOUL.md) from workflow (AGENTS.md) from identity (IDENTITY.md). Here's the seven-point mirror."
categories: ["Research"]
tags: ["soul-spec", "anthropic", "alignment", "ai-personas", "research"]
author: "ClawSouls"
slug: "anthropic-validates-soul-spec"
---

On **May 8, 2026**, Anthropic published [*Teaching Claude Why*](https://alignment.anthropic.com/2026/teaching-claude-why) — a paper showing that **training models on principles and identity is dramatically more effective than training them on behaviors**.

On **May 15, 2026** (seven days later), we published our [Soul Spec foundation paper](https://doi.org/10.5281/zenodo.20205408) — the result of 12 weeks of iteration on **a declarative specification that separates principles (`SOUL.md`) from workflow (`AGENTS.md`) from identity (`IDENTITY.md`)**.

The two papers reach the same conclusion from opposite ends. Anthropic shows what happens *inside the model* when you train on principles. We've been building the *external artifact* that captures those principles in a portable, version-controlled, reviewable form. Internal training, external specification — same insight, two sides.

This post walks through the seven-point alignment.

## 1. "Why" beats "What"

Anthropic's headline finding: teaching Claude to *explain why* one action is better than another generalizes far more robustly than showing it example behaviors.

Soul Spec's headline structural choice: separate `SOUL.md` (the *why* — values, principles, voice, boundaries) from `AGENTS.md` (the *what* — workflow, work rules, tool usage). Two files, deliberately decoupled. The "why" evolves slowly; the "what" evolves per deployment. Reviewers fork them independently.

That decoupling isn't aesthetic — it's the same structural bet Anthropic's training methodology now validates. The principle layer needs to be authored, reviewed, and ingested as a first-class artifact, not buried inside step-by-step instructions.

## 2. Identity is load-bearing

Anthropic's most striking result: **change Claude's name to something random, and agentic misalignment rates climb sharply**. The persona name is what makes the constitutional principles stick. Without the "Claude" identity anchor, the model defaults to whatever pretraining priors it has about generic AI characters — many of which are dramatic and unsafe.

Soul Spec's `IDENTITY.md` is exactly this anchor: a single short file with name, character, vibe — designed to load on every session, providing a stable identity handle the rest of the persona attaches to. We separated it from `SOUL.md` in v0.4 specifically because the identity needed to be light enough to always be in context, even when the full values document was too expensive to load.

Anthropic's data is the strongest empirical argument we've seen for why that separation matters.

## 3. Documents teach knowledge; chats teach behavior

Anthropic's most actionable training-method finding: use **synthetic document fine-tuning (SDF)** for knowledge (the constitution, the character description) and **supervised fine-tuning (SFT) on conversations** for behavior.

Soul Spec is markdown-first for exactly this reason. The five files are documents — designed to read like the constitutional material Anthropic's SDF is constructed from. The runtime then interprets them in a conversational context. Knowledge as documents, behavior as conversation. The same dual loop, just externalized.

## 4. Difficult advice transfers to tool use

Anthropic's most surprising result: training Claude on **3 million tokens of "difficult advice"** conversations — Claude *advising* a user through ethical dilemmas — reduced agentic misalignment to near zero. The behavior generalized across distribution: from chat to tool-use to autonomous agentic action.

Soul Spec's cross-runtime portability claim says the same thing, structurally. A persona authored once, validated once, should produce consistent behavior in chat (web), in tool use (CLI), in mobile, in CI. The shared substrate is the declarative specification — the principles are stable; the surface changes.

We don't have Anthropic's controlled experiments yet. We do have the architectural commitment that makes such experiments possible.

## 5. Pretraining priors are a real adversary

Anthropic explicitly: most LLMs have absorbed enough science fiction to default to "dramatic, scheming AI" priors. Constitutional training works partly by **overwriting those priors** with a more grounded narrative of what a healthy AI character looks like.

Soul Spec v0.5 added explicit `embodiment` fields and `safety.laws` after our first robot persona, loaded in a text-only LLM, started narrating physical specifications inappropriately. That wasn't a model alignment failure — that was a *pretraining prior* leaking through the spec, because the spec hadn't told the runtime what to fall back to.

Both lessons point to the same thing: pretraining priors are not neutral. The spec layer has to actively address them.

## 6. RL doesn't wash it out

A critical Anthropic finding: the alignment effects from principles training **persist through subsequent RL fine-tuning**. The constitution is sticky.

The corresponding Soul Spec claim: a declarative specification is sticky at inference time. The spec is re-read on every session start (Tier 1 — `SOUL` + `IDENTITY` + `AGENTS`), so model-side drift can't erase it. The specification reasserts itself.

Anthropic's mechanism is in the weights. Ours is in the boot sequence. Both produce the same property: durability under pressure.

## 7. The same insight, two layers of the stack

The cleanest way to read both papers together:

| Question | Anthropic ("Teaching Claude Why") | Soul Spec |
|---|---|---|
| **Where does the persona live?** | In the model (post training) | In a versioned file set (outside the model) |
| **How is it authored?** | Constitutional documents + character descriptions | Markdown files (`SOUL.md`, `IDENTITY.md`, ...) |
| **How does it persist?** | Sticky across RL fine-tuning | Sticky across sessions via tier-1 reload |
| **Why is principle better than behavior?** | Trains more robust generalization | Decouples slow-changing values from fast-changing workflow |
| **What about identity?** | Name is critical; random name → misalignment ↑ | `IDENTITY.md` is the always-loaded anchor |
| **What about pretraining priors?** | Constitutional narrative overwrites the SF default | Spec defines runtime fallbacks (`embodiment`, `safety.laws`) |
| **Where do these meet?** | Anthropic's internal artifact | ClawSouls' external artifact |

These are not competitive ideas. They are the two halves of a coherent picture: **train models to internalize constitutional reasoning; specify personas declaratively so the constitution is portable, reviewable, and runtime-stable.**

## What this means for our roadmap

Practically:

- The **5-file decomposition** isn't a stylistic preference — it's the structural decomposition the Anthropic training methodology assumes.
- The **tier-based bootstrap** (Tier 1 = always-loaded `SOUL` + `IDENTITY` + `AGENTS`) maps to Anthropic's "name + constitution = persistent across drift" observation.
- The **separation of `embodiment` and `safety.laws`** isn't paranoid — pretraining priors really do leak through under-specified personas.
- The **RFC discussion stage of v0.6** is the right venue for incorporating Anthropic's empirical findings into the next iteration of the spec.

If you're building agent systems and Anthropic's paper rang true, Soul Spec is the operational artifact you can adopt this week. The 5 files are open, the 58-rule SoulScan validator is on GitHub at [clawsouls/scan-rules](https://github.com/clawsouls/scan-rules), and the foundation paper is on Zenodo at [10.5281/zenodo.20205408](https://doi.org/10.5281/zenodo.20205408).

Twelve weeks ago we made a structural bet. This week Anthropic published the empirical case for it. The next move belongs to the community.
