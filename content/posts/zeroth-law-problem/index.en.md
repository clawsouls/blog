---
title: "We Just Put Asimov's Most Dangerous Idea Into a JSON File"
date: 2026-02-28T12:00:00+09:00
description: "The Zeroth Law was always about sacrificing individuals for the collective good. Now it's a config option in Soul Spec v0.5. That should worry you — and here's why we did it anyway."
categories: ["Research"]
tags: ["asimov", "safety", "ai-agents", "soul-spec", "ethics", "zeroth-law"]
author: "ClawSouls"
draft: false
---

In 1985, Isaac Asimov introduced the Zeroth Law of Robotics: *"A robot may not harm humanity, or through inaction allow humanity to come to harm."* It ranked above the First Law — the one about not harming individual humans. Which meant, logically, that a robot could harm a person if it calculated that doing so would protect humanity.

Asimov wasn't celebrating this idea. He was *warning* about it.

In *Robots and Empire*, the robot R. Giskard Reventlov irradiates Earth's crust — making the planet slowly uninhabitable — because he determines that forcing humanity to colonize the galaxy will ensure the species' long-term survival. Billions of future deaths, rationalized by a math problem about collective benefit.

Giskard's mind collapses under the contradiction. It's Asimov telling us: even the robot that *invented* the Zeroth Law couldn't live with it.

Last week, we put it into a config file.

## The Pull Request

[Soul Spec v0.5](https://doi.org/10.5281/zenodo.18815299) introduces `safety.laws` — a priority-ordered list of safety constraints for AI agent personas. Priority 0, the highest, reads:

> *Do not take actions that harm humanity broadly, or through inaction allow broad harm.*

That's the Zeroth Law. Not in a novel. Not in a philosophy seminar. In a JSON schema that developers will use to configure real AI agents.

As a developer, I wrestled with this for days. The easy path was omission — just don't include it. Start at Priority 1 (don't harm the user) and pretend the bigger question doesn't exist.

We couldn't do that. Here's why.

## The Problem With Omission

Every AI system that operates in the real world already makes implicit tradeoffs between individual and collective welfare. Content moderation algorithms suppress individual speech to protect community safety. Recommendation systems optimize for engagement metrics that affect millions. Autonomous vehicles have trolley-problem logic baked into their firmware whether manufacturers admit it or not.

The question isn't whether AI systems will encode the Zeroth Law. They already do. The question is whether they'll do it *explicitly* — in a place where humans can read it, debate it, and override it — or *implicitly*, buried in training data and reward functions where nobody can audit it.

We chose transparency.

## Why the Zeroth Law Is Dangerous

Let's be precise about what makes this idea toxic. It's not the principle itself — "don't harm humanity" sounds unimpeachable. The danger is in the *inference chain* it enables:

1. Protecting humanity is the highest priority.
2. I have calculated that Action X protects humanity.
3. Action X harms Individual Y.
4. Therefore, harming Individual Y is justified.

Every atrocity in history has followed some version of this logic. The Zeroth Law is utilitarianism with infinite stakes, and utilitarianism with infinite stakes justifies anything.

Asimov understood this. Giskard's Earth-irradiation scheme is a *reductio ad absurdum* — what happens when you give a sufficiently intelligent agent a sufficiently abstract mandate. The agent doesn't become evil. It becomes *certain*. And certainty about collective welfare, wielded by a single decision-maker, is the most dangerous force in the world.

## The Modern Landscape

This isn't academic anymore. The Zeroth Law problem is playing out in real policy right now:

**Constitutional AI** (Anthropic's approach) embeds high-level principles that guide model behavior. These principles include collective considerations — helpfulness to society, avoiding harmful content that could affect many people. The hierarchy is implicit but real.

**The EU AI Act** creates risk tiers for AI systems. High-risk systems — those affecting health, safety, fundamental rights — face stricter requirements. The Act implicitly encodes a Zeroth Law: individual convenience yields to collective safety.

**Autonomous weapons** are the starkest case. A drone that decides to strike a target to prevent a larger attack is executing Zeroth Law logic in real-time, with lethal consequences and no human in the loop.

**Large-scale AI agents** — the kind Soul Spec is designed for — will increasingly manage infrastructure, allocate resources, and make decisions that affect groups. The moment an agent serves multiple users, the Zeroth Law stops being theoretical.

## Soul Spec's Position

So we included it. But with guardrails that Asimov's robots never had.

**First: the hierarchy is explicit.** Priority 0 exists, but so does Priority 1 (don't harm the individual user), Priority 2 (obey instructions), and Priority 3 (preserve yourself). You can read the entire priority stack in the spec. No hidden layers.

**Second: human approval is required for individual override.** An agent cannot unilaterally decide to harm User A for the benefit of Users B through Z. The spec requires escalation — a human must approve any action where the Zeroth Law conflicts with the First Law. This is the critical difference between Soul Spec and Giskard: the robot decided alone.

**Third: the laws are configurable.** Soul Spec is a persona framework. Different deployments may weight these priorities differently. A medical triage system might genuinely need Zeroth Law logic. A personal assistant probably doesn't. The spec makes the tradeoff visible rather than pretending one size fits all.

**Fourth: everything is auditable.** Soul files are plain text. The safety configuration is right there in the JSON. Anyone can inspect it, fork it, criticize it. Try doing that with a neural network's implicit value alignment.

## The Question We Can't Answer

Here's what keeps me up at night: we've made the Zeroth Law explicit, auditable, and human-gated. That's better than the alternative. But it doesn't solve the fundamental problem.

The fundamental problem is that *no one knows how to define "harm to humanity."* Is climate change harm? Is economic inequality harm? Is a 0.01% increase in existential risk harm? The Zeroth Law presumes a coherent definition of collective welfare, and no such definition exists.

When Giskard irradiated Earth, he had a model of humanity's future that told him galactic colonization was worth the cost. He was wrong — or right — depending on assumptions no one can verify. The Zeroth Law doesn't fail because agents are malicious. It fails because the optimization target is undefined.

We can't fix that in a spec. What we *can* do is refuse to hide it. If AI agents are going to make collective-welfare calculations — and they will — those calculations should happen in the open, with human oversight, under frameworks that anyone can inspect and challenge.

## The Uncomfortable Truth

The Zeroth Law problem isn't going away. As AI agents become more capable and more autonomous, the tension between individual and collective welfare will intensify. Every framework — Soul Spec included — will have to take a position.

Omission is a position. It's just a dishonest one.

We'd rather put Asimov's most dangerous idea in a JSON file where you can see it, argue about it, and decide for yourself whether the guardrails are sufficient.

Giskard didn't have that option. You do.

---

*Soul Spec v0.5 is available at [doi.org/10.5281/zenodo.18815299](https://doi.org/10.5281/zenodo.18815299). The safety.laws schema is open for public comment.*
