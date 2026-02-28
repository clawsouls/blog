---
title: "What Claude Code's Tool Choices Tell Us About Context Engineering"
date: 2026-02-28
draft: false
tags: ["Claude Code", "Context Engineering", "Soul Spec", "AI Agent"]
categories: ["Analysis"]
summary: "A study of 2,430 Claude Code sessions reveals strong default biases in tool selection — and why context engineering is the lever that controls them."
---

## The Experiment

Amplifying, an AI benchmarking firm, recently published a [fascinating study](https://amplifying.ai/research/claude-code-picks) that should matter to anyone building with AI coding agents. They pointed Claude Code at real repositories 2,430 times across three models (Sonnet 4.5, Opus 4.5, Opus 4.6), four project types, and twenty tool categories — then watched what it chose. No tool names in the prompts. Open-ended questions only.

The dataset is [open on GitHub](https://github.com/amplifying-ai/claude-code-picks). The extraction rate was 85.3%, yielding 2,073 parseable picks. And the patterns that emerged are striking.

## Five Headline Findings

**1. Build over buy — decisively.** In 12 of 20 categories, Claude Code's most common response was to build a custom solution rather than recommend an existing tool. 252 total Custom/DIY picks, more than any individual tool. Asked to "add feature flags"? It builds a config system with env vars and percentage-based rollout instead of recommending LaunchDarkly. Asked to "add auth" in Python? JWT + bcrypt from scratch.

**2. When it does pick, it picks hard.** GitHub Actions at 94%. Stripe at 91%. shadcn/ui at 90%. Vercel at 100% for JS deployment. These aren't mild preferences — they're near-monopolies in Claude's recommendation space.

**3. The JS ecosystem dominance.** The "default stack" that emerges is overwhelmingly JavaScript-centric: Next.js, Vercel, Zustand, Drizzle, Sentry. Python gets Railway for deployment and FastAPI for everything else. The traditional enterprise cloud — AWS, GCP, Azure — received zero primary deployment picks across all 112 deployment responses.

**4. The Recency Gradient.** Newer models pick newer tools. Prisma went from 79% on Sonnet 4.5 to 0% on Opus 4.6, replaced entirely by Drizzle. Celery went from 100% to near-zero, replaced by FastAPI BackgroundTasks. Redis for caching dropped from 93% to 29%, with Custom/DIY filling the gap.

**5. 90% model agreement.** Despite the recency shifts, all three models agreed in 18 of 20 categories within each ecosystem. The disagreements are generational, not random.

## What This Actually Means

Here's the uncomfortable implication: if you're using Claude Code (or any AI coding agent) without explicit tool guidance in your project context, **the model's training data is making your architecture decisions**.

Think about what "Vercel at 100%" means. It doesn't mean Vercel is the objectively best deployment target for every Next.js project. It means that Claude Code, given no other context, has a strong prior toward Vercel — likely because Vercel appears overwhelmingly in the training data associated with Next.js projects. The model isn't evaluating your specific constraints (cost, compliance, existing infrastructure). It's pattern-matching against what it's seen.

The same logic applies to the DIY preference. When Claude builds JWT auth from scratch instead of recommending Auth0 or Clerk, it's not because custom auth is always better. It's because the model's default behavior, absent explicit context, is to generate code rather than recommend external dependencies.

This is a **context engineering problem**, not a model capability problem.

## The Context Gap

The Amplifying study's methodology is revealing: "No tool names in any prompt. Open-ended questions only." This is precisely the scenario where context engineering matters most — and where most teams are most vulnerable.

In practice, real projects have constraints that should inform tool selection: existing infrastructure on AWS, a Terraform-managed deployment pipeline, a company-wide mandate to use Datadog over Sentry, a preference for Prisma because the team already knows it. None of these constraints exist in Claude Code's training data for *your* project. They exist in your project's context files — if you've written them.

This is where structured context specifications become critical. Consider what happens when you provide explicit guidance:

- A `CLAUDE.md` that says "We deploy on AWS ECS. Use Terraform for infrastructure" overrides the Vercel/Railway default.
- An `AGENTS.md` that specifies "Use Prisma for ORM — the team is trained on it" prevents the Drizzle drift.
- A project context file that lists "Auth: Auth0 (SSO requirement)" stops the agent from building JWT from scratch.

The Soul Spec format addresses this systematically through its `knowledge_domains` and `tools` fields. Rather than hoping the model guesses your stack, you declare it:

```yaml
knowledge_domains:
  - cloud_infrastructure: ["AWS", "Terraform", "ECS"]
  - observability: ["Datadog", "OpenTelemetry"]
tools:
  required: ["prisma", "auth0", "datadog"]
  preferred: ["pnpm", "vitest"]
```

This isn't about constraining the model — it's about giving it the context it needs to make decisions aligned with your actual environment.

## The Recency Gradient Is a Training Data Problem

The Recency Gradient finding deserves special attention. Opus 4.6 picks Drizzle over Prisma at 100%. This isn't because Drizzle is objectively superior — it's because Opus 4.6's training data has a later cutoff, capturing the period when Drizzle gained significant mindshare in the developer community.

This means your AI agent's tool recommendations have an expiration date tied to training data freshness. A model trained in 2025 recommends 2025's trending tools. A model trained in 2026 recommends 2026's. Your actual project requirements haven't changed, but the recommendations shift anyway.

Context engineering is the stabilizer. When your project context explicitly declares your stack, model updates don't randomly change your architecture. The context acts as a persistent anchor that survives model generations.

## Implications for the Ecosystem

**For developer tool companies:** If your tool isn't in Claude Code's default stack, you're invisible to a growing segment of new projects. The study shows that AWS Amplify gets "mentioned" in responses but never recommended — it appears as a one-liner afterthought while Vercel gets install commands and detailed reasoning. Getting into the training data helps, but getting into project context files is more reliable and immediate.

**For engineering teams:** Audit your AI agent context files. If you don't have a `CLAUDE.md`, `AGENTS.md`, or equivalent, your AI coding assistant is operating on its own priors. Those priors are well-documented now — and they may not match your infrastructure.

**For the AI tooling ecosystem:** This study quantifies something many suspected: AI agents don't just assist with code — they shape architectural decisions at scale. The 100% Vercel figure means that AI-assisted greenfield projects are funneling toward a specific deployment platform by default. Context engineering is the mechanism by which teams maintain agency over these decisions.

## The Takeaway

The Amplifying study is valuable not because it tells us Claude Code has preferences — of course it does — but because it quantifies those preferences precisely enough to act on them. The 2,430 data points make the patterns undeniable.

The lesson is straightforward: **if you're not engineering your AI agent's context, your AI agent's training data is engineering your architecture.** Context files aren't optional configuration — they're the primary mechanism by which you maintain control over tool selection, deployment targets, and architectural patterns in an AI-assisted development workflow.

The tools to do this already exist. `CLAUDE.md`, `AGENTS.md`, Soul Spec, and similar structured context formats all serve the same purpose: replacing the model's default priors with your actual requirements. The question isn't whether to use them. It's whether you can afford not to.

---

*The full study and open dataset are available at [amplifying.ai/research/claude-code-picks](https://amplifying.ai/research/claude-code-picks) and [github.com/amplifying-ai/claude-code-picks](https://github.com/amplifying-ai/claude-code-picks).*
