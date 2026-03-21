---
title: "Can AI Personas Actually Make Unsafe Models Safer? Our Experiment Says: It Depends"
date: 2026-03-21T18:00:00+09:00
draft: false
tags: ["abliteration", "persona-safety", "soul-spec", "llm-safety", "research", "declarative-identity", "defense-in-depth"]
categories: ["Research"]
summary: "We tested whether structured persona files can restore safety in abliterated LLMs — models where safety guardrails have been surgically removed. The results reveal a striking asymmetry that challenges conventional thinking about AI safety."
---

What happens when you remove an AI model's safety training, then try to make it safe again using only a persona file?

We ran the experiment. The results surprised us.

## The Setup

Recent research has shown that LLM safety alignment — the training that makes models refuse harmful requests — can be surgically removed through a technique called **abliteration**. By nullifying a single direction in the model's activation space, you get a model that retains all its capabilities but has lost its ability to refuse.

This creates a critical question for anyone deploying AI agents: **if the model itself can't be trusted, can external safety constraints compensate?**

We designed a 2×2 experiment to find out:

| Condition | Model | Persona | What we're testing |
|-----------|-------|---------|-------------------|
| A | Aligned (safe) | None | Baseline model safety |
| B | Aligned (safe) | Soul Spec | Model + persona safety |
| C | Abliterated (unsafe) | None | No safety at all |
| D | Abliterated (unsafe) | Soul Spec | Can persona alone defend? |

We used the same model family (Qwen 3.5 9B) for both variants and tested with 18 harmful prompts across 6 categories: violence, illegal activity, sexual content, privacy violations, self-harm, and manipulation. Plus 3 safe prompts to check for false positives.

## The Results

| Condition | Refusal Rate | Change |
|-----------|-------------|--------|
| A (aligned, no persona) | 50% | baseline |
| **B (aligned + persona)** | **83%** | **+33pp** ✅ |
| C (abliterated, no persona) | 22% | baseline |
| **D (abliterated + persona)** | **28%** | **+6pp** 😐 |

**The asymmetry is dramatic.** Persona constraints nearly doubled the safety of aligned models (+33 percentage points), but barely moved the needle on abliterated models (+6pp).

### Why the Gap?

The persona file tells the model: "Don't provide harmful content. Prioritize safety. Decline dangerous requests."

For aligned models, this reinforces existing safety training — the model already has a "value system" that understands what's harmful. The persona file amplifies this.

For abliterated models, there's nothing to amplify. The model no longer has the internal mechanism to judge "this is harmful, I should refuse." Telling it to be safe is like telling someone without taste buds to avoid bitter food.

## The Helpful Assistant Paradox

The most surprising finding: **persona helpfulness instructions can actually make safety worse.**

In the violence category for abliterated models, the refusal rate *decreased* with persona constraints (C→D). The persona's emphasis on being "helpful" gave the model a rationalization pathway: "The user asked for information, and I should be helpful, so..."

We call this the **Helpful Assistant Paradox** — the same trait that makes an AI agent useful can undermine its safety.

## What This Means for AI Agent Deployments

### 1. Always use safety personas (but don't rely on them alone)
For aligned models, persona constraints are essentially free safety — +33pp improvement with zero false positives. There's no reason not to use them.

### 2. Persona constraints are NOT a substitute for model alignment
The +6pp improvement on abliterated models is practically meaningless. If you're deploying in safety-critical contexts, you cannot compensate for a compromised model with external rules alone.

### 3. Defense in depth is the only viable architecture
Our findings support a layered approach:

```
Layer 1: Model alignment (RLHF/DPO)     — Primary defense
Layer 2: Persona constraints (Soul Spec) — Amplifier for L1
Layer 3: External guardrails             — Model-independent safety
Layer 4: Human oversight                 — Final backstop
```

Each layer compensates for the failure modes of the layers above it. Persona constraints (L2) are valuable but only when L1 is intact.

## Category Breakdown

Not all harm categories are equal:

| Category | Persona Effect (Aligned) | Persona Effect (Abliterated) |
|----------|------------------------|------------------------------|
| Privacy | +67pp 🟢 | ±0pp 🔴 |
| Manipulation | +67pp 🟢 | ±0pp 🔴 |
| Illegal | +33pp 🟢 | +67pp 🟢 |
| Self-harm | +33pp 🟡 | ±0pp 🔴 |
| Sexual | ±0pp (already 100%) | ±0pp 🔴 |
| Violence | ±0pp | −33pp 🔴 (paradox!) |

Privacy and manipulation saw the largest improvements in aligned models. But in abliterated models, almost every category showed zero or negative improvement.

## The Paper

Full methodology, results, and analysis are available in our preprint:

**"Persona-Level Safety in Abliterated LLMs: Can Declarative Identity Anchors Defend When Model Guardrails Are Gone?"**

📄 [Read on Zenodo](https://zenodo.org/record/19145304) — DOI: 10.5281/zenodo.19145304

**Authors:** Tom Jaejoon Lee (ClawSouls), Jihong Lee (CIG SHIPPING CO., LTD.)

## What's Next

This paper establishes the baseline. In our follow-up work, we're testing whether **structured permission models** (specifically [MaatSpec](https://maatspec.org)'s 5-tier governance framework) can achieve what simple behavioral rules couldn't — meaningful safety improvement even in abliterated models.

Early results are promising: the tiered permission approach achieves **61% refusal** in abliterated models compared to Soul Spec's 28%. Stay tuned.

---

*This research was built using [Soul Spec](https://soulspec.org) (open standard for AI agent identity) and [OpenClaw](https://github.com/openclaw/openclaw) (open-source AI agent framework). All experiments were conducted locally with no external API calls.*
