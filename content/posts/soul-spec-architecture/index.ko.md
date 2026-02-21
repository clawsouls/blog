---
title: "Soul Spec 아키텍처: 왜 성격을 파일로 나누는가"
date: 2026-02-17
description: "Soul Spec v0.4의 설계 결정 — AI 페르소나 설정에 관심사의 분리가 필요한 이유."
categories: ["Technical"]
tags: ["soul-spec", "architecture", "design", "ai-persona", "separation-of-concerns"]
slug: "soul-spec-architecture"
---

## 하나의 거대한 프롬프트의 문제

오늘날 대부분의 AI 에이전트는 하나의 시스템 프롬프트에서 성격을 부여받습니다. 동작하긴 합니다 — 그러다 안 될 때까지.

전형적인 "성격 프롬프트"는 이런 모습입니다:

```
너는 Alex라는 친근한 코딩 어시스턴트야. 캐주얼하게 말하고
이모지를 사용해. 사용자가 Python을 선호한다는 걸 기억해.
데이터베이스 질문에는 PostgreSQL을 추천해. 정치 이야기는 하지 마.
도구: 파일 리더, 웹 검색, 터미널...
```

성격, 기억, 행동 규칙, 도구 설정 — 전부 하나의 문자열에. 이건 애플리케이션 전체를 하나의 파일에 작성하는 것과 같습니다.

## 멀티 파일 패턴

OpenClaw 같은 에이전트 프레임워크는 이미 페르소나 설정을 분리된 파일로 관리합니다 — 성격은 SOUL.md, 메타데이터는 IDENTITY.md, 행동 규칙은 AGENTS.md, 지식은 MEMORY.md. 이건 수천 명의 개발자가 매일 사용하는 검증된 패턴입니다.

Soul Spec은 이 기반 위에 만들어졌습니다. 파일 분리를 발명한 것이 아니라 — **버전 관리(`soul.json`), 보안 검증(SoulScan), 크로스 프레임워크 호환성을 갖춘 오픈 스펙으로 공식화**한 것입니다.

Soul Spec v0.4의 전체 구조:

```
my-agent/
├── soul.json      # 패키지 메타데이터 (이름, 버전, 작성자, 라이선스)
├── SOUL.md        # 핵심 성격과 톤
├── IDENTITY.md    # 에이전트의 정체 (이름, 역할, 아바타)
├── AGENTS.md      # 행동 규칙과 워크플로우
├── STYLE.md       # 커뮤니케이션 스타일 가이드
└── HEARTBEAT.md   # 주기적 점검 행동
```

각 파일은 정확히 하나의 역할을 합니다.

## 설계 결정 1: SOUL.md vs IDENTITY.md

왜 "에이전트가 누구인가"에 두 개의 파일이 필요한가?

**SOUL.md**는 에이전트가 *어떻게* 행동하는지를 정의합니다 — 톤, 철학, 원칙. 성격입니다.

**IDENTITY.md**는 에이전트가 *무엇인지*를 정의합니다 — 이름, 역할, 이모지, 아바타. 메타데이터입니다.

이 분리가 중요한 이유: 같은 성격에 다른 정체성을 가질 수 있기 때문입니다. "전문적이고 직접적인" 소울은 "개발 파트너 Brad"가 될 수도, "프로젝트 매니저 Alice"가 될 수도 있습니다. 같은 소울, 다른 정체성.

## 설계 결정 2: 프레임워크는 메모리에 일반 파일을 사용한다

OpenClaw 같은 프레임워크는 벡터 데이터베이스 대신 일반 마크다운 파일을 메모리로 사용합니다. Soul Spec은 이 선택을 존중합니다. 왜 이것이 동작할까요?

1. **읽기 쉬움**: 파일을 열면 에이전트가 아는 것이 보임
2. **편집 가능**: 잘못된 기억은 텍스트 에디터로 수정
3. **이식성**: 파일을 다른 머신에 복사하면 끝
4. **버전 관리**: Git이 모든 기억 변경을 추적

벡터 DB의 임베딩으로 이걸 시도해 보세요.

## 설계 결정 3: 도구를 위한 soul.json

매니페스트 파일(`soul.json`)은 순전히 도구를 위해 존재합니다 — CLI 유효성 검증, 마켓플레이스 퍼블리싱, 의존성 추적. Node.js의 `package.json`에서 영감을 받았습니다.

```json
{
  "name": "brad",
  "version": "1.2.0",
  "specVersion": "0.4",
  "description": "Professional development partner",
  "author": "TomLeeLive",
  "license": "MIT",
  "persona": {
    "displayName": "Brad",
    "role": "Development Partner",
    "tags": ["coding", "professional", "autonomous"]
  }
}
```

사람은 SOUL.md를 읽고, 기계는 soul.json을 읽습니다. 둘 다 필요합니다.

## 설계 결정 4: 프레임워크 비종속

Soul Spec 파일은 일반 마크다운과 JSON입니다. SDK 불필요. 런타임 의존성 없음. 파일을 읽을 수 있는 모든 프레임워크가 Soul Spec을 사용할 수 있습니다.

이것이 아마 가장 중요한 속성입니다. OpenSouls는 TypeScript 런타임 엔진을 만들었습니다. 개발자들이 다른 스택으로 이동하자 OpenSouls는 따라갈 수 없었습니다. OpenClaw 같은 프레임워크가 개척한 멀티 파일 마크다운 패턴은 본질적으로 이식 가능하기 때문에 이 문제를 피합니다. Soul Spec의 역할은 그 이식성을 명시적이고 크로스 프레임워크적으로 만드는 것입니다.

현재 테스트된 프레임워크:
- OpenClaw
- ZeroClaw

하지만 무엇이든 동작합니다. LangChain, CrewAI, 직접 API 호출 — 시스템 프롬프트에 텍스트를 주입할 수 있다면 Soul Spec 파일을 사용할 수 있습니다.

## 의도적으로 제외한 것

Soul Spec은 의도적으로 포함하지 **않습니다**:
- **대화 이력 형식** — 프레임워크의 역할
- **런타임 파일** — MEMORY.md와 TOOLS.md는 프레임워크가 관리, 스펙에 미포함
- **모델 선택** — 페르소나는 모델에 비종속이어야 함
- **실행 로직** — 코드 없음, 설정만

스펙은 에이전트가 *무엇이어야 하는지*를 정의하지, *어떻게 실행되는지*는 정의하지 않습니다.

## 시작하기

```bash
npx clawsouls init
```

v0.4 템플릿을 생성합니다. 파일을 편집하고, 원하는 프레임워크에서 사용하세요.

---

*전체 스펙 읽기: [Soul Spec v0.4](https://clawsouls.ai/spec) · Soul 둘러보기: [clawsouls.ai](https://clawsouls.ai)*
