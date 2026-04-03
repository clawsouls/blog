---
title: "The Model Isn't the Bottleneck — Your Prompt Structure Is"
date: 2026-02-23T10:00:00+09:00
draft: false
description: "Chris Laub built the same app with 5 LLMs × 5 prompt styles. The results show prompt structure matters as much as model choice — and sometimes more."
categories: ["Research"]
tags: ["Context Engineering", "Soul Spec", "LLM", "Prompting"]
slug: "prompt-structure-bottleneck"
---

## The Experiment

Chris Laub ([@ChrisLaubAI](https://x.com/ChrisLaubAI)) ran an experiment that should change how you think about model selection. He built the same application five times — once with each major LLM — and tested five different prompt formatting styles across all of them.

The top scores by model (best prompt style for each):

| Model | Best Score | Best Format |
|---|---|---|
| Claude | 87 | XML |
| GPT-4 | 71 | Markdown |
| Grok | 68 | — |
| Gemini | 64 | — |
| DeepSeek | 52 | — |

Claude with XML prompts dominated. But here's the more interesting finding: **Claude scored 89 with Markdown prompts too**. The model was strong regardless of format — but every other model showed dramatic swings depending on prompt structure.

## The Real Takeaway: Structure > Model

The gap between Claude's best and DeepSeek's best is 35 points. That's a model gap, and it's real. But look at it from a different angle: for several models, the gap between their *best* and *worst* prompt style was comparable. Changing how you structure your prompt can matter as much as changing which model you use.

This isn't surprising if you've been following context engineering research. But it's rare to see it demonstrated this cleanly in a single controlled experiment.

## Academic Backup: PersonaGym

Laub's experiment aligns with findings from [PersonaGym](https://arxiv.org/abs/2407.18416) (EMNLP Findings 2025), a framework that evaluated 10 LLMs across 200 personas and 10,000 questions. Their headline result: **GPT-4 and LLaMA-3-8b scored identically on persona adherence**.

A model with 20× more parameters couldn't outperform a smaller one at following persona instructions. The researchers concluded that architectural improvements alone don't solve persona consistency — the specification quality matters.

Two independent studies, same conclusion: the model isn't the only bottleneck. The structure of what you feed it is.

## What This Means for Agent Development

If prompt structure determines output quality this much, then for AI agents — which run on persistent system prompts — the stakes are even higher. An agent's system prompt isn't a one-off query. It's a living document that shapes every interaction.

This is where structured context specifications come in.

### AGENTS.md: Structure for Code

The open-source community has already started converging on `AGENTS.md` files — structured documents that tell coding agents about project conventions, build commands, and code style. A [study of 466 open-source projects](https://arxiv.org/abs/2510.21413) (MSR 2026) found that these files significantly improve agent performance, but noted there's no standardized format yet.

### Soul Spec: Structure for Persona

Soul Spec applies the same principle to agent identity and behavior. Instead of a monolithic system prompt, it breaks persona definition into focused, structured files:

- **`SOUL.md`** — personality, communication style, behavioral boundaries
- **`IDENTITY.md`** — factual identity: name, role, relationships
- **`AGENTS.md`** — workflow rules and tool usage patterns
- **`MEMORY.md`** — persistent knowledge that survives context resets

The logic is the same as Laub's experiment: **structured context outperforms unstructured context**. Whether you're structuring code instructions or persona specifications, the format matters.

## The Evolving Playbook

The [ACE framework](https://arxiv.org/abs/2510.04618) (Stanford & SambaNova) takes this further, treating system prompts as "evolving playbooks" that improve over time. Their results: +10.6% performance improvement from structured, iteratively refined context — without changing the underlying model.

This maps directly to the Soul Spec pattern: `SOUL.md` defines the stable persona, while frameworks like OpenClaw use `MEMORY.md` to accumulate learned context. The playbook evolves, the identity stays consistent.

## Stop Chasing Models, Start Structuring Context

The industry spends enormous energy debating which model is "best." Laub's data suggests a different priority: **invest in how you structure your context**.

For individual prompts, this means choosing the right format (XML, Markdown, structured sections). For agents, it means investing in specification quality — the documents that define who your agent is and how it behaves.

Soul Spec is one way to standardize that investment. It's an open specification, not a proprietary format. The goal is simple: make structured persona context as normal as structured code context already is.

Because as the data shows, the model isn't always the bottleneck. Sometimes it's what you're feeding it.

---

*Sources: [Chris Laub's experiment](https://x.com/ChrisLaubAI), [PersonaGym (arXiv 2407.18416)](https://arxiv.org/abs/2407.18416), [ACE Framework (arXiv 2510.04618)](https://arxiv.org/abs/2510.04618), [AGENTS.md Study (arXiv 2510.21413)](https://arxiv.org/abs/2510.21413)*
