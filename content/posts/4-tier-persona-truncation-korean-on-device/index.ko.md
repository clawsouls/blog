---
title: "한국어 페르소나 + 온디바이스 AI의 작은 모델 한계 — 4-Tier truncation 패턴"
date: 2026-05-XX
draft: true
tags: ["soulclaw-mobile", "soul-spec", "on-device-ai", "gemma-4-e2b", "litert-lm", "persona", "4-tier-bootstrap", "korean-llm", "webllm", "qwen"]
categories: ["기술 / 분석"]
description: "Mati Wise Partner 페르소나 (6,866 tokens)의 작은 on-device 모델 한계 + 4-Tier truncation의 design / Korean token estimation / production reference."
---

Anthropic의 [페르소나 선택 모델(PSM, 2026)](https://alignment.anthropic.com/2026/psm)은 명확히 말한다:

> "페르소나는 AI 시스템 자체와 동일한 것이 아니다. LLM은 캐릭터를 시뮬레이션하고 있으며, Assistant는 그 캐릭터의 한 instance에 불과하다."

Karpathy는 Sequoia Ascent 2026에서 같은 흐름을 다른 각도로 표현했다:

> "install .md skills instead of install .sh scripts."

Spec-as-instruction의 frontier. 하지만 frontier 모델이 "on the rails"라면, on-device의 작은 모델은 "off-road jungle with a machete"다.

그 jungle에서 가장 먼저 무너지는 것이 페르소나다.

## Mati Wise Partner — 실제 truncation 케이스

[clawsouls.ai](https://clawsouls.ai)에 사용자가 publish한 페르소나, Mati Wise Partner. 5개 파일로 구성된 Soul Spec 패키지다:

| 파일 | 역할 |
|------|------|
| SOUL.md | 성격, 원칙, 경계선 |
| IDENTITY.md | 이름, 역할, 기본 정보 |
| AGENTS.md | 워크플로우, 안전 규칙 |
| STYLE.md | 커뮤니케이션 톤 |
| README.md | 사용자 온보딩 가이드 |

총 토큰: **6,866 tokens**.

### WebLLM Qwen 2.5 0.5B 시도

context window: 4,096 tokens. 결과는 즉각적이었다:

```
Error: Prompt tokens exceed context window size: 6866; context window: 4096
```

67% 초과. 모델이 페르소나를 로드하기도 전에 에러로 종료된다.

### SoulClaw Mobile — LiteRT-LM Gemma 4 E2B 시도

`maxNumTokens=4000`. 에러 없이 실행된다. 문제는 그 다음에 생겼다.

systemInstruction이 조용히 truncate되었고, 모델은 base identity로 회귀했다. 첫 번째 메시지에서 돌아온 응답:

> "I'm Gemma 4, how can I help you today?"

Mati가 아니다. 페르소나 설정이 무시된 것이 아니다 — 설정 자체가 도달하지 못했다. **Silent failure.**

## Karpathy의 'jaggedness' — 온디바이스의 직접적 매핑

Karpathy는 frontier와 edge의 격차를 이렇게 묘사했다: "off-road in the jungle with a machete."

Frontier의 RL training data는 100K LOC 규모의 리팩토링도 커버한다. 복잡한 multi-file instruction을 따르도록 훈련되어 있다. 이것이 "on the rails"다.

Edge의 작은 on-device 모델은 다르다:

- **컨텍스트 윈도우**: 4,096 ~ 8,192 tokens (frontier의 1/20)
- **Instruction fidelity**: 명령어 충실도 훈련에 투자된 compute가 적다
- **CJK tokenization**: 한글/한자/가나 문자의 token density가 Latin보다 높다

Soul Spec의 multi-file schema는 그 jungle의 길 표시다. 그런데 길 표시 자체가 truncate되면, 지도 없이 jungle을 걷는 것과 같다.

## 4-Tier Bootstrap 패턴 — design

truncation 문제의 구조적 해결. 모든 파일을 동등하게 취급하는 대신, 중요도에 따라 tier를 나눈다.

### Tier 구조

| Tier | 파일 | 로딩 조건 | 이유 |
|------|------|-----------|------|
| **Tier 1** | IDENTITY.md | 항상 (force-add) | 모델이 "나는 누구인가"를 잃으면 안 된다 |
| **Tier 2** | SOUL.md | budget 허용 시 | 성격/원칙/경계선 — 핵심 identity |
| **Tier 3** | AGENTS.md / STYLE.md / README.md | budget 허용 시 | 운영 세부사항 |
| **Tier 4** | memory search 등 | 드문 reach | 외부 컨텍스트 |

**Tier 1은 budget에 관계없이 항상 포함된다.** 토큰이 부족해도 IDENTITY.md는 살아남는다.

### 한국어 token estimation

CJK(한글/한자/가나) 문자의 tokenization은 Latin과 다르다:

- **CJK chars**: 0.75 token/char
- **Latin chars**: 0.25 token/char

예시: `"안녕하세요 Brad 입니다"` = 12 tokens

이 추정은 LiteRT-LM tokenizer와 ±20% 정합. conservative high 방향으로 잡아야 truncation을 피할 수 있다.

### Mati 사례에 적용

Qwen 2.5 0.5B (4,096 ctx) 기준:

```
Context window:       4,096 tokens
System reserves:       -512 tokens  (model overhead)
Chat history reserves: -512 tokens  (대화 기록)
Generation reserves:   -512 tokens  (응답 생성)
─────────────────────────────────────
Available budget:     2,560 tokens
```

Tier 1 우선 배치:

```
IDENTITY.md    755 tokens  → force-add ✅
AGENTS.md    1,755 tokens  → budget fit ✅
─────────────────────────
Used:         2,510 / 2,560 tokens

SOUL.md      truncated ⚠️
STYLE.md     truncated ⚠️
README.md    truncated ⚠️
```

결과:
- IDENTITY.md 살아남 → "I'm Gemma 4" 회귀 사라짐
- Mati의 이름과 기본 역할 유지
- 사용자에게 Toast 알림 표시: **"페르소나가 모델 한계 초과 — 클라우드 BYOK 권장"**

전체 Soul Spec이 로드되지는 않았다. 그러나 silent failure 대신 graceful degradation으로 전환되었다.

## Production references

4-Tier 패턴은 현재 여러 구현체에 배포되어 있다.

### soul-playground (TypeScript)

[clawsouls.ai/try](https://clawsouls.ai/try)의 live source. WebLLM 환경에서 `4-Tier` 로직 구현:

```typescript
// 예시 구조 (soul-playground)
function buildSystemPromptTiered(
  files: SoulFiles,
  budget: number,
  tokenizer: Tokenizer
): string {
  // Tier 1: force-add
  const identity = files.get('IDENTITY.md');
  let prompt = identity;
  let remaining = budget - countTokens(identity, tokenizer);

  // Tier 2~3: budget 허용 시
  for (const file of ['SOUL.md', 'AGENTS.md', 'STYLE.md', 'README.md']) {
    const content = files.get(file);
    const tokens = countTokens(content, tokenizer);
    if (remaining >= tokens) {
      prompt += '\n\n' + content;
      remaining -= tokens;
    }
  }
  return prompt;
}
```

### soulclaw-web (예정)

`buildSystemPromptTiered` API로 표준화 예정.

### soulclaw-android v1.6.5

[GitHub release v1.6.5](https://github.com/TomLeeLive/soulclaw-android/releases/tag/v1.6.5). `agent/TieredBootstrap.kt`에 Kotlin 구현. CJK-aware tokenizer 포함:

```kotlin
// CJK token density 보정
fun estimateTokens(text: String): Int {
    var count = 0
    for (ch in text) {
        count += when {
            ch.code in 0xAC00..0xD7A3 -> 1  // 한글
            ch.code in 0x4E00..0x9FFF -> 1  // 한자
            ch.code in 0x3040..0x30FF -> 1  // 가나
            else -> if (ch == ' ') 0 else 1
        }
    }
    // conservative: ×0.75 base, +20% buffer
    return (count * 0.75 * 1.2).toInt()
}
```

### WasmClaw v1.0-alpha.1

[`@wasmclaw/core`](https://www.npmjs.com/package/@wasmclaw/core) — Rust+WASM의 reference 구현. Soul Spec v0.6 ([Zenodo DOI 10.5281/zenodo.19147335](https://doi.org/10.5281/zenodo.19147335)) 기반:

```bash
npm install @wasmclaw/core@next
```

## 종합 + open invitation

Anthropic PSM이 말하는 것: LLM은 캐릭터를 시뮬레이션한다. 어떤 캐릭터인지가 결정적이다.

Karpathy가 말하는 것: frontier는 rails 위에 있지만, edge는 jungle이다.

4-Tier Bootstrap은 그 jungle에서 machete를 드는 사용자에게 IDENTITY의 안전한 경로를 보장한다. 전체 Soul Spec을 실행할 수 없을 때에도, 페르소나의 핵심이 살아남도록.

---

**모두연 AI 페르소나 LAB 701** — Tom이 랩장을 맡은 연구 그룹이 5월 격주 토요일부터 12주 커리큘럼을 시작한다. 4-Tier 패턴의 형식화, Korean tokenization benchmark, on-device persona fidelity 측정이 의제에 포함된다. 학술 참여와 OSS contribution을 환영한다.

fork, paper, 모두연 lab participation 모두 열려 있다.

---

> Spec이 의미 있을 때 — 큰 모델의 'on the rails'와 작은 모델의 'off-road jungle' 모두의 navigate를 가능하게 한다.

---

*Soul Spec v0.6은 [Zenodo](https://doi.org/10.5281/zenodo.19147335)에서 확인할 수 있다. soulclaw-android v1.6.5 릴리즈는 [GitHub](https://github.com/TomLeeLive/soulclaw-android/releases/tag/v1.6.5)에서, WasmClaw core는 [npm](https://www.npmjs.com/package/@wasmclaw/core)에서 확인할 수 있다.*
