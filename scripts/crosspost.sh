#!/bin/bash
# Cross-post Hugo blog posts to Hashnode + Medium
# Usage: ./crosspost.sh <post-dir> [en|ko]
# Example: ./crosspost.sh soul-spec-for-robots en

set -e

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
POST_DIR="$1"
LANG="${2:-en}"
HASHNODE_TOKEN="${HASHNODE_TOKEN:?Set HASHNODE_TOKEN env var}"
HASHNODE_PUB_ID="699d56e9d00f02a907899d5c"
MEDIUM_TOKEN="${MEDIUM_TOKEN}"

if [ -z "$POST_DIR" ]; then
  echo "Usage: $0 <post-dir> [en|ko]"
  exit 1
fi

if [ "$LANG" = "en" ]; then
  FILE="$BLOG_DIR/content/posts/$POST_DIR/index.en.md"
  CANONICAL="https://blog.clawsouls.ai/posts/$POST_DIR/"
else
  FILE="$BLOG_DIR/content/posts/$POST_DIR/index.ko.md"
  CANONICAL="https://blog.clawsouls.ai/ko/posts/$POST_DIR/"
fi

if [ ! -f "$FILE" ]; then
  echo "File not found: $FILE"
  exit 1
fi

# Extract frontmatter
TITLE=$(sed -n 's/^title: *"\(.*\)"/\1/p' "$FILE" | head -1)
DESCRIPTION=$(sed -n 's/^description: *"\(.*\)"/\1/p' "$FILE" | head -1)
TAGS_RAW=$(sed -n 's/^tags: *\[\(.*\)\]/\1/p' "$FILE")

# Extract body (after second ---)
BODY=$(awk '/^---$/{c++; next} c>=2' "$FILE")
# Append canonical link
BODY="$BODY

---
*Originally published at [$CANONICAL]($CANONICAL)*"

echo "=== Post Details ==="
echo "Title: $TITLE"
echo "Canonical: $CANONICAL"
echo "File: $FILE"
echo ""

# --- HASHNODE ---
echo "=== Publishing to Hashnode ==="

# Build tags array for Hashnode (convert to JSON objects with slug)
HASHNODE_TAGS=$(echo "$TAGS_RAW" | tr -d '"' | tr ',' '\n' | sed 's/^ *//' | while read tag; do
  slug=$(echo "$tag" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
  echo "{\"slug\":\"$slug\",\"name\":\"$tag\"}"
done | paste -sd',' -)

# Escape for JSON
BODY_ESCAPED=$(echo "$BODY" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))')
TITLE_ESCAPED=$(echo "$TITLE" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read().strip()))')

HASHNODE_QUERY=$(cat <<EOF
mutation {
  publishPost(input: {
    publicationId: "$HASHNODE_PUB_ID"
    title: $TITLE_ESCAPED
    contentMarkdown: $BODY_ESCAPED
    originalArticleURL: "$CANONICAL"
    tags: [$HASHNODE_TAGS]
  }) {
    post {
      id
      slug
      url
    }
  }
}
EOF
)

HASHNODE_PAYLOAD=$(python3 -c "import json; print(json.dumps({'query': '''$HASHNODE_QUERY'''}))" 2>/dev/null || \
  python3 -c "import sys,json; q=sys.stdin.read(); print(json.dumps({'query':q}))" <<< "$HASHNODE_QUERY")

HASHNODE_RESULT=$(curl -s -X POST https://gql.hashnode.com \
  -H "Content-Type: application/json" \
  -H "Authorization: $HASHNODE_TOKEN" \
  -d "$HASHNODE_PAYLOAD")

echo "$HASHNODE_RESULT" | python3 -m json.tool 2>/dev/null || echo "$HASHNODE_RESULT"
echo ""

# --- MEDIUM ---
if [ -n "$MEDIUM_TOKEN" ]; then
  echo "=== Publishing to Medium ==="
  
  # Get Medium user ID
  MEDIUM_USER=$(curl -s -H "Authorization: Bearer $MEDIUM_TOKEN" https://api.medium.com/v1/me)
  MEDIUM_USER_ID=$(echo "$MEDIUM_USER" | python3 -c "import sys,json; print(json.loads(sys.stdin.read())['data']['id'])")
  
  # Build tags (max 5 for Medium)
  MEDIUM_TAGS=$(echo "$TAGS_RAW" | tr -d '"' | tr ',' '\n' | sed 's/^ *//' | head -5 | python3 -c "import sys,json; print(json.dumps([l.strip() for l in sys.stdin.readlines() if l.strip()]))")
  
  MEDIUM_RESULT=$(curl -s -X POST "https://api.medium.com/v1/users/$MEDIUM_USER_ID/posts" \
    -H "Authorization: Bearer $MEDIUM_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$(python3 -c "
import json,sys
body = open('$FILE').read()
# Remove frontmatter
parts = body.split('---', 2)
content = parts[2] if len(parts) >= 3 else body
print(json.dumps({
  'title': $TITLE_ESCAPED,
  'contentFormat': 'markdown',
  'content': content,
  'canonicalUrl': '$CANONICAL',
  'tags': $MEDIUM_TAGS,
  'publishStatus': 'public'
}))
")")
  
  echo "$MEDIUM_RESULT" | python3 -m json.tool 2>/dev/null || echo "$MEDIUM_RESULT"
else
  echo "=== Medium: MEDIUM_TOKEN not set, skipping ==="
fi

echo ""
echo "Done!"
