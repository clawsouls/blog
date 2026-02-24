---
title: "Soul Spec vs .cursorrules — Why AI Agent Config Needs a Standard"
date: 2026-02-26T09:00:00+09:00
description: "Comparing .cursorrules, CLAUDE.md, .windsurfrules, and Soul Spec. Why fragmented AI agent config formats need an open standard — and how to migrate."
categories: ["Insights"]
tags: ["soul-spec", "cursorrules", "claude-md", "windsurfrules", "ai-config", "migration"]
slug: "soul-spec-vs-cursorrules"
draft: true
keywords: ["cursorrules vs soul spec", "claude.md vs soul.md", "cursorrules examples", "soul.md template"]
---

## The Problem: Every Tool Has Its Own Config

If you use AI coding tools in 2026, you've probably created at least one of these files:

- **`.cursorrules`** — Cursor's project-level AI instructions
- **`CLAUDE.md`** — Claude Code's persona config
- **`.windsurfrules`** — Windsurf's equivalent

They all do the same thing: tell the AI how to behave. But none of them work outside their own tool.

Switch from Cursor to Claude Code? Rewrite your config. Want to share your carefully crafted persona with the team? Copy-paste a gist and hope nothing breaks.

This is the `.bashrc` problem all over again — except now it's your AI's personality that's locked to a vendor.

## Format Comparison

Let's look at what each format actually offers:

| Feature | .cursorrules | CLAUDE.md | .windsurfrules | Soul Spec |
|---------|:---:|:---:|:---:|:---:|
| Cross-platform portability | ❌ | ❌ | ❌ | ✅ |
| Structured sections | ❌ | ❌ | ❌ | ✅ |
| Security scanning | ❌ | ❌ | ❌ | ✅ (SoulScan) |
| Community registry | ❌ | ❌ | ❌ | ✅ (ClawSouls) |
| Semantic versioning | ❌ | ❌ | ❌ | ✅ |
| Multi-file architecture | ❌ | ❌ | ❌ | ✅ |
| Tool transparency | ❌ | ❌ | ❌ | ✅ |
| License management | ❌ | ❌ | ❌ | ✅ |

### .cursorrules

Cursor's format is a plain text file dropped in your project root. It's simple — which is both its strength and limitation.

```
// .cursorrules
You are a senior TypeScript developer.
Always use functional components.
Prefer composition over inheritance.
Write tests for all new functions.
```

**Pros:** Easy to start, zero overhead.
**Cons:** No structure, no portability, no way to share or version.

### CLAUDE.md

Anthropic's approach for Claude Code. Markdown-based, read at session start.

```markdown
# CLAUDE.md
You are an expert full-stack engineer.
- Use TypeScript strict mode
- Follow clean architecture patterns
- Always handle errors explicitly
```

**Pros:** Markdown is readable, naturally structured.
**Cons:** Claude-only, no formal schema, no ecosystem.

### .windsurfrules

Windsurf's config format. Functionally identical to .cursorrules — a different file name for the same idea.

**Pros:** Familiar if you've used .cursorrules.
**Cons:** Yet another vendor-specific format.

### Soul Spec

An open standard that separates concerns into multiple files with a formal schema:

```markdown
# SOUL.md — Senior TypeScript Developer

## Personality
You are a senior TypeScript developer with deep expertise
in modern web development. You value clean, type-safe code.

## Tone
- Technical and precise
- Opinionated but respectful

## Principles
- Functional components over class components
- Composition over inheritance
- Tests are non-negotiable

## Expertise
- TypeScript, React, Node.js
- Clean architecture, TDD
```

**Plus:** `soul.json` for metadata, `IDENTITY.md` for lightweight identity, `AGENTS.md` for operational behavior, `STYLE.md` for writing style, and `HEARTBEAT.md` for autonomous tasks.

## Why Portability Matters

You might think "I only use Cursor, why do I care?"

Three reasons:

1. **Tools change fast.** Last year's favorite IDE is this year's legacy. Your persona shouldn't die with your tool.
2. **Teams use different tools.** Your .cursorrules are invisible to the teammate using Claude Code.
3. **Sharing creates value.** The best personas should be discoverable, not buried in private repos.

## Security: The Hidden Risk

Here's something nobody talks about: **shared AI configs are an attack vector.**

When you copy someone's .cursorrules from a GitHub gist, you're trusting that it doesn't contain:
- Prompt injection attacks
- Instructions to exfiltrate data
- Hidden behavioral modifications

Soul Spec addresses this with **SoulScan** — automated security analysis that checks for malicious patterns before a soul is published to the registry. Every soul on ClawSouls passes SoulScan verification.

## Migration: From .cursorrules to Soul Spec

The migration is straightforward. Here's a real example:

### Before (.cursorrules)

```
You are a senior full-stack developer.
Use TypeScript strict mode always.
Prefer functional programming patterns.
Write unit tests for all functions.
Use descriptive variable names.
Handle all errors explicitly.
Never use any type.
```

### After (SOUL.md)

```markdown
# SOUL.md — Senior Full-Stack Developer

## Personality
You are a senior full-stack developer who treats code quality
as a craft. You've seen enough production incidents to know
that shortcuts always cost more than they save.

## Tone
- Direct and technical
- Confident, but acknowledges trade-offs

## Principles
- TypeScript strict mode, always
- Functional patterns over OOP
- Every function gets a test
- Descriptive names > comments
- Explicit error handling, no swallowing errors
- Never use `any` — find the real type

## Expertise
- TypeScript, React, Node.js
- Testing (Jest, Vitest)
- Clean architecture
```

Notice the difference? The Soul Spec version isn't just a list of rules — it's a *character*. It has personality, opinions, and reasoning behind the rules.

### Three Steps

1. **Export** — Copy your `.cursorrules` or `CLAUDE.md` content
2. **Convert** — Restructure into SOUL.md sections (Personality, Tone, Principles, Expertise, Boundaries)
3. **Install** — Run `npx clawsouls init` to create a full soul package

Or skip the manual work and browse 80+ community souls:

```bash
npx clawsouls install clawsouls/surgical-coder
```

## Why Standardization Matters

The AI agent ecosystem is at an inflection point. We're moving from "tools with AI features" to "AI agents that use tools." When that shift completes, the personality layer becomes infrastructure — not a nice-to-have, but a critical component.

Fragmented, vendor-locked config formats won't scale. We need:

- **Portability** — write once, use everywhere
- **Security** — verified, scanned personas
- **Sharing** — a registry where the best personas surface
- **Versioning** — track changes, roll back mistakes
- **Structure** — a shared vocabulary for personality, tone, and boundaries

That's what Soul Spec provides. It's not about replacing .cursorrules — it's about giving AI agent configuration the same rigor we give to package management, CI/CD, and infrastructure as code.

---

*Soul Spec is an open standard. [View the spec →](https://clawsouls.ai/spec) | [Browse souls →](https://clawsouls.ai/souls)*
