---
title: "How to Use Soul Spec with ChatGPT"
date: 2026-02-22T02:00:00+09:00
description: "Connect soul-spec-mcp to ChatGPT using Streamable HTTP transport. Give ChatGPT a persistent persona powered by Soul Spec."
categories: ["Guides"]
tags: ["soul-spec", "chatgpt", "mcp", "persona", "guide", "tutorial", "openai"]
draft: false
---

## Overview

[ChatGPT](https://chatgpt.com) Business, Enterprise, and Edu plans now support MCP (Model Context Protocol) apps via Streamable HTTP transport. This means you can connect **soul-spec-mcp** to ChatGPT and give it access to the entire ClawSouls persona registry.

Browse, preview, and apply AI personas — all from within ChatGPT.

## Prerequisites

- ChatGPT **Plus/Pro** or higher plan (see compatibility table below)
- Node.js 18+
- A machine that can run a publicly accessible HTTP server (or use a tunnel like ngrok)

### ChatGPT Plan Compatibility

| Plan | External Tools | Read-only MCP |
|------|:-:|:-:|
| **Free** | Very limited | ❌ |
| **Plus** | Limited | Partial |
| **Pro** | Similar to Plus | Partial |
| **Business** | ✅ | ✅ |
| **Enterprise** | ✅ | ✅ |
| **Edu** | ✅ | ✅ |

> **Recommended:** Business, Enterprise, or Edu plans have full MCP support. Plus/Pro users may have limited access depending on feature rollout.

## Step 1: Install soul-spec-mcp

```bash
npm install -g soul-spec-mcp
```

## Step 2: Start the HTTP Server

soul-spec-mcp supports two transport modes: **stdio** (default, for Claude Code and similar) and **Streamable HTTP** (for ChatGPT).

Start the HTTP server:

```bash
soul-spec-mcp --http
```

This starts a server at `http://localhost:3100/mcp`. To use a different port:

```bash
soul-spec-mcp --http --port 8080
```

You can verify it's running:

```bash
curl http://localhost:3100/health
# {"status":"ok","transport":"streamable-http"}
```

## Step 3: Make It Accessible

ChatGPT needs to reach your server over the internet. Options:

**Option A: ngrok (quickest)**

```bash
ngrok http 3100
```

Copy the `https://` URL — you'll need it next.

**Option B: Deploy to a server**

Deploy on any cloud provider and run `soul-spec-mcp --http --port 3100`. Make sure port 3100 is open.

## Step 4: Add to ChatGPT

1. Open [ChatGPT](https://chatgpt.com) (Business/Enterprise/Edu)
2. Go to **Settings → MCP Apps** (or your admin panel)
3. Click **Add MCP App**
4. Enter your server URL: `https://your-domain.com/mcp`
5. Save and enable

ChatGPT now has access to all soul-spec-mcp tools.

## Step 5: Use It

In any ChatGPT conversation, you can now:

- **Search personas**: "Search for coding personas on ClawSouls"
- **Preview a soul**: "Preview the surgical-coder soul"
- **Apply a persona**: "Apply the clawsouls/brad persona"
- **Browse categories**: "What persona categories are available?"

### Example

> **You**: Search for creative writing personas on ClawSouls
>
> **ChatGPT**: *calls search_souls* — Found 5 souls: ...
>
> **You**: Apply the first one
>
> **ChatGPT**: *calls apply_persona* — Persona "Story Weaver" is now active...

## Available Tools

| Tool | Description |
|------|-------------|
| `search_souls` | Search personas by keyword, category, or tag |
| `get_soul` | Get detailed info about a specific soul |
| `install_soul` | Download and generate persona files |
| `preview_soul` | Preview what a soul looks like |
| `apply_persona` | Apply a persona to the current conversation |
| `list_categories` | Browse available categories |

## Tips

- **apply_persona** is the most useful for ChatGPT — it immediately changes the conversation's behavior
- Personas persist for the conversation but reset on new chats
- For permanent persona setup in other tools, see our [other guides](https://blog.clawsouls.ai/guides/)

## Learn More

- [Soul Spec](https://clawsouls.ai/spec) — The open spec for AI personas
- [ClawSouls Registry](https://clawsouls.ai/souls) — Browse all personas
- [soul-spec-mcp on npm](https://www.npmjs.com/package/soul-spec-mcp) — Package details
- [ChatGPT MCP Apps Guide](https://help.openai.com/ko-kr/articles/12584461) — OpenAI's official docs
