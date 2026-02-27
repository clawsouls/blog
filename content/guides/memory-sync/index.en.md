---
title: "Memory Sync Guide: Encrypt & Sync Your AI Agent's Memory"
date: 2026-02-27T06:00:00+09:00
description: "Encrypt your AI agent's memory files and sync them across devices via a GitHub private repo. Your keys stay local — the server never sees your data."
categories: ["Guides"]
tags: ["memory-sync", "encryption", "github", "agent-memory", "guide", "tutorial"]
---

## What Is Memory Sync?

AI agents accumulate knowledge over time — conversation logs, preferences, project context — stored in files like `MEMORY.md` and `memory/*.md`. **Memory Sync** encrypts these files locally and pushes them to a GitHub private repository, so you can pull them on any device.

- 🔐 **End-to-end encrypted** — files are encrypted before leaving your machine
- 🔄 **Cross-device sync** — share memory between your laptop, desktop, and CI
- 📦 **GitHub-backed** — versioned, private, and free

## Why Do You Need It?

| Problem | Memory Sync Solution |
|---|---|
| Agent forgets everything on a new machine | Pull encrypted memory and resume |
| Memory files contain sensitive data | age encryption — server never sees the key |
| No backup for agent knowledge | GitHub private repo = automatic backup |
| Multiple devices, fragmented context | One encrypted repo, any device |

## Prerequisites

- Node.js 18+
- A [GitHub Personal Access Token (PAT)](#how-do-i-create-a-github-pat) with `repo` scope

## Quick Start

### 1. Initialize

```bash
npx clawsouls sync init
```

This will:
- Prompt for your GitHub PAT
- Create a private repo (e.g. `clawsouls-memory-sync`) on your GitHub account
- Generate an **age keypair** (X25519) and store it locally

### 2. Push (Encrypt & Upload)

```bash
npx clawsouls sync push
```

Encrypts your local memory files and pushes the ciphertext to GitHub.

### 3. Pull (Download & Decrypt)

```bash
npx clawsouls sync pull
```

Pulls encrypted files from GitHub and decrypts them locally.

### 4. Check Status

```bash
npx clawsouls sync status
```

Shows sync state: last push/pull timestamps, pending local changes, and remote differences.

## Key Management

Your encryption key is the **only way** to decrypt your memory. Treat it like a password.

### Export Your Key

```bash
npx clawsouls sync export-key
```

Saves your private key to a file. **Store it somewhere safe** (password manager, encrypted USB, etc.).

### Import a Key (New Device)

```bash
npx clawsouls sync import-key
```

Restores your private key on another machine so you can decrypt synced memory.

> ⚠️ **If you lose your key, your encrypted memory is unrecoverable.** There is no server-side backup of your key. Export it immediately after `sync init`.

## How It Works

```
Local memory files
       │
       ▼
  age encrypt (X25519)
       │
       ▼
  GitHub Private Repo (encrypted blobs)
       │
       ▼
  age decrypt (local key)
       │
       ▼
  Memory restored on new device
```

**Tech stack:**
- **[age](https://age-encryption.org/)** — modern file encryption using X25519 key exchange
- **GitHub API** — private repo creation, push, and pull
- **Local keystore** — your private key never leaves your machine

## FAQ

### How do I create a GitHub PAT?

1. Go to [github.com/settings/tokens](https://github.com/settings/tokens)
2. Click **Generate new token (classic)**
3. Select the `repo` scope (full control of private repositories)
4. Copy the token and use it during `sync init`

> 💡 Fine-grained tokens also work — grant **Contents: Read and write** permission on the sync repo.

### What happens if I lose my key?

Your encrypted data on GitHub becomes **permanently unreadable**. There is no recovery mechanism. Always export your key right after initialization.

If you lose the key:
1. Delete the old sync repo on GitHub
2. Run `npx clawsouls sync init` to start fresh
3. **Export the new key immediately**

### Can I sync multiple agents?

Yes. Each agent (or soul) can have its own sync repo. Run `sync init` in each agent's working directory — a separate repo and keypair will be created for each.

### Is my data safe on GitHub?

GitHub stores only encrypted blobs. Without your local private key, the data is indistinguishable from random bytes. Even if the repo were exposed, the contents remain encrypted.

### Can I use this with a team?

Share the exported key with trusted team members via a secure channel. Anyone with the key and GitHub access can push and pull memory.
