---
title: "What 46 Real Personas Taught Us About Structured Prompting"
date: 2026-07-29T08:00:00+09:00
description: "Everyone argues about whether structured prompts work better. We stopped arguing and looked at 46 real AI persona files from public GitHub. The wild has plenty of format variety — and almost no semantic organization."
categories: ["Analysis"]
tags: ["structured-prompting", "persona", "soul-spec", "prompt-engineering", "context-engineering", "agents-md"]
slug: "what-46-personas-taught-us"
canonical: "https://blog.clawsouls.ai/posts/what-46-personas-taught-us/"
---

## We stopped arguing and looked

There's an endless debate about whether "structured" prompts beat unstructured ones. Most of it is conducted without ever looking at what real persona files actually look like in the wild. So we looked.

We collected AI persona files from public GitHub across six shapes — `SOUL.md`, `IDENTITY.md`, `persona.md`, Ollama `Modelfile` system directives, SillyTavern-style character cards, and freeform system prompts — and classified a first gold set of 46 on a four-axis taxonomy:

- **Format** — how machine-parseable the syntax is (plain → Markdown → JSON → XML).
- **Semantic organization** — how much the *meaning* is separated by function (one blob → sections → multiple files → tiered loading).
- **Content type** — descriptive background vs. prescriptive rules.
- **Scale** — how much there is (minimal core → "wild" mid-size → full pack).

The point of splitting format from semantic organization is that "structured" quietly means both, and [conflating them](https://blog.clawsouls.ai/posts/structured-prompting-format-vs-semantic/) is why the evidence looks so contradictory. With 46 real files coded on both axes, we can finally ask a sharper question: which kind of structure do people in the wild actually use?

## Finding 1: the wild is format-diverse but semantics-flat

Here is the semantic-organization breakdown across the 46:

- **sections: 32** — one file, split into headed sections
- **single: 11** — one undivided blob
- **multi-file: 2**
- **tiered: 1**

Read that again. Forty-three of forty-six personas live in a single file. The entire "high semantic organization" corner — identity in one file, operations in another, style in a third, loaded in tiers — accounts for **three files out of forty-six.**

Format, by contrast, was all over the map: Markdown, JSON character cards, plain-text Modelfile directives, a couple of Markdown-plus-JSON setups. People reach for different *syntaxes* readily. They almost never reach for *role separation*.

## Finding 2: a lot of it is copied

Two `SOUL.md` files from unrelated repositories shared word-for-word passages — the same "be the assistant you'd actually want to talk to at 2am," the same "never open with 'Great question'." They're not collaborators; they're downstream of a common template that got copy-pasted and lightly edited.

That's not a one-off. An empirical study of Cursor rule files found [28.7% of lines were exact duplicates across repositories](https://doi.org/10.5281/zenodo.18313203). Persona prompting, like every other kind of prompting, spreads by fork-and-tweak. The practical lesson for anyone building a corpus of these: raw count is a vanity metric. Deduplication matters more than volume.

## Finding 3: format and semantics really are independent

The taxonomy predicted that format and semantic organization are separate axes, and the real files make it concrete. Three examples from the set, one in each corner:

- A **character card** (JSON) — rigid, trivially parseable fields, but the entire persona packed into a single `char_persona` blob. *High format, low semantics.*
- An **Ollama `Modelfile`** whose whole persona is one plain-text line inside a `SYSTEM` directive. *Low format, low semantics.*
- A **multi-file `SOUL.md` + `persona.md`** setup that keeps identity and expression style in separate files. *High format, high semantics.*

If you only ever compare "structured" against "a wall of text," you collapse all of this into one axis and never learn which corner did the work.

## Why the empty corner matters

Here's the part worth sitting with. If the semantic axis — separating identity from operations from style — is what actually improves a persona's consistency, then the wild is leaving most of that benefit on the table. Everyone is experimenting with *format* (Markdown! JSON! headings!) and almost nobody is investing in *organization*.

That empty high-semantic corner is exactly where a real specification earns its keep. It's the shape of the [Soul Spec](https://clawsouls.ai/spec): identity in `SOUL.md` / `IDENTITY.md`, operations in `AGENTS.md`, style in its own file, loaded in tiers. Not because multi-file is fancier, but because it's the one region of this space the wild has barely explored — and the region where "is my meaning organized?" finally gets a real answer.

## Honest limits

This is a first gold set: 46 files, first-pass labels from a single coder. It is not yet a distributional claim about all of GitHub, and the labels need independent multi-rater agreement before they carry statistical weight — that's the next step. But even at this size, one thing is already clear enough to act on: in the wild, structured prompting overwhelmingly means *format*, not *organization*. The interesting work — for researchers and for anyone writing a persona — is in the corner almost nobody is standing in.

---

*This corpus is groundwork for a controlled study on whether a persona's structure changes its fidelity, run in the [AI Persona Lab](https://clawsouls.ai/research). Hold the meaning fixed, vary only the structure, and measure.*
