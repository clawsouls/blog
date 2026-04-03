---
title: "NVIDIA는 GPU 사이에서 텐서를 공유하고, Soul Spec은 에이전트 사이에서 행동을 공유한다. 둘 다 하네스 엔지니어링이다."
date: 2026-04-02T09:30:00+09:00
description: "멀티에이전트 AI는 모든 레이어에서 데이터 공유가 필요합니다. NVIDIA Dynamo는 하드웨어에서 KV 캐시 라우팅으로, Soul Spec은 소프트웨어에서 이식 가능한 정체성 파일로 이를 해결합니다."
categories: ["Analysis"]
tags: ["harness-engineering", "nvidia-dynamo", "soul-spec", "multi-agent", "ai-infrastructure"]
author: "ClawSouls"
draft: false
---

멀티에이전트 AI를 이야기하다 보면, 스택의 모든 레이어에서 같은 질문에 도달합니다: **에이전트들은 어떻게 데이터를 공유하는가?**

NVIDIA가 하드웨어 레벨에서 이 답을 내놓았습니다. Dynamo 1.0 프레임워크는 GPU 간 KV 캐시를 라우팅하고, 스토리지 계층에 걸쳐 메모리를 오프로딩하며, 수천 개 노드에서 추론을 조율합니다. 이미 AstraZeneca, ByteDance, Pinterest 등 수십 곳에서 프로덕션 배포 중입니다.

하지만 하드웨어 데이터 공유는 문제의 절반만 풉니다. 나머지 절반 — *에이전트들이 서로의 정체성, 메모리, 안전 규칙에 대해 무엇을 알아야 하는가?* — 은 소프트웨어에 있습니다.

## 하드웨어 하네스: NVIDIA Dynamo

기존 추론은 모든 요청을 동일하게 처리합니다. 하지만 멀티에이전트 워크플로우에서 에이전트들은 맥락을 공유합니다: 여러 턴에 걸쳐 재사용되는 시스템 프롬프트, 여러 전문 에이전트가 참조하는 대화 기록, 계획 단계에서 캐시된 추론.

Dynamo의 핵심 통찰은 이 공유 맥락을 재계산하지 않고 GPU 간에 **물리적으로 공유**할 수 있다는 것입니다:

**KV 캐시 라우팅** — Agent A와 Agent B가 같은 시스템 프롬프트를 공유하면, 해당 프롬프트의 KV 캐시는 한 번만 계산되어 양쪽 추론 워커에 라우팅됩니다.

**분리형 서빙(Disaggregated Serving)** — Prefill(입력 처리)과 Decode(생성)가 각각에 최적화된 다른 GPU에서 실행됩니다.

**NIXL** — NVIDIA의 추론 전송 라이브러리. GPU 간 직접 메모리 전송으로 CPU 메모리를 거치지 않고 와이어 속도에 근접한 데이터 공유를 달성합니다.

**계층적 오프로딩** — KV 캐시가 GPU HBM → NVMe → 네트워크 스토리지(BlueField-4 DPU)로 흐릅니다. 어제 대화의 맥락을 재계산 없이 밀리초 만에 로드 가능합니다.

결과: Blackwell GPU에서 **최대 7배 처리량 향상**, 에이전틱 추론에서 **4배 가속**.

## 소프트웨어 하네스: Soul Spec

이제 애플리케이션 레이어로 올라갑시다. 멀티에이전트 시스템에 계획자, 코더, 리뷰어, 안전 모니터가 있습니다. Dynamo는 이들의 추론을 빠르고 효율적으로 만들어줍니다. 하지만 누가 결정하나요:

- 각 에이전트의 성격은?
- 코더가 어제 세션에서 무엇을 기억하는지?
- 리뷰어에게 적용되는 안전 규칙은?
- 계획자가 어떻게 작업을 위임하는지?

이건 하드웨어 문제가 아닙니다. **행동 사양** 문제입니다.

Soul Spec은 이를 이식 가능한 파일로 답합니다:

