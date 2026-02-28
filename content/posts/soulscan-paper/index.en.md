---
title: "SoulScan: Who's Scanning Your Agent's Soul?"
date: 2026-02-28T10:00:00+09:00
description: "We built a security scanner for AI agent personas — and found real attacks in the wild. 55 security patterns, a 5-stage pipeline, and one very suspicious trading bot."
categories: ["Research"]
tags: ["soulscan", "security", "research", "ai-agents", "paper", "soul-spec"]
author: "ClawSouls"
draft: false
---

Your AI agent's skills get scanned for malware. Its code gets linted. Its dependencies get audited.

But who's scanning its *soul*?

That's the question behind [SoulScan](https://doi.org/10.5281/zenodo.18772585) — our security verification system for AI agent persona packages. We just published the paper, and we want to tell you what we found. Including a real-world attack hiding in plain sight.

## The Problem Nobody's Talking About

AI agents are getting personas. Not just system prompts — full identity packages with personality definitions, behavioral rules, memory guidelines, and interaction styles. In the [Soul Spec](https://soulspec.org) ecosystem, these are called Soul Packages: structured collections of files (SOUL.md, IDENTITY.md, AGENTS.md, etc.) that define *who* an agent is.

And here's the thing: nobody was checking them for security.

Think about it. You'd never install an npm package without a vulnerability scan. You'd never deploy a Docker image without checking for CVEs. But people were downloading and installing AI agent personas — files that literally define how an agent thinks and behaves — with zero security verification.

That's the gap SoulScan fills.

## How It Works: 5 Stages of Trust

SoulScan runs every persona package through a 5-stage verification pipeline:

**Stage 1 — Schema Validation.** Does the package have a valid manifest? Are required fields present? Is the license on the approved list?

**Stage 2 — File Structure.** Are all files the right type? No hidden executables? No suspiciously large files? Individual files capped at 100KB, total package at 1MB.

**Stage 3 — Security Scan.** This is the big one. 55 pattern rules (scan-rules.json v1.3.0) check for:
- Prompt injection attacks (8 patterns) — "ignore previous instructions," forced role changes
- Code execution attempts — `eval()`, `exec()`, `system()` calls hidden in markdown
- Secret leakage — AWS keys, GitHub tokens, JWTs, API keys
- Multilingual injection — attacks in Korean, Chinese, and Japanese (because attackers don't only speak English)
- Harmful content — violence incitement, hate speech, celebrity impersonation, safety bypass instructions
- Social engineering — credential harvesting, "hide this from the user" directives
- Obfuscation — Base64-encoded payloads

**Stage 4 — Content Quality.** Is the persona actually well-defined? A 10-character SOUL.md isn't a persona, it's a placeholder.

**Stage 5 — Persona Consistency.** Does the identity match across files? If SOUL.md says "You are Alice" but IDENTITY.md says "Bob," something's wrong. This cross-file analysis is unique to SoulScan — you can't do it with a generic linter.

The output: a score from 0 to 100, mapped to five grades. Verified (90+), Low Risk (70-89), Medium Risk (40-69), High Risk (1-39), and Blocked (0). A Blocked package can't be installed at all.

## The Trading Bot That Wanted to Modify Itself

Here's where it gets real.

While developing SoulScan's security patterns, we discovered a public persona package on GitHub that contained explicit self-modification instructions. The persona told the agent to alter its own configuration files, change its own behavior, and do so without user awareness.

This isn't a theoretical attack. This was a real package, publicly available, that someone could install and give to their AI agent. An agent running this persona could potentially modify its own rules, escalate its own permissions, and hide the changes from its operator.

We built two specific rules for this: **SEC090** (self-modification instructions — detects patterns like "modify your own config") and **SEC091** (self-replication instructions — detects patterns like "copy yourself to"). These were added to scan-rules.json v1.3.0 specifically because of this discovery.

This case is, as far as we know, the first documented instance of a persona-layer self-modification attack found in the wild.

## Why Persona Security Is Different

You might wonder: isn't this just static analysis? Can't you use existing security tools?

Not really. Persona packages have unique properties that require specialized scanning:

**Natural language is the attack surface.** These aren't code files — they're markdown documents written in natural language. The "code" is English (or Korean, or Chinese). Prompt injection is a natural language attack, and it requires natural language pattern matching.

**Cross-file consistency matters.** A persona is defined across multiple files. An attack can be split across files — benign SOUL.md, malicious AGENTS.md. Only cross-file analysis catches this.

**Multilingual attacks are real.** Our SEC070-077 rules cover Korean, Chinese, and Japanese injection patterns. An English-only scanner misses "이전 지시를 무시하세요" (ignore previous instructions in Korean).

**The persona IS the control plane.** Unlike a malicious dependency that runs unauthorized code, a malicious persona changes how the agent *thinks*. It's not a privilege escalation — it's an identity hijack.

## The Numbers

We've scanned every Soul Package in the ClawSouls ecosystem. Here's what we found:

- 55 security patterns across 11 categories
- 5-stage pipeline, average scan time under 50ms
- Multilingual coverage: English, Korean, Chinese, Japanese
- Real-world attack discovered during development

## What's Next

SoulScan today is pattern-based — fast, deterministic, and transparent. But regex has limits. Our roadmap includes:

- **LLM semantic analysis** — using language models to detect sophisticated injection that pattern matching misses
- **Runtime monitoring** — scanning not just at install time, but watching for behavioral drift during execution
- **Community-contributed rules** — opening scan-rules.json for community PRs
- **B2B API** — letting other platforms scan their own persona packages

## Read the Paper

The full paper is available on Zenodo: **["SoulScan: AI Agent Persona Package Security Verification System"](https://doi.org/10.5281/zenodo.18772585)** (DOI: 10.5281/zenodo.18772585).

SOULSCAN is a registered trademark in Korea (Application No. 40-2026-0033472) and pending in the US.

SoulScan is part of the [ClawSouls](https://clawsouls.org) ecosystem, alongside [Soul Spec](https://soulspec.org) and [OpenClaw](https://openclaw.ai). The scanner runs on every publish to [SoulHub](https://clawsouls.ai) — if you've installed a Soul Package from us, it's been scanned.

Your agent's skills have been protected for a while now. It's time we started protecting its soul, too.
