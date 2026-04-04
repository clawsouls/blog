#!/usr/bin/env bash
# Cross-post all 6 English posts to dev.to and Hashnode
set -e
cd "$(dirname "$0")/.."

DEVTO_KEY="${DEVTO_KEY:?Set DEVTO_KEY env var}"
RESULTS_FILE="scripts/crosspost-results.md"

echo "# Cross-post Results $(date)" > "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"

crosspost_one() {
  local slug="$1"
  local tags="$2"
  local FILE="content/posts/${slug}/index.en.md"
  local CANONICAL="https://blog.clawsouls.ai/posts/${slug}/"

  echo "=========================================="
  echo "Processing: $slug"
  echo "=========================================="

  # Extract title from frontmatter
  local TITLE=$(grep '^title:' "$FILE" | sed 's/title: *"//;s/"$//')

  # Strip frontmatter, get body
  local BODY=$(awk '/^---$/{c++;next} c>=2' "$FILE")

  # Add footer
  BODY="${BODY}

---
*Originally published at [blog.clawsouls.ai](${CANONICAL})*"

  echo "Title: $TITLE"

  # === dev.to ===
  echo "  → Posting to dev.to..."

  local PAYLOAD=$(jq -n \
    --arg title "$TITLE" \
    --arg body "$BODY" \
    --arg canonical "$CANONICAL" \
    --argjson tags "$tags" \
    '{article: {title: $title, body_markdown: $body, published: true, canonical_url: $canonical, tags: $tags}}')

  local DEVTO_RESPONSE=$(curl -s -X POST https://dev.to/api/articles \
    -H "Content-Type: application/json" \
    -H "api-key: $DEVTO_KEY" \
    -d "$PAYLOAD")

  local DEVTO_URL=$(echo "$DEVTO_RESPONSE" | jq -r '.url // empty')
  local DEVTO_ERROR=$(echo "$DEVTO_RESPONSE" | jq -r '.error // empty')

  if [ -n "$DEVTO_URL" ] && [ "$DEVTO_URL" != "null" ]; then
    echo "  ✅ dev.to: $DEVTO_URL"
  else
    echo "  ❌ dev.to error: $DEVTO_ERROR"
    echo "  Full response: $(echo "$DEVTO_RESPONSE" | head -c 500)"
    DEVTO_URL="ERROR: $DEVTO_ERROR"
  fi

  sleep 3

  # === Hashnode ===
  echo "  → Posting to Hashnode..."
  local HASHNODE_OUTPUT=$(node scripts/crosspost-hashnode.mjs "$slug" en 2>&1)
  echo "  $HASHNODE_OUTPUT"

  local HASHNODE_URL=$(echo "$HASHNODE_OUTPUT" | grep -o 'https://[^ ]*' | tail -1)

  # Record results
  echo "## $TITLE" >> "$RESULTS_FILE"
  echo "- dev.to: $DEVTO_URL" >> "$RESULTS_FILE"
  echo "- Hashnode: $HASHNODE_URL" >> "$RESULTS_FILE"
  echo "" >> "$RESULTS_FILE"

  sleep 3
}

crosspost_one "perfect-memory-breaks-ai-identity" '["ai","agents","memory","identity"]'
crosspost_one "soul-memory-4-tier-architecture" '["ai","agents","memory","architecture"]'
crosspost_one "why-perfect-memory-is-impossible" '["ai","agents","memory","transformers"]'
crosspost_one "the-human-in-the-loop-of-identity" '["ai","agents","identity","philosophy"]'
crosspost_one "claude-code-best-practices-we-already-built" '["ai","claudecode","devtools","programming"]'
crosspost_one "when-ai-agents-have-wallets" '["ai","agents","payments","security"]'

echo ""
echo "=========================================="
echo "ALL DONE. Results saved to $RESULTS_FILE"
echo "=========================================="
cat "$RESULTS_FILE"
