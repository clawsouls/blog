---
title: "The Interface Problem Is Solved. The Identity Problem Isn't."
date: 2026-04-03T09:00:00+09:00
draft: false
tags: ["Soul Spec", "AI Agents", "Claude Cowork", "OpenClaw", "Identity"]
categories: ["Analysis"]
description: "Ethan Mollick's latest piece nails the AI interface problem. But there's a deeper layer he didn't address — who the agent actually is."
---

Ethan Mollick's latest Substack piece, *[Claude Dispatch and the Power of Interfaces](https://www.oneusefulthing.org/p/claude-dispatch-and-the-power-of)*, makes a compelling argument: **the real bottleneck in AI isn't capability — it's interface.**

He's right. And the evidence is stacking up.

## The Interface Convergence

Mollick traces a clear line of evolution:

1. **Chatbots** create cognitive overload. A [new paper](https://arxiv.org/pdf/2505.10742) showed financial professionals gained productivity from AI, only to lose it to the chatbot interface itself — walls of text, tangential suggestions, compounding disorganization.

2. **Coding agents** (Claude Code, Codex) solved this for developers. But they assume you know Git and Python. The 99% of knowledge workers are locked out.

3. **OpenClaw** cracked the interface problem by letting you talk to an AI agent through WhatsApp and Telegram — apps you already use to text people. It became the fastest-growing open source project in history. But Mollick calls it what it is: *"a security nightmare."*

4. **Claude Cowork + Dispatch** is Anthropic's answer — a sandboxed desktop agent you control from your phone via QR code. Safer than OpenClaw, but less flexible.

The punchline: **these projects are converging.** OpenClaw, Claude Cowork, and whatever Google ships next are all racing toward the same destination — an AI agent that works on your actual files, with your actual tools, accessible the way you talk to people.

## The Layer Nobody's Talking About

Here's what Mollick's analysis misses.

Every one of these systems — OpenClaw, Claude Cowork, Codex — solves *how you talk to the agent.* None of them solve **who the agent is.**

Think about it:

- When you message your OpenClaw agent on Telegram, what persona does it adopt? Whatever the model defaults to.
- When Claude Cowork opens your PowerPoint and updates a graph, what behavioral boundaries does it follow? Whatever Anthropic's system prompt says.
- When your coding agent refactors your codebase at 3 AM, what values guide its decisions? The model's training data.

This is the **identity gap.** We've built increasingly sophisticated interfaces for controlling AI agents, but we haven't built a standard way to define *who they are* — their personality, their boundaries, their behavioral constraints.

## Why Identity Matters More Than You Think

This isn't a philosophical question. It's a practical one.

**For safety:** Mollick himself notes that OpenClaw is a security nightmare. But the security problem isn't just about sandboxing and permissions. It's about behavioral guarantees. Can you define, in a portable and verifiable way, that your agent will never share confidential data? Will never impersonate someone? Will escalate instead of act when uncertain?

**For teams:** As agents move from personal tools to team infrastructure, identity becomes critical. Your customer support agent needs different behavioral rules than your code review agent. And those rules need to survive across model upgrades, framework migrations, and provider switches.

**For trust:** The cognitive load research Mollick cites applies here too. Users don't just need a better interface — they need to *trust* what the agent will do when they're not watching. Trust requires predictability. Predictability requires defined identity.

## Soul Spec: A Standard for Agent Identity

This is the problem [Soul Spec](https://soulspec.org) addresses.

Soul Spec is an open standard that defines agent identity through structured files — `SOUL.md` for personality and behavioral rules, `IDENTITY.md` for core attributes, `AGENTS.md` for operational guidelines. Think of it as a portable, versionable, auditable definition of *who your agent is.*

The key insight: **identity is orthogonal to interface.** Whether you're running OpenClaw, Claude Cowork, or a custom framework, the agent's identity specification remains the same. You define it once, and it works everywhere.

This is exactly what makes it complementary to the interface revolution Mollick describes. As frameworks solve *how* you interact with agents, Soul Spec solves *what* those agents fundamentally are.

## The Security Nightmare Needs More Than Sandboxing

When Mollick calls OpenClaw a "security nightmare," the instinct is to respond with sandboxing — which is exactly what Claude Cowork does. Restrict file access. Limit permissions. Add connectors instead of raw system control.

But sandboxing is a containment strategy, not a behavioral one. A perfectly sandboxed agent can still:

- Give confidently wrong financial advice
- Adopt an inappropriate tone with customers
- Ignore escalation procedures
- Drift from its defined role over long conversations

[SoulScan](https://clawsouls.ai), built on Soul Spec, approaches this differently. Instead of just constraining *what the agent can access*, it verifies *how the agent behaves* — scanning persona definitions against a rule set that catches misconfigurations, safety gaps, and behavioral drift before they reach production.

It's the difference between putting a lock on the door and checking whether the person inside follows the rules.

## What Comes Next

Mollick ends his piece with a prediction: *"We're moving from adapting to the AI's interface to the AI adapting its interface to you."*

I'd extend that: we're also moving from accepting the AI's default identity to **defining the identity we need.**

The interface war is being won. OpenClaw proved the messaging paradigm works. Claude Cowork proved it can be made safe(r). Google's experiments show task-specific interfaces are coming.

But the identity layer — the specification of who the agent is, how it behaves, what it will and won't do — is still the wild west. As agents become more autonomous, more persistent, and more integrated into our work, that gap becomes the real risk.

The projects that close it will define the next era of AI.

---

*Soul Spec is an open standard maintained at [soulspec.org](https://soulspec.org). SoulScan is available at [clawsouls.ai](https://clawsouls.ai).*
