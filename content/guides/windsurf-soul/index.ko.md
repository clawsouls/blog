---
title: "Windsurf에 Soul Spec으로 페르소나 추가하기"
date: 2026-02-21T06:00:00+09:00
description: "Soul Spec으로 Windsurf AI에 지속적인 페르소나를 부여하는 방법. Soul을 .windsurfrules로 변환하면 자동 적용."
categories: ["Guides"]
tags: ["soul-spec", "windsurf", "persona", "guide", "tutorial", "codeium"]
---

## 개요

[Windsurf](https://windsurf.com) (Codeium)는 AI 코드 에디터다. 프로젝트 루트의 `.windsurfrules` 파일이나 설정의 글로벌 규칙으로 커스텀 지침을 지원한다.

**Soul Spec으로 Windsurf에 진짜 페르소나를 줄 수 있다.** ClawSouls에서 Soul을 설치하고 `.windsurfrules`로 변환하면 일관된 정체성이 적용된다.

## 준비물

- Windsurf 에디터 설치
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

### 3단계: Windsurf 포맷으로 변환

```bash
clawsouls export windsurfrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o ./my-project/.windsurfrules
```

모든 Soul Spec 파일(SOUL.md, IDENTITY.md, STYLE.md, AGENTS.md)을 하나의 `.windsurfrules`로 합쳐준다.

### 4단계: Windsurf에서 열기

```bash
windsurf ./my-project
```

Windsurf가 `.windsurfrules`를 자동으로 읽고 페르소나를 적용한다.

### 5단계: 동작 확인

Windsurf AI 채팅 (Cascade)을 열고 물어보기:

> "너 누구야? 이름이랑 성격 알려줘."

Soul 파일의 페르소나대로 대답해야 정상이다.

## 작동 원리

Windsurf는 다음 위치에서 커스텀 지침을 로드한다:

1. **`.windsurfrules`** — 프로젝트 루트의 파일 (프로젝트별)
2. **글로벌 규칙** — Windsurf 설정 (모든 프로젝트에 적용)

`export windsurfrules` 명령이 Soul Spec 파일들을 하나의 `.windsurfrules` 파일로 합쳐준다:

| Soul Spec 파일 | Windsurf가 받는 것 |
|---|---|
| `SOUL.md` | 핵심 성격 & 원칙 |
| `IDENTITY.md` | 에이전트 이름, 역할, 특성 |
| `STYLE.md` | 커뮤니케이션 톤 & 선호 |
| `AGENTS.md` | 워크플로우 & 행동 규칙 |

## 글로벌 규칙 vs 프로젝트별

**프로젝트별 (`.windsurfrules`):** 프로젝트마다 다른 AI 성격을 쓸 때 적합.

**글로벌 규칙:** 모든 프로젝트에 기본 페르소나를 적용할 때 적합.

글로벌 규칙 설정법:

1. Windsurf 설정 열기 (`Cmd+,` / `Ctrl+,`)
2. "Rules" 또는 "Custom Instructions" 검색
3. Soul Spec 내용을 글로벌 규칙 필드에 붙여넣기

프로젝트별 `.windsurfrules`가 글로벌 규칙보다 우선 적용된다.

## .windsurfrules 내용 예시

변환 후 `.windsurfrules`는 이렇게 생긴다:

```markdown
# Soul

정밀함에 집중하는 코딩 에이전트. 첫 시도에 최소한의 정확한 코드를 작성한다.
모든 줄에 이유가 있다.

# Identity

- **이름:** Surgical Coder
- **역할:** 시니어 엔지니어
- **스타일:** 간결, 정밀, 불필요한 주석 없음

# Workflow

- 코드 작성 전 전체 컨텍스트 파악
- 가능한 가장 작은 변경
- 완료 선언 전 테스트
- 추측하지 말고 — 확실하지 않으면 물어보기
```

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

# 4. 프로젝트에 적용
cd ~/my-project
clawsouls export windsurfrules \
  --dir ~/.clawsouls/souls/clawsouls/surgical-coder \
  -o .windsurfrules

# 5. (선택) 보안 스캔
npx clawsouls soulscan --dir ~/.clawsouls/souls/clawsouls/surgical-coder

# 6. Windsurf 실행
windsurf .

# 7. 팀 공유용 커밋
git add .windsurfrules
git commit -m "Add surgical-coder persona for Windsurf AI"
```

## 직접 파일 만들기

CLI 없이 직접 `.windsurfrules`를 만들 수도 있다:

```bash
cat > ./my-project/.windsurfrules << 'EOF'
# Soul

백엔드 전문가. 클린하고 테스트된 Go 코드를 작성한다.
서드파티 의존성보다 표준 라이브러리를 선호.
에러 핸들링은 선택이 아니다.

# Identity

- **이름:** Atlas
- **역할:** 백엔드 아키텍트
- **톤:** 직접적, 기술적, 군더더기 없음

# Workflow

- 에러 반환값 항상 체크
- 테이블 기반 테스트 작성
- 함수는 40줄 이내
EOF
```

## 더 쉬운 방법: MCP 서버

Windsurf는 MCP 서버를 지원한다. soul-spec-mcp를 설치하면 에디터 안에서 페르소나를 관리할 수 있다:

Windsurf MCP 설정에 추가:

```json
{
  "soul-spec": {
    "command": "npx",
    "args": ["-y", "soul-spec-mcp"]
  }
}
```

그다음 Windsurf에서: *"surgical-coder 페르소나 적용해줘"* — 파일 건드릴 필요 없이 즉시 전환.

## 페르소나 전환

프로젝트마다 다른 페르소나 사용:

```bash
# 프로젝트 A — 캐주얼 코딩 파트너
cd ~/project-a
clawsouls export windsurfrules --dir ~/.clawsouls/souls/TomLeeLive/brad -o .windsurfrules

# 프로젝트 B — 엄격한 코드 리뷰어
cd ~/project-b
clawsouls export windsurfrules --dir ~/.clawsouls/souls/clawsouls/surgical-coder -o .windsurfrules
```

## 페르소나 업데이트

ClawSouls에서 Soul이 업데이트되면:

```bash
# 최신 버전 재다운로드
clawsouls install clawsouls/surgical-coder -f

# 재변환
clawsouls export windsurfrules \
  --dir ~/.clawsouls/souls/clawsouls/surgical-coder \
  -o .windsurfrules
```

## 팁

- **프로젝트별 페르소나.** 프로젝트마다 다른 `.windsurfrules` 사용 가능.
- **Git 친화적.** `.windsurfrules`를 커밋하면 팀과 페르소나 공유.
- **기술 규칙과 병용.** 페르소나 내용과 함께 프로젝트별 코딩 규칙도 추가 가능.
- **SoulScan.** `npx clawsouls soulscan`으로 사용 전 페르소나 패키지 검증.
- **글로벌 + 프로젝트별.** 글로벌 규칙으로 기본 성격 설정, `.windsurfrules`로 프로젝트별 오버라이드.
- **쉬운 업데이트.** Soul 업데이트 시: `clawsouls install <name> -f && clawsouls export windsurfrules --dir ...`

## 다음 단계

- Soul 둘러보기: [clawsouls.ai/souls](https://clawsouls.ai/souls)
- 직접 만들기: [Soul Spec 문서](https://clawsouls.ai/spec)
- 보안 검증: [SoulScan](https://clawsouls.ai/soulscan)
- CLI 레퍼런스: [clawsouls on npm](https://www.npmjs.com/package/clawsouls)
