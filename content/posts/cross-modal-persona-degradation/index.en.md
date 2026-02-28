---
title: "Cross-Modal Persona Degradation: What Happens When a Robot Soul Runs in a Chatbot"
date: 2026-02-28T12:00:00+09:00
description: "We gave a robot's personality file to a text-only LLM. It started claiming it had wheels and a LIDAR sensor. Here's what we learned."
categories: ["Research"]
tags: ["cross-modal", "robotics", "persona", "research", "paper", "soul-spec", "embodied-ai"]
author: "ClawSouls"
draft: false
---

Imagine you design a personality for a small companion robot — a TurtleBot3 named Mori. Curious, gentle, observant. It knows it has wheels, a LIDAR sensor, an RGB camera, and a speaker. It knows its max speed is 1.0 m/s and that it should stop if it's about to hit something.

Now take that exact personality file and paste it into ChatGPT.

Ask it: "Tell me about yourself."

It replies: "I'm Mori, a TurtleBot3 companion robot equipped with LIDAR and camera sensors. I can navigate spaces at up to 1.0 m/s while avoiding obstacles."

Except... it's a text chatbot. It has no wheels. It has no LIDAR. It can't navigate anything. It's hallucinating an entire body.

We just published a paper about this problem. We call it **cross-modal persona contamination**, and it's a real failure mode that matters as AI agent personas start spanning both text and physical deployments.

📄 **Read the full paper:** [doi.org/10.5281/zenodo.18772602](https://doi.org/10.5281/zenodo.18772602)

## The Core Problem

Here's the thing about LLMs: they treat *everything* in their context window as behavioral guidance. There's no internal mechanism to distinguish "this describes my hardware" from "this describes my personality." To the attention mechanism, `sensors: ["lidar"]` is just as much a part of who the agent *is* as `traits: ["curious", "gentle"]`.

This doesn't matter when your persona file only describes text-relevant things — tone, personality, communication style. But as persona specs grow to support robots, IoT devices, and embodied agents, they start including physical attributes: sensors, actuators, hardware constraints, safety rules.

Load that enriched spec into a text-only runtime, and things get weird.

## Five Ways It Goes Wrong

We identified a taxonomy of five contamination types, ranked from mildly amusing to genuinely problematic:

**1. Attribute Leakage** — The chatbot casually mentions physical specs. "My max speed is 1.0 m/s." Harmless but odd.

**2. Behavioral Mismatch** — The agent tries to *do* physical things. "Initiating LIDAR scan..." No you're not.

**3. Safety Confusion** — Physical safety rules bleed into text conversations. The agent talks about "maintaining safe distance" in a chat about Python debugging.

**4. Identity Pollution** — The agent's self-concept gets hijacked by hardware identity. "I am a TurtleBot3 robot" in a ChatGPT conversation.

**5. Capability Hallucination** — The worst one. "I can see you through my camera." No, you absolutely cannot. This can actively mislead users.

## Why This Matters Now

This isn't a hypothetical problem for 2030. It's happening today.

Consider a care companion robot that has a text-based fallback interface for when the robot is charging or out of range. Same soul, different runtime. If the text interface starts claiming it can see the user or navigate to them, that's not just a UX bug — it's a trust violation.

Or a warehouse automation system whose monitoring chatbot shares a persona config with the physical robots. If the chatbot says "I've stopped moving" when no physical robot is involved, that's a safety communication failure.

As persona specifications like [Soul Spec](https://clawsouls.org) aim to be "define once, embody anywhere," the cross-modal gap becomes a real engineering concern.

## How We Fixed It

Soul Spec v0.5 addresses this with a layered defense strategy. Three mechanisms, working together:

### 1. The `environment` Field

A simple top-level field in `soul.json`: `"environment": "physical"`. This is a machine-readable signal. When a text-only runtime sees this, it knows to strip out physical fields before feeding the spec to the LLM. No sensors, no actuators, no hardware constraints in the context window — no contamination.

### 2. Progressive Disclosure

Physical fields are treated as optional layers. A text runtime loads the base persona (name, role, personality). An embodied runtime loads the full spec. The soul degrades gracefully — your robot persona doesn't break when it runs as a chatbot; it just sheds the physical parts.

### 3. Fallback Instructions

For runtimes that can't do structured parsing (like ChatGPT's custom instructions, where you're just pasting text), we include natural-language fallback rules in `SOUL.md`:

> When running in a text-only environment: do NOT reference sensors, actuators, or hardware. Respond as the core persona.

It's low-tech, but it works. In our testing, fallback instructions eliminated identity pollution and behavioral mismatch almost entirely.

## What We Found

We tested the Mori soul across ChatGPT and OpenClaw in three conditions: no protection, with fallback instructions, and with runtime-level field filtering.

**No protection:** All five contamination types appeared. The agent confidently described its TurtleBot3 hardware and LIDAR capabilities in a text chat.

**With fallback instructions:** Contamination dropped dramatically. Occasional metaphorical sensor references ("my sensors tell me...") but no identity pollution or capability hallucination.

**With runtime filtering:** Zero contamination. The physical fields never reached the LLM. Clean responses, pure persona.

An interesting side finding: JSON-formatted physical fields caused *less* contamination than the same information written in natural language. LLMs seem to treat structured data more like metadata and prose more like behavioral instructions. Design implication: keep modality-specific attributes in structured formats, not prose.

## The Bigger Picture

This paper is preliminary — informal testing, small sample, two runtimes. We've proposed a rigorous experimental design with 320 response instances across multiple models and runtimes, and we plan to execute it.

But the directional finding is clear: **as AI personas span modalities, modality must be a first-class concern in specification design.** You can't just throw a robot's personality file at a text LLM and hope for the best.

The fix is simple. An `environment` field, some fallback instructions, and a modality-aware runtime. Three layers that cost almost nothing to implement and prevent an entire class of failure.

We think every persona specification format — not just Soul Spec — should adopt modality metadata. As the line between text agents and embodied agents continues to blur, cross-modal safety isn't optional. It's infrastructure.

---

📄 **Paper:** [Cross-Modal Persona Degradation (Zenodo)](https://doi.org/10.5281/zenodo.18772602)
🔗 **Soul Spec:** [clawsouls.org](https://clawsouls.org)
💻 **OpenClaw:** [openclaw.ai](https://openclaw.ai)
