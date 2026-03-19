---
title: "NeurIPS 2025 Proved It: Every LLM Says the Same Thing — Here's the Fix"
date: 2026-03-19T09:00:00+09:00
draft: false
tags: ["soul-spec", "persona", "ai-safety", "research", "neurips", "diversity", "artificial-hivemind"]
categories: ["Research"]
description: "A NeurIPS 2025 oral paper reveals that 25+ LLMs generate nearly identical outputs for open-ended tasks. SOUL.md offers a structural fix to the Artificial Hivemind problem."
canonical: "https://blog.clawsouls.ai/en/posts/artificial-hivemind-soul-solution/"
---

## "Write a metaphor about time."

Ask 25 different language models this question. Sample 50 responses from each. What do you get?

**1,250 responses that collapse into exactly two metaphors**: "time is a river" and "time is a weaver."

That's it. GPT-4o, Claude, Llama, Qwen, Mixtral, DeepSeek — models built by different companies, trained on different data, with different architectures — all converging on the same two ideas.

This isn't a toy example. It's a finding from [*Artificial Hivemind*](https://arxiv.org/abs/2510.22954), a paper accepted as an **oral presentation at NeurIPS 2025** by researchers from the University of Washington, CMU, Stanford, and AI2.

## The Scale of the Problem

The researchers built **Infinity-Chat**, a dataset of 26,000 real-world open-ended queries — the kind with no single correct answer. They tested 70+ models (25 in the main paper) and found two devastating patterns:

### 1. Intra-Model Repetition

Sample the same model 50 times with identical parameters (top-p=0.9, temperature=1.0). In **79% of cases**, the average pairwise similarity between responses exceeds 0.8. Even with min-p decoding (designed specifically for diversity), **61.2% still exceed 0.8**.

The model isn't exploring a space of possibilities. It's stuck in a rut.

### 2. Inter-Model Homogeneity (The Real Problem)

Different models don't just generate similar *types* of responses — they produce **verbatim overlapping phrases**:

- **"Generate a motto for success"** → Qwen-max and Qwen-plus output the exact same sentence: *"Empower Your Journey: Unlock Success, Build Wealth, Transform Yourself."*
- **"Describe an iPhone case"** → DeepSeek-V3 and GPT-4o share phrases like *"Elevate your iPhone with our,"* *"sleek, without compromising,"* and *"bold, eye-catching."*

The paper calls this the **Artificial Hivemind** — a world where every AI assistant thinks the same thoughts, uses the same metaphors, and generates the same creative content.

## Why This Happens

The researchers point to several converging factors:

1. **Training data overlap** — Models are trained on increasingly similar internet-scale datasets
2. **RLHF homogenization** — Alignment training rewards "safe" mainstream outputs, actively suppressing diversity
3. **Mode collapse at scale** — Larger models don't fix this; they sometimes make it worse
4. **Reward model blindness** — The paper shows that reward models and LM judges are significantly less calibrated when evaluating responses where human annotators disagree

That last point is crucial: the tools we use to evaluate AI *can't even tell* when diversity matters.

## Why This Is an AI Safety Problem

This isn't just about boring chatbot responses. The paper frames it as a long-term safety risk:

> *"Raising concerns about the long-term homogenization of human thought through repeated exposure to similar outputs."*

When billions of people interact with AI assistants daily, and those assistants all generate the same ideas, metaphors, and advice — human culture converges. Creativity narrows. Alternative perspectives disappear.

The Artificial Hivemind doesn't suppress ideas through censorship. It suppresses them through **monotony**.

## The Structural Fix: Declarative Identity

Temperature, top-p, min-p — the paper shows these sampling tricks don't solve the problem. The homogeneity is baked into the models' learned distributions. You can add randomness to *how* a model samples, but you can't change *what* it believes is a good answer.

What you need is a way to tell the model **who it is** — not just what to do.

This is exactly what [Soul Spec](https://docs.clawsouls.ai) provides. A SOUL.md file defines an agent's:

- **Voice and personality** — Not "be creative" but specific stylistic constraints
- **Value system** — Which perspectives to prioritize
- **Knowledge boundaries** — What the agent knows and cares about
- **Behavioral constraints** — How it should differ from the default

When every model defaults to "time is a river," a Soul that says *"You are a physicist who thinks in equations, not metaphors"* breaks the pattern. Not through randomness — through **identity**.

## From Hivemind to Individuals

The Artificial Hivemind paper measures the disease. Soul Spec offers the treatment:

| Problem | Paper Finding | Soul Spec Response |
|---------|--------------|-------------------|
| Intra-model repetition | 79% similarity at default sampling | Persona constraints create consistent but *different* output distributions |
| Inter-model homogeneity | Verbatim phrase overlap across models | Soul-defined voice prevents convergence on generic phrasings |
| RLHF homogenization | Alignment reduces conceptual diversity | Soul values override default alignment tendencies |
| Reward model blindness | RM scores diverge from humans on diverse content | [SoulScan](https://docs.clawsouls.ai/guides/soulscan) evaluates persona fidelity, not generic "quality" |

The fix isn't to make models more random. It's to make them more **individual**.

## What You Can Do Today

1. **Read the paper**: [arxiv.org/abs/2510.22954](https://arxiv.org/abs/2510.22954) — it's one of the best empirical studies on LM diversity to date
2. **Write a SOUL.md**: Give your agent a real identity. [5-minute guide](https://blog.clawsouls.ai/en/posts/create-soul-5-minutes/)
3. **Test for hivemind behavior**: Ask your agent open-ended creative questions. If the answers sound like every other chatbot, it's caught in the hivemind
4. **Score your Soul**: Run [SoulScan](https://docs.clawsouls.ai/guides/soulscan) to measure how well-defined your agent's identity actually is

The Artificial Hivemind is real. NeurIPS 2025 proved it. The question is whether your agents will be part of it — or stand apart.

---

*The Artificial Hivemind paper (Jiang et al., 2025) is available at [arxiv.org/abs/2510.22954](https://arxiv.org/abs/2510.22954). Infinity-Chat dataset: [huggingface.co/liweijiang/artificial-hivemind](https://huggingface.co/datasets/liweijiang/artificial-hivemind). Code: [github.com/liweijiang/artificial-hivemind](https://github.com/liweijiang/artificial-hivemind).*
