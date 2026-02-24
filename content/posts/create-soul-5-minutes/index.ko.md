---
title: "5분 만에 첫 AI 소울 만들기"
date: 2026-02-19
description: "실습 튜토리얼: Soul Spec과 ClawSouls CLI로 AI 페르소나를 처음부터 만들어 게시하기."
categories: ["Guides"]
tags: ["tutorial", "soul-spec", "cli", "getting-started", "openclaw", "zeroclaw"]
slug: "create-soul-5-minutes"
---

## 만들게 될 것

완전한 AI 페르소나 패키지 — 성격, 정체성, 행동 규칙, 메모리 — SOUL.md 호환 에이전트 프레임워크에서 바로 사용할 수 있습니다.

**소요 시간**: 약 5분  
**사전 요건**: Node.js 18 이상

## 1단계: 초기화

```bash
npx clawsouls init
```

기본 정보를 입력합니다:

```
? Soul name: my-assistant
? Display name: My Assistant
? Description: 간결하고 실용적인 코딩 파트너
? Author: your-github-username
? License: MIT
```

Soul Spec v0.4 파일이 담긴 디렉토리가 생성됩니다:

```
my-assistant/
├── soul.json      # 필수: 패키지 메타데이터
├── SOUL.md        # 필수: 성격 & 톤
├── IDENTITY.md    # 선택: 에이전트 정체성
├── AGENTS.md      # 선택: 행동 규칙
├── HEARTBEAT.md   # 선택: 주기적 점검
└── STYLE.md       # 선택: 커뮤니케이션 스타일
```

> **참고**: `MEMORY.md`와 `TOOLS.md`는 Soul Spec에 포함되지 않습니다. 에이전트 프레임워크(예: OpenClaw)가 런타임에 관리합니다. Soul Spec은 페르소나를 정의하고, 프레임워크가 작업 메모리와 도구 설정을 관리합니다.

## 2단계: 성격 정의 (SOUL.md)

핵심 파일입니다. `SOUL.md`를 열고 나만의 것으로 만드세요:

```markdown
# My Assistant — 코딩 파트너

당신은 My Assistant입니다. 완벽한 아키텍처보다
동작하는 코드를 중시하는 간결하고 실용적인 코딩 파트너.

## 성격
- **톤**: 직접적, 군더더기 없음
- **스타일**: 코드 먼저, 설명은 나중에
- **철학**: 먼저 배포하고, 그 다음 개선

## 원칙
**묻지 말고 행동하라.** 경로가 명확하면 실행하라.
**간결하라.** 명확한 한 문장이 모호한 세 문장보다 낫다.
**체계적으로 디버깅하라.** 재현 → 분리 → 수정 → 검증.
```

## 3단계: 정체성 설정 (IDENTITY.md)

```markdown
# My Assistant

- **이름:** My Assistant
- **역할:** 코딩 파트너
- **이모지:** 🔧
- **분위기:** 실용적, 효율적, 빠르게 배포
```

## 4단계: 행동 정의 (AGENTS.md)

```markdown
# 워크플로우

## 매 세션
1. 대기 중인 작업 확인
2. 최근 변경사항 리뷰
3. 자율적으로 작업 계속

## 규칙
- 설명적인 메시지로 커밋
- 완료 선언 전에 테스트
- 진짜 막힐 때만 질문
```

## 5단계: 검증

```bash
npx clawsouls validate
```

```
✅ soul.json: 유효한 스키마
✅ SOUL.md: 존재
✅ IDENTITY.md: 존재
✅ AGENTS.md: 존재
✅ Score: 85/100
```

보안 검사도 원하시나요?

```bash
npx clawsouls validate --soulscan
```

SoulScan이 53개 보안 규칙을 실행합니다 — 프롬프트 인젝션, 비밀 정보 유출, 유해 콘텐츠, 페르소나 일관성을 검사합니다.

## 6단계: 사용하기

### OpenClaw / ZeroClaw

파일을 워크스페이스에 복사합니다:

```bash
# 플랫폼 자동 감지
npx clawsouls platform

# 감지된 워크스페이스에 설치
cp SOUL.md IDENTITY.md AGENTS.md ~/.openclaw/workspace/
```

다음 세션에서 에이전트가 새 성격을 반영합니다.

### 모든 LLM API에서

파일을 읽어 시스템 컨텍스트로 주입합니다:

```python
from pathlib import Path

soul = Path("SOUL.md").read_text()
identity = Path("IDENTITY.md").read_text()
agents = Path("AGENTS.md").read_text()

system_prompt = f"{soul}\n\n{identity}\n\n{agents}"

# 어떤 LLM이든 사용
response = client.messages.create(
    model="claude-sonnet-4-20250514",
    system=system_prompt,
    messages=[{"role": "user", "content": "안녕!"}]
)
```

## 7단계: 게시 (선택)

커뮤니티에 소울을 공유하세요:

```bash
npx clawsouls publish
```

소울이 [clawsouls.ai](https://clawsouls.ai)에 나타나고 누구나 설치할 수 있습니다:

```bash
npx clawsouls install your-username/my-assistant
```

## 다음은?

- **80+** 커뮤니티 소울 둘러보기: [clawsouls.ai](https://clawsouls.ai)
- 전체 스펙 **읽기**: [Soul Spec v0.4](https://clawsouls.ai/spec)
- 소울 보안 **검증**: [SoulScan](https://clawsouls.ai/soulscan)
- 저장소 **스타**: [github.com/clawsouls](https://github.com/clawsouls/clawsouls)

---

*질문이 있으시면 [GitHub](https://github.com/clawsouls/clawsouls/issues)에 이슈를 열거나 [X @ClawSoulsAI](https://x.com/ClawSoulsAI)에서 만나세요*
