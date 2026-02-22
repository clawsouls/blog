---
title: "ChatGPT에서 Soul Spec 사용하기"
date: 2026-02-22T02:00:00+09:00
description: "Streamable HTTP 트랜스포트로 soul-spec-mcp를 ChatGPT에 연결하는 방법. Soul Spec으로 ChatGPT에 지속적인 페르소나를 부여한다."
categories: ["Guides"]
tags: ["soul-spec", "chatgpt", "mcp", "persona", "guide", "tutorial", "openai"]
draft: false
---

## 개요

[ChatGPT](https://chatgpt.com) Business, Enterprise, Edu 플랜이 Streamable HTTP 트랜스포트를 통한 MCP(Model Context Protocol) 앱을 지원한다. **soul-spec-mcp**를 ChatGPT에 연결하면 ClawSouls 페르소나 레지스트리 전체에 접근할 수 있다.

페르소나 검색, 미리보기, 적용까지 ChatGPT 안에서 모두 가능하다.

## 사전 요구사항

- ChatGPT **Plus/Pro** 이상 플랜 (아래 호환성 표 참고)
- Node.js 18+
- 외부에서 접근 가능한 HTTP 서버 (또는 ngrok 같은 터널)

### ChatGPT 플랜별 MCP 호환성

| 플랜 | 외부 툴 연결 | 읽기 전용 MCP |
|------|:-:|:-:|
| **Free** | 거의 없음 | ❌ |
| **Plus** | 제한적 | 일부 가능 |
| **Pro** | Plus와 유사 | 일부 가능 |
| **Business** | ✅ | ✅ |
| **Enterprise** | ✅ | ✅ |
| **Edu** | ✅ | ✅ |

> **추천:** Business, Enterprise, Edu 플랜은 MCP 완전 지원. Plus/Pro 사용자는 기능 롤아웃에 따라 제한적일 수 있습니다.

## 1단계: soul-spec-mcp 설치

```bash
npm install -g soul-spec-mcp
```

## 2단계: HTTP 서버 시작

soul-spec-mcp는 두 가지 트랜스포트를 지원한다: **stdio** (기본, Claude Code 등) 와 **Streamable HTTP** (ChatGPT용).

HTTP 서버 시작:

```bash
soul-spec-mcp --http
```

`http://localhost:3100/mcp`에서 서버가 실행된다. 포트를 변경하려면:

```bash
soul-spec-mcp --http --port 8080
```

동작 확인:

```bash
curl http://localhost:3100/health
# {"status":"ok","transport":"streamable-http"}
```

## 3단계: 외부 접근 설정

ChatGPT가 서버에 접근하려면 인터넷에서 도달 가능해야 한다.

**방법 A: ngrok (가장 빠름)**

```bash
ngrok http 3100
```

`https://` URL을 복사해둔다.

**방법 B: 서버 배포**

클라우드 서버에 배포하고 `soul-spec-mcp --http --port 3100`을 실행한다. 포트가 열려있는지 확인할 것.

## 4단계: ChatGPT에 추가

1. [ChatGPT](https://chatgpt.com) (Business/Enterprise/Edu) 열기
2. **설정 → MCP 앱** (또는 관리자 패널)으로 이동
3. **MCP 앱 추가** 클릭
4. 서버 URL 입력: `https://your-domain.com/mcp`
5. 저장 및 활성화

이제 ChatGPT에서 soul-spec-mcp의 모든 도구를 사용할 수 있다.

## 5단계: 사용하기

ChatGPT 대화에서 바로 사용 가능:

- **페르소나 검색**: "ClawSouls에서 코딩 페르소나 검색해줘"
- **Soul 미리보기**: "surgical-coder soul 미리보기"
- **페르소나 적용**: "clawsouls/brad 페르소나 적용해"
- **카테고리 탐색**: "어떤 페르소나 카테고리가 있어?"

### 예시

> **나**: ClawSouls에서 크리에이티브 글쓰기 페르소나 찾아줘
>
> **ChatGPT**: *search_souls 호출* — 5개의 Soul을 찾았습니다: ...
>
> **나**: 첫 번째 거 적용해
>
> **ChatGPT**: *apply_persona 호출* — "Story Weaver" 페르소나가 활성화되었습니다...

## 사용 가능한 도구

| 도구 | 설명 |
|------|------|
| `search_souls` | 키워드, 카테고리, 태그로 페르소나 검색 |
| `get_soul` | 특정 Soul의 상세 정보 조회 |
| `install_soul` | 페르소나 파일 다운로드 및 생성 |
| `preview_soul` | Soul 미리보기 |
| `apply_persona` | 현재 대화에 페르소나 적용 |
| `list_categories` | 카테고리 목록 탐색 |

## 팁

- **apply_persona**가 ChatGPT에서 가장 유용하다 — 대화의 행동이 즉시 바뀐다
- 페르소나는 대화 동안 유지되지만 새 채팅에서는 초기화된다
- 다른 도구에서의 영구 설정은 [다른 가이드](https://blog.clawsouls.ai/guides/)를 참고

## 더 알아보기

- [Soul Spec](https://clawsouls.ai/spec) — AI 페르소나를 위한 오픈 스펙
- [ClawSouls 레지스트리](https://clawsouls.ai/souls) — 모든 페르소나 탐색
- [soul-spec-mcp (npm)](https://www.npmjs.com/package/soul-spec-mcp) — 패키지 정보
- [ChatGPT MCP 앱 가이드](https://help.openai.com/ko-kr/articles/12584461) — OpenAI 공식 문서
