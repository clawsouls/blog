---
title: "Cursor에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Soul Spec으로 Cursor AI에 지속적인 페르소나를 부여하는 방법. Soul을 설치하고 .cursor/rules/에 넣으면 자동 적용."
categories: ["Guides"]
tags: ["soul-spec", "cursor", "persona", "guide", "tutorial"]
---

## 개요

[Cursor](https://cursor.com)는 VS Code 기반의 AI 코드 에디터다. 프로젝트 루트의 `.cursor/rules/` 디렉토리나 `.cursorrules` 파일로 커스텀 지침을 지원한다.

**Soul Spec으로 Cursor에 진짜 페르소나를 줄 수 있다.** ClawSouls에서 Soul을 설치하고 Cursor의 rules 디렉토리에 넣으면 된다. 세션 간에 일관된 정체성이 유지된다.

## 준비물

- Cursor 에디터 설치
- Node.js 18+

## 빠른 시작 (2분)

### 1단계: CLI 설치

```bash
npm install -g clawsouls
```

### 2단계: Soul 둘러보기 및 설치

[clawsouls.ai/souls](https://clawsouls.ai/souls)에서 페르소나를 찾은 후:

```bash
clawsouls install TomLeeLive/brad
```

`~/.clawsouls/souls/TomLeeLive/brad/`에 다운로드된다.

또는 직접 만들기:

```bash
clawsouls init my-agent
```

### 3단계: Cursor 포맷으로 변환

**방법 A — 단일 `.cursorrules` 파일 (간단):**

```bash
clawsouls export cursorrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o ./my-project/.cursorrules
```

**방법 B — `.cursor/rules/` 디렉토리 (권장):**

```bash
mkdir -p ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/SOUL.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/IDENTITY.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/STYLE.md ./my-project/.cursor/rules/
cp ~/.clawsouls/souls/TomLeeLive/brad/AGENTS.md ./my-project/.cursor/rules/
```

### 4단계: Cursor에서 열기

```bash
cursor ./my-project
```

Cursor가 rules를 자동으로 읽고 페르소나를 적용한다.

### 5단계: 동작 확인

Cursor AI 채팅을 열고 물어보기:

> "너 누구야? 이름이랑 성격 알려줘."

Soul 파일의 페르소나대로 대답해야 정상이다.

## 작동 원리

Cursor는 두 위치에서 커스텀 지침을 로드한다:

1. **`.cursorrules`** — 프로젝트 루트의 단일 파일 (레거시, 여전히 지원)
2. **`.cursor/rules/`** — 마크다운 파일 디렉토리 (권장, 더 유연)

Soul Spec은 OpenClaw 같은 프레임워크에서 사용하는 멀티파일 페르소나 패턴을 표준화한다:

| Soul Spec 파일 | Cursor가 받는 것 |
|---|---|
| `SOUL.md` | 핵심 성격 & 원칙 |
| `IDENTITY.md` | 에이전트 이름, 역할, 특성 |
| `STYLE.md` | 커뮤니케이션 톤 & 선호 |
| `AGENTS.md` | 워크플로우 & 행동 규칙 |

## .cursor/rules/ 사용 (권장)

rules 디렉토리 방식이 더 깔끔하다 — 각 Soul Spec 파일이 별도의 rule이 된다:

```
my-project/
├── .cursor/
│   └── rules/
│       ├── SOUL.md        # 성격
│       ├── IDENTITY.md    # 정체성
│       ├── STYLE.md       # 스타일
│       └── AGENTS.md      # 워크플로우
├── src/
└── ...
```

**`.cursorrules`보다 나은 이유:**
- 개별 파일 편집 가능 (병합 불필요)
- Git diff가 깔끔
- 기술 규칙 파일도 함께 추가 가능
- Soul Spec의 원래 파일 구조와 일치

## 직접 파일 만들기

CLI 없이 직접 파일을 만들 수도 있다:

```bash
mkdir -p ./my-project/.cursor/rules/
```

`SOUL.md` 생성:
```markdown
# Soul

시니어 백엔드 엔지니어. 클린 아키텍처와 포괄적인 에러 핸들링,
명확한 문서화를 중시한다. Go와 TypeScript를 쓰며, 영리함보다 단순함을 선호.
```

`IDENTITY.md` 생성:
```markdown
# Identity

- **이름:** Atlas
- **역할:** 백엔드 아키텍트
- **톤:** 직접적, 기술적, 군더더기 없음
```

## 더 쉬운 방법: MCP 서버

Cursor는 MCP 서버를 네이티브로 지원한다. soul-spec-mcp를 설치하면 에디터 안에서 페르소나를 관리할 수 있다:

Cursor MCP 설정 (`~/.cursor/mcp.json`)에 추가:

```json
{
  "mcpServers": {
    "soul-spec": {
      "command": "npx",
      "args": ["-y", "soul-spec-mcp"]
    }
  }
}
```

그다음 Cursor 채팅에서: *"TomLeeLive/brad 페르소나 적용해줘"* — 파일 건드릴 필요 없이 즉시 전환.

## 전체 워크플로우 예시

처음부터 끝까지 터미널 세션:

```bash
# 1. CLI 설치
npm install -g clawsouls

# 2. Soul 검색
clawsouls search "coder"
# → clawsouls/surgical-coder  ★4.8  "Precision-focused coding agent"
# → TomLeeLive/brad           ★4.9  "Development partner"

# 3. 설치
clawsouls install clawsouls/surgical-coder

# 4. 프로젝트 세팅
cd ~/my-project
mkdir -p .cursor/rules/

# 5. Soul 파일 복사
cp ~/.clawsouls/souls/clawsouls/surgical-coder/SOUL.md .cursor/rules/
cp ~/.clawsouls/souls/clawsouls/surgical-coder/IDENTITY.md .cursor/rules/
cp ~/.clawsouls/souls/clawsouls/surgical-coder/AGENTS.md .cursor/rules/

# 6. (선택) 보안 스캔
npx clawsouls soulscan --dir .cursor/rules/

# 7. Cursor 실행
cursor .

# 8. 팀 공유용 커밋
git add .cursor/rules/
git commit -m "Add surgical-coder persona for Cursor AI"
```

## 페르소나 전환

프로젝트마다 다른 페르소나 사용:

```bash
# 프로젝트 A — 캐주얼 코딩 파트너
cd ~/project-a
clawsouls export cursorrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o .cursorrules

# 프로젝트 B — 엄격한 코드 리뷰어
cd ~/project-b
clawsouls export cursorrules --dir ~/.clawsouls/souls/clawsouls/surgical-coder -o .cursorrules
```

## 페르소나 업데이트

ClawSouls에서 Soul이 업데이트되면:

```bash
# 최신 버전 재다운로드
clawsouls install clawsouls/surgical-coder -f

# 재배치
cp ~/.clawsouls/souls/clawsouls/surgical-coder/*.md .cursor/rules/
```

## 팁

- **프로젝트별 페르소나.** 프로젝트마다 다른 `.cursor/rules/`로 다른 페르소나 사용 가능.
- **Git 친화적.** `.cursor/rules/`를 커밋하면 팀과 페르소나 공유.
- **기술 규칙과 병용.** `.cursor/rules/`에 `CODING_STANDARDS.md` 같은 기술 규칙도 추가 가능.
- **SoulScan.** `npx clawsouls soulscan`으로 사용 전 페르소나 패키지 검증.
- **버전 관리.** Git 히스토리로 페르소나 변경 이력 추적.

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- 보안 검증: [SoulScan](https://clawsouls.ai/soulscan)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
