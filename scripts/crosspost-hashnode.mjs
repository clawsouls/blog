#!/usr/bin/env node
// Cross-post to Hashnode (publish or update)
// Usage: node crosspost-hashnode.mjs <post-dir> [en|ko] [--update]

import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const BLOG_DIR = resolve(__dirname, '..');

const HASHNODE_TOKEN = process.env.HASHNODE_TOKEN;
if (!HASHNODE_TOKEN) throw new Error('Set HASHNODE_TOKEN env var');
const HASHNODE_PUB_ID = '699d56e9d00f02a907899d5c';

const args = process.argv.slice(2);
const updateMode = args.includes('--update');
const positional = args.filter(a => !a.startsWith('--'));
const postDir = positional[0];
const lang = positional[1] || 'en';

if (!postDir) {
  console.error('Usage: node crosspost-hashnode.mjs <post-dir> [en|ko] [--update]');
  console.error('  --update  Update existing post (finds by slug)');
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

async function gql(query, variables) {
  const res = await fetch('https://gql.hashnode.com', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': HASHNODE_TOKEN,
    },
    body: JSON.stringify({ query, variables }),
  });
  return res.json();
}

// Find existing post by title match
async function findExistingPost() {
  const query = `query FindPosts($pubId: ObjectId!) {
    publication(id: $pubId) {
      posts(first: 50) {
        edges { node { id slug title } }
      }
    }
  }`;
  const result = await gql(query, { pubId: HASHNODE_PUB_ID });
  const edges = result.data?.publication?.posts?.edges || [];
  // Try exact title match first, then slug partial match
  const exact = edges.find(e => e.node.title === title);
  if (exact) return exact.node;
  const slug = postDir.toLowerCase();
  return edges.find(e => e.node.slug.includes(slug))?.node;
}

if (updateMode) {
  // UPDATE existing post
  console.log(`Looking for existing post matching "${postDir}"...`);
  const existing = await findExistingPost();
  if (!existing) {
    console.error(`❌ No existing post found matching "${postDir}"`);
    console.error('   Publish first without --update, or check the slug.');
    process.exit(1);
  }
  console.log(`Found: "${existing.title}" (${existing.id})`);

  const query = `mutation UpdatePost($input: UpdatePostInput!) {
    updatePost(input: $input) {
      post { id slug url }
    }
  }`;

  const variables = {
    input: {
      id: existing.id,
      title,
      contentMarkdown: content,
      originalArticleURL: canonical,
      tags: hashTags,
    }
  };

  console.log(`Updating on Hashnode: "${title}"`);
  const result = await gql(query, variables);

  if (result.errors) {
    console.error('Hashnode errors:', JSON.stringify(result.errors, null, 2));
    process.exit(1);
  }

  const post = result.data?.updatePost?.post;
  if (post) {
    console.log(`✅ Updated: ${post.url}`);
  } else {
    console.log('Response:', JSON.stringify(result, null, 2));
  }

} else {
  // PUBLISH new post
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

  const result = await gql(query, variables);

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
}
