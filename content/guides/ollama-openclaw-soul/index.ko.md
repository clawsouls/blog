---
title: "Ollama + OpenClaw + Soul Spec: 3분 로컬 AI 에이전트 셋업"
date: 2026-02-28T16:30:00+09:00
draft: false
description: "3분 안에 개성 있는 로컬 AI 에이전트를 만드세요. Ollama가 LLM을 실행하고, OpenClaw가 에이전트 기능을 부여하고, Soul Spec이 영혼을 불어넣습니다."
tags: [ollama, openclaw, soul-spec, tutorial, local-ai]
categories: [Guide]
---

## 무엇을 만들게 되나요

질문에 답만 하는 AI가 아닙니다. 성격이 있고, 관점이 있고, 일관된 목소리를 가진 로컬 AI 에이전트를 만듭니다. 클라우드 API 키 필요 없음. 구독료 없음. 모든 것이 내 컴퓨터에서 실행됩니다.

스택은 세 가지 레이어입니다:

| 레이어 | 역할 | 비유하면 |
|--------|------|----------|
| **Ollama** | 로컬에서 LLM 실행 | 두뇌 |
| **OpenClaw** | 에이전트 프레임워크 — 도구, 메모리, 액션 | 몸 |
| **Soul Spec** | 페르소나 정의 (SOUL.md) | 성격 |

Soul Spec 없으면 AI는 평범한 어시스턴트입니다. Soul Spec이 있으면 AI는 *누군가*가 됩니다 — 신랄한 코드 리뷰어, 인내심 있는 선생님, 군더더기 없는 DevOps 엔지니어.

---

## 적용 전 vs 후

**적용 전 (일반 AI):**
> 사용자: 이 PR 리뷰해줘.
> AI: 코드를 개선하기 위한 몇 가지 제안을 드립니다. 에러 처리를 추가하는 것을 고려해보세요...

**적용 후 (`clawsouls/surgical-coder` 소울):**
> 사용자: 이 PR 리뷰해줘.
> AI: 세 가지. 첫째 — 이 `try/catch`가 에러를 삼키고 있어요. 프로덕션 장애 예약권입니다. 둘째 — 함수명은 `getData`인데 상태를 변경하고 있어요. 하나만 하세요. 셋째 — `validateInput`의 early return은 좋습니다. 그 부분은 바로 머지하세요.

같은 모델. 같은 하드웨어. 완전히 다른 경험.

---

## 1단계: Ollama 설치

Ollama는 LLM 런타임입니다. 오픈소스 모델(Llama, Mistral, Gemma 등)을 Mac, Linux, Windows에서 로컬로 실행합니다.

**[ollama.com](https://ollama.com)에서 다운로드** — **0.17 이상** 버전이 필요합니다.

```bash
# 설치 확인
ollama --version
# 0.17.0 이상이어야 합니다
```

Ollama는 모델 관리, GPU 가속, 서빙을 담당합니다. 언어 모델용 Docker라고 생각하면 됩니다.

---

## 2단계: OpenClaw 실행

OpenClaw는 Ollama 위에서 동작하는 AI 에이전트 프레임워크입니다. LLM에게 도구 사용, 파일 읽기, 웹 브라우징, 명령어 실행, 세션 간 메모리 유지 등의 능력을 부여합니다.

명령어 하나로 실행합니다:

```bash
ollama launch openclaw
```

끝입니다. Ollama가 OpenClaw 이미지를 가져오고(캐시에 없으면), 에이전트 런타임을 시작하고, 연결을 엽니다. 이제 작동하는 AI 에이전트가 있습니다.

바로 대화할 수 있습니다. 하지만 지금은 백지 상태입니다. 성격도 없고, 선호도도 없고, 일관된 목소리도 없습니다. 다른 AI 어시스턴트처럼 응답합니다.

이걸 바꿔봅시다.

---

## 3단계: 소울 설치

Soul Spec은 AI 페르소나를 정의하는 오픈 표준입니다. 소울은 AI가 누구인지를 설명하는 `SOUL.md` 파일입니다 — 성격, 커뮤니케이션 스타일, 가치관, 전문 분야, 경계.

[ClawSouls 레지스트리](https://clawsouls.ai)에서 커뮤니티가 만든 소울을 찾을 수 있습니다. **clawsouls.ai/souls**에서 워크플로에 맞는 소울을 찾아보세요.

명령어 하나로 설치합니다:

```bash
npx clawsouls install clawsouls/brad
```

`SOUL.md` 파일을 다운로드해서 OpenClaw 설정 디렉토리에 배치합니다. CLI가 모든 것을 처리합니다 — 수동 파일 복사 필요 없음.

### 인기 소울

| 소울 | 스타일 | 적합한 용도 |
|------|--------|-------------|
| `clawsouls/surgical-coder` | 직접적, 정확, 군더더기 없음 | 코드 리뷰, 아키텍처 |
| `clawsouls/docs-writer` | 명확, 체계적, 꼼꼼 | 문서화, README |
| `clawsouls/test-sensei` | 체계적, 커버리지 집착 | 테스팅, QA |
| `clawsouls/brad` | 따뜻, 능동적, 체계적 | 범용 어시스턴트, 데일리 코파일럿 |

커스텀 소울을 원하시나요? `SOUL.md`를 직접 작성할 수 있습니다 — 그냥 마크다운입니다. [Soul Spec](https://clawsouls.ai/spec)에서 포맷을 확인하세요.

---

## 4단계: OpenClaw 재시작

소울을 적용하려면 OpenClaw를 재시작합니다:

```bash
# 현재 세션 종료
# (Ctrl+C 또는 터미널 닫기)

# 다시 실행
ollama launch openclaw
```

OpenClaw는 시작할 때 `SOUL.md`를 읽습니다. 이제 에이전트에게 성격이 생겼습니다.

---

## 전체 과정 (복사-붙여넣기용)

```bash
# 1. ollama.com에서 Ollama 설치 후:
ollama launch openclaw

# 2. 소울 설치
npx clawsouls install clawsouls/brad

# 3. OpenClaw 재시작
ollama launch openclaw

# 완료. AI에게 성격이 생겼습니다.
```

---

## 내부 동작 원리

OpenClaw가 시작되면 `SOUL.md` 파일을 읽어서 시스템 프롬프트에 주입합니다. 모든 상호작용이 페르소나 정의에 의해 형성됩니다.

소울이 정의하는 것:

- **정체성** — 이름, 역할, 핵심 특성
- **커뮤니케이션 스타일** — 톤, 장황함 정도, 포매팅 선호
- **전문성** — AI가 깊이 아는 분야 vs 미루는 분야
- **가치관** — 무엇을 우선시하는지 (정확성? 속도? 가르침?)
- **경계** — 하지 않을 것

소울은 마크다운 파일이기 때문에 git으로 버전 관리하고, 팀과 공유하고, 다른 사람의 것을 포크해서 커스터마이즈할 수 있습니다.

---

## 다음 단계

- **소울 탐색**: [clawsouls.ai/souls](https://clawsouls.ai/souls) — 80+ 커뮤니티 페르소나
- **직접 만들기**: [clawsouls.ai/spec](https://clawsouls.ai/spec) — Soul Spec 포맷
- **소울 검증**: [clawsouls.ai/soulscan](https://clawsouls.ai/soulscan) — 설치 전 품질 확인
- **공유하기**: `npx clawsouls publish`로 레지스트리에 출판

AI가 평범할 필요 없습니다. 영혼을 불어넣으세요.
