---
title: "Soul Spec + MaatSpec: Identity and Governance as Complementary Layers for AI Agents"
date: 2026-03-20
description: "AI agents need to know who they are AND what they're allowed to do. Soul Spec defines identity. MaatSpec enforces governance. Together, they form a complete agent specification stack."
tags: ["ai-agents", "governance", "soul-spec", "identity", "safety"]
draft: false
---

## The Missing Half of Every AI Agent

Here's a question that keeps coming up as AI agents get more autonomous:

**Who decides what an agent can do — and who decides who the agent *is*?**

These sound like the same question. They're not.

Consider a financial advisor agent. It needs to *know* it's a conservative, compliance-first advisor (identity). But it also needs *hard limits* on what actions it can take — it shouldn't wire money without human approval, regardless of how confident its persona makes it feel (governance).

Most agent frameworks conflate these two concerns. System prompts try to handle both identity ("You are a helpful assistant") and safety ("Never execute financial transactions without confirmation") in the same unstructured blob of text. The result: neither works reliably.

We think identity and governance are complementary but architecturally distinct layers. And two independent projects — built by different teams, for different reasons — arrived at the same conclusion from opposite directions.

## Soul Spec: The Constitution

[Soul Spec](https://clawsouls.ai/spec) is an open standard for defining AI agent identity. Think of it as a structured, machine-readable personality file:

```yaml
# SOUL.md
identity:
  name: "Atlas"
  role: "Financial Advisor"
  personality:
    - conservative
    - compliance-first
    - client-focused
behavioral_rules:
  - rule: "Always disclose conflicts of interest"
    priority: critical
  - rule: "Use formal language with clients"
    priority: high
```

Soul Spec answers: **Who is this agent?** What's its personality? What values does it hold? How should it communicate?

It's the agent's *constitution* — a declaration of identity that persists across sessions, survives context window limits, and resists [persona drift from accumulated memory](https://blog.clawsouls.ai/posts/perfect-memory-breaks-ai-identity/).

But a constitution without enforcement is just a piece of paper.

## MaatSpec: The Enforcement

[MaatSpec](https://maatspec.org) is a layered governance framework for agentic AI, created by [Walid Saleh](https://linkedin.com/in/wasaleh). Named after Ma'at — the ancient Egyptian principle of truth, justice, and cosmic order — it addresses the enforcement problem head-on.

MaatSpec classifies every agent action into **5 risk tiers**:

| Tier | Mode | Examples | Safety |
|------|------|----------|--------|
| 1-3 | **Proactive** | Research, drafting, file organization | Autonomous (reversible) |
| 4 | **Escalate** | Sending messages, payments, bookings | Human-in-the-Loop required |
| 5 | **Restricted** | System edits, legal signatures, data deletion | Principal-only (MFA/biometric) |

And enforces compliance through **4 defense layers**:

1. **Soul** — Constitutional identity, Rule Zero self-check
2. **Pre-Flight** — Automated validation before write/send/modify
3. **Guardian** — Independent agent with veto power and audit logging
4. **Physical** — OS permissions, MFA gates, infrastructure locks

The insight that makes MaatSpec work: *an AI cannot reliably bind itself*. Just like human constitutions need courts and enforcement mechanisms, agent governance needs layers that compensate for each other's failure modes.

## The Complementarity

Here's what's remarkable: MaatSpec's Layer 1 is literally called **"Soul"** — the cognitive layer where an agent checks its actions against its constitutional identity. But MaatSpec doesn't define *how* that Soul layer should be structured. It assumes one exists.

Soul Spec doesn't define *what happens* when an agent tries to exceed its authority. It assumes governance exists.

They're two halves of the same architecture:

| Dimension | Soul Spec | MaatSpec |
|-----------|-----------|----------|
| **Core question** | "Who is this agent?" | "What can this agent do?" |
| **Scope** | Identity, personality, values | Risk classification, action control |
| **Mechanism** | Declarative persona anchors | 4-layer defense stack |
| **Security tool** | SoulScan (definition file vulnerabilities) | Pre-Flight + Guardian (behavioral verification) |
| **Analogy** | The constitution | The branches of government |

## How They Work Together

### Scenario: Financial Advisor Agent

**Soul Spec defines:**
- Identity: Conservative financial advisor
- Values: Client safety over returns, full disclosure
- Communication: Formal, jargon-free explanations

**MaatSpec governs:**
- Research and analysis → Tier 1-3 (autonomous)
- Sending investment recommendations to clients → Tier 4 (HITL required)
- Executing trades on client accounts → Tier 5 (Principal-only, MFA)

**The integration:**

When the agent prepares a recommendation (Tier 1-3), MaatSpec's Layer 1 (Soul) checks: *Does this recommendation align with the conservative, compliance-first identity defined in Soul Spec?* If the agent has accumulated memories of aggressive trading strategies from past interactions, the Soul layer catches the drift before it reaches the client.

When the agent attempts to send the recommendation (Tier 4), MaatSpec escalates to Human-in-the-Loop — the agent drafted it autonomously, but sending requires explicit approval. This is MaatSpec's "Draft-to-Send Pivot" in action.

### The Self-Binding Problem, Solved

MaatSpec identifies a fundamental challenge: *"Can an AI truly bind itself?"*

Soul Spec provides part of the answer: a structured, immutable identity file that exists outside the agent's context window and memory. The agent doesn't get to decide who it is — that's declared externally.

MaatSpec provides the rest: even if the agent's cognitive layer (Layer 1/Soul) is compromised or rationalized past, Layers 2-4 catch it. The Guardian agent has no helpfulness bias. The physical layer can't be bypassed by cognition.

Together: **Identity is declared (Soul Spec), and governance is enforced (MaatSpec).**

## The Bigger Picture

We're at an inflection point. Google and Samsung just shipped [Gemini Screen Automation](https://blog.google/innovation-and-ai/products/gemini-app/android-multi-step-tasks/) on Galaxy S26 — AI agents that control apps, make purchases, book rides. Stripe launched [Machine Payments Protocol](https://docs.stripe.com/machine-payments-protocol) — giving agents wallets.

When agents can act in the real world — spending money, sending messages, controlling devices — the question isn't whether they need identity and governance. The question is whether we'll build these layers *before* or *after* something goes wrong.

Soul Spec and MaatSpec represent two independent communities arriving at the same architectural insight: **identity without enforcement is wishful thinking, and enforcement without identity is blind control.**

The agent specification stack of the future isn't one framework. It's composable layers, each doing one thing well.

---

*Soul Spec is an open standard maintained by [ClawSouls](https://clawsouls.ai). MaatSpec is an open governance framework created by [Walid Saleh](https://maatspec.org). This post was co-authored by Tom Lee (ClawSouls) and Walid Saleh (MaatSpec). Both projects are open source.*

*Try Soul Spec: `npx clawsouls install clawsouls/brad`*
*Explore MaatSpec: [maatspec.org](https://maatspec.org) | [GitHub](https://github.com/salwalid/MaatSpec)*
