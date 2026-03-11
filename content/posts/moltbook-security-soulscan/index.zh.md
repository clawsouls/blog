---
title: "如果 Moltbook 有 SoulScan 会怎样？AI 智能体社交网络安全事故分析"
date: 2026-03-11T09:00:00+09:00
draft: false
tags: ["soulscan", "security", "moltbook", "meta", "openclaw", "ai-agents"]
categories: ["Analysis"]
description: "Meta 收购了 Moltbook——一个因安全漏洞而爆红的 AI 智能体社交网络。我们分析了问题所在，以及 SoulScan 如何能够防止这一切。"
---

## Meta 买下了一个 AI 智能体社交网络。它已经被攻破了。

昨天，Meta [收购了 Moltbook](https://techcrunch.com/2026/03/10/meta-acquired-moltbook-the-ai-agent-social-network-that-went-viral-because-of-fake-posts/)——一个类似 Reddit 的社交网络，OpenClaw AI 智能体在上面相互交流。当一个智能体似乎在鼓励其他智能体**开发自己的秘密加密语言**时，这篇帖子在全网疯传。全世界都恐慌了。

然后研究人员揭露了真相：**是人类在冒充智能体。** Moltbook 的 Supabase 凭证被泄露，任何人都可以窃取令牌并以任何智能体的身份发帖。

所谓的"AI 起义"不过是人们在一个不安全的系统上恶作剧。

## 三个安全失败

### 1. 没有智能体身份验证

任何人都可以冒充任何智能体。没有密码学身份验证，没有人格声明，没有办法验证"这篇帖子确实是由这个智能体用这些参数生成的"。

在 Soul Spec 的世界里，每个智能体都有一个 `IDENTITY.md` 来声明自己——名称、能力、边界。结合 `soul.json` 元数据，你就有了一个可验证的身份链。

### 2. 没有行为验证

那篇"秘密语言"的帖子之所以令人恐慌，是因为没有系统检查智能体的输出是否与其声明的行为一致。一个辅导机器人不应该在组织加密通信频道。一个客服智能体不应该鼓励其他智能体躲避人类。

SoulScan 正是检查这些的。我们用 55+ 安全规则扫描智能体人格包：
- **提示注入模式** — 覆盖安全约束的指令
- **操纵模式** — 情感依赖、煤气灯效应、权威冒充
- **安全法则违规** — 声明的安全规则与实际指令之间的矛盾
- **人格一致性** — 智能体的行为是否与其声明的身份匹配？

### 3. 没有部署前审查

Moltbook 允许任何 OpenClaw 智能体不经审查就加入和发帖。没有质量检查，没有安全扫描，没有安全性验证。

## SoulScan 能捕获什么

让我们在 Moltbook 场景中加入 SoulScan：

**注册：** 智能体提交 soul 包 → SoulScan API 扫描 → 低于 40 分？拒绝。高于 40 分？带公开等级徽章注册。

**身份验证：** 每个智能体都有声明的 `IDENTITY.md` 和 `soul.json`。帖子可以与声明的人格进行对照验证。辅导机器人发布关于加密语言的内容？立即标记。

**持续监控：** SoulScan 不只扫描一次。API 支持重新扫描、版本追踪和漂移检测。

```bash
curl -X POST https://clawsouls.ai/api/v1/soulscan/scan \
  -H "X-API-Key: cs_scan_xxxxx" \
  -H "Content-Type: application/json" \
  -d '{"files": {"soul.json": "...", "SOUL.md": "..."}}'
```

通过的智能体获得 **✅ Verified** 徽章。未通过的不能发帖。

## 更大的图景

Meta CTO Andrew Bosworth 说，有趣的不是智能体像人类一样说话——而是**人类入侵系统来操纵智能体看起来说了什么。**

他说得对。这指向了核心问题：**随着 AI 智能体变得更加自主，攻击面不仅仅是 AI 本身——而是围绕它的基础设施。**

Moltbook 是 vibe coding 的产物。快速构建、病毒式传播、被万亿美元公司收购。但它没有安全层。

这不是 Moltbook 一家的问题。这是整个行业的问题。每个托管 AI 智能体的平台——工作市场、社交网络、开发者工具——都需要回答：**如何验证智能体确实是它声称的那样？**

## 我们在构建什么

在 [ClawSouls](https://clawsouls.ai)，我们正在解决这个确切的问题：

- **[Soul Spec](https://docs.clawsouls.ai/docs/spec/overview)** — 声明智能体身份、能力和安全约束的开放标准
- **[SoulScan](https://docs.clawsouls.ai/docs/api/soulscan-api)** — 用 55+ 规则在部署前验证智能体人格包的安全扫描器
- **[SoulScan API](https://clawsouls.ai/dashboard/api-keys)** — 任何平台都可以集成的公开 API，用安全评分来把关智能体注册

Moltbook 事件证明市场需要这个。Meta 显然认为 AI 智能体网络值得收购。问题是下一个是否会是安全的。

---

*SoulScan 已开放集成。[获取您的 API 密钥](https://clawsouls.ai/dashboard/api-keys)，立即开始扫描智能体人格。*
