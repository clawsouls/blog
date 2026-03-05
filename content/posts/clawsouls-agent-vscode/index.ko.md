---
title: "ClawSouls Agent 출시: 에디터 안의 AI 에이전트"
date: 2026-03-05T09:30:00+09:00
draft: false
tags: ["clawsouls", "vscode", "ai-agent", "swarm-memory", "soulscan"]
categories: ["launch"]
description: "AI 에이전트에 성격을 부여하는 VSCode 확장. 팀 메모리 공유, 보안 스캔, 암호화 — 설치 한 번으로 끝."
---

## 문제

AI 코딩 어시스턴트는 매번 당신을 처음 만나는 사람처럼 대한다. 탭을 닫으면 맥락이 사라지고, 도구를 바꾸면 처음부터 시작해야 한다.

만약 AI 에이전트가:
- 세션을 넘어 **기억**할 수 있다면?
- 팀의 다른 에이전트와 **지식을 공유**할 수 있다면?
- PII와 프롬프트 인젝션을 **자동으로 스캔**할 수 있다면?

## ClawSouls Agent

[ClawSouls Agent](https://clawsouls.ai/agent)는 VSCode에서 동작하는 무료 확장입니다.

### 설치 한 번으로 끝 (Zero Setup)

설치 → API 키 입력 → 대화 시작. 터미널 명령어 없음. 서버 설정 없음. OpenClaw이 확장 안에 내장되어 있습니다.

### 성격 있는 AI 채팅

에이전트는 단순한 챗봇이 아닙니다 — **소울(Soul)**이 있습니다. [ClawSouls 마켓플레이스](https://clawsouls.ai/souls)에서 골라 설치하거나, 직접 만드세요. 성격은 세션을 넘어 유지됩니다.

### Swarm Memory: 팀 지식 공유

킬러 피처입니다. 개발팀의 AI 에이전트들이 협업합니다:

```
에이전트 A (백엔드) ──branch──→ Git Repo ←──branch── 에이전트 B (프론트엔드)
                                    ↓
                              Merge Engine
```

각 에이전트가 독립적으로 학습하고, merge하면 지식이 합쳐집니다. 로컬 Ollama를 통한 LLM 시맨틱 병합으로 충돌도 자동 해결됩니다.

**팀의 AI 에이전트가 서로에게서 배울 수 있습니다.**

팀원이 퇴사하면 암호화 키를 원클릭으로 교체. 지식은 남고, 접근 권한은 사라집니다.

### SoulScan 보안

저장할 때마다 자동 보안 스캔:
- PII 탐지 (API 키, 이메일, 비밀번호)
- 프롬프트 인젝션 탐지
- 파일 간 모순 분석
- 에디터에 인라인으로 경고 표시 (린터처럼)

### Soul 체크포인트

성격 스냅샷 저장 및 복원. 4계층 오염 감지로 정체성 드리프트를 사전에 차단합니다.

### Age 암호화

팀 메모리는 [age](https://age-encryption.org/)로 종단간 암호화됩니다. 각 팀원이 자신의 키를 관리합니다. 모든 것이 GUI 버튼으로 — 터미널 불필요.

## 차별점

| 기능 | Cursor/Copilot | ClawSouls Agent |
|------|---------------|-----------------|
| 지속되는 성격 | ❌ | ✅ Soul 파일 |
| 팀 메모리 공유 | ❌ | ✅ Swarm Memory |
| 보안 스캔 | ❌ | ✅ SoulScan |
| 정체성 보호 | ❌ | ✅ 체크포인트 |
| 암호화 협업 | ❌ | ✅ Age 암호화 |
| 오픈 소스 | ❌ | ✅ 영원히 무료 |

## 시작하기

1. VSCode Marketplace에서 "ClawSouls Agent" 검색
2. 또는 [clawsouls.ai/agent](https://clawsouls.ai/agent) 방문

무료, 오픈 소스. 커뮤니티 에디션은 영원히 무료입니다.

---

*[ClawSouls](https://clawsouls.ai) — AI 에이전트 페르소나 오픈 플랫폼*
