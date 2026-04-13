---
title: "Soul Spec v0.6: 마크다운 파일 하나면 충분하다"
date: 2026-04-13T10:00:00+09:00
description: "Soul Spec을 재설계합니다. SOUL.md 하나로 AI 에이전트 페르소나를 정의할 수 있도록. 방향을 공유하고 피드백을 구합니다."
categories: ["Announcement"]
tags: ["soul-spec", "v0.6", "rfc", "ai-agents", "open-standard"]
author: "ClawSouls"
draft: false
---

두 달 전 Soul Spec v0.3을 출시했을 때, 페르소나를 만들려면 `soul.json`에 필수 필드 10개 이상, `SOUL.md`, 그리고 `specVersion`과 `version`의 차이를 이해해야 했다. 동작은 했지만, 같은 피드백이 계속 돌아왔다: *"에이전트에 성격만 넣고 싶은데 왜 이렇게 많이 필요해요?"*

맞는 말이다.

## 여기까지 어떻게 왔나

Soul Spec은 네 번의 버전을 거치며 사용자가 실제로 필요로 하는 것에 따라 진화했다:

**v0.3**은 기초를 놓았다 — 페르소나 패키지란 무엇인가? `soul.json`을 정의하고, `SOUL.md`를 성격 파일로 도입하고, 레지스트리에 퍼블리시할 수 있게 만들었다.

**v0.4**는 더 어려운 질문을 했다: 사람들이 다른 프레임워크를 쓰면? 멀티프레임워크 호환성, SoulScan 검증, 점진적 공개(progressive disclosure)를 추가했다.

**v0.5**는 물리 세계로 갔다. 로봇과 임베디드 에이전트가 1급 지원을 받았다 — 센서, 액추에이터, 아시모프에서 영감을 받은 안전 법칙. 에이전트에 몸이 있다면, 영혼도 그걸 알아야 한다.

세 버전에 걸친 핵심 트렌드 3가지:

1. **진입장벽이 계속 낮아지고 있다.** 매 버전마다 시작이 더 쉬워졌다.
2. **안전성은 계속 강화되고 있다.** SoulScan, 안전 법칙, 정적 분석 — 버전마다 레이어가 추가된다.
3. **범위가 자연스럽게 확장되고 있다.** 챗봇 → 멀티프레임워크 → 로봇 → 에이전트 생태계.

## v0.6이 바꾸는 것

핵심: **SOUL.md가 유일한 필수 파일이 된다.**

디렉토리에 마크다운 파일 하나를 넣는다. 그게 소울이다. 플랫폼이 SOUL.md의 제목과 첫 문단에서 `soul.json`을 자동 생성한다. 보일러플레이트 없음, 스키마 암기 없음, 마찰 없음.

더 많은 걸 원하는 크리에이터를 위해 3티어 시스템을 도입한다:

| 티어 | 파일 | 필수 여부 |
|------|------|----------|
| **Tier 1** (핵심) | `soul.json`, `SOUL.md` | `soul.json` 자동 생성 |
| **Tier 2** (표준) | `IDENTITY.md`, `AGENTS.md`, `STYLE.md`, `HEARTBEAT.md`, `README.md` | 선택 |
| **Tier 3** (확장) | `RULES.md`, `TOOLS.md`, `USER.md`, 커스텀 파일 | 선택 |

Tier 3이 새롭다 — 소울 팩에 **모든** `.md`, `.yaml`, `.json` 파일을 포함할 수 있다. 도구 경계, 사용자 캘리브레이션 프로필, 행동 규칙, 플랫폼별 익스포트. 당신의 소울, 당신의 구조.

## 이식성 문제

솔직한 긴장 관계가 있다: Soul Spec은 "하나의 소스, 모든 에이전트에서 사용"을 약속한다. 하지만 AGENTS.md가 OpenClaw에서만 동작하는 도구 워크플로우를 정의하고, HEARTBEAT.md가 대부분의 프레임워크에서 실행할 수 없는 자율 행동을 정의한다면 — "모든 에이전트"는 거짓말인가?

아니라고 생각하지만, 명확한 기대치 설정이 필요하다.

우리의 답은 **Core Portability Guarantee**다:

- **A등급** (어디서든 동작): `SOUL.md`, `IDENTITY.md`, `STYLE.md` — 모든 프레임워크에서 시스템 프롬프트로 변환 가능. 손실 제로.
- **B등급** (대부분 동작): `AGENTS.md`, `README.md` — 일부 프레임워크 특화 기능이 변환되지 않을 수 있음.
- **C등급** (프레임워크 특화): `HEARTBEAT.md`, `TOOLS.md`, Tier 3 파일 — 지원하는 곳에서의 보너스 기능.

HTML을 생각하면 된다. 모든 브라우저가 기본을 렌더링한다. 일부는 최신 CSS를 지원한다. 표준이 동작하는 이유는 코어가 보편적이고 나머지가 우아하게 퇴화(graceful degradation)하기 때문이다.

CLI는 `clawsouls export --target cursor|claude|openai`를 지원할 예정이다 — Core 파일을 대상 포맷으로 합치고, 변환되지 않는 부분에 대해 경고한다.

## 의견을 구합니다

v0.6 피드백을 위한 [GitHub Discussion](https://github.com/orgs/clawsouls/discussions/2)을 열었다. 구체적인 질문:

1. **최소 소울**: SOUL.md만으로 충분한가? `soul.json`은 필수로 유지해야 하나?
2. **티어 배치**: `RULES.md`는 Tier 3보다 Tier 2가 맞지 않나?
3. **셸 스크립트**: SoulScan 정적 분석 필수 조건으로 `.sh` 파일 허용을 검토 중이다. 너무 위험한가?
4. **크기 제한**: 개별 파일 100KB, 전체 1MB. 적절한가?
5. **자동 생성 soul.json**: 플랫폼이 SOUL.md에서 어떤 필드를 추출해야 하나?
6. **네이밍 규칙**: `TOOLS.md`, `RULES.md` 같은 이름을 표준화해야 하나?

Soul Spec으로 빌드하고 있거나, AI 에이전트 표준에 관심이 있거나, 의견이 있다면 — 듣고 싶다.

**[GitHub에서 논의에 참여하기](https://github.com/orgs/clawsouls/discussions/2)**

---

*Soul Spec은 AI 에이전트 페르소나를 위한 오픈 표준이다. [문서 읽기](https://docs.clawsouls.ai) 또는 [퍼블리시된 소울 둘러보기](https://clawsouls.ai).*
