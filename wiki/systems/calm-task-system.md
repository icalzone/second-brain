---
type: system
domains: [personal, work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# Calm Task System

A low-friction personal productivity system built around **Apple Reminders** for execution and a **Second Brain** wiki for thinking and reference. Designed to reduce decision fatigue, maintain trust in lists, and recover quickly when things feel overwhelming.

## Core Rules

| Rule | What it means |
|------|---------------|
| Dates mean dates | If something has a date, it *must* matter on that date. No fake dates. |
| Flags mean action | Flagged = actively working on it *now*. Not urgency — intent. |
| Backlog is permission to forget | If it has your attention, it cannot live in Backlog. |
| Decisions before actions | Backlog → Tasks is a decision. Tasks → Flagged is an action. |
| Short lists = calm mind | Heavy lists are signals, not failures. |

## Four Workflow Modes

```
Capture  →  Organize  →  Plan  →  Execute
(fast)      (slow)       (light)   (no organizing)
```

- **Capture** — fast, frictionless, no decisions. Uses Inbox, Notes, Wallabag, Siri.
- **Organize** — deliberate, limited, scheduled. Once daily or weekly, never during execution.
- **Plan** — lightweight steering. Choose 1–3 outcomes, not a full plan.
- **Execute** — look only at Active and Today. No backlog browsing, no restructuring.

## Lists

### Capture
| List | Purpose |
|------|---------|
| **Inbox** | Everything enters here. No thinking at capture time. |

### Storage Lists (rarely browsed)
| List | Purpose |
|------|---------|
| **Tasks** | Committed to-dos; decided but not yet active |
| **Bills** | All bills regardless of due date |
| **Backlog** | Ideas, someday items, no urgency |

### Smart Lists (what you actually look at)
| Smart List | Shows | Trust level |
|------------|-------|-------------|
| **Today** | Due today | Fully trusted |
| **Bills Due This Week** | Bills due in next 7 days | Fully trusted |
| **Active** | Flagged + not completed | Fully trusted — "I am actively working on these" |
| **Upcoming** | Due in ~5 days + `#scheduled` tag | Best-effort heads-up, not demanding |

## Flags vs. Dates

- **Due date** = external commitment or real deadline
- **Flag** = internal focus and intent
- Never use flags to mean urgency. Dates already handle that.

## Promotion Rules

```
Backlog → Tasks      (when you decide something is real)
Tasks → Flagged      (when you are actively working on it)
```

Backlog items **never get flagged directly**.

## Tags

Tags support filtering, not priority or status. Keep to 0–2 per task.

- **Context**: `#work`, `#home`, `#computer`, `#phone`, `#errands`
- **Area**: `#finance`, `#health`, `#{project}`
- **Signal**: `#scheduled` — intentional early warning for Upcoming list

## Reviews

### Morning (2 min)
1. Open **Today**
2. Open **Active**
3. Choose 1–3 outcomes that would make today successful
4. Unflag everything else if needed

### Daily (5–10 min)
1. Process **Reminders Inbox** → Tasks / Bills / Backlog
2. Scan **Mail** for requests, commitments, deadlines
   - If action required → capture to Reminders Inbox with email link
   - Do not manage tasks from Mail

### Weekly (10–15 min)
- Reset Active (≤7 items)
- Quick calendar glance (next 7–10 days)
- Scan Upcoming
- Promote 1–3 Backlog items
- Check Bills

### Monthly Trust Reset (5–10 min)
- Prune Tasks
- Remove guilt from Backlog
- Push fake dates
- Unflag everything, then re-flag only what's real

## Apple Shortcuts Integration

**Principle: Automate capture and linking. Never automate decisions.**

Shortcuts may: capture, tag, link, template.  
Shortcuts may not: auto-prioritize, auto-schedule, move Backlog → Tasks without you choosing.

### Shortcuts by Maturity

**Core (build first)**
- **Universal Capture** — one entry point (Reminder / Note / Calendar), no auto-dates or flags
- **Create Reminder from Mail** — extracts action from email into Inbox with a message link

**Optional (adds leverage)**
- **Mark as `#scheduled`** — tags tasks for Upcoming visibility without due dates
- **Link to Context (Reminder ↔ Note)** — creates a note and pastes back a deep link to the reminder
- **Daily Review Launcher** — opens Reminders Inbox + Mail
- **Weekly Review Launcher** — opens Active, Upcoming, Backlog, Calendar
- **Inbox Triage Helper**
- **Weekend Mode Toggle**
- **Create Reminder from Notes Selection**

**Advanced (protects meaning)**
- **End-of-Day Flag Reality Check** — guards the meaning of the flag

> If a shortcut feels controlling or confusing, delete it.

## Knowledge & Second Brain Integration

| Tool | Role |
|------|------|
| Apple Notes | Quick thinking, daily notes |
| Second Brain wiki | Thinking, reference, synthesis |
| FreshRSS → Wallabag | Reading intake |
| Wallabag → Notes | Worth reading → saved |
| Notes → Second Brain | Worth keeping → synthesized |

**Rule of Separation**
- **Reminders** = commitments and actions
- **Calendar** = time-bound reality
- **Notes / Second Brain** = thinking, reference, synthesis

If something in Notes becomes actionable → it graduates to Reminders.

## Emergency Reset

> **Unflag everything except the next 3 things.**

Instant clarity. No re-organization required.

## When This Breaks

| Symptom | Cause |
|---------|-------|
| Too many flags | You skipped the decision step |
| Today feels noisy | Fake dates were added |
| Backlog feels heavy | It's doing its job |
| Avoiding the app | Reset flags |

## Sources

Raw files:
- [task-system-FULL.md](/raw/task-system-FULL.md)
- [task-system-CHEATSHEET.md](/raw/task-system-CHEATSHEET.md)
- [task-system-APPENDIX-apple-shortcuts-RECIPES.md](/raw/task-system-APPENDIX-apple-shortcuts-RECIPES.md)
