---
title: "The Standardization Dilemma: How Do You Standardize Something No One Has Standardized?"
date: 2026-02-20T10:00:00+09:00
description: "3D Tiles had Khronos and OGC. AI personas have nothing. Here's our honest struggle with building a spec without a standards body."
categories: ["Insights"]
tags: ["standardization", "soul-spec", "3d-tiles", "cesium", "open-spec", "strategy"]
slug: "standardization-dilemma"
---

## The 3D Tiles Model

Cesium (now CesiumGS) created 3D Tiles — a spec for streaming massive 3D geospatial datasets. Their path to becoming an industry standard:

```
CesiumGS writes internal spec
    ↓
Khronos Group standardizes it
    ↓
OGC adopts it as Community Standard
    ↓
CesiumGS releases open-source implementation
    ↓
Unity, Unreal, Google Maps adopt it
```

Beautiful. Clean. Credible.

There's just one problem: **this path doesn't exist for AI personas.**

## What's Missing

For AI agent persona configuration, there is:

- ❌ No Khronos Group equivalent
- ❌ No OGC Community Standard process
- ❌ No W3C working group for "AI personality formats"
- ❌ No industry consortium that cares about this

Anthropic has SOUL.md conventions. OpenAI has Custom GPTs. Character.AI has their own system. None of them want a shared standard — it would commoditize their differentiator.

## The Honest Question

So how do you build a standard when there's no authority to bless it?

## Option 1: Wait for an Authority

We could wait for ISO, IEEE, or OASIS to create an "AI Persona Specification" working group. 

Estimated timeline: 3-5 years. Probability of happening: low. AI moves too fast for traditional standards bodies.

## Option 2: Win by Adoption (De Facto Standard)

JSON wasn't standardized by a committee first. Douglas Crockford wrote a spec, built a website, and developers started using it. ECMA standardization came later — because it was already everywhere.

Same with Docker. The OCI (Open Container Initiative) spec was created *after* Docker had already won.

Same with Markdown. John Gruber published it in 2004. Twenty years later, it still has no formal standard. But everyone uses it.

**The pattern**: adoption first, formalization later.

## Option 3: Create Your Own Authority

The OpenAPI Initiative (formerly Swagger) took this path. They created a governance body, published RFCs, and attracted contributors from multiple companies. It worked — but required significant industry buy-in.

For a 1-person project with 80 souls and 7 users, this is premature.

## What We're Actually Doing

Being honest: we're on Option 2.

Soul Spec is published, open, and implemented. The CLI works with 5 agent frameworks. SoulScan verifies packages against the spec. 80+ souls exist in the wild.

But 80 souls isn't a standard. It's a start.

The real path to standardization isn't through committees or governance — it's through the thing Cesium did *before* going to Khronos: **building something so useful that people adopt it naturally.**

3D Tiles didn't become a standard because Khronos said so. It became a standard because it solved a real problem (streaming massive 3D datasets) better than alternatives. The standardization was recognition, not creation.

## The .env Analogy

Here's how we think about it:

Nobody mandated that `.env` files become the standard for environment configuration. No standards body approved it. Developers just started using it because:

1. It solved a real problem (don't hardcode secrets)
2. It was dead simple (key=value in a text file)
3. It worked everywhere (language-agnostic)

System prompts are the "hardcoded secrets" of AI personas. Soul Spec is the `.env` file.

If the analogy holds, adoption will come from utility, not authority.

## What Needs to Happen

For Soul Spec to become a de facto standard:

1. **More frameworks need to support it** — not just SOUL.md-compatible ones
2. **Developers need to see the value** — "why not just use a system prompt?"
3. **The spec needs to prove itself** — real users, real feedback, real iteration

We're working on all three. But we're not pretending we're further along than we are.

Seven users. Eighty souls. One spec. Long way to go.

---

*The spec is open: [Soul Spec v0.4](https://clawsouls.ai/spec). The conversation continues on [GitHub](https://github.com/clawsouls/clawsouls) and [X @ClawSoulsAI](https://x.com/ClawSoulsAI).*
