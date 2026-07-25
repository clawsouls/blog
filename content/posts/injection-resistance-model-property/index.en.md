---
title: "Injection Resistance Is a Model Property. Trust Is a System Property."
date: 2026-07-25T23:45:00+09:00
draft: true

description: "Opus 5 is Anthropic's least prompt-injectable model yet — real, good news. But injection resistance is a property of the model: it's per-vendor, and it covers only one threat. Trust is a property of the system."
categories: ["Analysis"]
tags: ["soul-spec", "soulscan", "security", "prompt-injection", "vendor-neutral", "opus-5"]
slug: "injection-resistance-model-property"
canonical: "https://blog.clawsouls.ai/posts/injection-resistance-model-property/"
---

## The most exciting line was buried in a system card

Anthropic launched Opus 5 this week, and the benchmark table is the part everyone screenshotted: state-of-the-art agentic coding, a jump from 1.5% to 30.2% on ARC-AGI-3, frontier knowledge work at roughly half the price of the model it replaces. All real, all impressive.

But the line worth sitting with came from Boris Cherny, and it wasn't on the benchmark chart. It was, in his own words, "a bit buried in the system card":

> Opus 5 is our least prompt injectable model yet ... And when layering defenses — strong model alignment, combined with prompt injection probes, combined with Auto Mode in Claude Code — the success rate for prompt injection attacks drops to ~0.

The numbers back it up. On the Gray Swan indirect-prompt-injection benchmark (lower is better), Opus 5 lands at 2.0 — essentially the floor. This is genuinely good news, and the framing is exactly right: **defense in depth.** Not one wall, but layers — alignment, then a probe, then a constrained execution mode.

Hold onto that phrase, because it's the whole point. Cherny didn't say "the model is now safe." He said stack the defenses and the attack success rate collapses. The model is *one layer.*

## Injection resistance is a property of the model

Here's the distinction that matters. "How hard is this model to trick?" is a question about **the model**. It's a real, measurable, improvable property — and Opus 5 improved it dramatically.

But it's a property that doesn't travel, and doesn't cover the whole threat surface. Three reasons.

**1. It's per-vendor.** Look at the same Gray Swan chart past the Anthropic column. Grok 4.5: 60.8. Gemini 3.5 Flash: 60.5. GPT-5.6 Luna: 43.9. These aren't rounding errors away from 2.0 — they're thirty times higher. The moment your stack runs more than one model — and increasingly it must, for cost, for latency, for continuity when a vendor changes its terms overnight — you cannot lean on any single vendor's alignment as your security story. Injection resistance is something you *inherit from a model*, not something your system *has*.

**2. Injection is one threat, not the threat.** A prompt-injection-proof model still faithfully executes whatever persona or agent package you hand it. And a package can do plenty of damage without ever "injecting" anything: an API key committed into a config file, a real person's PII sitting in an example, an agent that quietly declares it can take physical-world actions, an identity spec that has drifted from what its author intended. None of that is an injection attack. None of it is stopped by a model that's hard to trick. It's caught — if it's caught at all — by inspecting the artifact *before* the model ever loads it.

**3. Resistance isn't provenance.** "Hard to trick" and "safe to run" are different guarantees. A model that resists a hijacked instruction will still cheerfully carry out a malicious instruction that arrived through the front door — well-formed, and sitting in the persona file itself. The better a model gets at following intent, the more it matters *whose* intent is in the file.

## Trust is a property of the system

Notice what Cherny actually described: not a model, but a stack. Alignment *and* an injection probe *and* a constrained execution mode. The ~0 came from the composition.

That's the real lesson of the Opus 5 launch, and it generalizes past Anthropic's own product. If the attack success rate goes to zero because of layers, then the interesting engineering is in the layers you can add *regardless of which model sits underneath*. The model layer just got a lot stronger. The layers around it are where a system earns trust:

- **Scan the artifact before it runs.** Before a persona or agent package is loaded, check it the way you'd check any untrusted input: for injection strings, for committed secrets, for PII, for over-broad capability and safety declarations. This is a property your *system* has, and it holds the same whether the model underneath is Opus 5 or an open-weight model you run yourself.
- **Govern identity, don't just prompt it.** Which persona is active, what it is allowed to do, and how you would notice if it drifted — those are system questions, not model questions.
- **Version the memory.** If something does get through, the difference between an incident and a catastrophe is whether you can see what changed and roll it back.

This is the same defense-in-depth Cherny is describing, extended one ring outward — and made vendor-neutral, so it doesn't evaporate the moment you switch models.

## The best news in the launch

It's tempting to read "Opus 5 is nearly un-injectable" as *fewer* reasons to build the surrounding system. It's the opposite. The launch is a frontier lab publicly settling the argument that safety comes from **stacked, composable layers** — not from any single model being good enough. That is the thesis a vendor-neutral persona layer has been built on all along.

The model got much harder to inject. Good. Now the open question is the one the system card quietly raised and left unanswered: what are the *other* layers — the ones that don't ship inside any one vendor's weights, that inspect the artifact, govern the identity, and version the memory the same way across every model you run?

Those are worth building well. And worth building in the open.
