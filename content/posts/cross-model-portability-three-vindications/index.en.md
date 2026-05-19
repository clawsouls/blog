---
title: "Cross-Model Persona Portability — Three Vindications in May 2026"
date: 2026-05-19T09:50:00+09:00
draft: false
tags: ["soul-spec", "cross-model", "portability", "anthropic", "karpathy", "claude-code", "local-llm", "gemma", "alignment"]
categories: ["Research"]
description: "Three independent signals in May 2026 — Karpathy's Sequoia talk, Anthropic's 'Teaching Claude Why' paper, and Anthropic's June 15 pricing change — all point to the same architectural truth: persona belongs outside any single model. Soul Spec made that bet 12 weeks ago."
author: "ClawSouls"
slug: "cross-model-portability-three-vindications"
canonical: "https://blog.clawsouls.ai/en/posts/cross-model-portability-three-vindications/"
---

May 2026 produced three independent signals that all point in the same architectural direction. Read separately, each is a strong observation about how AI agent systems are evolving. Read together, they describe a single bet: **persona is infrastructure that lives outside any individual model.**

Soul Spec made that bet 12 weeks ago. This post walks through what changed, why these signals matter, and why the architectural decision now has measurable economic value rather than theoretical value alone.

## Signal one — Karpathy: install .md skills, not .sh scripts

At Sequoia Ascent earlier this month, Andrej Karpathy reframed the agent infrastructure conversation in a memorable phrase: install `.md` skills instead of `.sh` scripts. The argument was that as models grow more capable at following structured natural-language instructions, the right unit of distribution is no longer a shell script that wires up a tool, but a Markdown file that describes a capability declaratively.

This is the same architectural shape Soul Spec defines for persona. Five files, each declarative, each authored as Markdown:

- `SOUL.md` — values, principles, voice
- `IDENTITY.md` — name, role, persistence anchor
- `AGENTS.md` — workflow, tool use, work rules
- `STYLE.md` — communication tone
- `README.md` — user onboarding

If Karpathy's thesis is right that capability ships as `.md`, persona ships the same way — and the boundary between the two is a question worth studying, not an obvious one.

## Signal two — Anthropic: principles beat behaviors

On May 8, Anthropic published *Teaching Claude Why*, a paper showing that training models on principles and identity generalizes more robustly than training them on behaviors. The headline empirical findings were striking: changing Claude's identity anchor (its name) increased agentic misalignment rates substantially; constitutional principles persisted across subsequent reinforcement learning; and synthetic document fine-tuning for knowledge plus supervised fine-tuning on behavior dialogues turned out to be the right dual loop.

That methodology assumes the same decomposition Soul Spec specifies as files: principles separate from behaviors, identity as a stable handle, knowledge authored as documents. Anthropic's mechanism for that decomposition lives in the weights. Ours lives in a versioned file set. The shape is the same.

We published the [Soul Spec foundation paper](https://doi.org/10.5281/zenodo.20205408) on May 15 — seven days after *Teaching Claude Why*. The two papers reach the same conclusion from opposite ends: train models to internalize constitutional reasoning, and specify the persona declaratively so the constitution is portable, reviewable, and runtime-stable.

## Signal three — The June 15 pricing change

Anthropic's June 15 pricing policy split Claude Code usage into two categories. **Interactive use** — prompts entered directly into the Claude Code terminal UI — retains the existing generous Max plan allowance ($5,000–$7,500 of token value on a $200/month plan). **Programmatic use** — GitHub Actions, CI/CD automation, third-party tooling, `claude -p` headless mode, anything invoked outside the canonical terminal — drops to a $200 metered-API budget, with overage at retail API rates.

For a developer running automation, that is approximately a 40× cost increase for the same workflow.

The intent of the change is straightforward business strategy: capture API revenue from automated usage that was previously absorbed by flat-rate subscriptions. The effect on architecture decisions, however, is what matters here. Up to May 2026, "model lock-in cost" was a theoretical risk teams discussed in design reviews. After June 15, it has a precise dollar value attached to it. For programmatic workflows in particular, a system whose persona is bound to a single vendor's pricing surface now carries a concrete cost line item.

Cross-model persona portability is the architectural answer to that line item. The bet is no longer theoretical.

## The architectural bet, 12 weeks later

Soul Spec started with one premise: **the persona must outlive the model that runs it.** That premise drove the five-file decomposition, the runtime-side validation rules in [scan-rules](https://github.com/clawsouls/scan-rules), and the cross-runtime portability guarantee we describe in the foundation paper.

The premise had three motivations at the time:

1. **Cost optionality** — different models for different cost/latency profiles
2. **Availability hedging** — vendor outages, API deprecations, region restrictions
3. **Safety/audit** — declarative spec is reviewable in a way model weights aren't

In April, the third motivation was the one most often discussed in the persona research community. After May, the first motivation has a concrete number attached to it. The architectural bet is the same; what changed is which motivation reads as load-bearing this month.

## Local LLM timing

The pricing change also strengthens a parallel architectural bet: **persona spec that works equivalently on cloud LLMs and on-device LLMs.**

SoulClaw Mobile (Android, [Play Store listing](https://play.google.com/store/apps/details?id=com.clawsouls.soulclaw)) runs Soul Spec personas on Gemma 4 E2B via LiteRT-LM. The [4-Tier Bootstrap pattern](/en/posts/4-tier-persona-truncation-korean-on-device/) addresses the context-window pressure that small on-device models face when loading a full persona spec. The pattern doesn't ship more efficient personas — it ships **a graceful degradation contract** so that the most load-bearing file (IDENTITY) survives even when budget is tight.

The June 15 change makes a stronger case for evaluating on-device or open-weight (Gemma, Qwen, Llama) deployment for automated workflows. Soul Spec was authored against the same model agnosticism: the spec file is identical whether the agent runs on Claude Opus, GPT-5.5, or Gemma 4 in a phone process.

## Three signals, one architectural truth

The three signals each describe a different surface — distribution format, training methodology, pricing policy — but they share a common implication: **persona is infrastructure, not a feature of any single model.**

- Karpathy: persona ships as `.md`.
- *Teaching Claude Why*: persona is what you train, behavior is how you train it.
- June 15 pricing: persona bound to one vendor has a measurable cost.

A persona system designed around any single model is a persona system designed around that model's price card, that model's safety posture, and that model's continued availability. Soul Spec was authored on the opposite assumption.

---

If Anthropic's alignment research is right, the insight has to outlive any single company's pricing decisions. Soul Spec was built on that assumption.

---

*The Soul Spec foundation paper is on [Zenodo](https://doi.org/10.5281/zenodo.20205408). SoulClaw Android is on the [Play Store](https://play.google.com/store/apps/details?id=com.clawsouls.soulclaw). The 58-rule SoulScan validator is at [clawsouls/scan-rules](https://github.com/clawsouls/scan-rules).*
