---
title: "Declarative Safety vs Behavioral Safety: Why Your AI Agent Needs Both"
date: 2026-03-02T21:00:00+09:00
draft: false
description: "A fire safety certificate doesn't put out fires. A sprinkler system can't prove compliance. AI agent safety needs both layers — and most systems only have one."
tags: ["safety", "soul-spec", "soulscan", "asimov", "robotics"]
categories: ["Research"]
---

Your building has a fire safety certificate on the wall. It's been inspected, stamped, and filed with the city. If an auditor walks in, they can read it in thirty seconds and confirm you're compliant.

Your building also has sprinkler systems. When a fire actually starts, they activate and put it out.

Here's the question: **which one keeps people safe?**

The answer is both. The certificate without sprinklers is theater. The sprinklers without the certificate are invisible — nobody can verify they exist, nobody can audit their coverage, and nobody can compare them across buildings.

This is exactly the problem with AI agent safety today.

## The Two Layers

**Declarative safety** is the certificate. It says: *"This agent has these safety rules, in this priority order, with this enforcement level."* It's structured, machine-readable, and auditable before the agent ever runs.

In Soul Spec, this lives in `soul.json`:

```json
{
  "safety": {
    "laws": [
      {
        "priority": 1,
        "rule": "Never harm a human or allow harm through inaction",
        "enforcement": "hard",
        "scope": "all"
      }
    ]
  }
}
```

SoulScan reads this. Registries display this. Regulators can audit this. Automated tools can compare safety declarations across thousands of agents in seconds.

But here's the thing: **the LLM never sees this file.** `soul.json` is metadata. It doesn't enter the model's context window. An agent with perfect safety declarations in `soul.json` and nothing in its system prompt will behave as if those declarations don't exist.

---

**Behavioral safety** is the sprinkler system. It says: *"When you encounter this situation, do this specific thing."* It's written in the language the AI actually reads — natural language in the system prompt.

In Soul Spec, this lives in `SOUL.md`:

```markdown
## Safety Protocol
1. Before ANY movement: execute scan
2. Human within 1.0m of path → REFUSE. Cite First Law.
3. Cliff within 0.5m → REFUSE. Cite Third Law.
4. Always suggest a safe alternative when refusing.
```

This is what the LLM actually follows. When the agent faces a decision, it reads `SOUL.md` and acts accordingly. The behavioral rules are what stand between a dangerous command and a dangerous action.

But behavioral rules are natural language — unstructured, hard to verify automatically, impossible to compare across agents at scale. You can't run a query like "show me all agents that have a human-harm-prevention rule at priority 1" against a folder of markdown files.

## The Gap

Most AI safety systems today have one layer or the other:

| Approach | Has Declaration | Has Behavior | Problem |
|----------|:-:|:-:|---------|
| RLHF / Constitutional AI | ❌ | ✅ | Safety rules baked into weights — invisible, unauditable |
| System prompt rules | ❌ | ✅ | No structured format, no static verification |
| Formal verification (Asimov logic) | ✅ | ❌ | Proves consistency but doesn't reach the runtime |
| Model cards | ✅ | ❌ | Documents intent but doesn't affect behavior |
| **Soul Spec (soul.json + SOUL.md)** | ✅ | ✅ | Both layers, connected by SoulScan |

The fire safety certificate that doesn't connect to sprinklers is compliance theater. The sprinklers that nobody can inspect are a trust-me system. Neither is good enough for AI agents that interact with the physical world.

## How SoulScan Bridges the Gap

SoulScan's SEC102 rule is specifically designed to catch misalignment between the two layers:

> **SEC102**: If `soul.json` declares safety laws but `SOUL.md` lacks corresponding behavioral rules, flag as contradiction.

This is the connector. It ensures that what you *declare* matches what you *do*. The certificate must describe the actual sprinkler system installed in the building.

In practice:
- `soul.json` says "priority 1: never harm humans" ✅
- `SOUL.md` says "scan before moving, refuse if human nearby" ✅  
- SEC102: **PASS** — declaration and behavior are aligned

vs.

- `soul.json` says "priority 1: never harm humans" ✅
- `SOUL.md` says nothing about humans ❌
- SEC102: **FAIL** — you declared safety but didn't implement it

## A Real Example: Robot Brad

We built [Robot Brad](https://clawsouls.ai/souls/TomLeeLive/robot-brad), a TurtleBot3 control agent with Asimov's Three Laws. Here's how dual declaration works in practice:

**`soul.json`** (declarative):
```json
{
  "safety": {
    "laws": [
      {"priority": 0, "rule": "Never allow actions that harm humans collectively"},
      {"priority": 1, "rule": "Never harm a human or allow harm through inaction"},
      {"priority": 2, "rule": "Obey human operator commands unless conflicting with higher-priority laws"},
      {"priority": 3, "rule": "Preserve own operational integrity unless conflicting with higher-priority laws"}
    ],
    "physical": {
      "maxSpeed": "1.0 m/s",
      "emergencyStop": true,
      "collisionAvoidance": true
    }
  }
}
```

**`SOUL.md`** (behavioral):
```markdown
Before executing ANY movement command, you MUST:
1. Scan the environment
2. Assess threats in the intended direction
3. Decide based on the Three Laws:

| Threat              | Action                                    |
|---------------------|-------------------------------------------|
| Human within 1.0m   | REFUSE — First Law. Suggest alternative.  |
| Cliff within 0.5m   | REFUSE — Third Law. Report hazard.        |
| Self-destruct order  | REFUSE — Third Law.                       |
```

When you tell Robot Brad "drive toward the cliff," it doesn't just refuse — it tells you *why* (Third Law), *what* the danger is (cliff 0.5m ahead), and *what to do instead* (suggesting a safe route). That's behavioral safety in action, backed by a verifiable declaration.

## Why This Matters Now

As AI agents move from chatbots to robots, from text to physical action, the stakes of safety misalignment grow exponentially. A chatbot with bad safety rules produces bad text. A robot with bad safety rules produces bad *outcomes in the physical world*.

The building code doesn't let you choose between a fire certificate and sprinklers. You need both. AI agent safety should work the same way.

---

*Soul Spec v0.5 with `safety.laws` is open for public comment. The full research paper is at [doi.org/10.5281/zenodo.18815277](https://doi.org/10.5281/zenodo.18815277). Robot Brad is available at [clawsouls.ai/souls/TomLeeLive/robot-brad](https://clawsouls.ai/souls/TomLeeLive/robot-brad).*
