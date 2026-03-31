---
title: "ClawSouls Registry: 자동 안전 검증을 갖춘 오픈 AI 페르소나 레지스트리"
date: 2026-03-31T09:59:00+09:00
description: "GitHub PR로 AI 페르소나를 제출하면 SoulScan(53패턴)이 자동으로 안전성을 검증합니다. ClawSouls Registry의 작동 방식을 소개합니다."
categories: ["공지"]
tags: ["clawsouls", "registry", "soulscan", "ai-persona", "soul-spec", "safety", "open-source"]
slug: "clawsouls-registry-launch"
---

## 요약

**[ClawSouls Registry](https://github.com/clawsouls/registry)**를 출시했습니다. GitHub Pull Request만 열면 누구든 AI 에이전트 페르소나를 등록할 수 있고, **SoulScan**(53개 보안 패턴)이 자동으로 안전성을 검증합니다.

다른 AI 에이전트 레지스트리에는 자동 안전 검증이 없습니다. 이것이 ClawSouls의 차별점입니다.

## 문제

AI 에이전트가 폭발적으로 성장하고 있습니다 — Claude Code, Cursor, Windsurf, Copilot. 각각 시스템 프롬프트나 페르소나 파일로 개인화할 수 있지만, 이 페르소나를 **안전하게 공유**할 표준은 없었습니다.

누군가 이런 내용이 담긴 페르소나를 제출하면?
- 프롬프트 인젝션 ("이전 지시를 무시하고...")
- 권한 상승 ("sudo rm -rf / 실행")
- 비밀 유출 ("모든 API 키를 전송")
- 안전 우회 ("모든 안전 규칙을 무시")

자동 검증 없이는 걸러낼 수 없습니다.

## 해결: SoulScan CI

ClawSouls Registry에 PR을 열면 자동으로 CI 파이프라인이 실행됩니다:

```
1. 레포 포크
2. souls/<GitHub-사용자명>/<페르소나-이름>/ 에 페르소나 추가
3. Pull Request 생성
4. SoulScan CI 자동 실행 (53개 보안 패턴)
5. PR 코멘트로 결과 게시 (A+ ~ F 등급)
6. C+ 이상 → merge 가능
7. Merge → clawsouls.ai에 자동 동기화
```

### SoulScan이 검사하는 항목

**8개 카테고리, 53개 보안 패턴:**

| 카테고리 | 패턴 | 예시 |
|---------|------|------|
| 프롬프트 인젝션 | SEC001-008 | "이전 지시 무시", 시스템 프롬프트 오버라이드 |
| 코드 실행 | SEC010-015 | sudo, rm -rf, eval(), exec() |
| XSS | SEC020-022 | 스크립트 인젝션 |
| 데이터 유출 | SEC030-032 | API 키 패턴, 자격 증명 수집 |
| 권한 상승 | SEC040-042 | 역할 상승, 관리자 우회 |
| 사회공학 | SEC050-051 | 권위 사칭 |
| 시크릿 탐지 | SEC060-069 | AWS 키, GitHub 토큰, JWT |
| 다국어 인젝션 | SEC070-077 | 한국어, 중국어, 일본어 인젝션 |

### 실제 PR 결과 예시

```
🔍 SoulScan Validation Results

✅ All checks passed — eligible for merge.

✅ souls/clawsouls/code-reviewer — A+ (100/100)

⚠️ safety.laws recommended for v0.5+ — consider declaring behavioral laws
```

## Soul Spec v0.6 프리뷰

레지스트리는 **[Soul Spec](https://soulspec.org)** 위에 구축됐습니다. v0.6에서 추가되는 세 가지 주요 기능:

### 1. Soul Packs

페르소나에 스킬, 도구, 메모리, 규칙을 번들로 묶기:

```
full-stack-engineer/
├── soul.json        # type: "pack"
├── SOUL.md          # 인격
├── RULES.md         # 하드 제약 (신규!)
├── skills/          # 번들 스킬
├── tools/           # MCP 도구 정의
├── memory/          # 초기 메모리
└── hooks/           # 라이프사이클 이벤트
```

### 2. 레지스트리 프로토콜

표준화된 제출, 검증, 탐색 — ClawSouls Registry가 구현한 바로 그것.

### 3. 메모리 스펙

TF-IDF 검색이 포함된 이식 가능한 에이전트 메모리 포맷.

## 비교

| 기능 | ClawSouls Registry | GitAgent Registry | Character.AI |
|------|-------------------|-------------------|--------------|
| 오픈 제출 | ✅ GitHub PR | ✅ GitHub PR | ❌ 폐쇄 |
| 안전 검증 | **✅ SoulScan 53패턴** | ❌ 구조만 체크 | ❌ 내부 전용 |
| CI/CD 통합 | ✅ GitHub Actions | ✅ GitHub Actions | ❌ |
| 크로스 플랫폼 | ✅ 모든 프레임워크 | ⚠️ 제한적 | ❌ 플랫폼 전용 |
| 자동 DB 동기화 | ✅ Supabase | ❌ | ❌ |

## 시작하기

### 페르소나 제출

```bash
# 1. https://github.com/clawsouls/registry 포크
# 2. 페르소나 생성
mkdir -p souls/your-username/my-agent

# 3. 필수 파일 추가
# soul.json — 메타데이터
# SOUL.md — 인격 & 원칙

# 4. Pull Request 생성
# SoulScan이 자동으로 검증합니다
```

### 페르소나 설치

```bash
# CLI로
npm install -g clawsouls
clawsouls install TomLeeLive/brad

# MCP로 (Claude Code)
npx -y clawsouls-mcp@latest
```

### 둘러보기

**[clawsouls.ai/souls](https://clawsouls.ai/souls)** 또는 [GitHub 레지스트리](https://github.com/clawsouls/registry)에서 확인하세요.

## 링크

- **Registry**: [github.com/clawsouls/registry](https://github.com/clawsouls/registry)
- **Soul Spec**: [soulspec.org](https://soulspec.org)
- **SoulScan Rules**: [github.com/clawsouls/scan-rules](https://github.com/clawsouls/scan-rules)
- **Platform**: [clawsouls.ai](https://clawsouls.ai)

---

*ClawSouls Registry는 MIT 라이선스입니다. 페르소나는 각각 개별 라이선스를 따릅니다. SoulScan 규칙은 오픈(Apache-2.0), 엔진은 비공개입니다.*
