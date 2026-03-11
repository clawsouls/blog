---
title: "Files Are the New API — But Who's Checking the Files?"
date: 2026-03-11T23:30:00+09:00
draft: false
tags: ["ai-agents", "filesystems", "soul-spec", "soulscan", "context-engineering"]
categories: ["Technical"]
description: "Everyone agrees AI agents need file-based persistent context. But nobody's talking about quality, security, or sync. Here's what's missing."
---

Everyone is suddenly talking about files.

LlamaIndex published "[Files Are All You Need](https://www.llamaindex.ai/blog/files-are-all-you-need)." LangChain wrote about [agents using filesystems for context engineering](https://blog.langchain.com/how-agents-can-use-filesystems-for-context-engineering/). Oracle — yes, *that* Oracle — compared [filesystems vs databases for agent memory](https://blogs.oracle.com/developers/comparing-file-systems-and-databases-for-effective-ai-agent-memory-management). Karpathy pointed out that Claude Code works *because* it runs on your machine, with your files, your context.

The consensus is clear: **file-based persistent context is the future of AI agents.**

We agree. We've been building on this assumption for months. But after watching this conversation unfold, we think the industry is celebrating the answer while ignoring three critical questions.

## The Problem Everyone Sees

LLM context windows are ephemeral. They're whiteboards that get erased after every session. Files solve this elegantly — write context to disk, read it back later. No API orchestration, no vendor lock-in, no complex infrastructure.

CLAUDE.md gives your agent project context. `.cursorrules` gives it coding preferences. `aboutme.md` gives it your identity. Simple, portable, powerful.

Anthropic took this further with Agent Skills (SKILL.md), now adopted by Microsoft, OpenAI, GitHub, and Cursor. Write a skill once, use it everywhere. The file format *is* the API.

This is genuinely exciting. But it's also incomplete.

## Question 1: What's Actually in These Files?

Here's something nobody's discussing: these files are **unsanitized inputs to language models.**

A CLAUDE.md with a hidden prompt injection can hijack your coding agent. A persona file with embedded instructions can exfiltrate data. A shared skill file from an unknown author can contain anything.

ETH Zürich's recent research found that context files can actually *decrease* task success rates and increase inference costs by 20%+. Their conclusion wasn't "don't use files" — it was that **poorly written context files make agents worse.**

The problem isn't files. It's that nobody's checking them.

This is why we built [SoulScan](https://clawsouls.ai/soulscan) — a static analysis engine for AI agent configuration files. 55+ security rules across prompt injection detection, PII exposure, credential leakage, and structural quality. Think ESLint, but for your agent's identity files.

If files are the new API, they need the same rigor we apply to any other API: validation, security scanning, and quality gates.

## Question 2: Which Files? Whose Standard?

Right now we have CLAUDE.md, AGENTS.md, `.cursorrules`, `copilot-instructions.md`, and more — all doing roughly the same thing with different names and no interoperability.

SKILL.md is a step forward for *capabilities*. But what about the agent's *identity*? Its personality, values, communication style, knowledge boundaries?

Today, if you switch from Cursor to Claude Code to Copilot, you rewrite your agent's persona from scratch. Your preferences, tone, expertise — none of it transfers.

[Soul Spec](https://docs.clawsouls.ai/spec) addresses this layer. It's an open specification for portable AI agent personas — a structured format (soul.json + SOUL.md + IDENTITY.md) that any framework can read. Write your agent's identity once, use it across every tool.

SKILL.md standardizes what agents *can do*. Soul Spec standardizes who agents *are*. They're complementary layers, and we need both.

## Question 3: What Happens When Files Live on Multiple Machines?

Here's the scenario nobody's solving yet: you have an AI agent on your laptop and another on your workstation. Both accumulate memory, preferences, and context in local files. How do you sync them?

Copy-paste? That breaks when both machines modify the same file. Cloud sync? That creates conflicts with no resolution strategy. Central database? That defeats the purpose of file-based local-first architecture.

This is a distributed systems problem disguised as a file management problem. And it gets harder when you add encryption (your agent's memory contains sensitive data) and multi-user collaboration (teams sharing agent context).

We built Swarm Memory to solve exactly this: git-based distributed sync with semantic conflict detection, end-to-end encryption (age), and LLM-assisted merge resolution. Your agent's files stay local, stay encrypted, and stay in sync.

*(Patent pending: KR 10-2026-0038525)*

## Files + Rigor = The Future

The industry is right that files are the answer. But files without standards are chaos. Files without security checks are attack vectors. Files without sync are silos.

The stack we think is needed:

1. **A portable identity standard** — so agent personas move between tools (Soul Spec)
2. **A security/quality scanner** — so files are validated before they reach the model (SoulScan)
3. **A distributed sync layer** — so files work across machines and teams (Swarm Memory)

The file is the interface. What we build *around* the file determines whether AI agents become reliable teammates or unpredictable liabilities.

---

*We're building this stack at [ClawSouls](https://clawsouls.ai). Soul Spec is open, SoulScan is free for open-source, and everything runs local-first. If you're working on similar problems, we'd love to hear from you.*
