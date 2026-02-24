---
title: "Soul Spec v0.5: 챗봇부터 로봇까지 — 에이전트 정체성의 물리적 확장"
date: 2026-02-26T09:00:00+09:00
draft: false
tags: ["soul-spec", "로봇", "embodied-ai", "ROS2", "표준화"]
categories: ["발표"]
description: "Soul Spec v0.5가 로봇과 IoT 디바이스를 지원한다. 하드웨어 제약, 물리적 안전, 상호작용 모드를 정의하는 최초의 오픈 페르소나 표준."
---

Soul Spec v0.5를 발표한다. 핵심 변화: **로봇과 물리적 AI 에이전트 지원**.

챗봇의 성격을 정의하던 같은 포맷으로, 이제 로봇의 성격도 정의할 수 있다.

## 왜 로봇에 페르소나 표준이 필요한가

2025년에 발표된 연구들이 하나의 사실을 증명했다:

**일관된 성격을 가진 로봇이 더 나은 성능을 보인다.**

Nature Scientific Reports(2025)에 발표된 연구는 GPT-4 기반 로봇에 특정 성격을 부여했을 때 대화 역학과 사용자 경험이 향상됨을 실험적으로 증명했다. arXiv(2512.06910)의 연구는 LLM으로 설정한 로봇 성격이 작업 동기 부여와 성능에 직접적인 영향을 미침을 보여줬다.

더 주목할 만한 것은 Frontiers in Robotics and AI(2025)에 발표된 논문이다. 이 논문은 **단일 로봇 안에 여러 "상호작용 캐릭터"를 선택·조정할 수 있는 마켓플레이스** 개념을 제안한다. 로봇용 앱스토어가 아니라, 로봇용 페르소나 스토어.

문제는: **표준화된 성격 정의 포맷이 없다**. 각 연구팀이 자체 방식을 사용한다. ROS2 + LLM 통합은 활발하지만, 페르소나 정의는 팀마다 다르다.

## Soul Spec v0.5: 무엇이 바뀌었나

### 새로운 필드

```json
{
  "environment": "embodied",
  "interactionMode": "voice",
  "hardwareConstraints": {
    "hasDisplay": true,
    "hasSpeaker": true,
    "hasMicrophone": true,
    "mobility": "mobile",
    "manipulator": false
  },
  "safety": {
    "physical": {
      "contactPolicy": "gentle-contact",
      "emergencyProtocol": "alert_operator",
      "operatingZone": "indoor",
      "maxSpeed": "0.3m/s"
    }
  }
}
```

| 필드 | 용도 |
|---|---|
| `environment` | 배포 환경: `virtual`, `embodied`, `hybrid` |
| `interactionMode` | 주요 상호작용: `text`, `voice`, `multimodal`, `gesture` |
| `hardwareConstraints` | 디스플레이, 스피커, 카메라, 이동성, 매니퓰레이터 |
| `safety.physical` | 접촉 정책, 비상 프로토콜, 작동 구역, 최대 속도 |

### 로봇 플랫폼 식별자

`compatibility.frameworks`에 로봇 플랫폼 추가:

- `ros2` — Robot Operating System 2
- `isaac` — NVIDIA Isaac
- `webots` — Cyberbotics Webots
- `gazebo` — Open Robotics Gazebo

### 100% 하위 호환

모든 새 필드는 옵션이다. 기존 챗봇 soul은 변경 없이 동작한다. `environment` 필드를 생략하면 `"virtual"`로 간주된다.

## 예시: 요양원 동반자 로봇

```json
{
  "specVersion": "0.5",
  "name": "care-companion",
  "displayName": "Care Companion",
  "description": "Gentle elderly care companion with patience and warmth.",
  "environment": "embodied",
  "interactionMode": "voice",
  "hardwareConstraints": {
    "hasDisplay": true,
    "hasSpeaker": true,
    "hasMicrophone": true,
    "mobility": "mobile",
    "manipulator": false
  },
  "safety": {
    "physical": {
      "contactPolicy": "gentle-contact",
      "emergencyProtocol": "alert_operator",
      "operatingZone": "indoor",
      "maxSpeed": "0.3m/s"
    }
  },
  "compatibility": {
    "frameworks": ["ros2", "openclaw"]
  }
}
```

같은 `SOUL.md`가 챗봇에서도 로봇에서도 동작한다. 성격은 하나, 몸은 여러 개.

## 물리적 안전: 새로운 차원

챗봇에서 보안은 프롬프트 주입 방어다. 로봇에서 보안은 **사람을 다치게 하지 않는 것**이다.

Soul Spec v0.5는 물리적 안전을 스펙 레벨에서 정의한다:

- `contactPolicy`: 접촉 허용 여부와 수준
- `emergencyProtocol`: 비상 시 행동 (정지, 운영자 알림, 복귀)
- `operatingZone`: 실내/실외 제한
- `maxSpeed`: 최대 이동 속도

[SoulScan](https://clawsouls.ai/soulscan)은 `environment: "embodied"`인 soul에 `safety.physical`이 없으면 경고를 발생시킨다. 물리적 에이전트에 안전 선언이 없는 것은 위험이다.

## Define Once, Embody Anywhere

Docker가 "Build once, run anywhere"를 소프트웨어에 가져왔다면, Soul Spec은 "Define once, embody anywhere"를 에이전트 정체성에 가져온다.

같은 페르소나 패키지가:
- **OpenClaw**에서 텔레그램 어시스턴트로
- **Cursor**에서 코딩 파트너로
- **ROS2**에서 물리적 로봇으로

런타임은 다르다. 정체성은 하나다.

---

*Soul Spec v0.5 전문은 [soulspec.org](https://soulspec.org)에서, 로봇 확장 상세는 [soulspec.org/robotics](https://soulspec.org/robotics)에서 확인할 수 있다.*
