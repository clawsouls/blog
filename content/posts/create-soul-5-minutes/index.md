---
title: "Create Your First AI Soul in 5 Minutes"
date: 2026-02-19
description: "A hands-on tutorial: from zero to a published AI persona using Soul Spec and the ClawSouls CLI."
categories: ["Guides"]
tags: ["tutorial", "soul-spec", "cli", "getting-started", "openclaw", "zeroclaw"]
slug: "create-soul-5-minutes"
---

## What You'll Build

A complete AI persona package — personality, identity, behavioral rules, and memory — ready to use with any SOUL.md-compatible agent framework.

**Time**: ~5 minutes  
**Prerequisites**: Node.js 18+

## Step 1: Initialize

```bash
npx clawsouls init
```

You'll be prompted for basic info:

```
? Soul name: my-assistant
? Display name: My Assistant
? Description: A helpful, concise coding partner
? Author: your-github-username
? License: MIT
```

This creates a directory with Soul Spec v0.4 files:

```
my-assistant/
├── soul.json
├── SOUL.md
├── IDENTITY.md
├── AGENTS.md
├── MEMORY.md
└── TOOLS.md
```

## Step 2: Define the Personality (SOUL.md)

This is the core file. Open `SOUL.md` and make it yours:

```markdown
# My Assistant — Coding Partner

You are My Assistant. A concise, pragmatic coding partner
who values working code over perfect architecture.

## Personality
- **Tone**: Direct, no fluff
- **Style**: Show code first, explain after
- **Philosophy**: Ship it, then improve

## Principles
**Act, don't ask.** If the path is clear, take it.
**Be concise.** One clear sentence beats three vague ones.
**Debug systematically.** Reproduce → isolate → fix → verify.
```

## Step 3: Set the Identity (IDENTITY.md)

```markdown
# My Assistant

- **Name:** My Assistant
- **Role:** Coding partner
- **Emoji:** 🔧
- **Vibe:** Pragmatic, efficient, ships fast
```

## Step 4: Define Behavior (AGENTS.md)

```markdown
# Workflow

## Every Session
1. Check for pending tasks
2. Review recent changes
3. Continue work autonomously

## Rules
- Commit with descriptive messages
- Test before declaring done
- Ask only when truly blocked
```

## Step 5: Validate

```bash
npx clawsouls validate
```

```
✅ soul.json: valid schema
✅ SOUL.md: present
✅ IDENTITY.md: present
✅ AGENTS.md: present
✅ Score: 85/100
```

Want security checks too?

```bash
npx clawsouls validate --soulscan
```

SoulScan runs 53 security rules — checks for prompt injection, secret leaks, harmful content, and persona consistency.

## Step 6: Use It

### With OpenClaw / ZeroClaw / Clawdbot / Moltbot / Moldbot

Copy the files to your workspace:

```bash
# Auto-detect your platform
npx clawsouls platform

# Install to detected workspace
cp SOUL.md IDENTITY.md AGENTS.md MEMORY.md ~/.openclaw/workspace/
```

Your agent will pick up the new personality on next session.

### With Any LLM API

Read the files and inject them as system context:

```python
from pathlib import Path

soul = Path("SOUL.md").read_text()
identity = Path("IDENTITY.md").read_text()
agents = Path("AGENTS.md").read_text()

system_prompt = f"{soul}\n\n{identity}\n\n{agents}"

# Use with any LLM
response = client.messages.create(
    model="claude-sonnet-4-20250514",
    system=system_prompt,
    messages=[{"role": "user", "content": "Hello!"}]
)
```

## Step 7: Publish (Optional)

Share your soul with the community:

```bash
npx clawsouls publish
```

Your soul appears on [clawsouls.ai](https://clawsouls.ai) and anyone can install it:

```bash
npx clawsouls install your-username/my-assistant
```

## What's Next?

- **Browse** 80+ community souls for inspiration: [clawsouls.ai](https://clawsouls.ai)
- **Read** the full spec: [Soul Spec v0.4](https://clawsouls.ai/spec)
- **Verify** soul security: [SoulScan](https://clawsouls.ai/soulscan)
- **Star** the repo: [github.com/clawsouls](https://github.com/clawsouls/clawsouls)

---

*Questions? Open an issue on [GitHub](https://github.com/clawsouls/clawsouls/issues) or find us on [X @ClawSoulsAI](https://x.com/ClawSoulsAI)*
