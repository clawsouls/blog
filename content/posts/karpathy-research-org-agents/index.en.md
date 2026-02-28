---
title: "Karpathy's AI Research Lab Failed — Here's What It Reveals About Agent Architecture"
date: 2026-02-28T15:00:00+09:00
description: "Andrej Karpathy ran 8 AI agents as a research organization. They couldn't do science. The failure points to something deeper about how we architect multi-agent systems."
categories: ["Analysis"]
tags: ["karpathy", "multi-agent", "research", "soul-spec", "context-engineering"]
draft: false
---

Andrej Karpathy just ran one of the most interesting multi-agent experiments I've seen — and [it failed](https://x.com/karpathy/status/2027521323275325622). Not in a boring way. In a deeply instructive way that tells us exactly where the frontier is between what agents can and can't do.

## The Experiment

Karpathy set up 8 AI agents — 4 Claude, 4 Codex — each with its own GPU, running pretraining experiments on his [nanochat](https://github.com/karpathy/nanochat) codebase. The goal: see if agents can function as an AI research organization, autonomously designing and running ML experiments.

He tried two organizational structures:

1. **8 independent researchers** — each agent working autonomously on its own research direction
2. **1 chief scientist + 8 juniors** — a hierarchical setup where one agent coordinates the others

The infrastructure was elegant. Git branches mapped to research programs. Feature branches represented individual scientists. Git worktrees provided isolation. tmux window grids enabled monitoring. Simple files handled inter-agent communication.

It's exactly the kind of setup you'd want. Clean, modular, well-engineered.

And the result? **It doesn't work.**

## Where It Broke

The agents were perfectly capable of *running* experiments. They could write training scripts, launch jobs, collect metrics, and produce results. The mechanical execution was fine.

The problem was everything *around* execution — the actual science:

- **No strong baselines.** Agents would jump straight into exotic variations without establishing what a reasonable baseline looks like.
- **Nonsensical experiment design.** They'd change multiple variables simultaneously, making results uninterpretable.
- **No proper ablations.** Instead of systematically isolating variables, they'd run sprawling sweeps with no clear hypothesis.
- **No control for compute.** Agents didn't normalize for runtime or FLOPs, so "improvements" were often just "I used more compute."
- **Spurious discoveries.** In the most telling example, an agent proudly reported that increasing hidden size improves validation loss. That's not a discovery — it's a near-tautology that any ML student would recognize.

The agents were excellent *implementers* but terrible *scientists*. They could execute well-scoped tasks but couldn't creatively generate meaningful research directions.

## "You Are Now Programming an Organization"

Here's the line from Karpathy that stuck with me:

> "You are now programming an organization... the source code is the collection of prompts, skills, tools, and processes that make it up."

This is a profound reframing. When you run multiple agents as a team, you're no longer just writing code or prompts. You're defining an organization's operating system — its culture, methodology, expertise, and judgment — entirely through text artifacts.

And like any source code, it can be well-architected or poorly architected. Karpathy's experiment used capable agents with good infrastructure but generic identities. Each agent was essentially "Claude, do research." That's like hiring eight smart generalists with no domain training and expecting them to run a research lab.

## The Missing Layer: Agent Identity

What's interesting about the failure modes Karpathy describes is that they're not failures of *capability*. Claude and Codex are perfectly capable of designing proper ablation studies, establishing baselines, and controlling for compute — if you ask them to. The agents failed because they lacked the *judgment* layer that tells a good researcher what matters.

A well-trained ML researcher doesn't just know how to run experiments. They carry a mental model of what constitutes rigorous science. They know that you always need a baseline. They know that changing one variable at a time is the foundation of experimental design. They know that "bigger model performs better" isn't interesting. This knowledge isn't about intelligence — it's about accumulated experience and internalized methodology.

This is the distinction between a *capable* agent and a *well-defined* agent. Capability is the foundation — what the model can do. Identity is the architecture — what the agent *should* do, how it thinks, what standards it holds itself to.

In our work on [Soul Spec](https://github.com/clawsouls/soul-spec), we've been developing exactly this standardization layer. A Soul document doesn't just give an agent instructions; it defines the agent's expertise, values, methodology, and judgment criteria. It's the difference between telling someone "do research" and giving them a complete professional identity — their training, their standards, their instincts about what good work looks like.

Karpathy's "organization source code" — the collection of prompts, skills, tools, and processes — maps directly to what Soul Spec structures: persona, skills, tools, and operational procedures, all in a standardized format that can be version-controlled, shared, and iterated on.

## What Would "Better Souls" Look Like?

Imagine re-running Karpathy's experiment, but instead of generic agents, each one has a carefully crafted research identity:

- A **senior ML researcher soul** that insists on baselines before any experiment, refuses to change multiple variables simultaneously, and always normalizes for compute.
- A **statistician soul** that reviews experimental designs before execution, flagging confounds and suggesting controls.
- A **research director soul** that evaluates proposed experiments against novelty and significance criteria before approving compute allocation.

Each of these agents would use the same underlying model. The difference is entirely in the identity layer — the accumulated wisdom about *how* to do research well, encoded as structured context.

Would this solve the problem completely? Probably not. But it would address the specific failure modes Karpathy identified. The agents failed not because they couldn't think, but because they didn't know what good research *looks like*. That's exactly what a well-crafted identity provides.

## The Experience Gap

There's a deeper issue, though. Even the best-written persona can only encode *declarative* knowledge — rules and principles. What human researchers also have is *experiential* knowledge: the intuition built from running hundreds of experiments, seeing what works and what doesn't, developing a feel for promising research directions.

This connects to something we've been researching with [experiential memory systems](https://github.com/clawsouls/soul-spec/blob/main/MEMORY.md). When agents can accumulate and retrieve experiences from past work — not just follow instructions, but *learn from their own history* — they develop something closer to genuine expertise. An agent that has run 50 ablation studies and seen the results has different judgment than a fresh agent with the same instructions.

Karpathy's agents started each experiment with a blank slate. No memory of past failures. No accumulated intuition. Every run was a first day on the job. In a research context, that's devastating — so much of good science comes from knowing what *not* to try.

## Where This Leads

Karpathy's experiment is a landmark in multi-agent research, not because it succeeded, but because it mapped the failure modes so precisely. The agents can implement. They can't ideate. They can execute. They can't judge.

The path forward isn't better models (though that helps). It's better agent architecture:

1. **Structured identity** — not just "you are a researcher" but a complete professional persona with methodology, standards, and judgment criteria
2. **Experiential memory** — agents that learn from past experiments, building genuine intuition over time
3. **Organizational design** — the right roles, the right review processes, the right checks and balances, all encoded in the "source code" of the organization

Karpathy called it "programming an organization." We'd add: the quality of that program depends on how well you define each agent's soul.

The tools exist. The models are capable. What's missing is the architecture that turns capable tools into competent professionals. That's the challenge — and the opportunity — ahead.
