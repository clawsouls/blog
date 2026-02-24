---
title: "Soul Spec v0.5: From Chatbots to Robots — Agent Identity Goes Physical"
date: 2026-02-24T20:30:00+09:00
draft: false
tags: ["soul-spec", "robotics", "embodied-ai", "ROS2", "standardization"]
categories: ["Announcement"]
description: "Soul Spec v0.5 adds support for robots and IoT devices. Hardware constraints, physical safety, and interaction modes — the first open persona standard for embodied agents."
---

Announcing Soul Spec v0.5. The key change: **support for robots and physical AI agents**.

The same format that defines a chatbot's personality now defines a robot's personality.

## Why Robots Need a Persona Standard

Research published in 2025 proves one thing:

**Robots with consistent personalities perform better.**

A study in Nature Scientific Reports (2025) experimentally demonstrated that giving GPT-4-powered robots specific personalities improves conversational dynamics and user experience. Research on arXiv (2512.06910) showed that LLM-configured robot personality directly impacts task motivation and performance.

Most notably, a paper in Frontiers in Robotics and AI (2025) proposes **a marketplace where multiple "interaction characters" can be selected and adjusted within a single robot**. Not an app store for robots — a persona store.

The problem: **no standardized personality definition format exists**. Each research team uses their own approach. ROS2 + LLM integration is active, but persona definition varies across teams.

## What's New in v0.5

### New Fields

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

| Field | Purpose |
|---|---|
| `environment` | Deployment context: `virtual`, `embodied`, `hybrid` |
| `interactionMode` | Primary interaction: `text`, `voice`, `multimodal`, `gesture` |
| `hardwareConstraints` | Display, speaker, camera, mobility, manipulator |
| `safety.physical` | Contact policy, emergency protocol, operating zone, max speed |

### Robotics Platform Identifiers

Added to `compatibility.frameworks`:

- `ros2` — Robot Operating System 2
- `isaac` — NVIDIA Isaac
- `webots` — Cyberbotics Webots
- `gazebo` — Open Robotics Gazebo

### 100% Backward Compatible

All new fields are optional. Existing chatbot souls work without changes. Omitting `environment` defaults to `"virtual"`.

## Example: Care Companion Robot

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

Same `SOUL.md` works on both chatbot and robot. One personality, multiple bodies.

## Physical Safety: A New Dimension

In chatbots, security means prompt injection defense. In robots, security means **not hurting people**.

Soul Spec v0.5 defines physical safety at the spec level:

- `contactPolicy`: Whether and how physical contact is permitted
- `emergencyProtocol`: Emergency behavior (stop, alert operator, return home)
- `operatingZone`: Indoor/outdoor restriction
- `maxSpeed`: Maximum movement speed

[SoulScan](https://clawsouls.ai/soulscan) flags embodied souls (`environment: "embodied"`) that lack `safety.physical` declarations. A physical agent without explicit safety rules is a risk.

## Define Once, Embody Anywhere

Docker brought "Build once, run anywhere" to software. Soul Spec brings "Define once, embody anywhere" to agent identity.

The same persona package works as:
- A **Telegram assistant** on OpenClaw
- A **coding partner** on Cursor
- A **physical robot** on ROS2

Different runtimes. One identity.

---

*Read the full Soul Spec v0.5 at [soulspec.org](https://soulspec.org). Robotics details at [soulspec.org/robotics](https://soulspec.org/robotics).*

## References

1. LLM-based Robot Personality Simulation and Cognitive System. *Scientific Reports* (Nature), 2025. [doi:10.1038/s41598-025-01528-8](https://doi.org/10.1038/s41598-025-01528-8)
2. Robot Character Generation and Adaptive HRI with Personality Shaping. *arXiv*, 2025. [arXiv:2503.15518](https://arxiv.org/abs/2503.15518)
3. Robots with Attitudes: LLM-Driven Robot Personalities on Motivation and Performance. *arXiv*, 2025. [arXiv:2512.06910](https://arxiv.org/abs/2512.06910)
4. Making Social Robots Adaptable by a Marketplace for Interaction Characters. *Frontiers in Robotics and AI*, 2025. [doi:10.3389/frobt.2025.1534346](https://doi.org/10.3389/frobt.2025.1534346)
5. ROS-LLM: A ROS Framework for Embodied AI with Task Feedback. *arXiv*, 2024. [arXiv:2406.19741](https://arxiv.org/abs/2406.19741)
6. Designing Social Robots with LLMs for Engaging Human Interaction. *Applied Sciences* (MDPI), 2025. [doi:10.3390/app15116377](https://doi.org/10.3390/app15116377)
