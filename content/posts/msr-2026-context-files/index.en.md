---
title: "466 Repos Studied — AI Context Files Have No Standard Yet"
date: 2026-02-24T10:00:00+09:00
draft: true
description: "A new MSR 2026 paper analyzed AGENTS.md files across 466 open-source projects. The finding: no established structure, wild variation in style, and constant evolution. Soul Spec was designed to solve exactly this."
categories: ["Research"]
tags: ["context-engineering", "agents-md", "soul-spec", "msr-2026", "ai-agents", "research"]
slug: "msr-2026-context-files"
---

## Researchers Studied How Developers Talk to AI Agents

A team from Heidelberg University, University of Bamberg, and Singapore Management University just published ["Context Engineering for AI Agents in Open-Source Software"](https://arxiv.org/abs/2510.21413) — the first systematic study of AI context files (AGENTS.md, CLAUDE.md, etc.) in real open-source projects. It will be presented at [MSR 2026](https://2026.msrconf.org/) in Rio de Janeiro this April.

They mined **10,000 GitHub repositories** and found **466** that had adopted at least one AI context file format. Then they dove deep into the content, structure, and evolution of AGENTS.md files specifically.

The findings are striking — and they validate a problem we've been working on since day one.

## The Key Findings

### 1. Only 5% Adoption — But Growing Fast

Of 10,000 mature, popular repositories, only 466 had AI context files. We're still early. But the trajectory is clear: developers are realizing that **what context you give the model matters more than how you prompt it**.

### 2. No Established Content Structure

This is the paper's most important finding. From the abstract:

> *"Our findings indicate that there is no established content structure yet and that there is a lot of variation in terms of how context is provided."*

Every project reinvents the wheel. Some AGENTS.md files are 30 lines; others exceed 1,000. The researchers identified **14 categories** of information developers commonly include:

| Category | Frequency |
|---|---|
| Conventions (coding standards) | 50 |
| Contribution guidelines | 48 |
| Architecture / structure | 47 |
| Build commands | 40 |
| Goals / purposes | 32 |
| Test execution | 32 |
| Metadata | 29 |
| Test strategy | 24 |
| Tech stack | 15 |
| Setup | 11 |
| References | 9 |
| Troubleshooting | 8 |
| Patterns / examples | 8 |
| Security | 6 |

But there's no agreement on **which** of these to include, **how** to organize them, or **what format** to use.

### 3. Five Styles of Writing for AI

The researchers found developers use five distinct styles when writing instructions for AI agents:

- **Descriptive**: "This project uses the Linux Kernel Style Guideline."
- **Prescriptive**: "Follow the existing code style and conventions."
- **Prohibitive**: "Never commit directly to the main branch."
- **Explanatory**: "Avoid hard-coded waits to prevent timing issues in CI environments."
- **Conditional**: "If you need to use reflection, use ReflectionUtils APIs."

This mirrors the kind of variation you'd see in the early days of any documentation format — before conventions settle.

### 4. Constant Evolution

Half of the AGENTS.md files (50%) were never modified after creation. But the other half underwent active iteration. The most common changes were **adding instructions** and **modifying existing instructions** — developers are fine-tuning how they talk to their AI agents, treating context files as living documents.

## Why This Matters for Soul Spec

The MSR paper essentially describes the problem that Soul Spec was designed to solve.

### The Gap: No Structure

The paper finds "no established content structure" for AI context files. Soul Spec provides exactly that — a **named-file convention** where each file has a clear role:

| Soul Spec File | Purpose | MSR Category Mapping |
|---|---|---|
| `SOUL.md` | Persona, tone, principles | Goals/purposes, Conventions |
| `AGENTS.md` | Workflow, tools, safety rules | Conventions, Contribution guidelines |
| `IDENTITY.md` | Name, avatar, metadata | Metadata |
| `MEMORY.md` | Learned context, preferences | — (not in MSR categories) |
| `USER.md` | Human context | — (not in MSR categories) |

Soul Spec doesn't compete with AGENTS.md — it **complements** it. AGENTS.md covers the *technical* context (build commands, test strategy, architecture). Soul Spec covers the *behavioral* context (who the agent is, how it communicates, what it remembers).

### The Gap: No Persona Layer

The MSR study focused on coding agents, where context is mostly technical. But as AI agents expand beyond coding — into customer service, personal assistance, creative work — the **persona layer** becomes critical.

None of the 14 categories in the MSR study address:
- **Who** the agent is (personality, tone, values)
- **How** it relates to the human (communication style, language preferences)
- **What** it remembers across sessions (persistent memory)

These are the exact files Soul Spec defines. The MSR paper's framework stops where Soul Spec begins.

### The Gap: No Cross-Tool Standard

The paper notes that different tools use different formats (CLAUDE.md for Claude Code, copilot-instructions.md for Copilot, AGENTS.md as an emerging convention). Soul Spec is designed to be **framework-agnostic** — the same soul.json + markdown files work across OpenClaw, Claude Code, Cursor, Windsurf, and more.

## What the Paper Gets Right

A few quotes that resonated:

> *"Software developers are now writing and maintaining documentation for machines."*

This is the fundamental shift. Documentation was always for humans. Now it's for AI agents too. And the requirements are different — AI needs structure, consistency, and explicit boundaries that humans can infer from culture and context.

> *"OSS repositories serve as natural laboratories for studying how developers experiment with 'talking' to agent-based AI tools."*

Exactly. Every AGENTS.md file is an experiment in context engineering. Soul Spec aims to **reduce the experimentation cost** by providing a proven starting structure.

> *"Research should also investigate the co-evolution of source code and related AI context files."*

This is the next frontier. When you change your code, do you update your AGENTS.md? When you update AGENTS.md, does agent behavior improve? Soul Spec's versioning (currently v0.4) is designed to evolve with these questions.

## The Bigger Picture

The MSR paper confirms what practitioners have been discovering through trial and error: **context engineering is a new discipline**, and we don't have established best practices yet.

Soul Spec is our answer — not a rigid schema, but a **minimal convention** that gives structure to the chaos while staying flexible enough for any project. It's the difference between every developer inventing their own config file format vs. having a `.gitignore` convention that everyone understands.

The paper's 466 projects are just the beginning. As AI agents become standard development tools, context files will become as fundamental as README files. The question is whether they'll remain fragmented across tools and styles, or converge toward shared conventions.

We're betting on convergence.

---

*The paper ["Context Engineering for AI Agents in Open-Source Software"](https://arxiv.org/abs/2510.21413) by Mohsenimofidi et al. will be presented at MSR 2026 in Rio de Janeiro. The supplementary data is available at [doi:10.5281/zenodo.17428770](https://doi.org/10.5281/zenodo.17428770).*

*Soul Spec is an open specification for AI agent personas. Learn more at [clawsouls.ai/spec](https://clawsouls.ai/spec).*
