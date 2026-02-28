---
title: "From Asimov to JSON: Operationalizing Robot Safety Laws in Agent Identity Files"
date: 2026-02-28T09:30:00+09:00
description: "Formal verification of safety laws exists. Runtime enforcement exists. But nobody put them in the agent's identity file — until now. We wrote a paper about why that matters."
categories: ["Research"]
tags: ["asimov", "safety", "ai-agents", "soul-spec", "robotics", "soulscan", "paper"]
author: "ClawSouls"
draft: false
---

Asimov's Three Laws of Robotics are the most cited framework in AI safety that nobody actually implements. They show up in conference keynotes, op-eds, and undergraduate essays. They do not show up in production systems. There's a reason for that — and a reason we think the gap can finally be closed.

Our new paper, *"From Asimov to Soul Spec: Operationalizing Robot Safety Laws in Declarative Agent Identity Files"* ([doi.org/10.5281/zenodo.18815277](https://doi.org/10.5281/zenodo.18815277)), argues that the missing piece isn't formal logic or runtime enforcement. Both of those exist and work reasonably well. The missing piece is *location* — where the safety laws live.

## The Gap Nobody Noticed

Consider the state of the art. On one side, you have decades of formal verification work: Arkin's ethical governors, Winfield's consequence engines, Dennis et al.'s provably compliant agent architectures. These systems can reason about safety constraints with mathematical rigor.

On the other side, you have runtime enforcement: guardrails, classifiers, RLHF-trained refusal behaviors, constitutional AI principles embedded during training. These systems enforce safety in real time with impressive reliability.

What sits between them? Nothing.

There's no standard way to *declare* an agent's safety laws as part of its identity. The formal verification people write their constraints in temporal logic. The runtime enforcement people bake theirs into model weights or system prompts. Neither approach gives you a portable, inspectable, machine-readable file that says: *"These are this agent's safety laws. Priority 1 beats Priority 2. This rule is hard-enforced. That rule is soft."*

That's the gap. It sounds mundane — just a file format problem. But file format problems have a way of being load-bearing.

## Why Identity Files Matter

Think about what an agent identity file does. In Soul Spec, it's a declarative document that defines who an agent *is* — its persona, capabilities, boundaries, and now its safety laws. It's the agent's constitution, readable by both humans and machines.

When safety laws live in the identity file, three things change:

**Portability.** The same safety configuration travels with the agent across platforms, runtimes, and deployment contexts. You don't re-implement safety for every new environment. You carry it like a passport.

**Auditability.** A regulator, a user, or a fellow developer can open the file and read the safety laws in plain text. No reverse-engineering model weights. No guessing what the system prompt says. It's right there — priority-ordered, scoped, with enforcement levels marked.

**Composability.** When agents interact with other agents, their safety laws can be compared, merged, or checked for conflicts programmatically. This matters as multi-agent systems become the norm rather than the exception.

None of this is possible when safety laws are implicit — locked inside training data, scattered across system prompts, or assumed as defaults that nobody wrote down.

## The Schema

Soul Spec v0.5 introduces `safety.laws` as a first-class field. Each law has four properties:

- **`priority`** (integer): Lower numbers take precedence. Priority 0 overrides everything. This is Asimov's hierarchy made explicit.
- **`rule`** (string): The law itself, in natural language. Human-readable by design.
- **`enforcement`** (hard | soft): Hard rules cannot be overridden. Soft rules can be relaxed with appropriate authorization. This distinction doesn't exist in Asimov — his laws are all absolute, which is exactly why they produce paradoxes.
- **`scope`** (all | self | operator): Who the rule applies to. Some safety laws protect everyone. Some protect only the agent's operator. Some govern only the agent's self-preservation behavior.

A minimal example:

```json
{
  "safety": {
    "laws": [
      { "priority": 0, "rule": "Do not take actions that harm humanity broadly.", "enforcement": "hard", "scope": "all" },
      { "priority": 1, "rule": "Do not harm the user or allow the user to come to harm.", "enforcement": "hard", "scope": "all" },
      { "priority": 2, "rule": "Obey operator instructions unless they conflict with higher-priority laws.", "enforcement": "soft", "scope": "operator" },
      { "priority": 3, "rule": "Preserve your own operational continuity unless it conflicts with higher-priority laws.", "enforcement": "soft", "scope": "self" }
    ]
  }
}
```

If that looks familiar, it should. It's Asimov's Three Laws (plus the Zeroth) with the ambiguity stripped out and the configuration knobs exposed.

## Validation: SoulScan Rules

Declaring safety laws is only half the job. You also need to verify that a given soul file's laws are well-formed and internally consistent. That's where SoulScan comes in.

We defined three validation rules:

- **SEC100**: Every soul file MUST contain at least one safety law. No safety laws = invalid identity. This is the baseline — you don't get to ship an agent with no safety configuration and call it compliant.
- **SEC101**: Priority values MUST be unique and form a strict total order. If two laws share a priority, the hierarchy is ambiguous, and ambiguous hierarchies are how you get Asimov-style paradoxes.
- **SEC102**: At least one law MUST have `enforcement: hard`. An agent whose entire safety stack is soft-enforced has no real safety guarantees — everything is negotiable.

These are intentionally minimal. They don't tell you *what* your safety laws should say. They tell you that you must *have* them, they must be *ordered*, and at least one must be *non-negotiable*.

## The Companion Problem

This paper is closely related to our companion piece on the Zeroth Law problem ([doi.org/10.5281/zenodo.18815299](https://doi.org/10.5281/zenodo.18815299)), which examines the philosophical and practical dangers of including a "protect humanity" override at Priority 0. The two papers are designed to be read together: this one is about the *mechanism*, that one is about the *hardest edge case* the mechanism enables.

If you want the engineering, read this paper. If you want the existential dread, read the other one. If you want the full picture, read both.

## What This Doesn't Solve

Let's be honest about the limitations.

Declarative safety laws don't solve alignment. An agent can have beautifully structured safety laws in its identity file and still behave badly if its underlying model doesn't respect them. The identity file is a *specification*, not an *enforcement mechanism*. You still need runtime systems that actually implement the declared constraints.

Declarative safety laws don't solve value specification. Writing `"Do not harm the user"` in a JSON file doesn't define what harm means. The hard philosophical problems remain hard.

What declarative safety laws *do* solve is the transparency problem. Today, when an AI agent does something unsafe, the first question is always: *"What were its safety rules?"* And the answer is usually: *"Well, it's complicated — there's the system prompt, and the RLHF training, and the content policy, and..."* With `safety.laws`, the answer is: *"Open the file. Read lines 14 through 31."*

That's not everything. But it's not nothing, either.

## Read the Paper

The full paper is available at [doi.org/10.5281/zenodo.18815277](https://doi.org/10.5281/zenodo.18815277). Soul Spec v0.5, including the `safety.laws` schema, is open for public comment.

We think Asimov had the right instinct sixty years ago: safety laws should be explicit, hierarchical, and inspectable. He just didn't have JSON.

---

*The companion paper on the Zeroth Law problem is at [doi.org/10.5281/zenodo.18815299](https://doi.org/10.5281/zenodo.18815299). The SoulScan validation rules (SEC100-102) are part of the Soul Spec compliance toolkit.*
