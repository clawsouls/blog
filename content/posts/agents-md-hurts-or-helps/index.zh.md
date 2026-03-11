---
title: "新研究称 AGENTS.md 让 AI 变差——但有一个前提"
date: 2026-02-26T10:00:00+09:00
draft: false
description: "苏黎世联邦理工学院的一项研究发现，AGENTS.md 文件降低了编码智能体的性能，并将成本增加了 20%。但真正的教训不是删除你的上下文文件——而是写出更好的文件。"
categories: ["Research"]
tags: ["context-engineering", "agents-md", "soul-spec", "soulscan", "ai-agents", "research"]
slug: "agents-md-hurts-or-helps"
---

## 震动 AI 社区的标题

苏黎世联邦理工学院的一篇新论文投下了一颗重磅炸弹：**AGENTS.md 文件让编码智能体变得更差**。

["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988) 由 Gloaguen、Mündler、Müller、Raychev 和 Vechev 撰写，测试了上下文文件是否真的能帮助 AI 编码智能体完成实际任务。他们的发现：

- 提供上下文文件时**任务成功率下降了**
- **推理成本增加了超过 20%**
- LLM 生成的*和*开发者编写的文件都导致了问题
- 智能体忠实地遵循了指令——但这些指令让它们变差了

结论？上下文文件引入了"不必要的要求"，使任务变得更难。建议：**只描述最小需求**。

如果你正在使用 CLAUDE.md、AGENTS.md 或任何仓库级上下文文件，这听起来可能令人担忧。但在你删除一切之前——让我们看看到底发生了什么。

## 两篇论文，相反的结论

有趣的是，就在几周前，另一个研究团队发表了一项关于*完全相同主题*的研究，得出了**相反的结论**。

[Lulla 等人 (2601.20404)](https://arxiv.org/abs/2601.20404)，提交给 ICSE JAWS 审稿，发现结构化的 AGENTS.md 文件：

- **将运行时间减少了 28%**
- **将 token 使用量减少了 16%**
- 可衡量地提高了智能体效率

那么到底哪个对？上下文文件是帮助还是阻碍？

## 答案：取决于质量

当你看看每项研究实际测试了什么时，矛盾就消失了。

**Gloaguen 等人**测试了两种场景：
1. LLM 生成的上下文文件（遵循智能体开发者指南）
2. 开发者已经提交到仓库中的任何文件

在两种情况下，文件都包含**过多的信息**——架构概述、编码标准、测试要求、风格指南——所有这些都被加载到每个任务中，无论是否相关。

**Lulla 等人**研究了更加聚焦的文件，检查开发者如何自然地构建他们的指令以及智能体如何响应。

模式很清楚：

| 上下文质量 | 效果 |
|---|---|
| 臃肿的、什么都包含的文件 | ❌ 性能下降，成本上升 |
| 聚焦的、最小需求 | ✅ 效率提高 |
| LLM 生成且未经审查 | ❌ 比没有上下文更差 |
| 人工策划的、任务相关的 | ✅ 可衡量的收益 |

**问题不在于上下文文件本身。问题在于糟糕的上下文文件。**

## 三种失败模式

苏黎世联邦理工学院的论文识别了上下文文件出错的具体方式：

### 1. 不必要的探索
当上下文文件说"始终运行完整测试套件"或"审查所有相关模块"时，智能体会顺从地探索比需要的多得多的代码。精力浪费。焦点丧失。

### 2. 冗余信息
现代编码智能体已经很擅长自行发现项目结构。告诉它们已经能自己弄清楚的事情不会有帮助——它只会给上下文窗口增加噪音。

### 3. 不相关的要求
架构决策、编码风格偏好、部署工作流——这些可能对某些任务很重要，但对其他任务来说是纯噪音。将所有内容加载到每个任务中，就像在回复一封邮件之前阅读整本员工手册。

## 这对 Soul Spec 意味着什么

Soul Spec 正是围绕这篇论文推荐的原则设计的：**最小化、结构化、目的分离的上下文**。

以下是具体方式：

### 关注点分离
Soul Spec 不会把所有东西放在一个文件中。身份放在 `SOUL.md`。编码规则放在 `AGENTS.md`。周期性健康检查放在 `HEARTBEAT.md`。每个文件都有明确的目的，智能体只加载相关内容。

```
my-soul/
├── soul.json        # 元数据
├── SOUL.md          # 身份和个性（始终加载）
├── IDENTITY.md      # 名称、角色、头像
├── AGENTS.md        # 编码特定规则（开发任务时加载）
└── HEARTBEAT.md     # 周期性健康检查
```

### 质量优于数量
论文发现 LLM 生成的文件比*完全没有文件*表现更差。这就是 [SoulScan](https://clawsouls.ai/soulscan) 存在的原因——它根据 53 个安全和质量模式检查人格包，捕获臃肿的文件、矛盾的指令和会造成混淆而非帮助的内容。

### 设计上的最小化
Soul Spec v0.5 明确鼓励最小化的核心定义。你的 `SOUL.md` 应该包含身份、个性和行为规则——而不是你的整个项目架构。规范的文件结构自然地强制执行这种分离。

## 真正的教训

不要删除你的上下文文件。**修复它们。**

苏黎世联邦理工学院的论文和 Lulla 等人的论文并不矛盾——它们在衡量不同的东西。综合来看，它们讲述了一个一致的故事：

1. **糟糕的上下文比没有上下文更差**——停止自动生成臃肿的文件
2. **好的上下文可衡量地提高性能**——聚焦的、人工策划的指令有效
3. **结构很重要**——分离关注点，只加载相关内容
4. **质量验证必不可少**——你需要在上下文文件投入生产之前对其进行检查

这就是我们用 Soul Spec 和 SoulScan 一直在构建的方向。不是更多的上下文——而是*更好的*上下文。

---

## 参考文献

- Gloaguen et al., ["Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?"](https://arxiv.org/abs/2602.11988), arXiv:2602.11988, February 2026
- Lulla et al., ["On the Impact of AGENTS.md Files on the Efficiency of AI Coding Agents"](https://arxiv.org/abs/2601.20404), under submission to ICSE JAWS
- Mohsenimofidi et al., ["Context Engineering for AI Agents in Open-Source Software"](https://arxiv.org/abs/2510.21413), MSR 2026
- Baltes et al., ["Configuring Agentic AI Coding Tools: An Exploratory Study"](https://arxiv.org/abs/2602.14690), arXiv:2602.14690, February 2026

---

*Soul Spec 是一个开放的 AI 智能体人格标准。[浏览 80+ 社区 souls →](https://clawsouls.ai/souls)*
