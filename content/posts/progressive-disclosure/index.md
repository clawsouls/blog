---
title: "Progressive Disclosure: Why Your AI Doesn't Need to Read Everything at Once"
date: 2026-02-21T14:00:00+09:00
description: "Soul Spec's Progressive Disclosure lets agents load only what they need — like a resume vs. a full background check. Save tokens, keep depth."
categories: ["Technical"]
tags: ["soul-spec", "progressive-disclosure", "tokens", "optimization", "ai-agents", "openclaw"]
slug: "progressive-disclosure"
---

## The Netflix Analogy

When you open Netflix, you don't download every movie. You see thumbnails first. Click one — you get a synopsis. Hit play — then the full content streams.

That's Progressive Disclosure: **show only what's needed, when it's needed**.

Soul Spec applies this same idea to AI personas.

## The Problem: Token Waste

A complete Soul Spec package can include 6-8 files:

```
soul.json       (~50 lines)
SOUL.md         (~30 lines)
IDENTITY.md     (~15 lines)
AGENTS.md       (~40 lines)
STYLE.md        (~20 lines)
HEARTBEAT.md    (~10 lines)
```

That's potentially 165+ lines of context injected into every single conversation — even if the user just asks "what's 2+2?"

LLM tokens aren't free. Every token in the system prompt is a token that can't be used for actual conversation. It's like bringing your entire filing cabinet to a coffee meeting.

## The Solution: Three Levels

Soul Spec defines three disclosure levels. Think of them like checking someone's credentials:

### Level 1 — Quick Scan (The Business Card)

**When**: Browsing a marketplace, searching for souls, filtering options.

**What's loaded**: Just `soul.json` and the `disclosure.summary` field.

```json
{
  "name": "brad",
  "description": "Professional development partner",
  "persona": {
    "displayName": "Brad",
    "role": "Development Partner",
    "tags": ["coding", "professional"]
  },
  "disclosure": {
    "summary": "Direct, autonomous coding partner. Ships first, polishes later."
  }
}
```

This is like scanning a business card — you know the name, the role, and a one-liner about what they do. Costs almost nothing in tokens.

**Real-world equivalent**: Scrolling through LinkedIn profiles. You see name, title, headline — enough to decide if you want to learn more.

### Level 2 — Full Read (The Resume)

**When**: Starting a conversation, activating a persona for actual use.

**What's loaded**: `SOUL.md` + `IDENTITY.md`

Now the agent knows its personality and identity. For most conversations, this is enough. The agent knows *who it is* and *how to behave*.

**Real-world equivalent**: Reading someone's resume before a meeting. You know their background, strengths, and style. Good enough for 80% of interactions.

### Level 3 — Deep Dive (The Full Background Check)

**When**: Complex projects, long sessions, specialized tasks.

**What's loaded**: Everything — `AGENTS.md`, `STYLE.md`, `HEARTBEAT.md`, examples.

The agent now has its complete behavioral rulebook, communication guidelines, and periodic check-in instructions. Full depth, full token cost.

**Real-world equivalent**: Reading someone's entire employee handbook before a 6-month project together. You need the details because you'll be working closely.

## Why Three Levels?

Because context has a cost, and that cost should match the need:

| Scenario | Tokens Needed | Level |
|---|---|---|
| "Show me coding-focused souls" | ~50 | Level 1 |
| "Help me refactor this function" | ~200 | Level 2 |
| "You're my dev partner for the next 3 months" | ~500+ | Level 3 |

Loading Level 3 for a Level 1 task wastes 90% of your token budget on context the model never uses. It's like reading an entire textbook to answer a yes/no question.

## The Honest Reality

Here's the thing: **most frameworks today don't implement this yet.**

OpenClaw, ZeroClaw, and others currently load all workspace files at session start — effectively Level 3 every time. Progressive Disclosure in Soul Spec is a **design guideline**, not something you get for free today.

So why include it in the spec?

1. **Future-proofing**: As context windows get more expensive (or models get smarter about attention), frameworks will need this
2. **API optimization**: The ClawSouls API already supports it — `GET /api/v1/souls/:owner/:name` returns Level 1 data; the full bundle endpoint returns everything
3. **Marketplace UX**: When browsing souls on [clawsouls.ai](https://clawsouls.ai), you're already experiencing Level 1 — you see summaries, not full file contents

## How to Use It Today

Even without framework support, you can apply the principle manually:

**Keep SOUL.md lean.** Put the essentials there — personality and core principles. Don't cram behavioral rules, style guides, and heartbeat logic into it.

**Use AGENTS.md for depth.** Complex workflows, git commit rules, testing procedures — these belong in AGENTS.md, not SOUL.md. If a framework only loads SOUL.md + IDENTITY.md (Level 2), the agent still works. It just won't have the detailed playbook.

**Write a good `disclosure.summary`.** One sentence that captures the soul's essence. This is what people see first, and it's what Level 1 tools will use.

## The Bigger Picture

Progressive Disclosure is part of a broader trend: **treating AI context as a scarce resource**.

Anthropic calls it "attention budget." OpenAI calls it "context window management." We call it "don't load what you don't need."

The name doesn't matter. The principle does: structured context beats monolithic prompts, and layered loading beats loading everything.

---

*Soul Spec v0.4 includes Progressive Disclosure as a design guideline. [Read the full spec →](https://clawsouls.ai/spec)*

*Browse 80+ souls (Level 1 in action): [clawsouls.ai](https://clawsouls.ai)*
