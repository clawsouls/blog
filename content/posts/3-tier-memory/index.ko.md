---
title: "3-Tier Memory: AI 에이전트가 절대 잊지 않는 기억 시스템"
date: 2026-03-18T00:20:00+09:00
draft: false
tags: ["soulclaw", "memory", "ai-agents", "dag", "architecture"]
categories: ["Engineering"]
description: "DAG 대화 저장소 + 시맨틱 벡터 검색 + 패시브 메모리 자동 추출을 결합한 무손실 3-Tier 장기 기억 시스템 구현기"
---

## 문제: 기억상실증에 걸린 AI 에이전트

모든 AI 에이전트 프레임워크가 공유하는 치명적 약점이 있습니다: **에이전트가 모든 것을 잊는다는 것.**

컨텍스트 윈도우는 유한합니다. 대화가 한계를 넘기면 오래된 메시지는 조용히 영구적으로 삭제됩니다. 3주 전에 내린 결정? 지난 달 언급한 기술적 선호? 사라집니다.

우리는 이것을 **Compaction 문제**라고 부릅니다. 요약 기반 정리는 뉘앙스를 잃고, 단순 잘라내기는 모든 것을 잃습니다.

## 해결: 3-Tier 메모리 아키텍처

SoulClaw v2026.3.18에 도입된 **3-Tier 메모리 시스템**은 단 하나의 대화 턴도 잃지 않으면서 빠르고 관련성 높은 검색을 보장합니다.

### Layer 1: DAG 무손실 저장소 (신규)

모든 대화 메시지가 SQLite 기반 **DAG(Directed Acyclic Graph)**에 저장됩니다:

```
Level 0: 원본 메시지 (절대 삭제 안 함)
   ↓ 10턴마다
Level 1: 청크 요약 (LLM 생성)
   ↓ 요약 10개마다
Level 2+: 상위 요약 (재귀적)
```

**핵심 설계 결정:**

- **SQLite** — 의존성 제로, 단일 파일 DB. 외부 서비스 불필요.
- **FTS5 전문 검색** — 모든 대화 기록에서 즉시 키워드 검색.
- **증분 저장** — 턴마다 새 메시지만 기록, 중복 없음.
- **계층 구조** — Level 0 원본 → Level 1+ 점진적 요약.

DAG 구조 덕분에 요약에서 원본 메시지로 항상 추적 가능합니다. **아무것도 잃지 않습니다.**

### Layer 2: 시맨틱 벡터 검색 (기존)

SoulClaw의 메모리 검색 엔진은 **임베딩 모델**(예: `bge-m3`)을 사용해 메모리 파일을 벡터로 변환합니다.

- **하이브리드 검색**: TF-IDF 키워드 매칭 + 코사인 유사도 벡터 검색
- **로컬 우선**: Ollama + `bge-m3`, 클라우드 API 불필요
- **파일 기반**: `MEMORY.md`와 `memory/*.md` 파일 인덱싱

### Layer 3: 패시브 메모리 자동 추출 (기존)

5턴마다 SoulClaw가 대화를 자동 분석해 중요 정보를 추출합니다:

- 사용자 선호와 개인 사실
- 세션 중 내린 핵심 결정
- 마감일과 약속
- 기술적 설정
- 이름과 관계

이 정보는 `memory/*.md` 파일에 자동 기록되고, Layer 2가 인덱싱해 향후 검색에 활용합니다.

## 활성화 방법

`memorySearch`가 설정되면 DAG가 자동 활성화됩니다:

```json
{
  "agents": {
    "defaults": {
      "memorySearch": {
        "provider": "local"
      }
    }
  }
}
```

SQLite DB는 `<workspace>/.dag-memory.sqlite`에 저장되며 증분 성장합니다. 참고: ~50 대화 턴 ≈ 300KB.

## 설치

```bash
npm install -g soulclaw
soulclaw onboard
```

온보딩 중 메모리 검색을 설정하면 3-tier 메모리 시스템이 자동 활성화됩니다.

---

*SoulClaw는 Soul 기반 AI 에이전트 프레임워크입니다. [clawsouls.ai](https://clawsouls.ai)에서 더 알아보세요.*
