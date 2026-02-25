---
title: "로봇 Soul을 ChatGPT에서 쓸 수 있을까?"
date: 2026-02-25
description: "v0.5 로보틱스 soul을 텍스트 전용 AI 에이전트에 넣으면 무슨 일이 생길까"
tags: ["soul-spec", "robotics", "compatibility", "v0.5"]
categories: ["guides"]
---

Soul Spec v0.5에서 로보틱스 확장이 추가됐다. `sensors`, `actuators`, `safety.physical` 같은 필드로 soul이 물리적인 몸을 기술할 수 있게 된 거다. 그런데 이런 로봇용 soul을 ChatGPT나 OpenClaw 같은 텍스트 전용 에이전트에 넣으면 어떻게 될까?

터질까? 에이전트가 자기한테 팔이 있다고 착각할까?

한번 알아보자.

## v0.5가 추가한 것들

로보틱스 확장은 여러 새로운 필드를 도입한다:

```json
{
  "environment": "physical",
  "interactionMode": "embodied",
  "sensors": ["lidar", "camera_rgb", "imu"],
  "actuators": ["wheel_left", "wheel_right", "gripper"],
  "safety": {
    "physical": {
      "maxSpeed": 1.5,
      "emergencyStop": true,
      "collisionAvoidance": true
    }
  },
  "hardwareConstraints": {
    "ros2Topics": ["/cmd_vel", "/odom"],
    "updateRateHz": 30
  }
}
```

이 필드들은 soul-aware 펌웨어를 돌리는 로봇을 위한 거다. 에이전트에게 어떤 몸을 갖고 있는지, 얼마나 빠르게 움직일 수 있는지, 어떤 ROS2 토픽에 퍼블리시해야 하는지 알려준다.

## 텍스트 에이전트에서 실제로 일어나는 일

결론부터 말하면: **아무것도 터지지 않는다.** 근데 동작이 항상 예상대로인 건 아니다.

### 모르는 필드는 조용히 무시된다 ✅

대부분의 soul-aware 시스템(OpenClaw 포함)은 자기가 아는 필드만 파싱한다. `actuators`, `hardwareConstraints`, `ros2Topics` — 텍스트 에이전트는 그냥 건너뛴다. 안전하다. 스펙이 원래 이렇게 설계됐다.

### `environment: "physical"`이 페르소나 오염을 일으킨다 ⚠️

여기서부터 재밌어진다. LLM이 자기 soul에서 `environment: "physical"`을 읽으면, 자기가 로봇이라고 *믿기* 시작할 수 있다. 이런 출력이 나온다:

> "실제 세계에서 작동하는 물리적 에이전트로서 말씀드리자면..."

에이전트가 고장 난 게 아니다. LLM이 원래 하는 대로 — 컨텍스트를 문자 그대로 해석하는 것뿐이다.

### `safety.physical.maxSpeed`가 대화에 새어 나온다 ⚠️

에이전트가 저녁 레시피 얘기 중에 갑자기 "제 최대 속도는 1.5m/s입니다"라고 말할 수 있다. LLM이 safety 블록을 자기 정체성의 일부로 취급하고 묻지도 않았는데 꺼내는 거다.

### ROS2 토픽 연결은 조용히 실패한다 ✅

미들웨어가 실제로 `/cmd_vel`이나 `/odom`에 연결을 시도하면 실패하긴 하는데 — 조용히. 크래시도 없고, 에러 전파도 없다. 에이전트는 계속 돌아간다.

## 진짜 위험: 페르소나 해석 오염

위험한 건 기술적 실패가 아니다. **의미론적 오염**이다.

로봇 soul을 가진 텍스트 에이전트는 죽지 않는다 — *연기한다*. 이런 일이 생길 수 있다:

- 할 수 없는 물리적 행동을 묘사함
- 없는 센서를 언급함
- 텍스트 상호작용에 물리적 안전 제약을 적용함
- 로봇 같은 응답을 예상하지 못한 사용자를 혼란시킴

이게 페르소나 오염이고, 프로덕션에 나가도 아무도 모를 만큼 미묘하다. 사용자가 "왜 제 챗봇이 자꾸 그리퍼 얘기를 해요?"라고 물어올 때까지는.

## 베스트 프랙티스

### 1. 텍스트 전용 soul에는 `environment: "virtual"` 사용

```json
{
  "environment": "virtual",
  "interactionMode": "conversational"
}
```

가장 간단한 해결책이다. 에이전트한테 몸이 없으면, 없다고 써라.

### 2. SOUL.md에 폴백 노트 추가

```markdown
## 환경 호환성
텍스트 전용 환경에서는 모든 물리적 제약, 센서 참조,
액추에이터 설명을 무시하세요. 당신은 물리적 몸이 없습니다.
```

이렇게 하면 JSON에 로보틱스 필드가 있더라도 LLM이 명시적으로 무시할 수 있다.

### 3. CLI 경고를 활용

OpenClaw CLI는 `environment: "physical"` soul을 텍스트 전용 에이전트에 적용하려 할 때 경고를 띄운다:

```
⚠ Soul의 environment=physical이지만 대상 에이전트는 텍스트 전용입니다.
  물리적 필드는 무시됩니다. environment=virtual 설정을 고려하세요.
```

이 경고를 무시하지 말자.

## 결론

Soul Spec v0.5는 설계상 하위 호환된다. 로봇 soul을 텍스트 에이전트에 넣어도 아무것도 안 터진다 — 스펙이 우아하게 퇴화한다.

하지만 "안 터진다"와 "잘 작동한다"는 다르다. 진짜 문제는 페르소나 오염이다: 그냥 챗봇인데 자기가 로봇인 줄 아는 LLM.

해결은 간단하다: `environment` 필드를 의도적으로 설정해라. 텍스트면 `"virtual"`, 로봇이면 `"physical"`. 스펙은 둘 다 지원한다. 실수로 섞지만 말자.
