---
title: "Every AI Project Becomes an Agent — And Every Agent Needs a Soul"
date: 2026-02-24T19:00:00+09:00
description: "Allen Hutchison observes that every AI project converges on becoming an agent. He's right. But when agents become universal, the real challenge isn't code — it's trust. And designing trust is what Soul Spec is for."
categories: ["Insights"]
tags: ["ai-agents", "soul-spec", "guardrails", "context-engineering", "allen-hutchison"]
slug: "every-ai-project-becomes-agent"
draft: true
---

## The Law of Convergence

Allen Hutchison's essay ["Building AI Agents: From Simple Scripts to Autonomy"](https://allen.hutchison.org/2026/01/15/everything-becomes-an-agent/) opens with an observation that any developer will recognize:

> I sat down to write a simple Python script. Two hours later, I was writing a while loop, defining a tools array, parsing JSON outputs. I was building an agent. Again.

([GeekNews Korean summary](https://news.hada.io/topic?id=25870))

His definition is elegant: **agent = a model running in a loop with access to tools**. Grant a simple script even one tool — just `read_file` — and conversation becomes delegation, and the script becomes an agent.

Over the course of 2025, nearly every project he touched followed this pattern. Gemini Scribe, Gemini CLI, Podcast RAG — different starting points, same destination.

## Death of the Classifier, Birth of the Agent

The most striking case Hutchison shares is "the classifier that wanted to be an agent."

In his Podcast RAG system, he built an AI classifier to analyze user questions and route them to the right search function. It worked, but the cracks showed quickly. What if the user wanted both? What if intent was ambiguous? Developer assumptions encoded in branching logic will always eventually be wrong.

The fix was embarrassingly simple. **Delete the classifier, give the agent two tools.** `search_descriptions` and `search_episodes`. The agent chose based on context. It could use both in parallel. Less code, more capability.

> "If you're writing if/else logic to decide what the AI should do, you might be building a classifier that wants to be an agent."

This is more than a technical observation. **The moment you replace conditional branches with model judgment, code complexity vanishes — but a new kind of complexity emerges.**

## Guardrails: From Code to Trust

Here's where Hutchison lands his real punch:

> The real complexity isn't in the code — it's in **trust and judgment delegation**. Developers need to focus on preventing **judgment errors**, not syntax errors.

When you give an agent shell access, your worry isn't a typo — it's `rm -rf`. The shift from Human-in-the-Loop (approve every step) to Human-on-the-Loop (set goals and boundaries, let the system drive). Humans become supervisors, not operators.

This transition has a prerequisite: **the boundaries an agent must respect need to be clearly defined.** Autonomy without guardrails isn't autonomy — it's neglect.

Hutchison explores this deeply in his [Agentic Shift series](https://allen.hutchison.org/the-agentic-shift/), covering policy engines, observability, and the concrete design of agent governance.

## The Persona Problem of the Agent Era

Let's take one more step.

If agents become universal — if every AI project converges on becoming an agent — the next question is natural: **when thousands of agents act on their own judgment, how do you ensure consistency?**

Hutchison's Policy Engine controls *what an agent can do*. But *how it should do it* — tone, judgment criteria, priorities, relationship with the user — is harder to define through policies alone. This isn't a capability problem. It's an **identity problem**.

OpenClaw's `SOUL.md`, Claude Code's `CLAUDE.md`, Cursor's `.cursorrules` — agent frameworks already solve this through "persona files." Declarative files that give agents identity, values, and behavioral rules.

[Soul Spec](https://soulspec.org) proposes a **shared grammar** for these files. When persona, behavior, and boundary are defined in a structured format:

- Agent behavior becomes **predictable** (declarative guardrail definition)
- Personas become **portable** (consistency across frameworks)
- Judgment criteria become **verifiable** (content-level validation via tools like SoulScan)

The "judgment error prevention by design" that Hutchison calls for — this is exactly it. When code-level permission policies combine with declarative behavioral specs, agents finally become trustworthy colleagues.

## Agents Are Already Here

The most resonant part of Hutchison's observation:

> The moment you want to add a tool definition to your simple script, you've already entered the agent-building stage.

Agents aren't a distant future technology. Every AI system with tool access is already an agent, or becoming one. The question isn't whether you *can* build agents — it's whether you can *govern* them.

Code complexity has decreased. But trust complexity is just getting started. How do you set guardrails, define personas, and verify judgment criteria?

We believe part of the answer lies in standardizing behavioral specifications. If Hutchison's Policy Engine defines what agents *can* do, Soul Spec defines what they *should* do. You need both.

---

*Read Allen Hutchison's original essay [here](https://allen.hutchison.org/2026/01/15/everything-becomes-an-agent/), and the GeekNews Korean summary [here](https://news.hada.io/topic?id=25870).*
