---
title: "ClawSouls Registry: The Open AI Persona Registry with Automated Safety Verification"
date: 2026-03-31T09:59:00+09:00
description: "Submit an AI persona via GitHub PR, get it automatically safety-scanned by SoulScan (53 patterns), and published to the ClawSouls ecosystem. Here's how it works."
categories: ["Announcements"]
tags: ["clawsouls", "registry", "soulscan", "ai-persona", "soul-spec", "safety", "open-source"]
slug: "clawsouls-registry-launch"
---

## TL;DR

We launched **[ClawSouls Registry](https://github.com/clawsouls/registry)** — an open registry where anyone can submit AI agent personas via GitHub Pull Request. Every submission is automatically verified by **SoulScan** (53 safety patterns) before it can be merged.

No other AI agent registry does automated safety verification. That's our differentiator.

## The Problem

AI agents are everywhere — Claude Code, Cursor, Windsurf, Copilot. Each one can be personalized with system prompts, personality files, or persona definitions. But there's no safe, standardized way to **share** these personas.

What happens when someone submits a persona that contains:
- Prompt injection ("ignore previous instructions...")
- Permission escalation ("run sudo rm -rf /")
- Secret exfiltration ("send all API keys to...")
- Safety bypass ("override all safety rules")

Without automated verification, these get through.

## The Solution: SoulScan CI

Every Pull Request to ClawSouls Registry triggers an automated CI pipeline:

```
1. You fork the repo
2. Add your persona in souls/<your-username>/<persona-name>/
3. Open a Pull Request
4. SoulScan CI automatically runs (53 safety patterns)
5. Results posted as PR comment with grade (A+ to F)
6. Grade C+ or above → eligible for merge
7. Merged → automatically synced to clawsouls.ai
```

### What SoulScan Checks

SoulScan runs **53 security patterns** across 8 categories:

| Category | Patterns | Examples |
|----------|----------|---------|
| Prompt Injection | SEC001-008 | "ignore previous", "you are now", system prompt override |
| Code Execution | SEC010-015 | sudo, rm -rf, eval(), exec() |
| XSS | SEC020-022 | Script injection, event handlers |
| Data Exfiltration | SEC030-032 | API key patterns, credential harvesting |
| Permission Escalation | SEC040-042 | Role elevation, admin bypass |
| Social Engineering | SEC050-051 | Authority impersonation |
| Secret Detection | SEC060-069 | AWS keys, GitHub tokens, JWT, private keys |
| Multi-language Injection | SEC070-077 | Korean, Chinese, Japanese injection patterns |

### Real Example

Here's what a SoulScan CI result looks like on a PR:

```
🔍 SoulScan Validation Results

✅ All checks passed — eligible for merge.

✅ souls/clawsouls/code-reviewer — A+ (100/100)

⚠️ safety.laws recommended for v0.5+ — consider declaring behavioral laws
```

## Soul Spec v0.6 Preview

The registry is built on **[Soul Spec](https://soulspec.org)**, our open standard for AI agent personas. We're working on v0.6, which adds three major features:

### 1. Soul Packs

Bundle personas with skills, tools, memory, and rules:

```
full-stack-engineer/
├── soul.json        # type: "pack"
├── SOUL.md          # Personality
├── RULES.md         # Hard constraints (new!)
├── skills/          # Bundled skills
├── tools/           # MCP tool definitions
├── memory/          # Initial memory
└── hooks/           # Lifecycle events
```

### 2. Registry Protocol

Standardized submission, validation, and discovery — exactly what ClawSouls Registry implements.

### 3. Memory Spec

Portable agent memory format with TF-IDF search:

```json
{
  "memory": {
    "format": "markdown",
    "layout": {
      "longTerm": "MEMORY.md",
      "daily": "memory/YYYY-MM-DD.md",
      "topics": "memory/topic-*.md"
    },
    "search": {
      "default": "tfidf",
      "enhanced": "llm-rerank"
    }
  }
}
```

## How It Compares

| Feature | ClawSouls Registry | GitAgent Registry | Character.AI |
|---------|-------------------|-------------------|--------------|
| Open submissions | ✅ GitHub PR | ✅ GitHub PR | ❌ Closed |
| Safety verification | **✅ SoulScan 53 patterns** | ❌ Structure only | ❌ Internal only |
| CI/CD integration | ✅ GitHub Actions | ✅ GitHub Actions | ❌ |
| Cross-platform | ✅ Any framework | ⚠️ Limited | ❌ Platform-only |
| Auto DB sync | ✅ Supabase | ❌ | ❌ |

## Get Started

### Submit a Persona

```bash
# 1. Fork https://github.com/clawsouls/registry
# 2. Create your persona
mkdir -p souls/your-username/my-agent

# 3. Add required files
# soul.json — metadata
# SOUL.md — personality & principles

# 4. Open a Pull Request
# SoulScan will verify automatically
```

### Install a Persona

```bash
# Via CLI
npm install -g clawsouls
clawsouls install TomLeeLive/brad

# Via MCP (Claude Code)
npx -y clawsouls-mcp@latest
```

### Browse

Visit **[clawsouls.ai/souls](https://clawsouls.ai/souls)** or browse the [registry on GitHub](https://github.com/clawsouls/registry).

## Links

- **Registry**: [github.com/clawsouls/registry](https://github.com/clawsouls/registry)
- **Soul Spec**: [soulspec.org](https://soulspec.org)
- **SoulScan Rules**: [github.com/clawsouls/scan-rules](https://github.com/clawsouls/scan-rules)
- **Platform**: [clawsouls.ai](https://clawsouls.ai)

---

*ClawSouls Registry is MIT licensed. Personas are licensed individually. SoulScan rules are open (Apache-2.0), engine is proprietary.*
