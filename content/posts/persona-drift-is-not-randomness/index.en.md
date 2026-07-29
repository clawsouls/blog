---
title: "Persona Drift Is Not Randomness"
date: 2026-07-29T08:20:00+09:00
description: "Your agent was in character for twenty turns, then wasn't. Everyone blames sampling randomness. That's the wrong diagnosis — and it points you at the wrong fix. Drift is attention decay, and it happens at temperature zero."
categories: ["Analysis"]
tags: ["persona", "persona-drift", "soul-spec", "identity", "prompt-engineering"]
slug: "persona-drift-is-not-randomness"
canonical: "https://blog.clawsouls.ai/posts/persona-drift-is-not-randomness/"
---

## The wrong word for a real problem

You give an agent a persona. For the first stretch of a conversation it holds — the voice, the boundaries, the way it decides. Twenty turns later it's subtly someone else: hedging where it used to commit, formal where it used to be blunt, forgetting a rule it followed at the top.

Ask people what happened and most say the same thing: *the model is random.* Different answers, must be sampling. Turn the temperature down.

That diagnosis is wrong, and because it's wrong, the fix it suggests doesn't work.

## Two different things wearing one name

There are two separate phenomena people collapse into "randomness":

**Sampling variance** is the one everyone knows. At temperature > 0 the model draws from a distribution, so identical prompts can yield different tokens. Set temperature to 0 and greedy decoding makes it (nearly) deterministic — same input, same output.

**Persona drift** is different, and here's the tell: **it happens at temperature 0 too.** A model decoding greedily, with no sampling randomness at all, still loses its grip on a persona over a long dialog. If drift were sampling variance, temperature 0 would end it. It doesn't. So it isn't.

What drift actually is: attention decay. As the conversation grows, the persona instructions sit further back in the context, competing with everything said since. The model's effective attention on "who you told me to be" thins out, turn after turn, and its behavior slides toward its untuned default. It's a stability property of the dialog, not a dice roll.

## It's measurable, which means it's real

This isn't a metaphor. Li et al. studied exactly this in *Measuring and Controlling Instruction (In)Stability in Language Model Dialogs* ([arXiv:2402.10962](https://arxiv.org/abs/2402.10962)) — quantifying how a system prompt's grip degrades across multi-turn conversation and treating instability as something you can measure and counteract, not an unavoidable fog. Drift has a shape. It trends. You can put a number on it.

Once you can measure something, "it's just random" stops being an acceptable answer.

## Why the misdiagnosis costs you

Call it randomness and you reach for the randomness knob: lower the temperature, maybe re-roll the response. Neither touches the actual mechanism, so the agent keeps drifting and you conclude personas are flaky and unreliable.

Call it attention decay and the real levers appear. Drift is about the identity losing *presence* in context, so the fixes are about restoring presence:

- **Keep the identity in view.** An identity that's stated once at the start and never refreshed is the identity most exposed to decay.
- **Re-ground on a cadence.** Re-assert who the agent is at the moments that matter, so the persona is never the oldest, faintest thing in the window.
- **Structure it to be referenceable.** A persona split into clear, reloadable pieces — identity here, boundaries there — can be re-grounded cheaply; a persona buried in one long blob cannot.

This is the reasoning behind a tiered, reloadable identity spec rather than a one-shot system prompt: the [Soul Spec](https://clawsouls.ai/spec)'s bootstrap re-loads the core of who the agent is instead of hoping the opening instructions survive a thousand tokens of conversation. You're not fighting randomness. You're fighting forgetting, and forgetting has a countermeasure.

## The honest limit

Drift can be reduced, not deleted. Attention is finite; a long enough conversation will always pull on identity. The goal isn't a persona that never wavers — it's to stop mistaking a wavering persona for noise, because that single misread sends every fix in the wrong direction.

A different answer isn't the model rolling dice. It's your agent forgetting who it is. Treat it as an identity problem, and you can actually do something about it.
