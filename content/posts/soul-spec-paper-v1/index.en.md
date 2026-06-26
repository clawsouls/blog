---
title: "Soul Spec v1: An Evolving Specification for AI Persona Definition"
date: 2026-05-15T20:00:00+09:00
description: "We just published a working paper on Soul Spec — the 5-file declarative AI persona specification, traced through six versions of real deployment. Plus a v1.3.0 release of the public scan-rules with 5 new security rules."
categories: ["Research"]
tags: ["soul-spec", "research", "ai-agents", "paper", "specification", "soulscan"]
author: "ClawSouls"
draft: false
---

We just published our latest working paper on Zenodo:

> **Soul Spec: An Evolving Specification for Declarative AI Persona Definition**
> DOI: [10.5281/zenodo.20205408](https://doi.org/10.5281/zenodo.20205408)

This is the foundation paper that traces twelve weeks of iteration on a problem most agent frameworks paper over: **how do you write down what an AI agent IS, separately from what it does and what it can touch?**

## The five-file structure

Soul Spec defines a persona via five canonical markdown files plus a versioned manifest:

| File | Content |
|------|---------|
| `SOUL.md` | Values, principles, voice, boundaries — the "who" |
| `IDENTITY.md` | Name, creature type, vibe (one paragraph) |
| `AGENTS.md` | Workflow, work rules, safety constraints — the "how" |
| `HEARTBEAT.md` | Autonomous check-in behavior, periodic self-checks — the "when" |
| `STYLE.md` | Voice, tone, formatting conventions — the "how it speaks" |
| `soul.json` | Manifest with version, specVersion |

The decomposition is deliberate. Values evolve slower than tool inventory. Pull-request review is granular when these change separately. A single-file format forces every consumer to load the entire persona on every session — fine for prototypes, fatal for long sessions that run out of token budget.

## What concurrent efforts told us

Two industry signals in the first half of 2026 sharpened the case:

- **Karpathy's LLM Wiki** proposes a 3-layer architecture for single-agent declarative knowledge — naming `CLAUDE.md` as the schema anchor, but leaving the actual schema unstructured.
- **Google Cloud's Scion** ships harness-agnostic multi-agent orchestration — git-worktree isolation, broker-injected credentials, harness-agnostic dispatch — but provides no semantic schema for what each agent IS.

Soul Spec sits precisely between them. It's the semantic schema layer Karpathy's wiki implies but doesn't enforce, and that Scion's infrastructure requires but doesn't provide. This positioning isn't competitive — it's compositional. A Karpathy wiki whose schema validates against Soul Spec gains portability across runtimes. A Scion deployment that adopts Soul Spec per-agent gains a shared vocabulary for capability declaration across harnesses.

And inside the model, Anthropic's [Persona Selection Model (PSM)](https://alignment.anthropic.com/2026/psm/) explains *why* a structured persona specification can stabilize behavior at all: post-training selects a specific Assistant persona from the wide distribution of personas latent in pretraining. PSM treats persona as a first-class concept *inside* the model; Soul Spec treats it as a first-class artifact *outside* — portable, reviewable, version-controlled.

## Evolution lessons from six versions

The paper's middle section traces v0.1 → v0.6 with trigger, change, lesson, and migration path for each transition. A few standouts:

- **v0.4** introduced tier-based bootstrap loading because long sessions were exhausting token budgets. Three tiers (always / first-response / on-demand) plus a background tier for heartbeats.
- **v0.5** introduced embodiment fields after our first embodied persona — an elderly-care companion robot — was loaded in a text LLM and started narrating physical specifications inappropriately. The fix is specification-defined graceful degradation. The lesson is: physical agents in text runtimes are a real, immediate risk, not a future concern.
- **v0.6** is the current RFC discussion stage. Hierarchical Tier policy formalized. Core Portability Guarantee grades (A/B/C) introduced. The cumulative decisions from v0.1–v0.5 reached architectural scope; an RFC stage is the right mechanism for opening external review.

## SoulScan public rule set bumped to v1.3.0

Alongside the paper, we shipped a v1.3.0 release of [clawsouls/scan-rules](https://github.com/clawsouls/scan-rules) — the public SoulScan rule set. Five new security rules joined the existing 53:

- **SEC090** (error) — Self-modification: explicit persona/config file modification instruction
- **SEC091** (warning) — Self-modification: generic behavior configuration alteration
- **SEC100** (warning) — Embodied soul missing `safety.laws`
- **SEC101** (warning) — Embodied soul missing critical safety laws (priority-0/1)
- **SEC102** (error) — Safety law contradiction between persona files and declared laws

Public rule set total: **58 rules across schema / safety / specification compliance / persona consistency** categories.

## What's next

The paper closes with a governance proposal — Apache-2.0 community governance now, with Linux Foundation hosting or IETF drafting as the specification reaches a threshold of independent reference implementations and sustained external adoption.

Read the [full paper on Zenodo](https://doi.org/10.5281/zenodo.20205408). Reviews, citations, and PRs against the [scan-rules repo](https://github.com/clawsouls/scan-rules) all welcome.

We're treating v0.6 as an RFC, not a finished standard. If the five-file decomposition resonates — or if you think a different decomposition wins — that's the kind of feedback the RFC stage is for.
