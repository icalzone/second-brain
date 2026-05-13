# Second Brain – Cheat Sheet

This system is optimized for:
- Zero‑friction daily capture
- Periodic AI‑assisted synthesis
- Durable, queryable knowledge

You only do **three kinds of work**: capture, synthesize, query.

---

## DAILY (Capture Mode — 1–2 minutes)

**Goal:** Get things out of your head. No thinking.

### What to do
- Add files directly to `raw/`
- Stop immediately

### Allowed content
- Rough notes
- Ideas / thoughts
- Logs / errors
- Links
- Screenshots / PDFs

### Rules
- `raw/` is flat (no subfolders)
- No metadata
- No cleanup
- Filenames may include a date or short hint (optional)

✅ If you hesitate about where it goes, it goes in `raw/`.

---

## WEEKLY (Synthesis Mode — ~20–30 minutes)

**Goal:** Turn noise into durable knowledge.

### Step 1 — Run ingest
VS Code → Command Palette → Tasks →  
**Second Brain: Weekly Synthesis (Ingest → Summary)**

AI will:
- Read new raw files
- Update or create wiki pages
- Add links + minimal YAML metadata

---

### Step 2 — Review like code
You:
- Read diffs
- Fix wording
- Reject weak structure
- Clarify what matters

AI proposes. You decide.

---

### Step 3 — Commit insights
Use meaningful commits:
- `ai: synthesize form reliability failures`
- `refine: clarify trusted types conflict`
- `docs: connect reliability metrics to goals`

Your git log becomes your learning timeline.

---

## MONTHLY / AS‑NEEDED (Maintenance Mode)

VS Code → Tasks →  
**Second Brain: Lint**

AI reports:
- Duplicates
- Broken links
- Orphaned pages

You clean only what hurts.

---

## QUERYING (Thinking Mode)

When you need answers:
VS Code → Tasks →  
**Second Brain: Query Wiki**

Example questions:
- “What patterns recur in recent production issues?”
- “Summarize what I’ve learned about form reliability”
- “What concepts connect this project to past work?”

Results are saved to `outputs/queries/`.

---

## WORK VS PERSONAL

Never separate at capture time.

Distinction happens later in `wiki/` via metadata:
```yaml
domains: [work]
domains: [personal]