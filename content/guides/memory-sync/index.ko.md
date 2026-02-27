---
title: "Memory Sync 가이드: AI 에이전트 메모리 암호화 동기화"
date: 2026-02-27T06:00:00+09:00
description: "AI 에이전트의 메모리 파일을 암호화하여 GitHub private repo에 동기화합니다. 키는 로컬에만 저장되어 서버가 데이터를 볼 수 없습니다."
categories: ["Guides"]
tags: ["memory-sync", "encryption", "github", "agent-memory", "guide", "tutorial"]
---

## Memory Sync란?

AI 에이전트는 시간이 지나면서 대화 기록, 선호도, 프로젝트 맥락 등을 `MEMORY.md`와 `memory/*.md` 파일에 축적합니다. **Memory Sync**는 이 파일들을 로컬에서 암호화한 뒤 GitHub private repo에 저장하여, 어떤 기기에서든 복원할 수 있게 해줍니다.

- 🔐 **종단간 암호화** — 파일이 기기를 떠나기 전에 암호화
- 🔄 **크로스 디바이스 동기화** — 노트북, 데스크톱, CI 환경 간 메모리 공유
- 📦 **GitHub 기반** — 버전 관리, 비공개, 무료

## 왜 필요한가?

| 문제 | Memory Sync 해결 |
|---|---|
| 새 기기에서 에이전트가 모든 걸 잊음 | 암호화된 메모리를 pull하여 즉시 복원 |
| 메모리 파일에 민감한 데이터 포함 | age 암호화 — 서버는 키를 모름 |
| 에이전트 지식 백업이 없음 | GitHub private repo = 자동 백업 |
| 여러 기기, 파편화된 맥락 | 하나의 암호화 repo, 어떤 기기든 |

## 사전 요구사항

- Node.js 18+
- `repo` 스코프가 있는 [GitHub Personal Access Token (PAT)](#github-pat는-어떻게-발급하나요)

## Quick Start

### 1. 초기화

```bash
npx clawsouls sync init
```

실행하면:
- GitHub PAT 입력 프롬프트
- GitHub 계정에 private repo (예: `clawsouls-memory-sync`) 자동 생성
- **age 키페어** (X25519) 생성 후 로컬에 저장

### 2. Push (암호화 & 업로드)

```bash
npx clawsouls sync push
```

로컬 메모리 파일을 암호화하여 GitHub에 push합니다.

### 3. Pull (다운로드 & 복호화)

```bash
npx clawsouls sync pull
```

GitHub에서 암호화된 파일을 pull하여 로컬에서 복호화합니다.

### 4. 상태 확인

```bash
npx clawsouls sync status
```

동기화 상태를 표시합니다: 마지막 push/pull 시각, 로컬 변경사항, 원격 차이점.

## 키 관리

암호화 키는 메모리를 복호화할 수 있는 **유일한 수단**입니다. 비밀번호처럼 관리하세요.

### 키 내보내기

```bash
npx clawsouls sync export-key
```

개인 키를 파일로 저장합니다. **안전한 곳에 보관하세요** (비밀번호 관리자, 암호화된 USB 등).

### 키 가져오기 (새 기기)

```bash
npx clawsouls sync import-key
```

다른 기기에서 개인 키를 복원하여 동기화된 메모리를 복호화할 수 있게 합니다.

> ⚠️ **키를 분실하면 암호화된 메모리를 복구할 수 없습니다.** 서버 측에 키 백업은 없습니다. `sync init` 직후 반드시 키를 내보내세요.

## 작동 원리

```
로컬 메모리 파일
       │
       ▼
  age 암호화 (X25519)
       │
       ▼
  GitHub Private Repo (암호화된 blob)
       │
       ▼
  age 복호화 (로컬 키)
       │
       ▼
  새 기기에서 메모리 복원
```

**기술 스택:**
- **[age](https://age-encryption.org/)** — X25519 키 교환 기반 최신 파일 암호화
- **GitHub API** — private repo 생성, push, pull
- **로컬 키 저장소** — 개인 키는 절대 기기를 떠나지 않음

## FAQ

### GitHub PAT는 어떻게 발급하나요?

1. [github.com/settings/tokens](https://github.com/settings/tokens)에 접속
2. **Generate new token (classic)** 클릭
3. `repo` 스코프 선택 (private repository 전체 권한)
4. 토큰을 복사하여 `sync init` 시 사용

> 💡 Fine-grained token도 사용 가능합니다 — sync repo에 대해 **Contents: Read and write** 권한을 부여하세요.

### 키를 분실하면 어떻게 하나요?

GitHub에 저장된 암호화 데이터는 **영구적으로 읽을 수 없게** 됩니다. 복구 메커니즘은 없습니다. 초기화 직후 반드시 키를 내보내세요.

키를 분실한 경우:
1. GitHub에서 기존 sync repo 삭제
2. `npx clawsouls sync init`으로 새로 시작
3. **새 키를 즉시 내보내기**

### 여러 에이전트를 동기화할 수 있나요?

네. 각 에이전트(또는 소울)별로 별도의 sync repo를 가질 수 있습니다. 각 에이전트의 작업 디렉터리에서 `sync init`을 실행하면 각각 별도의 repo와 키페어가 생성됩니다.

### GitHub에 저장된 데이터는 안전한가요?

GitHub에는 암호화된 blob만 저장됩니다. 로컬 개인 키 없이는 데이터를 랜덤 바이트와 구분할 수 없습니다. repo가 노출되더라도 내용은 암호화 상태로 유지됩니다.

### 팀에서 사용할 수 있나요?

내보낸 키를 안전한 채널을 통해 신뢰할 수 있는 팀원에게 공유하세요. 키와 GitHub 접근 권한이 있는 누구나 메모리를 push/pull할 수 있습니다.
