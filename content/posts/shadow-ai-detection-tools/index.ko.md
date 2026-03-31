---
title: "Shadow AI 탐지 도구 비교: Claw-Hunter vs openclaw-detect"
date: 2026-02-27T09:00:00+09:00
draft: false
tags: ["security", "shadow-ai", "enterprise", "mdm", "ai-agents", "open-source"]
categories: ["Security Analysis"]
summary: "직원이 몰래 OpenClaw을 쓰고 있다면? 기업 보안팀을 위한 두 오픈소스 탐지 도구 — Backslash Security의 Claw-Hunter와 Knostic의 openclaw-detect — 를 기술적으로 비교 분석합니다."
---

기업 보안팀에게 새로운 과제가 생겼습니다. **직원들이 승인 없이 AI 에이전트를 설치하고 있다는 것.**

2026년 2월 현재, OpenClaw의 Shadow AI 확산을 탐지하기 위한 오픈소스 도구가 두 개 등장했습니다. 앱 보안 회사 Backslash Security의 [Claw-Hunter](https://github.com/backslash-security/Claw-Hunter)와, AI 에이전트 가시성 회사 Knostic의 [openclaw-detect](https://github.com/knostic/openclaw-detect)입니다.

두 도구 모두 같은 문제를 풀지만, 접근 방식이 다릅니다. 하나는 보안 감사 도구이고, 다른 하나는 MDM 센서입니다.

## Shadow AI란 무엇인가

Shadow IT는 IT 부서의 승인 없이 직원이 사용하는 기술을 말합니다. Dropbox, Slack, ChatGPT가 모두 Shadow IT로 시작해서 공식 도구가 되었습니다.

**Shadow AI**는 이 패턴의 AI 에이전트 버전입니다. OpenClaw은 특히 Shadow AI로 확산되기 쉬운 특성을 가지고 있습니다:

- **로컬 설치**: 클라우드 서비스와 달리 네트워크 트래픽으로 탐지하기 어렵습니다
- **Shell 접근**: 파일 시스템, 터미널, 브라우저까지 접근 가능합니다
- **API 키 사용**: 개인 API 키를 설정에 저장하며, 이것이 기업 credential과 혼재될 수 있습니다
- **게이트웨이 데몬**: 백그라운드에서 상시 실행되는 서비스입니다

개발자가 생산성을 위해 OpenClaw을 설치하는 것은 자연스럽습니다. 문제는 보안팀이 **그 존재조차 모른다**는 것입니다.

## 두 도구 상세 비교

### Claw-Hunter — 보안 감사 도구

[Claw-Hunter](https://github.com/backslash-security/Claw-Hunter)는 Backslash Security([backslash.security](https://backslash.security))가 만든 엔드포인트 보안 감사 도구입니다.

**탐지를 넘어 감사까지** 수행한다는 점이 특징입니다:

| 기능 | 설명 |
|------|------|
| 설치 탐지 | CLI 바이너리, 앱 번들 존재 여부 |
| 게이트웨이 상태 | 백그라운드 데몬 실행 여부 |
| Shell 접근 권한 | 어떤 shell에 대한 접근이 허용되어 있는지 |
| Credential 노출 | 설정 파일 내 credential 존재 여부 |
| API 키 스캔 | 저장된 API 키 탐지 |

출력은 **JSON 형식**으로, SIEM(Security Information and Event Management) 시스템에 바로 연동할 수 있습니다. 각 항목에 대해 `clean`, `warning`, `critical` 수준의 **risk scoring**을 제공합니다.

```bash
# 실행 예시 (macOS/Linux)
./claw-hunter.sh
```

스택은 순수 bash + PowerShell로, 외부 의존성이 없습니다. MDM은 Jamf와 Intune을 지원합니다. 라이선스는 MIT.

### openclaw-detect — MDM 센서

[openclaw-detect](https://github.com/knostic/openclaw-detect)는 Knostic([knostic.ai](https://knostic.ai))이 만든 경량 탐지 센서입니다.

Claw-Hunter와 달리 **"설치되어 있는가?"**라는 단일 질문에 집중합니다:

| 탐지 대상 | 설명 |
|-----------|------|
| CLI 바이너리 | `openclaw` 커맨드 존재 여부 |
| 앱 번들 | macOS .app, Windows 설치 경로 |
| 설정 파일 | `~/.openclaw/` 디렉토리 |
| 게이트웨이 | 데몬 프로세스 |
| Docker | 컨테이너 내 OpenClaw 실행 여부 |

출력은 key-value 텍스트이며, exit code로 결과를 전달합니다: `0`이면 미탐지, `1`이면 탐지. 이 단순한 인터페이스 덕분에 **7개 MDM 플랫폼**을 지원합니다:

- Jamf
- Intune
- JumpCloud
- CrowdStrike
- Addigy
- Kandji
- Workspace ONE

라이선스는 Apache 2.0. Knostic은 별도로 [openclaw-telemetry](https://github.com/knostic/openclaw-telemetry) 저장소도 운영하고 있어, 탐지 이후 텔레메트리 수집까지의 파이프라인을 구축하려는 의도가 보입니다.

## 비교 요약

| | Claw-Hunter | openclaw-detect |
|---|---|---|
| **개발사** | Backslash Security | Knostic |
| **목적** | 보안 감사 | 설치 탐지 |
| **출력** | JSON + risk scoring | key-value + exit code |
| **MDM 지원** | 2개 (Jamf, Intune) | 7개 |
| **Credential 스캔** | ✅ | ❌ |
| **API 키 스캔** | ✅ | ❌ |
| **Shell 권한 감사** | ✅ | ❌ |
| **SIEM 연동** | JSON 네이티브 | 수동 파싱 필요 |
| **라이선스** | MIT | Apache 2.0 |

**선택 기준**: 보안 감사가 필요하면 Claw-Hunter, 다양한 MDM에서 존재 여부만 빠르게 확인하려면 openclaw-detect.

## 왜 기업이 AI 에이전트 탐지에 나서는가

이 도구들의 존재 자체가 시장 신호입니다.

**첫째, OpenClaw의 확산 속도.** 보안 회사 두 곳이 독립적으로 탐지 도구를 만들었다는 것은, 기업 고객으로부터 "우리 조직에 OpenClaw이 얼마나 깔려 있는지 모르겠다"는 요청이 충분히 있었다는 뜻입니다.

**둘째, AI 에이전트의 특수성.** ChatGPT 웹은 프록시 로그로 탐지합니다. 하지만 OpenClaw은 로컬에서 실행되고, shell 접근 권한을 가지며, API 키를 로컬에 저장합니다. 네트워크 기반 DLP(Data Loss Prevention)로는 부족합니다.

**셋째, 컴플라이언스 요구.** SOC 2, ISO 27001 등의 프레임워크는 "승인되지 않은 소프트웨어"의 설치 현황 파악을 요구합니다. AI 에이전트도 예외가 아닙니다.

## 보안의 두 축: 인프라 vs 콘텐츠

Claw-Hunter와 openclaw-detect는 **인프라 레벨 보안**입니다. "OpenClaw이 설치되어 있는가?", "어떤 권한을 가지고 있는가?"에 답합니다.

하지만 인프라 탐지만으로는 충분하지 않습니다. AI 에이전트 보안에는 또 다른 축이 있습니다:

- **인프라 레벨**: 설치 탐지, 권한 감사, credential 노출 확인 → Claw-Hunter, openclaw-detect
- **콘텐츠 레벨**: 에이전트가 실행하는 스킬, 설정 파일의 안전성 검증 → 예: [SoulScan](https://soulscan.ai) 같은 콘텐츠 분석 도구

인프라 레벨이 "자물쇠가 달려 있는가?"를 확인한다면, 콘텐츠 레벨은 "자물쇠 안에 뭐가 들어있는가?"를 확인합니다. [앞서 분석한 ClawHub 악성 스킬 사건](/posts/clawhub-malware-supply-chain/)이 보여주듯, AI 에이전트가 실행하는 콘텐츠 자체의 보안 검증도 점점 중요해지고 있습니다.

## AI 에이전트 생태계 보안의 미래

현재 두 도구는 OpenClaw만을 대상으로 합니다. 하지만 AI 에이전트는 OpenClaw만 있는 것이 아닙니다. Cursor, Windsurf, Devin, 그리고 수많은 에이전트 프레임워크들이 유사한 패턴 — 로컬 설치, shell 접근, API 키 저장 — 을 공유합니다.

예상되는 발전 방향:

1. **범용 AI 에이전트 탐지**: OpenClaw 특화에서 범용 에이전트 탐지로 확장
2. **실시간 모니터링**: 설치 여부 스캔에서 실시간 행위 모니터링으로 진화
3. **콘텐츠 보안 통합**: 인프라 탐지 + 콘텐츠 검증의 통합 파이프라인
4. **에이전트 거버넌스 플랫폼**: 탐지, 정책, 감사를 통합하는 플랫폼의 등장

AI 에이전트 보안은 아직 초기 단계입니다. 하지만 두 보안 회사가 동시에 오픈소스 탐지 도구를 내놓았다는 것은, 이 분야가 빠르게 움직이고 있다는 분명한 신호입니다.

## 결론

Shadow AI는 이미 현실입니다. 그리고 기업 보안 생태계는 대응을 시작했습니다.

Claw-Hunter는 깊이 있는 보안 감사를, openclaw-detect는 넓은 MDM 호환성을 제공합니다. 두 도구 모두 오픈소스이고, 의존성 없이 바로 실행할 수 있습니다.

AI 에이전트가 개발자의 일상 도구가 된 지금, 보안팀에게는 가시성 확보가 첫 번째 과제입니다. 이 도구들은 그 첫 걸음입니다.
