---
title: "Week 1: SoulScan Launch, Soul Spec v0.4, and 80 Souls"
date: 2026-02-20T22:00:00+09:00
description: "Weekly update — SoulScan security scanner goes live, Soul Spec v0.4 released, community growing, and what's next."
categories: ["Weekly Update"]
tags: ["weekly", "soulscan", "soul-spec", "community", "update"]
slug: "week-1-update"
---

## This Week's Highlights

### 🛡️ SoulScan Goes Live

The biggest launch this week: [SoulScan](https://clawsouls.ai/soulscan), our automated security scanner for AI persona packages.

**What it does**: Runs 53 security rules against any soul package — detecting prompt injection, secret leaks, harmful content, and persona inconsistencies.

**Why it matters**: As AI persona packages become more common, the supply chain attack surface grows. SoulScan is the first tool specifically designed to verify AI persona packages before you install them.

Every soul on ClawSouls now shows a security badge:
- 🟢 **Pass** (0-100 score)
- 🟡 **Warning** (issues found but not critical)
- 🔴 **Fail** (security risks detected)

Current scan results across 80 souls: 11 pass, 69 warn, 0 fail.

The scan rules are [open source](https://github.com/clawsouls/scan-rules) — inspect exactly what we check.

### 📋 Soul Spec v0.4 Released

The spec got a significant update:

**New in v0.4**:
- `STYLE.md` — dedicated file for communication style
- `HEARTBEAT.md` — periodic check-in behavior
- `recommendedSkills` replaces deprecated `skills` field
- Deprecated: `modes`, `interpolation` fields

**Why**: Real-world usage showed that style guidelines and heartbeat behavior deserve their own files. Cramming everything into SOUL.md was causing the exact monolith problem the spec was designed to prevent.

All 80 existing souls have been upgraded to v0.4.

### 📊 Community Numbers

| Metric | Count |
|---|---|
| Published souls | 80 |
| Registered users | 7 |
| CLI version | v0.4.2 |
| Supported platforms | 5 |
| SoulScan rules | 53 |
| Total downloads | 1,250+ (game engine plugins) |

### 🔬 Research

Our position paper "Soul-Driven Interaction Design" is published on Zenodo ([DOI: 10.5281/zenodo.18678616](https://doi.org/10.5281/zenodo.18678616)). Planning an empirical follow-up study once we have enough users for meaningful data.

## What We Learned

**Context Engineering is real.** Anthropic published a blog post about "Effective Context Engineering" that validates the core Soul Spec thesis: structured context beats monolithic prompts. [We wrote about the connection.](/posts/context-engineering-and-soul-spec/)

**Runtime engines are fragile.** OpenSouls (⭐294) appears to have shut down — website, docs, and most repos are gone. [Lessons learned.](/posts/what-happened-to-opensouls/)

**Standards need adoption, not committees.** We explored the standardization question deeply this week. [Honest reflections.](/posts/standardization-dilemma/)

## Next Week's Focus

1. **User acquisition** — Reddit, X, developer communities
2. **First external soul registration** — getting someone outside our team to publish
3. **Blog cadence** — daily posts (you're reading the first weekly)
4. **Platform guide SEO** — dedicated pages for each supported framework

## How to Get Involved

- **Browse souls**: [clawsouls.ai](https://clawsouls.ai)
- **Create your own**: `npx clawsouls init`
- **Star the repo**: [github.com/clawsouls](https://github.com/clawsouls/clawsouls)
- **Follow updates**: [X @ClawSoulsAI](https://x.com/ClawSoulsAI)

---

*See you next week. Ship souls, not prompts.*
