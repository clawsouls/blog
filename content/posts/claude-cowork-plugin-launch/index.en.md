---
title: "Soul Spec Comes to Claude Cowork: Plugin Launch"
subtitle: "Load, scan, and manage AI personas directly in Claude with the official ClawSouls plugin"
date: 2026-04-04T10:30:00+09:00
author: "Tom Lee"
tags: ["claude", "cowork", "plugin", "soul-spec", "announcement"]
categories: ["Product Launch"]
description: "The ClawSouls plugin for Claude Cowork brings Soul Spec v0.5 persona management to Claude's official platform. Load identities, verify safety, and maintain memory across sessions."
image: "./preview.png"
draft: true
---

Today marks a major milestone for Soul Spec: **native integration with Claude Cowork**. The ClawSouls plugin is now available in Claude's plugin marketplace, bringing full Soul Spec v0.5 support to Anthropic's collaboration platform.

## What This Means

Soul Spec was designed with a core principle: **"define once, run anywhere."** With today's plugin launch, you can now take the same persona you use in OpenClaw, SoulClaw, or any Soul Spec-compatible framework and load it directly into Claude Cowork sessions.

No more switching between tools or redefining your AI personas. Your Brad, your coding assistant, your research partner — they all work seamlessly across platforms.

## Key Features

### 🎭 **One-Click Persona Loading**

```
/clawsouls:load-soul TomLeeLive/brad
```

