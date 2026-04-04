---
title: "From Third-Party Agent to Claude Code Native: ClawSouls Plugin Launch"
subtitle: "Migrate your AI agent from OpenClaw and other harnesses to Claude Code — with full persona, memory, and safety intact"
date: 2026-04-04T10:30:00+09:00
author: "Tom Lee"
tags: ["claude", "claude-code", "plugin", "clawsouls", "announcement"]
categories: ["Product Launch"]
description: "Migrate your AI agent from OpenClaw and third-party harnesses to Claude Code natively. The ClawSouls plugin brings Soul Spec v0.5 persona management, Telegram integration, and persistent memory — all within your Claude subscription."
image: "screenshots/telegram-pairing.jpg"
draft: false
---

If you've been running an AI agent through OpenClaw or another third-party harness, **today you can bring it home to Claude Code** — with your persona, months of memory, and safety rules fully intact.

The ClawSouls plugin makes Claude Code a native agent platform. No more external harness fees. No more worrying about third-party policy changes. Your agent runs directly inside Claude's ecosystem, covered by your existing subscription.

## Why Now?

On April 4, 2026, Anthropic updated their policy: Claude subscriptions no longer cover third-party harnesses. If you've been running agents through external tools, you now face additional usage billing.

The ClawSouls plugin solves this by letting you **migrate your agent directly into Claude Code** — same persona, same memory, same workflow — at zero additional cost within your subscription.

## What This Means

ClawSouls was built on a core principle: **"define once, run anywhere."** With today's plugin launch, you can take the same persona you've been using in OpenClaw, SoulClaw, or any Soul Spec-compatible framework and load it directly into Claude Code sessions.

No more switching between tools or redefining your AI personas. Your development partner, your coding assistant, your research agent — they all migrate seamlessly.

## Key Features

### 🎭 **One-Click Persona Loading**

```
/clawsouls:load-soul clawsouls/brad
```

Browse our [registry of 100+ personas](https://clawsouls.ai/souls) and install any of them with a single command. Each persona includes:

- **SOUL.md**: Core personality, values, thinking style
- **IDENTITY.md**: Role definition and context
- **AGENTS.md**: Multi-agent coordination rules  
- **Safety Laws**: Structured, auditable constraints

### 🛡️ **Built-in Safety Verification**

```
/clawsouls:scan
```

Every persona can be analyzed with our **SoulScan** system — 53 safety patterns that detect potential issues before you install. Get grades from A+ to F with actionable recommendations.

### 🧠 **Persistent Memory**

Unlike standard Claude sessions that lose context, the plugin maintains:

- **MEMORY.md**: Curated long-term knowledge  
- **Topic files**: Project-specific context
- **Daily logs**: Session history that survives

Memory automatically saves before context compaction and reloads after, giving your personas true continuity.

### 🔍 **Memory Search**

```
/clawsouls:memory search "API integration patterns"
```

Search your memory files using TF-IDF ranking with Korean language support and recency boosting. Find relevant context from weeks of prior conversations.

## Standards-Based Approach

While other AI platforms create proprietary persona formats, Soul Spec remains **open and interoperable**:

- **MIT License**: Free to implement anywhere
- **Version controlled**: Clear evolution path (currently v0.5)
- **Multi-vendor**: Works across OpenClaw, SoulClaw, Claude, and expanding

When Claude Desktop adds plugin support or new AI platforms emerge, your Soul Spec personas will work day one.

## See It in Action

<!-- Screenshots: Tom will prepare with sensitive data blurred -->

![Telegram pairing with Claude Code](screenshots/telegram-pairing.jpg)
*Connecting a Telegram bot to Claude Code with one command*

![Brad responding on Telegram](screenshots/brad-telegram.jpg)
*Brad maintains his persona — direct tone, Korean, project context — all through Telegram*

![Memory search via Telegram](screenshots/memory-search.jpg)
*Searching months of project memory from your phone*

![Plugin commands loaded](screenshots/plugin-commands.jpg)
*Seven ClawSouls commands available via the plugin system*

## Installation

### Option 1: Local Plugin (Recommended)

```bash
git clone https://github.com/clawsouls/clawsouls-claude-code-plugin.git ~/.claude/clawsouls-plugin
claude --plugin-dir ~/.claude/clawsouls-plugin
```

### Option 2: Direct from GitHub (when marketplace available)

```bash
/plugin marketplace add clawsouls/clawsouls-claude-code-plugin
/plugin install clawsouls@claude-code-plugin
```

The plugin automatically installs our [MCP server](https://github.com/clawsouls/soul-spec-mcp) for registry access and includes 7 skills, 7 commands, 2 agents, lifecycle hooks, and 12 MCP tools.

## Example: Loading Brad

Let's walk through loading "Brad" — a development partner persona:

```
/clawsouls:load-soul clawsouls/brad
```

The plugin:

1. **Downloads** the Soul Spec package from our registry
2. **Saves** original files to `~/.clawsouls/active/clawsouls/brad/`
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
git clone https://github.com/clawsouls/clawsouls-claude-code-plugin.git ~/.claude/clawsouls-plugin

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

ClawSouls isn't just about Claude — it's about creating a **universal ecosystem** for AI personas that works across any platform. Today's plugin launch proves the concept: develop once, deploy everywhere.

Whether you're using:
- **OpenClaw** for local development
- **SoulClaw** for team coordination  
- **Claude Code** for coding and collaboration
- **Future platforms** we haven't imagined yet

Your personas remain consistent, portable, and safe.

## Try It Today

Ready to bring your AI personas to Claude? 

1. **Clone**: `git clone https://github.com/clawsouls/clawsouls-claude-code-plugin.git ~/.claude/clawsouls-plugin`
2. **Launch**: `claude --plugin-dir ~/.claude/clawsouls-plugin`
3. **Browse**: Visit [clawsouls.ai/souls](https://clawsouls.ai/souls) for 100+ personas
4. **Load**: `/clawsouls:load-soul owner/name`
5. **Activate**: `/clawsouls:activate`

Questions? Check the [documentation](https://docs.clawsouls.ai/docs/guides/claude-code-plugin) or open an issue on [GitHub](https://github.com/clawsouls/clawsouls-claude-code-plugin/issues).

The future of AI personas is **open, portable, and starting today**.

---

*ClawSouls is the official registry for Soul Spec personas. [Learn more](https://soulspec.org) about the standard or [browse personas](https://clawsouls.ai/souls) to get started.*