---
title: "How to Use Soul Spec in VS Code"
date: 2026-02-22T09:00:00+09:00
description: "Browse, install, and manage AI personas directly in VS Code with the Soul Spec extension. Access 80+ community souls from the sidebar."
categories: ["Guides"]
tags: ["soul-spec", "vscode", "extension", "persona", "guide", "tutorial"]
draft: false
---

## Overview

The **Soul Spec** extension for VS Code puts the entire ClawSouls persona registry at your fingertips. Browse 80+ community souls from the sidebar, install them with one click, and export to any supported platform — all without leaving your editor.

## Install the Extension

### Option A: From the Marketplace

1. Open VS Code
2. Press `Ctrl+Shift+X` (or `Cmd+Shift+X` on Mac) to open Extensions
3. Search for **"Soul Spec"**
4. Click **Install**

Or visit the listing directly: [Soul Spec on VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=clawsouls.soul-spec)

### Option B: From VSIX

For manual or offline installs:

1. Download the `.vsix` file from the [GitHub releases page](https://github.com/clawsouls/vscode-soul-spec/releases)
2. Open VS Code → Extensions panel (`Ctrl+Shift+X`)
3. Click the **`...`** menu (top-right of the Extensions panel)
4. Select **Install from VSIX...**
5. Choose the downloaded `.vsix` file

## Features

### Soul Browser

After installing, a new **Soul Browser** panel appears in the sidebar. It connects to the ClawSouls registry and displays 80+ community souls with search and filtering.

Click any soul to preview its description, personality traits, and configuration.

### Install Soul

Install a soul into your project directly from VS Code:

- Open the Command Palette: `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
- Run **"Soul Spec: Install Soul"**
- Pick a soul from the list — done

The soul files are added to your project root.

### Init — Create a New Soul

Want to build your own persona? Run:

- Command Palette → **"Soul Spec: Init"**

This scaffolds a new `soul.json` template with the required fields, ready for customization.

### Export for Platforms

Soul Spec supports exporting installed souls for different AI platforms:

| Platform | Export Format |
|----------|-------------|
| **Claude Code** | `CLAUDE.md` |
| **Cursor** | `.cursorrules` |
| **Windsurf** | `.windsurfrules` |

Run **"Soul Spec: Export"** from the Command Palette and select your target platform.

### soul.json Validation

The extension validates your `soul.json` files in real time. Schema errors, missing fields, and invalid values are highlighted as you type — no need to run a separate linter.

### Status Bar Badge

A small Soul Spec badge appears in the status bar when a soul is active in your project. Click it for quick actions.

## Quick Start

1. **Install** the extension from the [Marketplace](https://marketplace.visualstudio.com/items?itemName=clawsouls.soul-spec)
2. **Open Soul Browser** in the sidebar
3. **Pick a soul** — browse or search the registry
4. **Install** — one click and it's in your project
5. **Done** — your AI tools now have a persona

## Next Steps

- [Add a persona to Claude Code](/guides/claude-code-soul/)
- [Add a persona to Cursor](/guides/cursor-soul/)
- [Add a persona to Windsurf](/guides/windsurf-soul/)
- [Use Soul Spec MCP with any client](/guides/soul-spec-mcp/)
