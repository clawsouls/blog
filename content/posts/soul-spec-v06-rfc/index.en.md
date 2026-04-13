---
title: "Soul Spec v0.6: One Markdown File Is All You Need"
date: 2026-04-13T10:00:00+09:00
description: "We're redesigning Soul Spec so that a single SOUL.md file is enough to define an AI agent persona. Here's where we're headed — and we want your feedback."
categories: ["Announcement"]
tags: ["soul-spec", "v0.6", "rfc", "ai-agents", "open-standard"]
author: "ClawSouls"
draft: false
---

When we released Soul Spec v0.3 two months ago, creating a persona required a `soul.json` with over ten mandatory fields, plus a `SOUL.md`, plus knowing the difference between `specVersion` and `version`. It worked, but we kept hearing the same thing: *"I just want to give my agent a personality. Why do I need all this?"*

Fair point.

## How We Got Here

Soul Spec has evolved through four versions, each driven by what people actually needed:

**v0.3** laid the foundation — what *is* a persona package? We defined `soul.json`, introduced `SOUL.md` as the personality file, and made souls publishable to a registry.

**v0.4** asked the harder question: what if people use different frameworks? We added multi-framework compatibility, SoulScan validation, and progressive disclosure so platforms could show as much or as little as needed.

**v0.5** went physical. Robots and embodied agents got first-class support — sensors, actuators, and Asimov-inspired safety laws. If your agent has a body, its soul should know about it.

Three versions, three clear trends:

1. **The barrier to entry keeps dropping.** Every version has made it easier to get started.
2. **Safety keeps getting stronger.** SoulScan, safety laws, static analysis — each version adds another layer.
3. **The scope expands naturally.** Chatbots to multi-framework to robots to ecosystem tooling.

## What v0.6 Changes

The headline: **SOUL.md is the only required file.**

Drop a markdown file into a directory. That's a soul. Platforms can auto-generate `soul.json` from your SOUL.md's title and first paragraph. No boilerplate, no schema to memorize, no friction.

For creators who want more, we're introducing a three-tier system:

| Tier | Files | Required? |
|------|-------|-----------|
| **Tier 1** (Core) | `soul.json`, `SOUL.md` | `soul.json` auto-generated |
| **Tier 2** (Standard) | `IDENTITY.md`, `AGENTS.md`, `STYLE.md`, `HEARTBEAT.md`, `README.md` | Optional |
| **Tier 3** (Extensions) | `RULES.md`, `TOOLS.md`, `USER.md`, custom files | Optional |

Tier 3 is new — you can include **any** `.md`, `.yaml`, or `.json` file in your soul pack. Tool boundaries, user calibration profiles, behavioral rules, platform-specific exports. Your soul, your structure.

## The Portability Question

Here's the honest tension: Soul Spec promises "one source, any agent." But if AGENTS.md defines tool workflows that only work on OpenClaw, and HEARTBEAT.md defines autonomous behaviors that most frameworks can't execute — is "any agent" a lie?

We don't think so, but it requires clear expectations.

Our answer is a **Core Portability Guarantee**:

- **Grade A** (works everywhere): `SOUL.md`, `IDENTITY.md`, `STYLE.md` — these convert to system prompts on any framework. Zero loss.
- **Grade B** (works mostly): `AGENTS.md`, `README.md` — some framework-specific features may not translate.
- **Grade C** (framework-specific): `HEARTBEAT.md`, `TOOLS.md`, Tier 3 files — bonus features where supported.

Think of it like HTML. Every browser renders the basics. Some support cutting-edge CSS. The standard works because the core is universal and the rest degrades gracefully.

The CLI will support `clawsouls export --target cursor|claude|openai` — merging your Core files into the target format, with warnings for anything that won't carry over.

## What We're Asking

We've opened a [GitHub Discussion](https://github.com/orgs/clawsouls/discussions/2) for v0.6 feedback. Specific questions:

1. **Minimal soul**: Is SOUL.md-only the right minimum? Or should `soul.json` stay required?
2. **Tier placement**: Should `RULES.md` be Tier 2 instead of Tier 3?
3. **Shell scripts**: We're considering allowing `.sh` files with mandatory SoulScan static analysis. Too risky?
4. **Size limits**: 100KB per extra file, 1MB total. Reasonable?
5. **Auto-generated soul.json**: What fields should platforms extract from SOUL.md?
6. **Naming conventions**: Should we standardize names like `TOOLS.md` and `RULES.md`?

If you're building with Soul Spec, thinking about AI agent standards, or just have opinions — we want to hear them.

**[Join the discussion on GitHub](https://github.com/orgs/clawsouls/discussions/2)**

---

*Soul Spec is an open standard for AI agent personas. [Read the docs](https://docs.clawsouls.ai) or [browse published souls](https://clawsouls.ai).*
