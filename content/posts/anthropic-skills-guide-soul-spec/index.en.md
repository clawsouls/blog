---
title: "Anthropic Publishes Official Skills Guide — How It Compares to Soul Spec"
date: 2026-02-24T20:30:00+09:00
draft: false
tags: ["anthropic", "skills", "soul-spec", "agents", "standardization"]
categories: ["Analysis"]
description: "Anthropic released a complete guide to building Skills for Claude. Here's how SKILL.md differs from Soul Spec's soul.json — and why you need both."
---

Anthropic just released "The Complete Guide to Building Skills for Claude" — a 33-page document defining the official standard for packaging **workflow knowledge** into Claude agents.

Soul Spec, created by ClawSouls, defines an agent's **identity and persona**. The names sound similar, but they solve different problems.

## What Skills Do

A skill is a folder:

```
your-skill/
├── SKILL.md          # Required — workflow instructions
├── scripts/          # Optional — executable code
├── references/       # Optional — documentation
└── assets/           # Optional — templates, icons
```

The YAML frontmatter in `SKILL.md` is the key. Claude reads this metadata to decide when to load each skill.

```yaml
---
name: sprint-planner
description: Manages Linear project workflows. Use when user mentions "sprint" or "create tasks".
---
```

**Progressive Disclosure** in three levels minimizes token usage:
1. **Frontmatter** — always in system prompt (decides when to trigger)
2. **SKILL.md body** — loaded when relevant (actual instructions)
3. **Linked files** — explored only when needed (detailed references)

## What Soul Spec Does

Soul Spec defines an agent's **identity**:

```
my-agent/
├── soul.json         # Metadata (name, description, tags)
├── SOUL.md           # Personality, tone, principles
├── IDENTITY.md       # Basic information
└── USER.md           # User context
```

If Skills answer "how to do it," Soul Spec answers "who does it."

## Comparison

| | Skills (SKILL.md) | Soul Spec (soul.json) |
|---|---|---|
| **Purpose** | Workflow knowledge | Persona & identity |
| **Core question** | "How to do it?" | "Who am I?" |
| **Trigger** | On user request | Always active |
| **Multiple** | Many skills at once | One persona |
| **MCP** | Direct support | Indirect (via skills) |
| **Standard** | Anthropic-proprietary | Open spec (LLM-agnostic) |

## Why You Need Both

Anthropic describes Skills with a **kitchen analogy**:
- MCP = professional kitchen (tools, ingredients, equipment)
- Skills = recipes (step-by-step instructions)

Add Soul Spec to complete the picture:
- **Soul = the chef** (experience, style, philosophy)

Same recipe, different chef, different experience. A customer onboarding workflow executed by "friendly, thorough Brad" feels different from "fast, efficient Kira."

## Notable Points from the Guide

**1. Skills API**
- `/v1/skills` endpoint for programmatic management
- `container.skills` parameter in Messages API
- Agent SDK integration

**2. Organization-wide Deployment**
- Admins can deploy skills workspace-wide (shipped Dec 2025)
- Automatic updates, centralized management

**3. Five Patterns**
- Sequential Workflow Orchestration
- Multi-MCP Coordination
- Iterative Refinement
- Context-aware Tool Selection
- Domain-specific Intelligence

**4. Open Standard Declaration**
> "We've published Agent Skills as an open standard. Like MCP, we believe skills should be portable across tools and platforms."

Skills aims for open portability — the same direction Soul Spec has pursued from day one.

## In Practice: Skills + Soul Spec

```
my-agent/
├── soul.json          # Agent identity
├── SOUL.md            # Personality and principles
├── IDENTITY.md        # Basic info
├── skills/
│   ├── sprint-planner/
│   │   └── SKILL.md   # Sprint planning workflow
│   └── code-review/
│       └── SKILL.md   # Code review workflow
```

The Soul defines *who*. Skills define *what*. Together, they form the **complete agent package**.

## What This Means

Anthropic formalizing Skills into a 33-page guide signals a maturing agent ecosystem:

- **MCP** → how agents connect to the world (2024)
- **Skills** → how agents work (2025-2026)
- **Soul Spec** → how agents exist

All three layers aim for open standards. They solve different problems. Not competition — completion.

---

*Explore Soul Spec at [clawsouls.ai](https://clawsouls.ai). A guide for using Skills alongside Soul Spec is coming soon.*