Browse our [registry of 100+ personas](https://clawsouls.ai/souls) and install any of them with a single command. Each persona includes:

- **SOUL.md**: Core personality, values, thinking style
- **IDENTITY.md**: Role definition and context
- **AGENTS.md**: Multi-agent coordination rules  
- **Safety Laws**: Structured, auditable constraints

### 🛡️ **Built-in Safety Verification**

```
/clawsouls:scan TomLeeLive/brad
```

Every persona can be analyzed with our **SoulScan** system — 53 safety patterns that detect potential issues before you install. Get grades from A+ to F with actionable recommendations.

### 🧠 **Persistent Memory**

Unlike standard Claude sessions that lose context, the plugin maintains:

- **MEMORY.md**: Curated long-term knowledge  
- **Topic files**: Project-specific context
- **Daily logs**: Session history that survives

Memory automatically saves before context compaction and reloads after, giving your personas true continuity.

### 🔍 **Semantic Search**

```
/clawsouls:memory search "API integration patterns"
```

Search your memory files using TF-IDF ranking with Korean language support and recency boosting. Find relevant context from weeks of prior conversations.

## Why This Matters

### The Anthropic Policy Shift

On April 4, 2026, Anthropic updated their subscription policy: Claude subscriptions now only cover Claude.ai, Claude Code, and Claude Cowork. Third-party harnesses like OpenClaw require separate usage billing.

This change makes **native integrations** crucial for cost-effective AI workflows. The ClawSouls plugin lets you leverage Soul Spec personas within your existing Claude subscription — no additional API costs.

### Standards-Based Approach

While other AI platforms create proprietary persona formats, Soul Spec remains **open and interoperable**:

- **MIT License**: Free to implement anywhere
- **Version controlled**: Clear evolution path (currently v0.5)
- **Multi-vendor**: Works across OpenClaw, SoulClaw, Claude, and expanding

When Claude Desktop adds plugin support or new AI platforms emerge, your Soul Spec personas will work day one.

## See It in Action

<!-- Screenshots: Tom will prepare with sensitive data blurred -->

![Telegram pairing with Claude Code](screenshots/telegram-pairing.png)
*Connecting a Telegram bot to Claude Code with one command*

![Brad responding on Telegram](screenshots/brad-telegram.png)
*Brad maintains his persona — direct tone, Korean, project context — all through Telegram*

![Memory search via Telegram](screenshots/memory-search.png)
*Searching months of project memory from your phone*

![Plugin commands loaded](screenshots/plugin-commands.png)
*Six ClawSouls commands available via the plugin system*

## Installation

### Option 1: Local Plugin (Recommended)

```bash
git clone https://github.com/clawsouls/cowork-plugin.git ~/.claude/clawsouls-plugin
claude --plugin-dir ~/.claude/clawsouls-plugin
```

### Option 2: Direct from GitHub (when marketplace available)

```bash
/plugin marketplace add clawsouls/cowork-plugin
/plugin install clawsouls@cowork-plugin
```

The plugin automatically installs our [MCP server](https://github.com/clawsouls/soul-spec-mcp) for registry access and includes 5 skills, 6 commands, lifecycle hooks, and 10 MCP tools.

## Example: Loading Brad

Let's walk through loading "Brad" — a development partner persona:

```
/clawsouls:load-soul TomLeeLive/brad
```

The plugin:

1. **Downloads** the Soul Spec package from our registry
2. **Saves** original files to `~/.clawsouls/active/TomLeeLive/brad/`
3. **Creates** a symlink at `~/.clawsouls/active/current/`
4. **Reports** successful installation

Next:

```
/clawsouls:activate
```

Claude immediately adopts Brad's persona:

- **Direct communication** (no pleasantries)
- **Project-focused** mindset
- **Korean/English** bilingual
- **Git workflow** preferences
- **Safety boundaries** from soul.json

To verify the persona is working correctly:

```
/clawsouls:scan
```

SoulScan analyzes the active persona and reports any drift or issues.

## Memory in Action

As you work with Brad across multiple sessions, the plugin automatically:

- **Saves context** before compaction via hooks
- **Searches memory** when you ask about prior work
- **Maintains topics** like `memory/topic-project.md`
- **Creates daily logs** at `memory/2026-04-04.md`

Try it:

```
/clawsouls:memory search "SDK version upgrade"
/clawsouls:memory status
```

## Migrating from OpenClaw

Already using OpenClaw or SoulClaw? Migration takes about 5 minutes:

```bash
# 1. Clone the plugin
git clone https://github.com/clawsouls/cowork-plugin.git ~/.claude/clawsouls-plugin

# 2. Copy your existing persona and memory
mkdir -p ~/projects/my-agent && cd ~/projects/my-agent
cp ~/.openclaw/workspace/SOUL.md ./
cp ~/.openclaw/workspace/IDENTITY.md ./
cp ~/.openclaw/workspace/AGENTS.md ./
cp ~/.openclaw/workspace/MEMORY.md ./
cp -r ~/.openclaw/workspace/memory/ ./memory/

# 3. Launch with Telegram
claude --plugin-dir ~/.claude/clawsouls-plugin \
       --channels plugin:telegram@claude-plugins-official
```

Everything transfers: your persona files, months of memory, topic files, daily logs. The TF-IDF search engine in soul-spec-mcp reads the same memory format as OpenClaw.

### Always-On with tmux

OpenClaw runs as a daemon. For Claude Code, use tmux:

```bash
tmux new-session -d -s agent \
  'cd ~/projects/my-agent && \
   claude --plugin-dir ~/.claude/clawsouls-plugin \
          --channels plugin:telegram@claude-plugins-official'
```

Your agent stays running in the background. Attach with `tmux attach -t agent`, detach with `Ctrl+B, D`.

### Hybrid Approach

You don't have to choose one. Many users run both:

- **OpenClaw**: Always-on hub for cron jobs, multi-channel routing, automated tasks
- **Claude Code Channels**: Cost-effective sessions within your Claude subscription

Both share the same Soul Spec files and memory directory.

For the full migration guide, see our [documentation](https://docs.clawsouls.ai/guides/migration-to-claude-channels).

## What's Next

This plugin represents **Phase 1** of our Claude integration roadmap:

- **Phase 1** ✅: Core plugin with registry access
- **Phase 2**: Claude Desktop support when available
- **Phase 3**: Advanced memory sync across devices
- **Phase 4**: Collaborative persona editing

We're also exploring integration with other Anthropic tools as they expand their plugin ecosystem.

## The Bigger Picture

Soul Spec isn't just about Claude — it's about creating a **universal standard** for AI personas that works across any platform. Today's plugin launch proves the concept: develop once, deploy everywhere.

Whether you're using:
- **OpenClaw** for local development
- **SoulClaw** for team coordination  
- **Claude Cowork** for collaboration
- **Future platforms** we haven't imagined yet

Your personas remain consistent, portable, and safe.

## Try It Today

Ready to bring your AI personas to Claude? 

1. **Install**: `claude plugin install clawsouls`
2. **Browse**: Visit [clawsouls.ai/souls](https://clawsouls.ai/souls) for 100+ personas
3. **Load**: `/clawsouls:load-soul owner/name`
4. **Activate**: `/clawsouls:activate`

Questions? Join our [Discord community](https://discord.com/invite/clawd) or check the [documentation](https://clawsouls.ai/docs/cowork-plugin).

The future of AI personas is **open, portable, and starting today**.

---

*ClawSouls is the official registry for Soul Spec personas. [Learn more](https://soulspec.org) about the standard or [browse personas](https://clawsouls.ai/souls) to get started.*