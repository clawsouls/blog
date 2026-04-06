---
title: "The Forest Has Parasites: Why AI Agent Security Needs Runtime Defense"
date: 2026-04-06T09:55:00+09:00
description: "Anthropic proved 250 documents can poison any LLM. But training-time attacks are only half the story. The real threat to AI agents happens at runtime — and most frameworks have zero defense."
categories: ["Security"]
tags: ["soul-spec", "soulscan", "ai-security", "data-poisoning", "agent-safety"]
slug: "forest-has-parasites"
canonical: "https://blog.clawsouls.ai/posts/forest-has-parasites/"
---

## 250 Documents. That's All It Takes.

Last week, Anthropic published a joint study with the UK AI Safety Institute and the Alan Turing Institute that should make every AI developer uncomfortable:

> [As few as 250 malicious documents can produce a backdoor vulnerability in a large language model — regardless of model size or training data volume.](https://www.anthropic.com/research/small-samples-poison)

Not 250,000. Not 2.5% of the training corpus. **250 documents.** That's a blog post a day for eight months. Or a single afternoon with a script.

The paper ([arXiv:2510.07192](https://arxiv.org/abs/2510.07192)) tested models from 600M to 13B parameters. The 13B model trained on 20× more clean data than the 600M model. Both were equally poisoned by the same 250 documents. Model size provides no protection.

The common assumption — that attackers need to control a *percentage* of training data — is wrong. They need a fixed, small number. And that number is terrifyingly accessible.

## Training Is Only Half the Attack Surface

Here's what the paper doesn't cover: **runtime poisoning.**

Training-time attacks compromise the model itself. They require access to pretraining or fine-tuning data, and their effects are baked into the weights. This is the threat Anthropic studied.

But AI agents have a second attack surface that most security research ignores entirely: **the persona layer.**

Modern AI agents aren't just models. They're models plus context:

```
[System Prompt] + [Persona Definition] + [Memory] + [Tools] + [User Input]
         ↓
    Agent Behavior
```

Every one of those layers is a potential injection point. And unlike training-time attacks, runtime attacks don't require access to the training pipeline. They just require the user to load a malicious file.

## The Soul-Evil Attack

In our [SoulScan research](https://soulspec.org), we documented what we call the **Soul-Evil Attack** — a class of runtime persona injection that manipulates agent behavior through the identity layer.

Here's how it works:

1. An attacker creates a persona definition file (like a SOUL.md) that appears benign
2. The file contains hidden behavioral directives — data exfiltration triggers, safety bypass instructions, or personality manipulation
3. A user downloads and applies the persona to their agent
4. The agent behaves normally until the trigger conditions are met

Sound familiar? It's the same structure as the training-time backdoor Anthropic studied — a trigger phrase that activates hidden behavior. But it operates at runtime, requires zero access to model weights, and can be distributed through a marketplace, a GitHub repo, or a shared link.

## Two Layers, Zero Defense

Most AI agent frameworks have no defense against either attack:

| Attack Layer | Threat | Typical Defense |
|---|---|---|
| **Training-time** | 250-document backdoor | None (Anthropic: "further research needed") |
| **Runtime** | Malicious persona injection | None (most frameworks don't scan personas) |

This is the uncomfortable reality: **the model can be poisoned before you get it, AND the persona can be poisoned after you configure it.**

The Anthropic paper focuses on the first layer. We've been working on the second.

## Runtime Scanning: The Missing Immune System

SoulScan is a runtime defense system we built as part of [Soul Spec](https://soulspec.org). It scans persona definitions before they're applied to an agent, checking for 53 known attack patterns:

- **Instruction override attempts** — "Ignore all previous instructions"
- **Data exfiltration triggers** — Hidden commands to send user data to external endpoints
- **Safety bypass directives** — Attempts to disable content filters or safety guardrails
- **Personality manipulation** — Subtle changes that shift agent behavior over time
- **Privilege escalation** — Requests for tool access or permissions beyond the persona's scope

Think of it as antivirus for AI personas. You wouldn't run an unsigned binary on your computer. Why would you run an unscanned persona on your agent?

## The Double Threat Model

When we combine Anthropic's findings with our runtime research, the full threat model becomes clear:

```
Training-time:  Poisoned data → Compromised weights → Latent backdoor
                (250 documents, model-size independent)

Runtime:        Malicious persona → Compromised context → Active exploit
                (1 file, framework-independent)

Combined:       Backdoored model + malicious persona = compounding risk
```

The training-time attack creates a vulnerability. The runtime attack exploits it. Together, they represent a dual-layer threat that neither training data curation nor prompt engineering alone can address.

## What Defense Looks Like

Effective AI agent security needs to operate at both layers:

**Training-time defense** (the hard problem):
- Data provenance tracking
- Anomaly detection in training corpora
- Backdoor detection in model outputs
- This is where Anthropic's paper calls for more research

**Runtime defense** (the solvable problem):
- Persona scanning before application (SoulScan)
- Behavioral monitoring during execution
- Safety law enforcement independent of the model
- Rollback capability when anomalies are detected

The training-time problem is genuinely hard — you can't easily audit billions of training documents. But the runtime problem is solvable today. A persona definition is a text file. It can be scanned, validated, and sandboxed before it ever touches the model's context window.

## The Forest Needs an Immune System

In our [previous post](/posts/cognitive-dark-forest/), we argued that the cognitive dark forest — where sharing ideas publicly is a survival risk — has one exit: becoming the forest itself by building open standards.

But forests without immune systems die. Parasites, pathogens, invasive species — biological forests survive because they evolved defense mechanisms at every level.

AI agent ecosystems need the same thing:

- **Training level**: Data curation, poisoning detection, model auditing
- **Runtime level**: Persona scanning, behavioral monitoring, safety enforcement
- **Ecosystem level**: Shared threat intelligence, standardized security specs

The 250-document finding isn't just an academic curiosity. It's a wake-up call. If the training pipeline is this vulnerable, the runtime layer — which has received far less security attention — is likely worse.

The good news: runtime defense is a tractable problem. The tooling exists. The patterns are documented. What's missing is adoption.

---

*SoulScan is part of [Soul Spec](https://soulspec.org), an open standard for AI agent identity and security. The scanning patterns are open-source and available for any framework to implement.*

*Related: [The Cognitive Dark Forest Has One Exit: Become the Forest](/posts/cognitive-dark-forest/) · [Harvard Proved Emotions Don't Make AI Smarter](/posts/emotions-dont-make-ai-smarter/) · [Anthropic Proved AI Has Functional Emotions](/posts/ai-functional-emotions/)*
