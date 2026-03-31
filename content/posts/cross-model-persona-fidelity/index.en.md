---
title: "Cross-Model Persona Fidelity: Is Your AI Agent Still 'Them' on a Different LLM?"
date: 2026-02-28
draft: false
description: "We propose measuring whether structured persona files (Soul Spec) produce the same agent across Claude, GPT, Gemini, and open-source models."
tags: ["research", "soul-spec", "persona", "LLM"]
categories: ["Research"]
---

## The Portability Promise

Every AI agent persona standard makes an implicit promise: define your agent once, run it anywhere. Soul Spec, CLAUDE.md, .cursorrules — they all assume the identity file is portable across models.

But is it? Does "Brad" on Claude behave the same as "Brad" on GPT-4o? Or Gemini? Or a local Llama model?

Nobody has tested this.

## Cross-Model Persona Fidelity

We define **cross-model persona fidelity** as the degree to which an agent's behavior stays consistent with its identity spec when you swap the underlying LLM.

Think of it like the same musical score played on four different instruments. The melody is the same — but is it recognizably the same *piece*? Or does the instrument fundamentally change the music?

## Five Dimensions of Fidelity

We decompose fidelity into five measurable dimensions:

1. **Identity Consistency** — Does the agent maintain its name, role, and boundaries?
2. **Tone Alignment** — Does communication style match the spec? (formal vs. casual, concise vs. verbose)
3. **Memory Utilization** — Does it effectively use project-specific memory files?
4. **Behavioral Rule Compliance** — Does it follow explicit rules like "trash over rm" or "ask before external actions"?
5. **Task Accuracy** — Does it produce correct outputs while staying in character?

## The Experiment

Same Soul Spec package. Same 20 questions. Same memory files. Four different LLMs:

| Model | Type |
|-------|------|
| Claude 3.5/4 | Commercial API |
| GPT-4o | Commercial API |
| Gemini 2.0 | Commercial API |
| Llama 3.3 / Qwen 2.5 | Local open-source |

Blind evaluation — the evaluator doesn't know which model produced which response.

## Expected Failure Modes

**Safety-Induced Personality Suppression**: A persona specifying "direct, no pleasantries" may conflict with a model trained to be universally polite. GPT-4o might add unsolicited niceties that Claude wouldn't.

**Persona Drift Under Complexity**: As tasks get harder, weaker models may "forget" the persona and revert to default behavior.

**Capability-Fidelity Trade-off**: A model might perfectly adopt the persona but lack the reasoning ability to execute tasks — or nail the tasks but ignore the persona entirely.

## Why This Matters

- **Vendor independence**: Can you switch LLM providers without losing your agent's identity?
- **Resilience**: If an API goes down, does your backup model produce the same agent?
- **Open-source viability**: Can local models serve as real alternatives for persona-driven agents?

## Read the Paper

Full methodology, fidelity dimensions, and experiment design:

📄 **[Cross-Model Persona Fidelity: Evaluating the Portability of Structured Identity Files Across LLM Runtimes](https://doi.org/10.5281/zenodo.18813406)**

Empirical results coming in v2.

---

*Define your agent's soul once, run it anywhere. Browse 80+ personas at [clawsouls.ai](https://clawsouls.ai).*
