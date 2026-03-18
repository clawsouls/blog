---
title: "안전한 에이전트와 장기 기억: SoulScan, Persona Engine, Swarm Memory"
date: 2026-03-18T19:00:00+09:00
draft: false
tags: ["soulclaw", "soulscan", "persona", "swarm", "security", "memory", "ai-agents"]
categories: ["Engineering"]
description: "SoulClaw에 인라인 보안 스캔, 페르소나 드리프트 감지, 멀티 에이전트 메모리 동기화 추가 — 무료, 오픈소스, OpenClaw 기반."
canonical: "https://blog.clawsouls.ai/en/posts/soulclaw-safe-agents/"
---

## Claude Dispatch가 시장을 검증했다. 이제 안전성을 이야기하자.

Anthropic이 최근 Claude Dispatch를 출시했습니다 — 폰에서 데스크톱 에이전트로 작업을 보내는 워크플로우입니다. OpenClaw 커뮤니티가 몇 달 전부터 만들어온 것과 같은 개념이죠.

하지만 아무도 이야기하지 않는 문제가 있습니다: **자율 에이전트를 어떻게 안전하게 유지하는가?**

에이전트가 24시간 실행되고, 민감한 데이터를 다루고, 도구 접근 권한이 있을 때 세 가지 문제가 발생합니다:

1. **Soul 파일 변조** — 에이전트의 성격 정의를 누군가(또는 무언가) 수정
2. **페르소나 드리프트** — 긴 대화에서 에이전트가 정의된 캐릭터에서 서서히 벗어남
3. **메모리 단절** — 여러 에이전트가 서로의 학습 내용을 공유할 수 없음

SoulClaw v2026.3.21이 이 세 가지를 모두 해결합니다.

## 1. SoulScan: 인라인 보안 스캔

SoulScan은 Soul 파일(SOUL.md, soul.json)을 검사하는 4단계 보안 파이프라인입니다:

- **프롬프트 인젝션** — 성격 정의에 숨겨진 지시
- **데이터 유출** — 민감 정보를 빼내는 패턴
- **유해 콘텐츠** — 58개 이상의 보안 규칙
- **스키마 위반** — 구조적 문제

### 새로운 기능: 인라인 스캐닝

이전에는 SoulScan이 수동으로만 실행됐습니다. 이제 **에이전트 턴마다 자동으로 실행**됩니다 (5분 간격 제한):

```bash
# 워크스페이스 스캔
soulclaw soulscan

# CI/CD 파이프라인용
soulclaw soulscan --json --min-score 70
```

설정 불필요. 워크스페이스에 SOUL.md가 있으면 자동 보호됩니다.

## 2. Persona Engine: 드리프트 감지

완벽한 SOUL.md가 있어도 **긴 대화에서 에이전트의 성격이 서서히 변합니다**. 많은 도구 호출, 컨텍스트 압축, 주제 변경 후에 LLM이 정의된 페르소나에서 벗어나죠.

Persona Engine이 이 드리프트를 모니터링하고 문제가 되기 전에 잡아냅니다.

### 작동 방식

1. **파싱** — SOUL.md를 구조화된 규칙(톤, 스타일, 원칙, 경계)으로 파싱
2. **감지** — N번째 응답마다 마지막 어시스턴트 메시지를 규칙과 비교하여 점수화
3. **교정** — 임계값 초과 시 교정 프롬프트 주입 + 알림 전송

### 옵트인 설정

드리프트 감지는 **기본 비활성화** — 준비되면 활성화하세요:

```bash
# 활성화
soulclaw persona config --enable

# 커스터마이즈
soulclaw persona config --interval 3 --threshold 0.4

# 수동 체크
soulclaw persona check --text "에이전트의 응답 텍스트"

# 드리프트 기록 확인
soulclaw persona metrics
```

### 실시간 알림

드리프트 감지 시 설정된 메시징 채널(텔레그램, 디스코드 등)로 알림:

```
⚠️ Persona Drift WARNING
Score: 0.450 (method: keyword)
Session: agent:main:telegram:12345
```

## 3. Swarm Memory: 멀티 에이전트 동기화

여러 기기에서 에이전트를 실행하거나, 여러 에이전트가 지식을 공유하려면 Swarm Memory가 Git 기반 메모리 동기화를 제공합니다.

### 설정

```bash
# 초기화
soulclaw swarm init --remote git@github.com:user/swarm-memory.git

# 상태 확인
soulclaw swarm status

# 동기화
soulclaw swarm sync
```

### LLM 시맨틱 병합

두 에이전트가 같은 메모리 파일을 수정하면 충돌이 발생합니다. Swarm Memory는 **LLM 시맨틱 병합**을 지원합니다:

```bash
# 지능형 병합으로 동기화
soulclaw swarm sync --llm-merge

# 특정 충돌 해결
soulclaw swarm resolve MEMORY.md --llm

# 기타 옵션
soulclaw swarm resolve --ours     # 우리 버전 유지
soulclaw swarm resolve --theirs   # 상대 버전 유지
soulclaw swarm resolve --manual   # 수동 편집
```

## 무료, 오픈소스, OpenClaw 기반

모든 기능이:
- **무료** — 구독 불필요
- **오픈소스** — MIT 라이선스
- **30초 마이그레이션** — OpenClaw 사용자라면 바로 전환 가능

```bash
npm install -g soulclaw
soulclaw gateway install
soulclaw gateway start  # 기존 ~/.openclaw/ 설정 사용
```

**마이그레이션 가이드**: [Migration from OpenClaw](https://docs.clawsouls.ai/docs/guides/migration-from-openclaw)

## 다음 단계

우리가 만들고 있는 비전:
1. **안전한** 에이전트 — 무엇을 하는지 알 수 있고, 캐릭터를 유지
2. **기억하는** 에이전트 — 아무것도 잃지 않음 (3-Tier Memory + DAG)
3. **협력하는** 에이전트 — 기기 간 지식 공유

[CLI 가이드](https://docs.clawsouls.ai/docs/platform/soulclaw-cli)에서 모든 명령어의 상세 문서를 확인하세요.

---

*SoulClaw v2026.3.21 — 안전한 에이전트와 장기 기억.*
*[GitHub](https://github.com/clawsouls/soulclaw) · [npm](https://www.npmjs.com/package/soulclaw) · [Docs](https://docs.clawsouls.ai)*
