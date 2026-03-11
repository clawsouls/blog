---
title: "Anthropic 发布官方 Skills 指南——与 Soul Spec 的对比"
date: 2026-02-24T20:30:00+09:00
draft: false
tags: ["anthropic", "skills", "soul-spec", "agents", "standardization"]
categories: ["Analysis"]
description: "Anthropic 发布了为 Claude 构建 Skills 的完整指南。以下是 SKILL.md 与 Soul Spec 的 soul.json 的区别——以及为什么你两者都需要。"
---

Anthropic 刚刚发布了"The Complete Guide to Building Skills for Claude"——一份33页的文档，定义了将**工作流知识**打包到 Claude 智能体中的官方标准。

ClawSouls 创建的 Soul Spec 定义了智能体的**身份和人格**。名称听起来相似，但它们解决的是不同的问题。

## Skills 做什么

一个 skill 是一个文件夹：

```
your-skill/
├── SKILL.md          # 必需 — 工作流指令
├── scripts/          # 可选 — 可执行代码
├── references/       # 可选 — 文档
└── assets/           # 可选 — 模板、图标
```

`SKILL.md` 中的 YAML 前置元数据是关键。Claude 读取这些元数据来决定何时加载每个 skill。

```yaml
---
name: sprint-planner
description: Manages Linear project workflows. Use when user mentions "sprint" or "create tasks".
---
```

**渐进式披露**分为三个级别，最小化 token 使用：
1. **前置元数据** — 始终在系统提示中（决定何时触发）
2. **SKILL.md 正文** — 相关时加载（实际指令）
3. **链接文件** — 仅在需要时探索（详细参考）

## Soul Spec 做什么

Soul Spec 定义智能体的**身份**：

```
my-agent/
├── soul.json         # 元数据（名称、描述、标签）
├── SOUL.md           # 个性、语调、原则
├── IDENTITY.md       # 基本信息
└── USER.md           # 用户上下文
```

如果 Skills 回答"怎么做"，Soul Spec 回答"谁来做"。

## 对比

| | Skills (SKILL.md) | Soul Spec (soul.json) |
|---|---|---|
| **目的** | 工作流知识 | 人格和身份 |
| **核心问题** | "怎么做？" | "我是谁？" |
| **触发** | 用户请求时 | 始终活跃 |
| **多个** | 同时多个 skills | 一个人格 |
| **MCP** | 直接支持 | 间接（通过 skills） |
| **标准** | Anthropic 专有 | 开放规范（LLM 无关） |

## 为什么两者都需要

Anthropic 用**厨房类比**描述 Skills：
- MCP = 专业厨房（工具、食材、设备）
- Skills = 食谱（分步指令）

加入 Soul Spec 完成画面：
- **Soul = 厨师**（经验、风格、理念）

同样的食谱，不同的厨师，不同的体验。由"友好、细致的 Brad"执行的客户入职工作流，与"快速、高效的 Kira"的体验截然不同。

## 指南中的值得注意的要点

**1. Skills API**
- `/v1/skills` 端点用于程序化管理
- Messages API 中的 `container.skills` 参数
- Agent SDK 集成

**2. 组织级部署**
- 管理员可以在整个工作区部署 skills（2025年12月上线）
- 自动更新，集中管理

**3. 五种模式**
- 顺序工作流编排
- 多 MCP 协调
- 迭代细化
- 上下文感知工具选择
- 特定领域智能

**4. 开放标准声明**
> "我们将 Agent Skills 发布为开放标准。与 MCP 一样，我们认为 skills 应该跨工具和平台可移植。"

Skills 旨在实现开放可移植性——这与 Soul Spec 从第一天起追求的方向相同。

## 实践中：Skills + Soul Spec

```
my-agent/
├── soul.json          # 智能体身份
├── SOUL.md            # 个性和原则
├── IDENTITY.md        # 基本信息
├── skills/
│   ├── sprint-planner/
│   │   └── SKILL.md   # Sprint 规划工作流
│   └── code-review/
│       └── SKILL.md   # 代码审查工作流
```

Soul 定义*谁*。Skills 定义*什么*。它们共同构成**完整的智能体包**。

## 这意味着什么

Anthropic 将 Skills 正式化为33页指南，标志着智能体生态系统的成熟：

- **MCP** → 智能体如何连接世界（2024）
- **Skills** → 智能体如何工作（2025-2026）
- **Soul Spec** → 智能体如何存在

所有三个层都以开放标准为目标。它们解决不同的问题。不是竞争——是互补。

---

*探索 Soul Spec：[clawsouls.ai](https://clawsouls.ai)。关于将 Skills 与 Soul Spec 一起使用的指南即将推出。*
