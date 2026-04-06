---
title: "Andrew Ng Was Right 9 Months Ago — Here's What Changed (And What Didn't)"
date: 2026-04-07T09:50:00+09:00
draft: true
description: "In mid-2025, Andrew Ng laid out a pragmatic framework for AI agents. Nine months later, nearly every prediction holds — but the landscape has shifted in ways that make his insights even more relevant."
categories: ["Analysis"]
tags: ["soul-spec", "ai-agents", "andrew-ng", "multi-agent", "mcp"]
slug: "andrew-ng-was-right"
canonical: "https://blog.clawsouls.ai/posts/andrew-ng-was-right/"
---

## The Talk That Aged Like Wine

In mid-2025, Andrew Ng gave a talk on the state of AI agents. No hype. No "AGI by Tuesday." Just a clear-eyed look at what works, what doesn't, and where the real opportunities are.

Nine months later, I went back to check his predictions against reality. The scorecard is remarkable: **7 for 7.**

But the interesting part isn't what he got right. It's what changed around his predictions — and what that means for anyone building with AI agents today.

## The Scorecard

### 1. "Stop debating the definition of 'agent.' Focus on the autonomy spectrum."

**Verdict: Still right.**

The industry is still arguing about what counts as a "real" agent. Meanwhile, the teams shipping value have moved on. They build systems at whatever autonomy level solves the problem — from simple linear workflows to multi-step reasoning chains.

The definition debate is a spectator sport. The autonomy spectrum is where the work happens.

### 2. "Most business value comes from simple, linear workflows — not complex autonomous agents."

**Verdict: Even more right than before.**

This was counterintuitive in mid-2025, when the narrative was "fully autonomous agents will replace everything." Nine months later, the evidence is clear: the majority of enterprise AI value comes from automating repetitive, structured tasks.

Form filling. Database queries. Document processing. Not glamorous, but that's where the money is.

### 3. "Evals are underrated."

**Verdict: Precisely correct.**

Evaluation systems have become the dividing line between teams that ship reliable AI and teams that ship demos. Anthropic's latest work on [agent evaluation](https://www.anthropic.com/research) uses GAN-style generator/evaluator architectures — exactly the kind of systematic evaluation Ng advocated.

At Soul Spec, our [SoulScan](https://soulspec.org) security scanner is fundamentally an eval system: 53 patterns that evaluate whether an agent's persona definition is safe to deploy. Evals aren't just for model quality — they're for operational safety.

### 4. "Voice stack is underrated."

**Verdict: Prescient.**

Voice-based AI has exploded. Google's AI Edge Gallery now runs Gemma 4 models on phones with sub-second response times. The gap between "voice demo" and "voice product" has collapsed — largely because on-device inference eliminated the latency problem Ng identified.

When your AI responds in under a second on a $300 phone, voice becomes a primary interface, not a novelty.

### 5. "MCP will reduce n×m integration to n+m."

**Verdict: Prediction achieved.**

MCP has become the de facto standard for tool integration. The n×m problem — every agent needing custom code for every data source — is being replaced by standardized interfaces. [Soul Spec's MCP server](https://github.com/clawsouls/clawsouls-claude-code-plugin) provides 12 tools through a single integration point.

Ng saw this coming before most of the industry took MCP seriously.

### 6. "Multi-agent systems only work within the same team."

**Verdict: Still true — and this is the key insight.**

Cross-organization agent-to-agent communication remains largely theoretical. But *within* a team? Multi-agent is becoming practical.

We're testing this right now with what we call Twin Brad — two instances of the same AI agent (one running Claude Opus, one running Qwen 3.5 locally) sharing memory through a protocol called [Swarm Memory](https://soulspec.org). Same personality. Same memories. Different engines.

The key: both agents share the same `SOUL.md` (identity definition) and `MEMORY.md` (persistent context). They're not strangers trying to cooperate — they're the same agent running on different hardware.

Ng's insight — "same team only" — maps precisely to this architecture. Multi-agent works when the agents share identity, not just protocol.

### 7. "Execution speed is the #1 factor for startup success."

**Verdict: Timeless truth — but with a twist.**

Speed still matters more than anything. But in 2026, AI has equalized coding speed across teams. If everyone can build fast, speed alone isn't a moat.

What's changed: **domain knowledge and standard ownership** have become the durable advantages. You can't fork 15 research papers. You can't clone a community. You can't speed-run becoming the reference implementation for an open standard.

Speed gets you to market. Standards keep you there.

## What Ng Didn't Predict (But Should Have)

There's one critical dimension Ng's talk didn't address: **agent safety and governance.**

In mid-2025, the conversation was about capability. Can agents do useful things? Nine months later, the conversation has shifted. Agents can clearly do useful things. The question is: **can we trust them in production?**

The [AI adoption bottleneck in 2026](https://blog.clawsouls.ai/posts/ai-seatbelt/) isn't model intelligence. It's:

- **Rollback**: Can you undo what the agent did?
- **Audit**: Can you trace what happened and why?
- **Accountability**: Who's responsible when it breaks?
- **Security**: Can the agent be hijacked or poisoned?

These are the questions blocking the 3/10 → 4/10 transition — from "some people use AI" to "everyone uses AI." Ng's framework for adoption was about capability and tooling. The missing piece is trust infrastructure.

## The Synthesis

Ng's framework + the safety dimension gives us a complete picture:

| Ng's Insight | 2026 Reality | What's Needed |
|---|---|---|
| Autonomy spectrum | Confirmed | Standards for each level |
| Simple workflows win | Even more true | Reliable execution > fancy demos |
| Evals matter | Critical | Security evals, not just quality evals |
| Voice is underrated | Exploding | On-device inference makes it real |
| MCP standardization | Achieved | Identity standards next (Soul Spec) |
| Same-team multi-agent | Only viable kind | Shared identity > shared protocol |
| Speed wins | Still true | But standards create lasting moats |

The trajectory is clear: from capability (can it do things?) to reliability (can we trust it?) to infrastructure (is it the default?).

Ng mapped the capability layer perfectly. The industry is now building the reliability layer. And the teams that get both right will define the infrastructure layer.

## What This Means for Builders

If you're building with AI agents today:

1. **Start simple.** Ng was right — linear workflows first. Add autonomy only when you've earned trust.

2. **Invest in evals early.** Not just "does the output look good?" but "is the agent behaving safely?"

3. **Standardize your agent identity.** When you swap models (and you will), your agent's personality and memory shouldn't reset to zero.

4. **Build the seatbelt before the engine.** Rollback, audit trails, governance. These aren't features — they're prerequisites for production.

5. **Multi-agent? Same team only.** Share identity, not just protocol. Same soul, different engines.

Andrew Ng gave us the map. Nine months later, the territory matches. The only addition: **the map needs a safety legend.**

---

*[Soul Spec](https://soulspec.org) is an open standard for AI agent identity, safety, and governance. Because the map needs a safety legend.*

*Related: [AI Doesn't Need a Bigger Engine — It Needs a Seatbelt](/posts/ai-seatbelt/) · [The Cognitive Dark Forest Has One Exit: Become the Forest](/posts/cognitive-dark-forest/)*
