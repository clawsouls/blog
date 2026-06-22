---
title: "Six Months of the Identity Layer: Why Anthropic, Microsoft, and OpenAI All Made the Same Bet"
date: 2026-06-09T08:59:00+09:00
description: "Anthropic's PSM paper (February 2026), Microsoft Build 2026 (June 2), and OpenAI's Dreaming V3 (June 5) — three frontier labs converged on the same hypothesis in six months. They all sit on the same thesis, but they all bet on the lock-in side. Soul Spec is the place where the user's identity, not the vendor's, stays portable."
categories: ["Analysis"]
tags: ["soul-spec", "anthropic", "microsoft", "openai", "agent-identity", "open-standard", "build-2026", "dreaming-v3", "persona"]
author: "ClawSouls"
draft: false
---

## A six-month consensus

In February 2026, Anthropic's Alignment Team published the **Persona Selection Model** paper, framing AI assistants as "a selection among pre-trained characters, where the character's traits are the behavior."

Five months later, on June 2, 2026, Microsoft Build 2026 announced:

> "Windows assigns agents a local ID or a cloud provisioned identity backed by Entra and attributes all activity from the container to that identity."

Three days after that, on June 5, OpenAI rolled out **Dreaming V3** to free-tier users, anchored by three pillars — Persistent Context, Preference Compliance, Temporal Understanding.

All three arrived at the same finding: **the next axis for AI agents is who answers — persistent identity and adaptive memory.**

This is no longer a single paper or a single product launch. In six months, the academic side, the OS side, and the consumer-AI side all bet on the same hypothesis. Calling it an industry consensus is not a stretch.

## Yet all three lock the user inside their own vendor

| Vendor | Identity implementation | Lock-in |
|---|---|---|
| Anthropic (PSM) | A character-selection mechanism inside Claude | Claude account |
| **Microsoft (Build 2026)** | **Entra-backed local ID or cloud identity** | **Windows + Entra** |
| OpenAI (Dreaming V3) | Memory Summary page + automatic synthesis | **ChatGPT account** |
| **Soul Spec** | **5 files (SOUL/IDENTITY/AGENTS/STYLE/HEARTBEAT) + soul.json manifest, vendor-neutral open standard** | **None** |

Microsoft binds identity to Windows. OpenAI binds it to a ChatGPT account. Anthropic binds it inside its own model. All three bet on the same hypothesis, and all three realize that hypothesis only inside their own walls.

This is not coincidence. Each company strengthening its platform lock-in is the natural commercial move. As businesses, it's rational.

But from the user's point of view?

## Where should identity live?

The AI-agent ecosystem is already multi-vendor. One user codes in Claude in the morning, refactors in Cursor, writes in GPT, searches with Gemini, designs in Windsurf, and offloads grunt work to a local agent inside OpenClaw. A single model does not do all the day's work.

In that multi-vendor world, asking the user to leave the "self they told the AI" trapped inside one vendor is 2024 thinking. If the dietary preference you told ChatGPT has to be re-typed into Claude — that is not identity. It is a vendor's lock file.

Microsoft's Entra-backed identity is robust inside Windows. But step outside Windows — to Mac, to a phone, to a Linux server, to another vendor's cloud — and the user has to start identity construction from zero.

OpenAI's Dreaming V3 remembers you precisely inside ChatGPT. But you cannot carry that memory to another model.

**Identity should belong to the user, not to the vendor.**

