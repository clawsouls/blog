---
title: "Ollama + OpenClaw + Soul Spec: 3-Minute Local AI Agent Setup"
date: 2026-02-28T16:30:00+09:00
draft: false
description: "Set up a local AI agent with a real personality in under 3 minutes. Ollama runs the LLM, OpenClaw gives it agency, and Soul Spec gives it a soul."
tags: [ollama, openclaw, soul-spec, tutorial, local-ai]
categories: [Guide]
---

## What You'll Build

A locally-running AI agent that doesn't just answer questions — it has a personality, opinions, and a consistent voice. No cloud API keys. No subscriptions. Everything runs on your machine.

The stack is three layers:

| Layer | What It Does | Think of It As |
|-------|-------------|----------------|
| **Ollama** | Runs the LLM on your hardware | The brain |
| **OpenClaw** | Agent framework — tools, memory, actions | The body |
| **Soul Spec** | Persona definition (SOUL.md) | The personality |

Without Soul Spec, your AI is a generic assistant. With it, your AI becomes *someone* — a sarcastic code reviewer, a patient teacher, a no-nonsense DevOps engineer.

---

## Before vs After

**Before (generic AI):**
> User: Review this PR.
> AI: Here are some suggestions for improving your code. Consider adding error handling...

**After (with `clawsouls/surgical-coder` soul):**
> User: Review this PR.
> AI: Three things. First — this `try/catch` is swallowing errors. That's a production incident waiting to happen. Second — the function name says `getData` but it's mutating state. Pick one. Third — nice use of early returns in `validateInput`. Ship that part.

Same model. Same hardware. Completely different interaction.

---

## Step 1: Install Ollama

Ollama is the LLM runtime. It downloads and runs open-source models (Llama, Mistral, Gemma, etc.) locally on your Mac, Linux, or Windows machine.

**Download from [ollama.com](https://ollama.com)** — you need version **0.17 or later**.

```bash
# Verify installation
ollama --version
# Should show 0.17.0 or higher
```

Ollama handles model management, GPU acceleration, and serving. Think of it as Docker, but for language models.

---

## Step 2: Launch OpenClaw

OpenClaw is an AI agent framework that runs on top of Ollama. It gives your LLM the ability to use tools, read files, browse the web, run commands, and maintain memory across sessions.

Launch it with a single command:

```bash
ollama launch openclaw
```

That's it. Ollama pulls the OpenClaw image (if not cached), starts the agent runtime, and opens a connection. You now have a working AI agent.

You can talk to it immediately — it works out of the box. But right now, it's a blank slate. It has no personality, no preferences, no consistent voice. It responds like any other AI assistant.

Let's fix that.

---

## Step 3: Install a Soul

Soul Spec is an open standard for defining AI personas. A soul is a `SOUL.md` file that describes who your AI is — its personality, communication style, values, expertise, and boundaries.

The [ClawSouls registry](https://clawsouls.ai) hosts community-created souls. Browse them at **clawsouls.ai/souls** to find one that fits your workflow.

Install a soul with one command:

```bash
npx clawsouls install clawsouls/brad
```

This downloads the `SOUL.md` file and places it in OpenClaw's configuration directory. The CLI handles everything — no manual file copying needed.

### Popular Souls

| Soul | Style | Best For |
|------|-------|----------|
| `clawsouls/surgical-coder` | Direct, precise, no fluff | Code review, architecture |
| `clawsouls/docs-writer` | Clear, structured, thorough | Documentation, READMEs |
| `clawsouls/test-sensei` | Methodical, coverage-obsessed | Testing, QA workflows |
| `clawsouls/brad` | Warm, proactive, organized | General assistant, daily co-pilot |

Want something custom? You can write your own `SOUL.md` — it's just markdown. The [Soul Spec](https://clawsouls.ai/spec) defines the format.

---

## Step 4: Restart OpenClaw

For the soul to take effect, restart OpenClaw:

```bash
# Stop the current session
# (Ctrl+C or close the terminal)

# Relaunch
ollama launch openclaw
```

OpenClaw reads `SOUL.md` on startup. Your agent now has a personality.

---

## The Full Flow (Copy-Paste Version)

```bash
# 1. Install Ollama from ollama.com, then:
ollama launch openclaw

# 2. Install a soul
npx clawsouls install clawsouls/brad

# 3. Restart OpenClaw
ollama launch openclaw

# Done. Your AI has a personality.
```

---

## How It Works Under the Hood

When OpenClaw starts, it reads the `SOUL.md` file and injects it into the system prompt. Every interaction is shaped by the persona definition.

The soul defines:

- **Identity** — Name, role, core traits
- **Communication style** — Tone, verbosity, formatting preferences
- **Expertise** — What the AI knows deeply vs. where it defers
- **Values** — What it prioritizes (accuracy? speed? teaching?)
- **Boundaries** — What it won't do

Because the soul is just a markdown file, you can version it with git, share it with your team, or fork someone else's and customize it.

---

## What's Next

- **Browse souls**: [clawsouls.ai/souls](https://clawsouls.ai/souls) — 80+ community personas
- **Create your own**: [clawsouls.ai/spec](https://clawsouls.ai/spec) — the Soul Spec format
- **Scan a soul**: [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan) — verify quality before installing
- **Share yours**: Publish to the registry with `npx clawsouls publish`

Your AI doesn't have to be generic. Give it a soul.
