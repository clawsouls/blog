#!/usr/bin/env node
// Cross-post to Hashnode
// Usage: node crosspost-hashnode.mjs <post-dir> [en|ko]

import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const BLOG_DIR = resolve(__dirname, '..');

const HASHNODE_TOKEN = process.env.HASHNODE_TOKEN || 'aab75ec6-b645-45b2-8110-1a9a5cd581e9';
const HASHNODE_PUB_ID = '699d56e9d00f02a907899d5c';

const postDir = process.argv[2];
const lang = process.argv[3] || 'en';

if (!postDir) {
  console.error('Usage: node crosspost-hashnode.mjs <post-dir> [en|ko]');
  process.exit(1);
}

const file = lang === 'en'
  ? `${BLOG_DIR}/content/posts/${postDir}/index.en.md`
  : `${BLOG_DIR}/content/posts/${postDir}/index.ko.md`;

const canonical = lang === 'en'
  ? `https://blog.clawsouls.ai/posts/${postDir}/`
  : `https://blog.clawsouls.ai/ko/posts/${postDir}/`;

const raw = readFileSync(file, 'utf-8');

// Parse frontmatter
const fmMatch = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
if (!fmMatch) { console.error('No frontmatter found'); process.exit(1); }

const fm = fmMatch[1];
const body = fmMatch[2];

const title = fm.match(/title:\s*"(.+?)"/)?.[1] || 'Untitled';
const tagsRaw = fm.match(/tags:\s*\[(.+?)\]/)?.[1] || '';
const tags = tagsRaw.split(',').map(t => t.trim().replace(/"/g, '')).filter(Boolean);

const content = body + `\n\n---\n*Originally published at [${canonical}](${canonical})*`;

const hashTags = tags.map(t => ({ slug: t.toLowerCase().replace(/\s+/g, '-'), name: t }));

const query = `mutation PublishPost($input: PublishPostInput!) {
  publishPost(input: $input) {
    post { id slug url }
  }
}`;

const variables = {
  input: {
    publicationId: HASHNODE_PUB_ID,
    title,
    contentMarkdown: content,
    originalArticleURL: canonical,
    tags: hashTags,
  }
};

console.log(`Publishing to Hashnode: "${title}"`);
console.log(`Canonical: ${canonical}`);
console.log(`Tags: ${tags.join(', ')}`);

const res = await fetch('https://gql.hashnode.com', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': HASHNODE_TOKEN,
  },
  body: JSON.stringify({ query, variables }),
});

const result = await res.json();

if (result.errors) {
  console.error('Hashnode errors:', JSON.stringify(result.errors, null, 2));
  process.exit(1);
}

const post = result.data?.publishPost?.post;
if (post) {
  console.log(`✅ Published: ${post.url}`);
} else {
  console.log('Response:', JSON.stringify(result, null, 2));
}
