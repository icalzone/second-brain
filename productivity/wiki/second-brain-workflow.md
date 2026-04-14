# Second Brain Workflow

A set of four reusable prompts for building and maintaining a personal AI-powered knowledge base (Second Brain). The system turns raw source material — articles, notes, pastes — into a structured, searchable wiki that compounds in value over time.

## The Four Prompts

### 1. Scrape a Web Source (Use Anytime)
Drop any URL into your knowledge base:

> Scrape [URL] into raw/. Use agent-browser to open the page, extract the main content, and save it as a markdown file in raw/ with a descriptive filename.

agent-browser handles JavaScript-heavy pages, login-gated content, and infinite-scroll pages.

### 2. Compile Your Wiki (Run This First After Adding Sources)
Turn everything in `raw/` into a structured wiki:

> Read everything in raw/. Then compile a wiki in wiki/ following the rules in CLAUDE.md. Create a README.md first, then create one .md file per major topic. Link related topics. Summarize every source.

Run this whenever `raw/` has new content. Each run updates or creates articles — it's additive, not destructive.

### 3. Ask Questions Against Your Wiki
Query your knowledge base:

> Based on everything in wiki/, what are the three biggest gaps in my understanding of [topic]?

> Compare what source A says about [concept] vs what source B says. Where do they disagree?

> Write me a 500-word briefing on [topic] using only what's in this knowledge base.

Save answers into `outputs/` or update wiki articles directly. This is the **compounding loop** — every query makes the system smarter.

### 4. Monthly Health Check
Keep the wiki accurate and well-organized:

> Review the entire wiki/ directory. Flag any contradictions between articles. Find topics mentioned but never explained. List any claims that aren't backed by a source in raw/. Suggest 3 new articles that would fill gaps.

Run once a month. Results feed back into the wiki as corrections and new articles.

## The LLM Knowledge Builder Commands

Four slash commands drop into your AI agent (Claude Code, GitHub Copilot, Cursor, Codex):

| Command | Purpose |
|---|---|
| `/second-brain` | One-time setup wizard |
| `/second-brain-ingest` | Drop raw sources in, AI builds your wiki |
| `/second-brain-query` | Ask questions across everything you've fed it |
| `/second-brain-lint` | Health check the knowledge base |

## Getting Started in 10 Minutes

1. Run `/second-brain` — walks you through naming and setup
2. Drop one document into `raw/` (an article, a note, anything)
3. Run `/second-brain-ingest` — watch it become a structured wiki page

## How the System Compounds

```
raw/         ← dump everything here, never edit
  ↓ compile
wiki/        ← AI-maintained structured knowledge
  ↓ query
outputs/     ← answers, briefings, analyses
  ↓ update
wiki/        ← gets smarter each cycle
```

## Sources
- `productivity/raw/second-brain-workflow.md`

## Related
- [task-system](task-system.md) — The task system that feeds actions from the Second Brain into Apple Reminders
- [README](README.md) — Productivity wiki home
