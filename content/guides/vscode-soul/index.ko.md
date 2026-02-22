---
title: "VS Code에서 Soul Spec 사용하기"
date: 2026-02-22T09:00:00+09:00
description: "Soul Spec VS Code 확장으로 에디터에서 바로 AI 페르소나를 검색, 설치, 관리한다. 사이드바에서 80개 이상의 커뮤니티 소울에 접근 가능."
categories: ["Guides"]
tags: ["soul-spec", "vscode", "extension", "persona", "guide", "tutorial"]
draft: false
---

## 개요

**Soul Spec** VS Code 확장은 ClawSouls 페르소나 레지스트리를 에디터 안에서 바로 사용할 수 있게 해준다. 사이드바에서 80개 이상의 커뮤니티 소울을 검색하고, 원클릭으로 설치하고, 원하는 플랫폼용으로 내보내기까지 — 에디터를 떠날 필요가 없다.

## 확장 설치

### 방법 A: 마켓플레이스에서 설치

1. VS Code를 연다
2. `Ctrl+Shift+X` (Mac은 `Cmd+Shift+X`)로 확장 패널을 연다
3. **"Soul Spec"**을 검색한다
4. **Install** 클릭

또는 마켓플레이스에서 직접 설치: [Soul Spec — VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=clawsouls.soul-spec)

### 방법 B: VSIX로 설치

수동 설치 또는 오프라인 환경:

1. [GitHub 릴리스 페이지](https://github.com/clawsouls/vscode-soul-spec/releases)에서 `.vsix` 파일을 다운로드한다
2. VS Code → 확장 패널 (`Ctrl+Shift+X`)
3. 우측 상단 **`...`** 메뉴 클릭
4. **Install from VSIX...** 선택
5. 다운로드한 `.vsix` 파일을 선택한다

## 기능

### Soul Browser

설치 후 사이드바에 **Soul Browser** 패널이 나타난다. ClawSouls 레지스트리에 연결되어 80개 이상의 커뮤니티 소울을 검색하고 필터링할 수 있다.

소울을 클릭하면 설명, 성격 특성, 설정을 미리 볼 수 있다.

### Install Soul

VS Code에서 바로 프로젝트에 소울을 설치한다:

- 커맨드 팔레트 열기: `Cmd+Shift+P` (Mac) 또는 `Ctrl+Shift+P` (Windows/Linux)
- **"Soul Spec: Install Soul"** 실행
- 목록에서 소울을 선택하면 끝

소울 파일이 프로젝트 루트에 추가된다.

### Init — 새 소울 만들기

직접 페르소나를 만들고 싶다면:

- 커맨드 팔레트 → **"Soul Spec: Init"**

필수 필드가 포함된 `soul.json` 템플릿이 생성된다.

### 플랫폼별 내보내기

설치된 소울을 다양한 AI 플랫폼용으로 내보낼 수 있다:

| 플랫폼 | 내보내기 형식 |
|----------|-------------|
| **Claude Code** | `CLAUDE.md` |
| **Cursor** | `.cursorrules` |
| **Windsurf** | `.windsurfrules` |

커맨드 팔레트에서 **"Soul Spec: Export"**를 실행하고 대상 플랫폼을 선택한다.

### soul.json 유효성 검사

`soul.json` 파일을 실시간으로 검증한다. 스키마 오류, 누락된 필드, 잘못된 값을 입력 즉시 표시해준다 — 별도 린터가 필요 없다.

### 상태 바 배지

프로젝트에 소울이 활성화되어 있으면 상태 바에 Soul Spec 배지가 나타난다. 클릭하면 빠른 액션 메뉴를 사용할 수 있다.

## 빠른 시작

1. [마켓플레이스](https://marketplace.visualstudio.com/items?itemName=clawsouls.soul-spec)에서 확장을 **설치**한다
2. 사이드바에서 **Soul Browser**를 연다
3. 레지스트리를 검색하거나 둘러보며 **소울을 선택**한다
4. **설치** — 원클릭으로 프로젝트에 추가
5. **끝** — AI 도구에 페르소나가 적용된다

## 다음 단계

- [Claude Code에 페르소나 추가하기](/guides/claude-code-soul/)
- [Cursor에 페르소나 추가하기](/guides/cursor-soul/)
- [Windsurf에 페르소나 추가하기](/guides/windsurf-soul/)
- [Soul Spec MCP 사용하기](/guides/soul-spec-mcp/)
