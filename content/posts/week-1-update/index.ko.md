---
title: "1주차: SoulScan 출시, Soul Spec v0.4, 그리고 80개의 소울"
date: 2026-02-20T22:00:00+09:00
description: "주간 업데이트 — SoulScan 보안 스캐너 출시, Soul Spec v0.4 릴리스, 커뮤니티 성장, 그리고 앞으로의 계획."
categories: ["Weekly Update"]
tags: ["weekly", "soulscan", "soul-spec", "community", "update"]
slug: "week-1-update"
---

## 이번 주 주요 소식

### 🛡️ SoulScan 출시

이번 주 가장 주목할 만한 소식은 AI 페르소나 패키지를 위한 자동화된 보안 스캐너, [SoulScan](https://clawsouls.ai/soulscan)의 출시입니다.

**주요 기능**: 53개의 보안 규칙을 통해 소울 패키지를 검사합니다. 프롬프트 인젝션, 비밀 정보 유출, 유해 콘텐츠, 페르소나 일관성 위반 등을 탐지합니다.

**중요성**: AI 페르소나 패키지가 점점 더 널리 사용되면서 공급망 공격의 위험이 커지고 있습니다. SoulScan은 이러한 패키지를 설치하기 전에 검증할 수 있도록 설계된 최초의 도구입니다.

ClawSouls의 모든 소울에는 보안 배지가 표시됩니다:
- 🟢 **통과** (0-100 점수)
- 🟡 **주의** (문제 발견, 치명적이지 않음)
- 🔴 **실패** (보안 위험 탐지)

80개의 소울 스캔 결과: 11개 통과, 69개 주의, 0개 실패.

스캔 규칙은 [오픈 소스](https://github.com/clawsouls/scan-rules)로 제공됩니다. 어떤 항목을 검사하는지 직접 확인해 보세요.

### 📋 Soul Spec v0.4 릴리스

스펙이 크게 업데이트되었습니다:

**v0.4 주요 변경 사항**:
- `STYLE.md` — 커뮤니케이션 스타일 전용 파일 추가
- `HEARTBEAT.md` — 주기적 점검 행동 파일 추가
- `recommendedSkills` 필드가 `skills` 필드로 대체됨
- Deprecated: `modes`, `interpolation` 필드

**변경 이유**: 실제 사용 사례에서 스타일 가이드라인과 하트비트 행동이 독립된 파일로 관리될 필요성이 확인되었습니다. 모든 내용을 SOUL.md에 포함시키는 것은 스펙이 해결하려던 모놀리식 문제를 오히려 악화시킬 수 있었습니다.

### 📊 커뮤니티 현황

| 지표 | 수치 |
|---|---|
| 게시된 소울 | 80 |
| 등록 사용자 | 7 |
| CLI 버전 | v0.4.2 |
| 지원 플랫폼 | 5 |
| SoulScan 규칙 | 53 |
| npm CLI 다운로드 | 600+ |

### 🔬 연구

포지션 페이퍼 "Soul-Driven Interaction Design"이 Zenodo에 게시되었습니다 ([DOI: 10.5281/zenodo.18678616](https://doi.org/10.5281/zenodo.18678616)). 의미 있는 데이터를 확보한 후, 실증적인 후속 연구를 계획 중입니다.

## 배운 점

**Context Engineering은 현실입니다.** Anthropic이 "Effective Context Engineering" 블로그 포스트를 게시하며 Soul Spec의 핵심 논제를 뒷받침했습니다: 구조화된 컨텍스트는 모놀리식 프롬프트를 능가합니다.

**런타임 엔진의 한계.** OpenSouls(⭐294)가 서비스를 종료한 것으로 보입니다. 웹사이트, 문서, 대부분의 저장소가 사라졌습니다.

**표준화는 위원회가 아닌 채택에서 시작됩니다.** 이번 주에는 표준화 문제를 심도 있게 탐구했습니다.

## 다음 주 계획

1. **사용자 확보** — Reddit, X, 개발자 커뮤니티에서 활동 강화
2. **최초 외부 소울 등록** — 팀 외부의 사용자가 소울을 퍼블리시하도록 유도
3. **블로그 일정** — 일일 포스팅 계획
4. **플랫폼 가이드 SEO** — 지원되는 각 프레임워크별 전용 페이지 제작

## 참여 방법

- **소울 둘러보기**: [clawsouls.ai](https://clawsouls.ai)
- **나만의 소울 만들기**: `npx clawsouls init`
- **저장소 스타**: [github.com/clawsouls](https://github.com/clawsouls/clawsouls)
- **업데이트 팔로우**: [X @ClawSoulsAI](https://x.com/ClawSoulsAI)

---

*다음 주에 만나요. 프롬프트가 아니라 소울을 전달하세요.*