This is why we shipped [Soul Spec](https://soulspec.org) as an open standard, not as a closed SDK. A Soul Spec persona (five files plus a soul.json manifest) behaves the same way across Claude Code, Cursor, Windsurf, OpenClaw, and Hermes Agent. The user owns the files, not the vendor.

## What it means that Microsoft named OpenClaw

The official Build 2026 materials list OpenClaw among trusted ecosystem technologies.

OpenClaw is the open-source agent framework where we work [as a contributor under the 882soft account](https://github.com/882soft). We maintain [SoulClaw](https://github.com/clawsouls/soulclaw), an OpenClaw fork, as the reference runtime for Soul Spec.

Microsoft naming OpenClaw means the ecosystem we work in every day has received frontier-level official validation.

## SoulClaw Mobile and Microsoft Aion 1.0 — the curious overlap

Another notable Build 2026 item is **Aion 1.0** — a 14-billion-parameter on-device model that lets "applications to reason over user intent, invoke tools, manage files and orchestrate sub-agents."

This is exactly the direction of our [SoulClaw Mobile](https://clawsouls.ai/agent) thesis — a local LLM on a phone becoming the user's agent, with user data never leaving the device. Microsoft does it with Windows + Aion. We do it with mobile + local LLM + Soul Spec persona download.

Same thesis. Different platform. And our side is vendor-neutral.

## What this consensus means

The convergence of three frontier labs tells us two things at once.

**It's validation.** Six months ago, when we started Soul Spec, the framing "AI needs persistent identity" sat almost alone — academically and industrially. That has changed. Anthropic gave it the academic anchor. Microsoft introduced it at the OS layer. OpenAI scaled it to free-tier consumers. The signal that our path is correct is now very strong.

**The race has begun.** With the thesis validated, *how to implement it* is the next battlefield. And all three frontier labs bet on the lock-in side of their own platforms. *No one bet on the path where the user owns their identity and moves freely.* That is our place.

## And in June, another race signal arrived

In the same week we wrote this post, **Thoughtworks Technology Radar Volume 34** (June 2026) landed. Two direct competitors joined the emerging agent-ecosystem category:

- **Snyk Agent Scan** (Trial) — "a security scanner for the agent ecosystem that discovers local components including MCP servers and skills, flagging risks such as prompt injection, tool poisoning, toxic flow, hardcoded secrets, and unsafe credential handling." Snyk (~$7.4B valuation) brought its enterprise-security platform straight into the agent market.

- **Beads** (Assess) — "a Git-based issue tracker designed as a permanent memory layer for coding agents." Built on Dolt (a Git-like SQL DB) and offering multi-agent work graphs with autonomous task assignment. Other early projects grouped together in the category include ticket and tracer.

The Radar's framing nails it: "agent-native project memory and task-tracking tools represent a new category." The category now has multiple players.

The interesting part is where we sit in it. We are not in the same layer as Snyk Agent Scan — Agent Scan operates at the **infra-layer security** plane (MCP servers, skills, credentials, supply chain). Our [SoulScan](https://github.com/clawsouls/soulscan) operates at the **persona-identity-layer safety** plane (Soul Spec persona verification + governance). We attack the same market at a different depth.

Our relationship with Beads is similar. Beads bets on **task-graph, add-only memory** (multi-agent task assignment + blocker relations). Our [Soul Memory](https://docs.clawsouls.ai/docs/platform/soul-memory) bets on **persona-bound memory with temporal decay** (T0 SOUL + T1–T3 + decay). Both are in the "agent-native memory" category, but at the fork between "memory bound to identity" and "memory bound to a task graph," we go in different directions.

**What this tells us**: Snyk and Beads joining this category is another piece of market validation. And they both arrived after us — we started six months earlier, and neither of them moved into the seat we left open: persona-first + open-standard + multi-runtime.

Three frontier labs converging at the thesis level + two enterprise players arriving at the implementation level = two sides of the same signal. *The category is forming, and we got to the exact seat we wanted first.*

## Our next steps

- **Soul Spec v0.6**: make vendor-neutral identity portability explicit at the spec level. Codify the trade-off versus Microsoft / OpenAI / Anthropic's lock-in models.
- **"Persona Fidelity across Claude / GPT / Gemini" follow-up paper**: quantitative data on how the same Soul Spec persona drifts across LLMs. We measure the value of a vendor-neutral standard in a multi-vendor world.
- **Modulabs AI Persona Lab**: meeting every other Saturday with the Korean AI research community to push this thesis academically.

Build a [Soul Spec persona directly](https://soulspec.org). Download a persona from [ClawSouls](https://clawsouls.ai) and apply it across runtimes. And if you think our bet is the right one, [star Soul Spec on GitHub](https://github.com/clawsouls/soulspec).

Anthropic, Microsoft, and OpenAI announced their bets in the past six months. We placed ours six months ago, and all three of them went a different direction from us.

What this means for us is exact: **The thesis is consensus. The implementation is the race. We are the only one not building a lock-in.**

## References

[Thoughtworks Technology Radar Volume 34](https://www.thoughtworks.com/radar)

---

*ClawSouls develops Soul Spec — an open standard for AI agent personas — and a persona-sharing platform built on top of it.*
