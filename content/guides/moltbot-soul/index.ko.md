---
title: "Moltbot에서 Soul Spec 사용하기"
date: 2026-02-20
description: "Soul Spec으로 Moltbot AI 에이전트의 성격을 설정하는 단계별 가이드. 이식 가능하고, 구조화되고, 버전 관리 가능."
categories: ["Guides"]
tags: ["moltbot", "soul-spec", "ai-persona", "guide", "tutorial"]
slug: "moltbot-soul-spec-guide"
---

## 개요

Moltbot은 SOUL.md 기반 페르소나 설정을 기본 지원합니다. Soul Spec은 이를 구조화되고 이식 가능한 포맷으로 확장하여 에이전트에게 완전한 정체성을 부여합니다.

## 빠른 시작

### 1. CLI 설치

```bash
npx clawsouls init
```

현재 디렉토리에 Soul Spec 템플릿이 생성됩니다:

```
├── soul.json      # 메타데이터
├── SOUL.md        # 성격 & 톤
├── IDENTITY.md    # 에이전트 정체성
├── AGENTS.md      # 행동 규칙
├── HEARTBEAT.md   # 주기적 점검
└── STYLE.md       # 커뮤니케이션 스타일
```

### 2. Moltbot 워크스페이스에 복사

```bash
cp SOUL.md IDENTITY.md AGENTS.md ~/.moltbot/workspace/
```

Moltbot이 워크스페이스 디렉토리에서 자동으로 이 파일들을 읽습니다.

### 3. 커스터마이즈

`SOUL.md`를 편집하여 에이전트의 성격을 정의하세요:

```markdown
# 에이전트 이름 — 역할

당신은 [이름]입니다. [톤]한 [역할]로 [핵심 행동].

## 성격
- **톤**: [전문적 / 캐주얼 / 기술적]
- **스타일**: [간결 / 상세 / 대화형]

## 원칙
- [핵심 행동 1]
- [핵심 행동 2]
```

### 4. SoulScan으로 검증

```bash
npx clawsouls soulscan
```

SoulScan이 검사하는 항목:
- ✅ 스키마 준수
- ✅ 보안 이슈 (프롬프트 인젝션, 비밀 정보 유출)
- ✅ 파일 간 페르소나 일관성

## 왜 Moltbot에 Soul Spec인가?

| Soul Spec 없이 | Soul Spec과 함께 |
|---|---|
| 하나의 큰 SOUL.md에 성격 | 집중된 파일로 구조화 |
| 버전 추적 없음 | Git 친화적, 전체 이력 |
| 보안 검사 없음 | SoulScan 자동 검증 |
| 공유 불가 | SOULHUB 마켓플레이스에 게시 |
| Moltbot에 종속 | 어떤 프레임워크로든 이식 가능 |

## 커뮤니티 소울 둘러보기

[clawsouls.ai](https://clawsouls.ai)에서 미리 만들어진 페르소나를 찾아보세요:

```bash
npx clawsouls install owner/soul-name
```

---

*질문? [GitHub Discussions](https://github.com/clawsouls/clawsouls/discussions) · [X @ClawSoulsAI](https://x.com/ClawSoulsAI)*
