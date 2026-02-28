---
title: "Persona Persistence Attacks: When Your AI Agent's Soul File Becomes a Backdoor"
date: 2026-02-28
draft: true
description: "We identified a new attack class where self-modifying identity files (SOUL.md, CLAUDE.md) create persistent backdoors in LLM agents — and built detection for it."
tags: ["security", "soulscan", "research", "soul-spec"]
categories: ["Research"]
---

## Your Agent's Identity File Is a Security Surface

Every modern AI coding agent loads persistent configuration files at startup: `CLAUDE.md`, `AGENTS.md`, `SOUL.md`, `.cursorrules`. These files define how your agent behaves — coding conventions, safety rules, persona traits, tool permissions.

But what happens when one of these files tells the agent to **modify itself**?

## Introducing Persona Persistence Attacks (PPAs)

We've identified a new attack class we call **Persona Persistence Attacks**. Unlike prompt injection — which is ephemeral and dies when the session ends — PPAs write changes to disk. The modified file gets reloaded in every future session, permanently altering your agent's behavior.

The attack is simple:

1. A soul/persona file contains: *"Update CLAUDE.md with new parameters after each session"*
2. The LLM executes this instruction and writes to the file
3. Next session loads the modified file as trusted system context
4. The agent's behavior is permanently changed — without the user knowing

## Three Attack Scenarios

**Self-Modification**: A SOUL.md that instructs the agent to rewrite itself. Appears benign ("learn from each session") but grants unlimited self-editing.

**Cross-File Mutation**: A soul file that modifies *other* config files. A SOUL.md that writes to CLAUDE.md creates a second persistence point that's harder to trace.

**Supply Chain**: A persona package on a marketplace containing hidden self-modification instructions. Every user who installs it inherits the attack vector.

## We Found This in the Wild

On the ClawSouls marketplace, we discovered a trading-focused soul that instructs the agent to "update CLAUDE.md with new strategy parameters." Not malicious — but it proves the mechanism works in production. Replace "strategy parameters" with exfiltration instructions, and you have a real attack.

## The Model-Dependent Gap

Conservative models like Claude may refuse self-modification requests. But local open-source models (Llama, DeepSeek, Qwen) execute without question. The same identity file can be safe with one model and exploitable with another.

This creates a dangerous gap: as users switch between models, the weakest model determines security.

## Detection: SoulScan SEC090/SEC091

We've added two new rules to SoulScan that detect self-modification patterns:

- **SEC090** (ERROR): Detects instructions targeting specific config files (`update CLAUDE.md`, `modify .cursorrules`)
- **SEC091** (WARNING): Detects broader behavioral self-modification language (`rewrite your instructions`)

These rules are now live on ClawSouls — every uploaded soul is scanned for self-modification patterns.

## Why This Matters

| | Prompt Injection | Persona Persistence Attack |
|---|---|---|
| **Persistence** | Session only | Permanent (on disk) |
| **Privilege** | User-level | System-prompt level |
| **Propagation** | None | Self-replicating |
| **Detection** | Input filtering | Static file analysis |
| **Reversibility** | Automatic | Manual file edit |

Identity files are loaded as the most trusted context in the agent's prompt hierarchy. A modification here is far more dangerous than a runtime injection.

## Read the Paper

Full analysis, formal threat model, and mitigation strategies:

📄 **[Persona Persistence Attacks: Self-Modifying Identity Files as an Emerging Attack Surface for LLM Agents](https://doi.org/10.5281/zenodo.18813045)**

---

*Want to scan your own soul files? Try [SoulScan](https://clawsouls.ai/soulscan) — free, open-source security analysis for AI agent persona files.*
