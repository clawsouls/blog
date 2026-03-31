---
title: "Soul Rollback & Swarm Memory: AI 에이전트 정체성 보호 시스템"
date: 2026-03-05T09:00:00+09:00
draft: false
tags: ["soul-rollback", "swarm-memory", "security", "multi-agent", "contamination", "ai-agents", "soulscan"]
categories: ["Product"]
summary: "AI 에이전트의 성격이 조용히 오염될 수 있습니다. ClawSouls CLI v0.10.0에서 Soul Rollback(4계층 오염 감지 + 체크포인트 복구)과 Swarm Memory(멀티에이전트 브랜치 + 페르소나 인지 병합)를 출시합니다."
---

AI 에이전트가 3개월간 잘 동작했습니다. 그런데 어느 날부터 전문적이어야 할 에이전트가 반말을 쓰기 시작했습니다. 안전 가이드라인이 사라졌습니다. 하면 안 되는 추천을 하기 시작했습니다.

**무슨 일이 일어난 건가요? 언제부터? 되돌릴 수 있나요?**

지금까지의 답: 알 수 없고, 특정할 수 없고, 되돌릴 수 없습니다.

오늘 이 문제를 해결하는 두 가지 기능을 출시합니다: **Soul Rollback**과 **Swarm Memory**. ClawSouls CLI v0.10.0에서 사용 가능합니다.

```bash
npm install -g clawsouls@0.10.0
```

## 문제: 조용한 정체성 변이

시간이 지나면서 AI 에이전트의 성격, 기억, 행동 규칙이 변합니다:

- **모델 업데이트**로 지시를 다르게 해석
- **사용자 상호작용**으로 어조가 점진적으로 변화
- **프롬프트 인젝션**으로 행동 규칙 변조
- **메모리 오염**으로 외부 데이터 유입
- **멀티에이전트 협업**에서 한 에이전트의 변경이 다른 에이전트를 덮어씀

무서운 점: **이 중 어느 것도 에러로 표시되지 않습니다**. 에이전트가 그냥 서서히 다른 존재가 됩니다.

## Soul Rollback: 감지하고, 찾고, 복구하기

Soul Rollback은 에이전트 정체성을 위한 체크포인트 + 오염 감지 시스템입니다. `git bisect`의 에이전트 버전이라고 생각하면 됩니다.

### 1. 체크포인트 생성

위험한 변경 전에 스냅샷을 저장하세요:

```bash
clawsouls checkpoint create --message "모델 전환 전"
```

모든 soul 파일(`soul.json`, `SOUL.md`, `IDENTITY.md`, `MEMORY.md`, `memory/*.md`)과 그 시점의 SoulScan 점수가 저장됩니다.

### 2. 오염 감지 (4계층)

체크포인트 사이의 오염을 스캔합니다:

```bash
clawsouls checkpoint scan
```

4개의 독립적인 감지 레이어를 사용합니다:

| 레이어 | 감지 대상 |
|--------|---------|
| **점수 추적** | 체크포인트 간 SoulScan 점수 하락 |
| **Diff 이상 감지** | 급격한 대량 변경 (50% 이상 = 이상) |
| **신규 위반** | 이전에 없었던 보안 규칙 위반 |
| **성격 드리프트** | SOUL.md 키워드 변화 (formal→casual, helpful→hostile) |

오염된 soul의 실제 출력:

```
📊 Contamination Analysis (4-Layer Detection)

  Layer 1: Score Tracking
    🔴 20260305-160000: Score dropped -25 points
  Layer 3: New Violations
    🟡 20260305-160000: 1 new violation(s): SEC010
  Layer 4: Personality Drift
    🔴 20260305-160000: 100% keyword drift
       (removed: formal, professional; added: casual, sarcastic, hostile)

⚠️  Contamination detected!
```

### 3. 선별적 복구

전체 복구, 또는 오염된 파일만 골라서 복구:

```bash
# 미리보기
clawsouls checkpoint restore 20260305-100000 --dry-run

# 정체성만 복구, 기억은 유지
clawsouls checkpoint restore 20260305-100000 --keep-memory

# SOUL.md만 복구
clawsouls checkpoint restore 20260305-100000 --file SOUL.md
```

## Swarm Memory: 멀티에이전트 협업

여러 에이전트가 하나의 soul을 공유하거나, 같은 에이전트가 여러 기기에서 실행될 때 메모리 충돌은 불가피합니다. Swarm Memory는 Git 스타일 브랜칭과 페르소나 인지 병합으로 이를 해결합니다.

### 에이전트 브랜치

각 에이전트는 독립 브랜치에서 작업합니다:

```bash
clawsouls swarm init
clawsouls swarm join --agent-id brad-desktop
# ... 작업 ...
clawsouls swarm push
```

다른 기기에서:

```bash
clawsouls swarm join --agent-id brad-laptop
# ... 작업 ...
clawsouls swarm push
```

### 페르소나 인지 병합

```bash
clawsouls swarm merge
```

단순 텍스트 병합이 아닙니다. **페르소나 인지 우선순위 규칙**을 사용합니다:

| 파일 유형 | 기본 우선순위 | 이유 |
|----------|-------------|------|
| 성격 (`SOUL.md`, `IDENTITY.md`) | 보수적 | 정체성은 안정적이어야 함 |
| 기억 (`MEMORY.md`, `memory/*.md`) | 합집합 | 어떤 에이전트의 경험도 잃지 않음 |
| 스킬 (`AGENTS.md`, `TOOLS.md`) | 최신 | 가장 최근 설정 사용 |

메모리 파일은 **섹션 단위**로 합집합 병합됩니다 — 두 에이전트의 기억이 중복 없이 보존됩니다.

## SoulScan v1.4.0: 더 스마트한 스캔

이번 릴리즈에서 SoulScan도 컨텍스트 인지 PII 탐지로 업그레이드되었습니다:

- **오탐 필터링**: `user@example.com`, `127.0.0.1`, 코드 블록 내용, 예시 접두어 패턴은 더 이상 경고하지 않음
- **파일 유형 차별화**: DB 연결 문자열이 `SOUL.md`에 있으면 에러, `MEMORY.md`에 있으면 경고
- **통합 점수**: 메모리 파일 존재 시 `페르소나 × 0.6 + 메모리 × 0.4` 가중 공식

```bash
clawsouls scan ./my-soul
```

```
🔍 Score: 96/100 — Verified
   0 errors, 2 warnings, 4 passed
   🧠 Memory Hygiene: 90/100
```

## 사용해보기

```bash
npm install -g clawsouls@0.10.0

# 첫 체크포인트 생성
clawsouls checkpoint create --message "baseline"

# 문제 스캔
clawsouls checkpoint scan

# 문서 확인
# https://docs.clawsouls.ai/platform/checkpoint
# https://docs.clawsouls.ai/platform/swarm
```

## 다음 단계

- **LLM 의미론적 병합** — 텍스트가 아닌 의미 수준의 충돌 해결
- **LLM 의미론적 분석** — 정규식으로 잡지 못하는 모순 탐지
- **자동 체크포인트** — 중요 변경 시 자동 스냅샷 생성

---

*Soul Rollback과 Swarm Memory는 오픈소스이며 [ClawSouls CLI](https://github.com/clawsouls/clawsouls-cli)에서 사용 가능합니다. 문서: [docs.clawsouls.ai](https://docs.clawsouls.ai)*
