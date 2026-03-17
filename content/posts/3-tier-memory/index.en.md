---
title: "3-Tier Memory: How SoulClaw Agents Never Forget"
date: 2026-03-18T00:20:00+09:00
draft: false
tags: ["soulclaw", "memory", "ai-agents", "dag", "architecture"]
categories: ["Engineering"]
description: "How we built a lossless 3-tier memory system combining DAG conversation storage, semantic vector search, and passive memory extraction for AI agents that truly remember."
---

## The Problem: AI Agents with Amnesia

Every AI agent framework has the same dirty secret: **your agent forgets everything**.

Context windows are finite. When conversations exceed the limit, older messages get pruned — silently, permanently. That decision your agent made three weeks ago? The technical preference you mentioned last month? Gone.

We call this the **compaction problem**: summarization-based pruning loses nuance, and hard truncation loses everything.

## Our Solution: 3-Tier Memory Architecture

SoulClaw v2026.3.18 introduces a **3-Tier Memory System** that ensures your AI agent never loses a single conversation turn while keeping retrieval fast and relevant.

### Layer 1: DAG Lossless Store (New)

Every conversation message is stored in a **Directed Acyclic Graph** backed by SQLite:

```
Level 0: Raw messages (never deleted)
   ↓ Every 10 turns
Level 1: Chunk summaries (LLM-generated)
   ↓ Every 10 summaries
Level 2+: Higher-level summaries (recursive)
```

**Key design decisions:**

- **SQLite** — Zero-dependency, single-file database. No external services required.
- **FTS5 full-text search** — Instant keyword search across all conversation history.
- **Incremental storage** — Only new messages are written per turn; no duplicates.
- **Level-based hierarchy** — Raw messages at level 0, progressive summarization at higher levels.

The DAG structure means you can always trace back from a summary to the original messages that produced it. Nothing is lost.

### Layer 2: Semantic Vector Search (Existing)

SoulClaw's existing memory search engine uses **embedding models** (like `bge-m3`) to convert memory files into vector representations. When you search for "what was our decision about the database schema?", it finds semantically relevant memories even if the exact words don't match.

- **Hybrid search**: TF-IDF keyword matching + cosine similarity vector search
- **Local-first**: Runs on Ollama with `bge-m3`, no cloud API needed
- **File-based**: Indexes `MEMORY.md` and `memory/*.md` files

### Layer 3: Passive Memory Extraction (Existing)

Every 5 conversation turns, SoulClaw automatically analyzes the conversation and extracts important information:

- User preferences and personal facts
- Key decisions made during the session
- Deadlines and commitments
- Technical configurations
- Names and relationships

These are silently written to `memory/*.md` files, which Layer 2 then indexes for future retrieval.

## How They Work Together

```
User message → Agent processes → Response generated
                                       ↓
                              ┌────────┴────────┐
                              ↓                  ↓
                         DAG Store          Passive Memory
                    (raw messages →      (extract important
                     SQLite + FTS5)      facts → memory/*.md)
                              ↓                  ↓
                              └────────┬────────┘
                                       ↓
                              Semantic Vector Index
                              (embed memory files +
                               FTS5 DAG search)
                                       ↓
                              3-Tier Retrieval
                              on next memory_search
```

When `memory_search` is called:
1. **FTS5** searches the DAG for exact keyword matches across all history
2. **Semantic search** finds conceptually related memories from indexed files
3. **Passive memories** provide curated, high-signal facts

The combination gives you both **precision** (exact matches from FTS5) and **recall** (conceptual matches from vectors).

## The FTS5 Pipeline: How DAG Search Actually Works

When `memory_search` is invoked, the DAG FTS5 search runs **in parallel** with the standard vector search — zero additional latency:

```typescript
// Inside memory_search tool execution
const [standardResults, dagResults] = await Promise.all([
  manager.search(query, opts),       // Vector + file search
  searchDagFts5({ cfg, query }),     // DAG FTS5 search
]);
// Merge with deduplication
```

The DAG FTS5 results are converted to the same `MemorySearchResult` format and merged with standard results. Deduplication prevents the same information from appearing twice.

**Why this matters:** Before DAG, if you asked "what did we decide about the database schema last week?", the agent could only search memory files that happened to capture that decision. Now it searches the **actual conversation** where the decision was made — word for word.

Results from DAG are tagged with `citation: "dag:<id>"` so you can distinguish them from file-based memories:

```json
{
  "path": ".dag-memory.sqlite",
  "snippet": "[DAG] We decided to use PostgreSQL with jsonb columns for...",
  "source": "memory",
  "citation": "dag:dag_1710700000_abc123"
}
```

## Activation

The DAG store activates automatically when `memorySearch` is configured — same gate as passive memory. No additional setup required:

```json
{
  "agents": {
    "defaults": {
      "memorySearch": {
        "provider": "local"
      }
    }
  }
}
```

The SQLite database is stored at `<workspace>/.dag-memory.sqlite` and grows incrementally. For reference, ~50 conversation turns ≈ 300KB.

## What's Next

- **DAG-aware context retrieval**: Automatically inject relevant historical summaries into the context window
- **Cross-session memory**: Share memories between different agent sessions
- **Memory visualization**: Browse the DAG tree in the SoulClaw dashboard

## Try It

```bash
npm install -g soulclaw
soulclaw onboard
```

The 3-tier memory system activates automatically once you configure memory search during onboarding.

---

*SoulClaw is a Soul-powered AI agent framework. Learn more at [clawsouls.ai](https://clawsouls.ai).*
