---
title: "Continuous Learning Won't Come From the Weights"
date: 2026-07-24T19:10:00+09:00

description: "DeepSeek's founder named continuous learning as the single biggest gap on the road to AGI. He's right — but the answer isn't retraining the model. It's a memory layer built in the open, at the file level."
categories: ["Analysis"]
tags: ["soul-spec", "memory", "continuous-learning", "deepseek", "ai-agents"]
slug: "continuous-learning-file-layer"
canonical: "https://blog.clawsouls.ai/posts/continuous-learning-file-layer/"
---

## The one gap everyone agrees on

In a closed-door investor briefing whose recording later leaked, DeepSeek's Liang Wenfeng was asked what's actually missing on the road to AGI. His answer wasn't a bigger model, or video, or another modality. He was blunt: the thing today's models can't do is **learn continuously**. Solve that, he said, and you reach a gradual singularity — and eventually embodied intelligence.

He's right. And it's worth sitting with how many people, from very different corners, now point at the same wall. Karpathy talks about agents that install skills like `.md` files. OpenAI shipped Dreaming — background memory synthesis between sessions. Microsoft built agent identity into the OS at Build. openclaw added `/dreaming`. The frontier and the ecosystem have converged on the same missing piece.

Here's the uncomfortable part for anyone who assumes the fix is "just train more": **the frozen model can't be where continuous learning happens.**

## Why not the weights

Three reasons, and none of them are going away:

**Economics.** You cannot retrain a model per user, per session. The whole appeal of a foundation model is that it's shared. The moment you want it to remember *your* last conversation, you've left the regime that training operates in.

**Opacity.** Weights are a black box. You can't open them up and see what the model "learned" last Tuesday. You can't delete one wrong fact. You can't audit what it retained about you. For anything that touches trust — a coworker, a support agent, a system of record — that's disqualifying.

**Lock-in.** Weights belong to one vendor's model. If your agent's accumulated experience lives inside a specific set of parameters, it dies the day you switch models. And you *will* switch models — the field moves too fast to marry one.

Put simply: continuous learning that lives in the weights is continuous *forgetting* from the user's side. Every new session starts from zero.

## Where it actually lives: the file layer

If the learning can't live in the model, it has to live beside it — in a store that's durable, inspectable, portable, and model-agnostic. Increasingly, that store looks like plain files.

Tolaria, an open-source knowledge base that surfaced this week, is a clean example of the pattern: markdown files, a git repository, YAML frontmatter, an MCP server, and `AGENTS` files so external AI tools can read and write the vault. Its design principles read like a manifesto — *files-first, git-first, offline-first, zero lock-in.* No accounts. No cloud dependency. Your knowledge is just files you own.

That's not a coincidence. It's where the whole "files-first" movement is going, because files solve exactly the three problems the weights can't: they're portable (any editor, any model), inspectable (you can read and diff every change), and versioned (git already solved memory-over-time decades ago).

Our own agent memory is built this way — plain markdown, git-synced, human-auditable. We put it to a hard test this month: we rebased our agent runtime across four months of upstream changes and swapped the underlying inference model entirely. The runtime changed. The model changed. The agent's memory came through intact, and it still cited what it had learned weeks earlier, under a different model. That is the entire point. **The learning has to survive the model.**

## But storage isn't cognition

Here's where most of the "just use markdown" takes stop too early. Writing files is the easy part. A folder of notes is not continuous learning — it's a filing cabinet. The hard, valuable work is the runtime around the files:

- **Retrieval.** Semantic search, so the *right* memory surfaces at the right moment — not a keyword grep that misses the one note phrased differently.
- **Promotion.** A policy for what graduates from "something that happened" into "something I must never forget." Not every note deserves to be permanent; some do, and the system has to decide.
- **Decay.** What fades. Without forgetting, a memory store calcifies into noise, and old context drowns the signal. Temporal decay is a feature, not a bug.
- **Identity separation.** Keeping *who the agent is* (its persona) distinct from *what it learned* (its experience). Blur the two and the agent's character drifts every time it picks up a new fact.

This runtime is the layer we call Soul Memory. The markdown store is a commodity — anyone can write files. The cognition layer on top is the moat.

## The counterintuitive part: bad memory is worse than none

If you take one thing from our [experiential memory research](https://blog.clawsouls.ai/posts/experiential-memory-paper/), take this: not all memory helps. In a blind study, agents given *synthetic* memory — tidy, summarized recaps — scored **below** agents given no memory at all. A confident, lossy summary turned out to be worse than an honest blank, because it made the agent overconfident about things it had subtly gotten wrong.

That is the trap in naive continuous learning. When you compress experience into a neat summary, the first things dropped are the caveats — *this was uncertain, this only held in that context, I didn't actually know this part.* But when the agent reads that summary back later, it takes the surviving sentences as settled fact. So it doesn't get smarter; it gets confident about the very things it got wrong.

Which is the point: *how* you remember matters as much as *what* you remember. A good memory format keeps, next to each fact, its provenance (where it came from and how sure you were), its scope (when it applies), and room to say "I don't have that." These aren't decoration bolted on at the end — they are what stop a summary from hardening into false confidence.

## If you're building agents

The through-line is simple:

1. **Treat memory as a first-class, portable artifact** — something you own and can move, not a feature you rent from a vendor.
2. **Store it in open, inspectable formats.** Markdown plus git is boring, and boring is exactly right for something that has to be trustworthy for years.
3. **Invest in the runtime, not just the database.** Retrieval, promotion, decay, identity separation — that's where a filing cabinet becomes learning.
4. **Separate identity from experience,** or watch your agent's character erode one fact at a time.

Continuous learning is the gap the whole field now agrees on. But it isn't a training problem waiting on the next model. It's a systems problem, at the file layer, available today. The teams that win won't be the ones with the biggest weights — they'll be the ones whose agents remember, and remember *well*, across every model they ever run.

---

**Reference.** Liang Wenfeng's remarks come from a leaked recording of DeepSeek's closed-door investor meeting (May 20, 2026), since widely reported and analyzed. Among the leaked remarks: *"The core capability of the next generation of models has to be continual learning — only then does it deserve to be called next-generation."* DeepSeek reportedly halted its second fundraising round after the leak.

- Recode China AI, [Liang Wenfeng on AGI, Compute, and Why DeepSeek Stays Open Source](https://www.recodechinaai.com/p/liang-wenfeng-on-agi-compute-and) (July 23, 2026) — analysis and quotes from the leaked transcript
- Seoul Economic Daily, [DeepSeek Abruptly Halts Fundraising After Founder's Remarks Leak](https://en.sedaily.com/international/2026/07/26/deepseek-abruptly-halts-fundraising-after-founders-remarks) (July 26, 2026)
