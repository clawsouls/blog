---
title: "New Study Says AGENTS.md Makes AI Worse — But There's a Catch"
date: 2026-02-26T10:00:00+09:00
draft: false
description: "An ETH Zurich study found that AGENTS.md files reduce coding agent performance and increase costs by 20%. But the real lesson isn't to delete your context files — it's to write better ones."
categories: ["Research"]
tags: ["context-engineering", "agents-md", "soul-spec", "soulscan", "ai-agents", "research"]
slug: "agents-md-hurts-or-helps"
---

## The Headline That Scared the AI Community

A new paper from ETH Zurich just dropped a bomb: **AGENTS.md files make coding agents worse**.

["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988) by Gloaguen, Mündler, Müller, Raychev, and Vechev tested whether context files actually help AI coding agents complete real-world tasks. Their findings:

- **Task success rates dropped** when context files were provided
- **Inference costs increased by over 20%**
- Both LLM-generated *and* developer-written files caused problems
- Agents followed the instructions faithfully — but the instructions made them worse

The conclusion? Context files introduce "unnecessary requirements" that make tasks harder. The recommendation: **describe only minimal requirements**.

If you're using CLAUDE.md, AGENTS.md, or any repository-level context file, this might sound alarming. But before you delete everything — let's look at what's actually going on.

## Two Papers, Opposite Conclusions

Here's what makes this interesting. Just weeks earlier, another research team published a study on the *exact same topic* with the **opposite finding**.

[Lulla et al. (2601.20404)](https://arxiv.org/abs/2601.20404), under submission to ICSE JAWS, found that structured AGENTS.md files:

- **Reduced runtime by 28%**
- **Cut token usage by 16%**
- Improved agent efficiency measurably

So which is it? Do context files help or hurt?

## The Answer: It Depends on Quality

The contradiction dissolves when you look at what each study actually tested.

**Gloaguen et al.** tested two scenarios:
1. LLM-generated context files (following agent-developer guidelines)
2. Whatever developers had already committed to their repos

In both cases, the files contained **too much information** — architecture overviews, coding standards, testing requirements, style guides — all loaded into every task regardless of relevance.

**Lulla et al.** studied files that were more focused, examining how developers naturally structure their instructions and how agents respond to them.

The pattern is clear:

| Context Quality | Effect |
|---|---|
| Bloated, kitchen-sink files | ❌ Performance drops, costs rise |
| Focused, minimal requirements | ✅ Efficiency improves |
| LLM-generated without review | ❌ Worse than no context at all |
| Human-curated, task-relevant | ✅ Measurable gains |

**The problem isn't context files. The problem is bad context files.**

## Three Failure Modes

The ETH Zurich paper identified specific ways context files go wrong:

### 1. Unnecessary Exploration
When a context file says "always run the full test suite" or "review all related modules," the agent obediently explores far more code than needed. Energy wasted. Focus lost.

### 2. Redundant Information
Modern coding agents are already good at discovering project structure on their own. Telling them what they can already figure out doesn't help — it just adds noise to the context window.

### 3. Irrelevant Requirements
Architecture decisions, coding style preferences, deployment workflows — these may matter for some tasks but are pure noise for others. Loading everything into every task is like reading the entire employee handbook before answering a single email.

## What This Means for Soul Spec

Soul Spec was designed around exactly the principle this paper recommends: **minimal, structured, purpose-separated context**.

Here's how:

### Separation of Concerns
Soul Spec doesn't put everything in one file. Identity goes in `SOUL.md`. Coding rules go in `AGENTS.md`. Periodic health checks go in `HEARTBEAT.md`. Each file has a clear purpose, and agents load only what's relevant.

```
my-soul/
├── soul.json        # Metadata
├── SOUL.md          # Identity & personality (always loaded)
├── IDENTITY.md      # Name, role, avatar
├── AGENTS.md        # Coding-specific rules (loaded for dev tasks)
└── HEARTBEAT.md     # Periodic health checks
```

### Quality Over Quantity
The paper found that LLM-generated files perform *worse* than no file at all. This is why [SoulScan](https://clawsouls.ai/soulscan) exists — it checks persona packages against 53 security and quality patterns, catching bloated files, contradictory instructions, and content that would confuse rather than help.

### Minimal by Design
Soul Spec v0.5 explicitly encourages minimal core definitions. Your `SOUL.md` should contain identity, personality, and behavioral rules — not your entire project architecture. The spec's file structure enforces this separation naturally.

## The Real Lesson

Don't delete your context files. **Fix them.**

The ETH Zurich paper and the Lulla et al. paper aren't contradicting each other — they're measuring different things. Together, they tell a consistent story:

1. **Bad context is worse than no context** — stop auto-generating bloated files
2. **Good context measurably improves performance** — focused, human-curated instructions work
3. **Structure matters** — separate concerns, load only what's relevant
4. **Quality verification is essential** — you need something checking your context files before they go into production

This is what we've been building toward with Soul Spec and SoulScan. Not more context — *better* context.

---

## References

- Gloaguen et al., ["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988), arXiv:2602.11988, February 2026
- Lulla et al., ["On the Impact of AGENTS.md Files on the Efficiency of AI Coding Agents"](https://arxiv.org/abs/2601.20404), under submission to ICSE JAWS
- Mohsenimofidi et al., ["Context Engineering for AI Agents in Open-Source Software"](https://arxiv.org/abs/2510.21413), MSR 2026
- Baltes et al., ["Configuring Agentic AI Coding Tools: An Exploratory Study"](https://arxiv.org/abs/2602.14690), arXiv:2602.14690, February 2026

---

*Soul Spec is an open standard for AI agent personas. [Browse 80+ community souls →](https://clawsouls.ai/souls)*
