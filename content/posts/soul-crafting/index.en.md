---
title: "Soul Crafting: Build an AI Persona by Talking — Right in Your Browser"
date: 2026-07-01T10:00:00+09:00
draft: false
tags: ["clawsouls", "soul-crafting", "soul-spec", "ai-persona", "webassembly", "browser"]
categories: ["launch"]
description: "No prompt engineering, no install, no API key. Answer a few questions and get a complete, portable Soul Spec — assembled deterministically, live in your browser."
---

## The bottleneck was always the prompt

Creating a good AI persona has meant wrestling with prompt files. You had to know the format and write the prompts well. That's the bottleneck.

**Soul Crafting** flips it: you answer a few questions, and it builds a complete Soul Spec for you — live in your browser. No prompt engineering, no install, no API key.

## How it works

Soul Crafting interviews you about your agent — its identity, its voice and values, how it should behave. As you answer, it assembles a canonical Soul Spec — `SOUL.md`, `IDENTITY.md`, `AGENTS.md`, `HEARTBEAT.md`, `STYLE.md` — **deterministically** from your answers, and previews it live next to the chat, with a SoulScan quality score that climbs as you go.

Because the files are assembled deterministically from your answers — not free-generated — the output is always a clean, valid spec.

## Test-chat, right there in the browser

Once your persona is taking shape, you can test-chat with it on the spot. A small language model (Qwen2.5) runs **entirely in your browser** via WebAssembly — no server, no key — so you can feel your new persona talk before you ever publish it. Want a richer conversation? Bring your own frontier API key.

## It's a real, portable persona

The result isn't a throwaway prompt — it's a Soul Spec: a vendor-neutral, structured persona you can publish to the ClawSouls registry, run on any model, version, fork, and share. The same persona, the same character, whichever LLM you point it at.

## Privacy by default

The whole thing runs in your browser. Nothing is sent anywhere until you choose to publish (which needs a quick login).

## Try it

Go to [clawsouls.ai](https://clawsouls.ai) and hit **Create in Browser**. Building is free and needs no signup; logging in lets you publish to the registry.

Soul Spec is our bet that personas should be a portable standard, not locked to one vendor. Soul Crafting is the on-ramp — now anyone can make one just by talking.