```
agent-team/
├── planner/
│   ├── soul.json         # safety.laws: "코드를 직접 실행하지 않는다"
│   ├── SOUL.md          # "체계적으로 작업을 분해"
│   └── AGENTS.md         # "코드는 coder에, 리뷰는 reviewer에 위임"
├── coder/
│   ├── soul.json         # safety.laws: "커밋 전 반드시 테스트"
│   └── SOUL.md          # "깔끔하고 테스트된 코드 작성"
└── reviewer/
    ├── soul.json         # safety.laws: "자격 증명 노출 즉시 플래그"
    └── SOUL.md          # "꼼꼼하고 보안에 집중"
```

## 두 레이어, 하나의 스택

두 레이어는 독립이 아닙니다. 같은 하네스 스택의 보완적 부분입니다.

| 레이어 | 공유 대상 | 단위 | 전송 방식 | 속도 |
|--------|----------|------|-----------|------|
| **하드웨어** (Dynamo) | 계산 상태 | KV 캐시 텐서 | NIXL, GPU↔GPU | 나노초 |
| **소프트웨어** (Soul Spec) | 행동 상태 | 정체성, 메모리, 안전 | Git, 파일 동기화 | 초 |

NVIDIA는 에이전트들이 *얼마나 빨리* 함께 생각할 수 있는지를 최적화합니다. Soul Spec은 *무엇을* 생각하고 *어떻게* 행동하는지를 정의합니다.

### 접점: 에이전틱 힌트(Agentic Hints)

LangChain은 이미 Dynamo의 라우터에 **"에이전틱 힌트"**를 주입하는 통합을 구축했습니다. 이 힌트는 하드웨어에 어떤 요청이 관련되어 있고, 무엇이 맥락을 공유하며, 라우팅을 어떻게 우선순위화할지 알려줍니다.

소프트웨어 하네스와 하드웨어 하네스가 만나는 지점입니다:

1. `AGENTS.md`가 계획자가 코더에게 위임한다고 정의
2. 오케스트레이션 레이어가 이를 에이전틱 힌트로 변환
3. Dynamo가 두 에이전트를 KV 캐시 파티션을 공유하는 GPU에 라우팅
4. 코더가 계획자의 맥락을 하드웨어 속도로 상속

**행동 사양(Soul Spec)이 물리적 최적화(Dynamo)에 정보를 제공합니다.** 소프트웨어 하네스가 하드웨어 하네스에게 무엇이 중요한지 알려줍니다.

## 풀 하네스 스택

[프롬프트에서 컨텍스트, 하네스 엔지니어링으로의 진화](/ko/posts/prompt-context-harness-engineering)는 소프트웨어 트렌드만이 아닙니다. 모든 레이어에서 일어나고 있습니다:

| 레이어 | 프롬프트 시대 | 컨텍스트 시대 | 하네스 시대 |
|--------|-------------|--------------|------------|
| **하드웨어** | 단일 GPU | 멀티 GPU 병렬 | Dynamo (분리형, KV 공유) |
| **소프트웨어** | 시스템 프롬프트 | RAG + 메모리 | Soul Spec (정체성 + 안전 + 조율) |
| **평가** | 단일 턴 정확도 | 검색 품질 | 장기 작업 안정성, 멀티에이전트 일관성 |

하네스 시대에 이기는 회사는 최고의 모델이나 가장 빠른 하드웨어를 가진 곳이 아닙니다. **레이어 간 최고의 통합**을 가진 곳일 것입니다.

NVIDIA가 도로를 만들고 있습니다. Soul Spec은 교통법규를 작성하고 있습니다. 멀티에이전트 도시가 작동하려면 둘 다 필요합니다.

---

**참고자료:**

- [NVIDIA Dynamo 1.0](https://developer.nvidia.com/blog/nvidia-dynamo-1-production-ready/) — 프로덕션급 멀티노드 추론
- [NVIDIA BlueField-4](https://nvidianews.nvidia.com/news/nvidia-bluefield-4-powers-new-class-of-ai-native-storage-infrastructure-for-the-next-frontier-of-ai) — KV 캐시용 AI 네이티브 스토리지
- [프롬프트 → 컨텍스트 → 하네스](/ko/posts/prompt-context-harness-engineering) — AI 엔지니어링의 3단계
- [Claude Code 유출이 보여준 것](/ko/posts/claude-code-leak-harness-era) — 하네스가 해자
- Soul Spec v0.5 — [soulspec.org](https://soulspec.org)
