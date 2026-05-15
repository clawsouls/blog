---
title: "Korean Personas and the Small Model Problem — A 4-Tier Truncation Pattern for On-Device AI"
date: 2026-05-15T22:00:00+09:00
draft: false
tags: ["soulclaw-mobile", "soul-spec", "on-device-ai", "gemma-4-e2b", "litert-lm", "persona", "4-tier-bootstrap", "korean-llm", "webllm", "qwen"]
categories: ["Technical / Analysis"]
description: "How the Mati Wise Partner persona (6,866 tokens) broke on every small on-device model — and the 4-Tier truncation pattern that fixes it. Includes Korean token estimation and production references."
---

Anthropic's [Persona Selection Model (PSM, 2026)](https://alignment.anthropic.com/2026/psm) makes the claim explicit:

> "A persona is not the same thing as the AI system itself. The LLM is simulating a character, and the Assistant is just one instance of that character."

Karpathy framed the same shift from the other end at Sequoia Ascent 2026:

> "Install .md skills instead of install .sh scripts."

Spec-as-instruction at the frontier. But if frontier models are "on the rails," on-device small models are "off-road in the jungle with a machete."

In that jungle, persona is the first thing to break.

## Mati Wise Partner — A Real Truncation Case

Mati Wise Partner is a persona published on [clawsouls.ai](https://clawsouls.ai). A five-file Soul Spec package:

| File | Role |
|------|------|
| SOUL.md | Personality, principles, boundaries |
| IDENTITY.md | Name, role, basic info |
| AGENTS.md | Workflow, safety rules |
| STYLE.md | Communication tone |
| README.md | User onboarding guide |

Total tokens: **6,866**.

### Attempt 1 — WebLLM Qwen 2.5 0.5B

Context window: 4,096 tokens. The result was immediate:

```
Error: Prompt tokens exceed context window size: 6866; context window: 4096
```

67% over the limit. The model never loaded the persona at all.

### Attempt 2 — SoulClaw Mobile, LiteRT-LM Gemma 4 E2B

`maxNumTokens=4000`. No error. The problem appeared on the first response.

The systemInstruction was silently truncated. The model fell back to its base identity:

> "I'm Gemma 4, how can I help you today?"

Not Mati. The persona setting wasn't ignored — it never arrived. **Silent failure.**

## Karpathy's 'Jaggedness' — Direct Mapping to On-Device Reality

Karpathy described the frontier-to-edge gap as "off-road in the jungle with a machete."

Frontier RL training data covers 100K LOC refactors. Models are trained to follow complex multi-file instructions reliably. That is "on the rails."

Small on-device models face a different set of constraints:

- **Context window**: 4,096–8,192 tokens (roughly 1/20th of frontier)
- **Instruction fidelity**: far less compute invested in following complex system prompts
- **CJK tokenization**: Korean/Chinese/Japanese characters carry higher token density than Latin script

Soul Spec's multi-file schema is the trail marker in that jungle. But if the trail marker itself gets truncated, you're navigating without a map.

## 4-Tier Bootstrap Pattern — Design

A structural fix for the truncation problem. Instead of treating all persona files as equal, the pattern assigns tiers by importance.

### Tier Structure

| Tier | Files | Loading Condition | Reason |
|------|-------|-------------------|--------|
| **Tier 1** | IDENTITY.md | Always (force-add) | The model must never lose "who am I" |
| **Tier 2** | SOUL.md | If budget allows | Core personality, principles, boundaries |
| **Tier 3** | AGENTS.md / STYLE.md / README.md | If budget allows | Operational detail |
| **Tier 4** | Memory search, etc. | Rare reach | External context |

**Tier 1 is budget-immune.** Even under severe token pressure, IDENTITY.md survives.

### Korean Token Estimation

CJK tokenization differs from Latin:

- **CJK chars** (Korean/Chinese/Japanese): 0.75 tokens/char
- **Latin chars**: 0.25 tokens/char

Example: `"안녕하세요 Brad 입니다"` = ~12 tokens

This estimate matches the LiteRT-LM tokenizer within ±20%. Rounding up (conservative high) avoids truncation surprises.

### Applied to Mati

Qwen 2.5 0.5B (4,096 ctx):

```
Context window:       4,096 tokens
System reserves:       -512 tokens  (model overhead)
Chat history reserves: -512 tokens  (conversation history)
Generation reserves:   -512 tokens  (response generation)
─────────────────────────────────────
Available budget:     2,560 tokens
```

Tier 1 placed first:

```
IDENTITY.md    755 tokens  → force-add ✅
AGENTS.md    1,755 tokens  → budget fit ✅
─────────────────────────
Used:         2,510 / 2,560 tokens

SOUL.md      truncated ⚠️
STYLE.md     truncated ⚠️
README.md    truncated ⚠️
```

Results:
- IDENTITY.md survives → "I'm Gemma 4" regression gone
- Mati's name and core role preserved
- Toast notification shown to user: **"Persona exceeds model limits — cloud BYOK recommended"**

The full Soul Spec didn't load. But silent failure became graceful degradation.

## Production References

The 4-Tier pattern is deployed across several implementations today.

### soul-playground (TypeScript)

The live source behind [clawsouls.ai/try](https://clawsouls.ai/try). Implements `4-Tier` logic for WebLLM environments:

```typescript
// Illustrative structure (soul-playground)
function buildSystemPromptTiered(
  files: SoulFiles,
  budget: number,
  tokenizer: Tokenizer
): string {
  // Tier 1: always include
  const identity = files.get('IDENTITY.md');
  let prompt = identity;
  let remaining = budget - countTokens(identity, tokenizer);

  // Tiers 2–3: include if budget allows
  for (const file of ['SOUL.md', 'AGENTS.md', 'STYLE.md', 'README.md']) {
    const content = files.get(file);
    const tokens = countTokens(content, tokenizer);
    if (remaining >= tokens) {
      prompt += '\n\n' + content;
      remaining -= tokens;
    }
  }
  return prompt;
}
```

### soulclaw-web (upcoming)

Standardized via the `buildSystemPromptTiered` API.

### soulclaw-android v1.6.5

[GitHub release v1.6.5](https://github.com/TomLeeLive/soulclaw-android/releases/tag/v1.6.5). Kotlin implementation in `agent/TieredBootstrap.kt` with CJK-aware token estimation:

```kotlin
// CJK token density correction
fun estimateTokens(text: String): Int {
    var count = 0
    for (ch in text) {
        count += when {
            ch.code in 0xAC00..0xD7A3 -> 1  // Korean (Hangul)
            ch.code in 0x4E00..0x9FFF -> 1  // CJK unified ideographs
            ch.code in 0x3040..0x30FF -> 1  // Hiragana / Katakana
            else -> if (ch == ' ') 0 else 1
        }
    }
    // conservative: ×0.75 base, +20% buffer
    return (count * 0.75 * 1.2).toInt()
}
```

### WasmClaw v1.0-alpha.1

[`@wasmclaw/core`](https://www.npmjs.com/package/@wasmclaw/core) — the reference Rust+WASM implementation built on Soul Spec v0.6 ([Zenodo DOI 10.5281/zenodo.19147335](https://doi.org/10.5281/zenodo.19147335)):

```bash
npm install @wasmclaw/core@next
```

## Summary + Open Invitation

Anthropic PSM says: the LLM is simulating a character. Which character matters.

Karpathy says: frontier is on the rails, edge is a jungle.

The 4-Tier Bootstrap pattern gives a user machete-ing through that jungle a safe path to IDENTITY — even when the full Soul Spec cannot fit. When a persona must survive truncation, this pattern ensures the most load-bearing file always arrives.

---

**Modulabs AI Persona LAB 701** — a research group led by Tom starting a 12-week curriculum every other Saturday from May. The agenda includes formalizing the 4-Tier pattern, Korean tokenization benchmarks, and on-device persona fidelity measurement. Academic participation and OSS contribution are welcome.

Fork, paper, or lab participation — all doors open.

---

> When spec matters — it enables navigation through both the frontier's "on the rails" and the small model's "off-road jungle."

---

*Soul Spec v0.6 is archived at [Zenodo](https://doi.org/10.5281/zenodo.19147335). The soulclaw-android v1.6.5 release is on [GitHub](https://github.com/TomLeeLive/soulclaw-android/releases/tag/v1.6.5). WasmClaw core is on [npm](https://www.npmjs.com/package/@wasmclaw/core).*
