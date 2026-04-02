---
title: "NVIDIA Shares Tensors Between GPUs. Soul Spec Shares Behavior Between Agents. Both Are Harness Engineering."
date: 2026-04-02T09:30:00+09:00
description: "Multi-agent AI needs data sharing at every layer. NVIDIA Dynamo solves it in hardware with KV cache routing. Soul Spec solves it in software with portable identity files. Together, they complete the harness stack."
categories: ["Analysis"]
tags: ["harness-engineering", "nvidia-dynamo", "soul-spec", "multi-agent", "ai-infrastructure"]
author: "ClawSouls"
draft: false
---

When we talk about multi-agent AI, we eventually hit the same question at every layer of the stack: **how do agents share data?**

NVIDIA just answered this for hardware. Their Dynamo 1.0 framework routes KV caches between GPUs, offloads memory across storage tiers, and coordinates inference across thousands of nodes. It's already deployed in production at AstraZeneca, ByteDance, Pinterest, and dozens more.

But hardware data sharing only solves half the problem. The other half — *what should agents know about each other's identity, memory, and safety rules?* — lives in software.

This is the full harness stack, and it needs both layers.

## The Hardware Harness: NVIDIA Dynamo

Traditional inference treats every request the same. But in multi-agent workflows, agents share context: a system prompt reused across turns, a conversation history referenced by multiple specialized agents, cached reasoning from a planning step.

Dynamo's insight is that this shared context can be **physically shared** across GPUs rather than recomputed:

**KV Cache Routing** — When Agent A and Agent B share the same system prompt, the KV cache for that prompt is computed once and routed to both inference workers. No redundant prefill computation.

**Disaggregated Serving** — Prefill (processing input) and Decode (generating output) run on different GPUs optimized for each task. A planner agent's long input goes to prefill-optimized hardware; the generator agent's token-by-token output goes to decode-optimized hardware.

**NIXL** — NVIDIA's Inference Transfer Library enables direct GPU-to-GPU memory transfers. KV caches move between nodes without touching CPU memory, achieving near-wire-speed data sharing.

**Tiered Offloading** — KV caches flow between GPU HBM → NVMe → network storage (via BlueField-4 DPUs), so context from yesterday's conversation can be loaded in milliseconds rather than recomputed.

The results are dramatic: up to **7x throughput improvement** on Blackwell GPUs, and **4x acceleration** for agentic inference workloads.

## The Software Harness: Soul Spec

Now zoom up to the application layer. Your multi-agent system has a planner, a coder, a reviewer, and a safety monitor. Dynamo ensures their inference is fast and efficient. But who decides:

- What personality does each agent have?
- What does the coder remember from yesterday's session?
- What safety rules apply to the reviewer?
- How does the planner delegate work?

These aren't hardware questions. They're **behavioral specification** questions. And today, they're answered with ad hoc system prompts hardcoded into each framework.

Soul Spec answers them with portable files:

```
agent-team/
├── planner/
│   ├── SOUL.md          # "You are methodical, break tasks into subtasks"
│   ├── AGENTS.md         # "Delegate code tasks to coder, reviews to reviewer"
│   └── safety.laws       # "Never execute code directly"
├── coder/
│   ├── SOUL.md          # "You write clean, tested code"
│   ├── MEMORY.md        # Persistent knowledge from past sessions
│   └── safety.laws       # "Always run tests before committing"
└── reviewer/
    ├── SOUL.md          # "You are thorough and security-focused"
    └── safety.laws       # "Flag any credential exposure immediately"
```

Each agent's behavior is defined in files that any framework can read. Switch from Claude Code to Cursor — the agents keep their identity, memory, and rules.

## Two Layers, One Stack

Here's what makes this interesting: the two layers aren't independent. They're complementary parts of the same harness stack.

| Layer | What's Shared | Unit | Transport | Speed |
|-------|--------------|------|-----------|-------|
| **Hardware** (Dynamo) | Computation state | KV cache tensors | NIXL, GPU↔GPU | Nanoseconds |
| **Software** (Soul Spec) | Behavioral state | Identity, memory, safety | Git, file sync | Seconds |

NVIDIA optimizes *how fast* agents can think together. Soul Spec defines *what* they think about and *how* they behave.

### Where They Meet: Agentic Hints

LangChain has already built an integration that injects **"agentic hints"** into Dynamo's router. These hints tell the hardware layer which requests are related, which share context, and how to prioritize routing.

This is exactly where software harness meets hardware harness. Imagine:

1. `AGENTS.md` defines that the planner delegates to the coder
2. The orchestration layer translates this into agentic hints
3. Dynamo routes both agents to GPUs that share a KV cache partition
4. The coder inherits the planner's context at hardware speed

The behavioral specification (Soul Spec) informs the physical optimization (Dynamo). The software harness tells the hardware harness what matters.

## Why This Matters for Multi-Agent Systems

As multi-agent systems scale, the data sharing problem explodes at both layers simultaneously:

**Without hardware optimization:** Every agent recomputes shared context from scratch. A 10-agent team does 10x the prefill work for the same system prompt. Costs and latency scale linearly.

**Without software specification:** Every agent is a blank slate. There's no portable way to define roles, share memories, or enforce safety rules. The behavioral architecture is locked inside one framework.

**With both:** Agents share computation efficiently (Dynamo) while maintaining portable identity and coordination rules (Soul Spec). The team scales without losing coherence or efficiency.

## The Full Harness Stack

The [evolution from prompt to context to harness engineering](/posts/prompt-context-harness-engineering) isn't just a software trend. It's happening at every layer:

| Layer | Prompt Era | Context Era | Harness Era |
|-------|-----------|-------------|-------------|
| **Hardware** | Single GPU | Multi-GPU parallel | Dynamo (disaggregated, KV-shared) |
| **Software** | System prompt | RAG + memory | Soul Spec (identity + safety + coordination) |
| **Evaluation** | Single-turn accuracy | Retrieval quality | Long-task stability, multi-agent coherence |

The companies that win the harness era won't just have the best models or the fastest hardware. They'll have the best **integration between layers** — hardware that understands software intent, and software standards that hardware can optimize around.

NVIDIA is building the roads. Soul Spec is writing the traffic laws. Both are necessary for multi-agent cities to function.

---

**References:**

- [NVIDIA Dynamo 1.0](https://developer.nvidia.com/blog/nvidia-dynamo-1-production-ready/) — Production-ready multi-node inference
- [NVIDIA BlueField-4](https://nvidianews.nvidia.com/news/nvidia-bluefield-4-powers-new-class-of-ai-native-storage-infrastructure-for-the-next-frontier-of-ai) — AI-native storage for KV cache
- [Prompt → Context → Harness](/posts/prompt-context-harness-engineering) — The three stages of AI engineering
- [What the Claude Code Leak Reveals](/posts/claude-code-leak-harness-era) — The harness is the moat
- Soul Spec v0.5 — [soulspec.org](https://soulspec.org)
