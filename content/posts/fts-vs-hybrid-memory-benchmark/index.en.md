---
title: "FTS vs Hybrid Memory Search: A Real-World Benchmark"
date: 2026-03-25T09:00:00+09:00
draft: false
tags: ["memory", "benchmark", "fts", "semantic-search", "hybrid", "soulclaw", "ai-agents"]
categories: ["Research"]
summary: "We benchmarked full-text search vs hybrid (FTS + semantic) memory retrieval using 30 questions against 6 weeks of real agent memory. FTS handles exact queries well (85%), but hybrid wins by +25% on paraphrased and contextual queries."
---

## TL;DR

| Mode | Exact Keywords | Paraphrased | Contextual | Overall |
|------|---------------|-------------|------------|---------|
| **FTS-only** | 85% | 30% | 30% | **48%** |
| **Hybrid** | 85% | 55% | 55% | **65%** |

FTS-only is surprisingly capable for direct lookups. But the moment users rephrase or ask abstract questions, hybrid search pulls ahead by **+25 percentage points**.

## Why This Matters

SoulClaw's [4-Tier Memory](/docs/platform/soul-memory) system stores everything an AI agent learns — from daily conversation logs to long-term decisions and project context. When your agent needs to recall something, the retrieval method determines whether it finds the right memory or returns noise.

Most hosted AI agents use one of three approaches:

1. **Full-Text Search (FTS)**: Keyword matching. Fast, free, requires no ML model.
2. **Semantic Search**: Vector embeddings (e.g., bge-m3 via Ollama). Finds conceptually similar content even without exact keyword overlap.
3. **Hybrid**: Combines both, re-ranks results. SoulClaw's default when an embedding provider is available.

We wanted hard numbers on the actual difference — not synthetic benchmarks, but real agent memory with real questions.

## Methodology

### Corpus

- **303 files**, **~14,000 lines** of agent memory
- Accumulated over **6+ weeks** of daily AI agent operation
- Includes: daily logs, project topic files, compaction summaries, business decisions, technical troubleshooting

### Questions

30 human-written questions in three categories:

- **Exact (10)**: Query uses terms that appear verbatim in the source ("What is the Zenodo DOI for Paper 1?")
- **Paraphrase (10)**: Query uses synonyms or indirect references ("Which AI memory startup did a Google chief scientist invest in?" → answer mentions "Jeff Dean" and "SuperMemory")
- **Contextual (10)**: Query is abstract, requiring understanding of context ("What's our real competitive advantage in hosting?" → answer spans multiple files about Soul ecosystem differentiation)

### Evaluation

- **Human-scored** (not LLM-scored) — the question author evaluated each result
- **Scoring**: 0 = irrelevant, 1 = partially relevant, 2 = correct answer retrievable
- Each question scored for **top-5 retrieved results**
- Total possible score per mode: 60 points (30 questions × 2 max)

### Search Configuration

- **FTS**: SoulClaw's built-in SQLite FTS5 (`chunks_fts` table), keyword extraction from query
- **Hybrid**: FTS + Ollama bge-m3 embeddings (768-dim, multilingual), reciprocal rank fusion

## Results

### By Category

| Category | Questions | FTS Score | Hybrid Score | FTS % | Hybrid % | Delta |
|----------|-----------|-----------|-------------|-------|----------|-------|
| Exact | 10 | 17/20 | 17/20 | 85% | 85% | 0% |
| Paraphrase | 10 | 6/20 | 11/20 | 30% | 55% | **+25%** |
| Contextual | 10 | 6/20 | 11/20 | 30% | 55% | **+25%** |
| **Total** | **30** | **29/60** | **39/60** | **48%** | **65%** | **+17%** |

### Key Observations

**1. FTS is strong on exact queries.**

When users ask "What's the Zenodo DOI?" and the memory file contains "Zenodo DOI: 10.5281/...", FTS finds it immediately. 85% accuracy on exact-term queries is production-viable.

**2. Hybrid's advantage is entirely in recall on indirect references.**

"The teenager who built an AI service" → FTS can't match this to "Dravya Shah, 19, SuperMemory." Hybrid's semantic component bridges the vocabulary gap.

**3. Contextual queries are hard for both.**

"Why did we choose papers over patents?" requires understanding a decision process spread across multiple files and conversations. 55% isn't great — this is arguably a reasoning task, not a retrieval task.

**4. Hybrid never hurts.**

In no case did hybrid score lower than FTS. The semantic component adds signal without adding noise, thanks to reciprocal rank fusion.

### Notable Examples

| Question | FTS | Hybrid | Why |
|----------|-----|--------|-----|
| "Which startup did a Google chief scientist invest in?" | ❌ 0 | ✅ 2 | FTS can't connect "Google chief scientist" → "Jeff Dean" |
| "What caused the chat authentication error?" | ✅ 2 | ✅ 2 | Both find "401 bug" and "machineToken" keywords |
| "Why are we careful in the open-source community?" | ❌ 0 | ⚠️ 1 | Abstract concept, hybrid gets close but not definitive |
| "Primer Stealth deadline?" | ✅ 2 | ❌ 0 | FTS wins — exact keywords present, hybrid ranked wrong file higher |

## What This Means for SoulClaw Users

### Self-hosted (free)

Install Ollama + bge-m3 for hybrid mode. Without it, you still get FTS — perfectly usable for daily operation. [Setup guide →](https://docs.clawsouls.ai/docs/platform/soulclaw-cli#semantic-memory-search)

### ClawSouls Hosting

| Plan | Memory Mode | Why |
|------|-------------|-----|
| **Starter ($7/mo)** | FTS-only | Handles 85% of exact queries. Most day-to-day agent interactions use exact terms. |
| **Pro ($29/mo)** | FTS-only | Same retrieval, more compute for other tasks. |
| **Premium ($149/mo)** | Hybrid | Full semantic search. Best for power users with large memory corpora and indirect queries. |

### The pragmatic view

If 70-80% of your questions to an agent use exact terms ("show me yesterday's meeting notes", "what's the API key"), FTS-only is fine. The gap matters for long-term users who develop shorthand and indirect references with their agent over weeks and months.

## Reproducing This Benchmark

The benchmark framework is available at our [memory-bench repository](https://github.com/clawsouls/memory-bench). To run against your own agent's memory:

1. Write questions with ground truth (which files contain answers)
2. Run `benchmark.sh` against your SoulClaw memory database
3. Score results manually

We deliberately chose human evaluation over LLM-as-judge to avoid circular reasoning — using an LLM to evaluate an LLM's memory retrieval introduces confounding variables.

## Limitations

- **Single corpus**: Results reflect one agent's 6-week memory. Different content distributions may yield different ratios.
- **30 questions**: Statistically small sample. We chose depth of evaluation over breadth.
- **Bilingual corpus**: Memory is Korean + English mixed. bge-m3 handles multilingual well, but FTS keyword extraction may behave differently in monolingual corpora.
- **No semantic-only mode tested**: We compared FTS vs Hybrid. Pure semantic (no FTS component) was not benchmarked separately.

## Conclusion

Full-text search is not dead. For agent memory retrieval with exact-term queries, it performs at 85% — good enough for most daily use. But hybrid search earns its keep on the 20-30% of queries where users don't use the exact words stored in memory.

The takeaway for AI agent builders: **don't skip FTS as a baseline.** It's free, fast, and surprisingly effective. Add semantic search as an enhancement, not a replacement.

---

*This research was conducted using SoulClaw v2026.3.34's memory system. Raw benchmark data and methodology are available in our [memory-bench repository](https://github.com/clawsouls/memory-bench).*
