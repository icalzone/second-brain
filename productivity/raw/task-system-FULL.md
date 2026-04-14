# A Calm, Low‑Friction Task & Knowledge System (Apple Reminders + Second Brain)

This document captures a **simple, durable personal productivity system** built around Apple Reminders for execution and a lightweight "Second Brain" for thinking, reference, and learning. The goal is to reduce decision fatigue, keep trust in your lists, and make it easy to recover when things feel overwhelming.

---

## Core Rules (Memorize These)

- **Dates mean dates**
 If something has a date, it *must* matter on that date.

- **Flags mean action**
 Flagged = you are intentionally working on it *now*.

- **Backlog is permission to forget**
 If something has your attention, it does not belong there.

- **Decisions before actions**
 Backlog → Tasks is a decision.
 Tasks → Flagged is an action.

- **Short lists = calm mind**
 Heavy lists are signals, not failures.

---

## The Big Picture Workflow
Your workflow has **four modes**, each with clear tool boundaries:
1. **Capture** – fast, frictionless, no decisions
2. **Organize** – deliberate, limited, scheduled
3. **Plan** – lightweight steering, not over‑thinking
4. **Execute** – do the work, no organizing allowed
---
## 1. Capture (Fast & Dumb)
Capture tools exist to answer one question only:
> “Do I want to look at this later?”
### Capture Tools
- Apple Mail
- Apple Calendar
- Apple Reminders (Inbox)
- Apple Notes (hot corner on Mac)
- FreshRSS
- Wallabag
- Siri → Reminders
### Capture Rules
- Do not assign priorities
- Do not over‑categorize
- Do not decide *how* or *when* yet
Everything captured lands in **Inbox**, Notes, or Wallabag.
---

## Apple Shortcuts (Automation That Respects the System)

**Automate capture and linking. Never automate decisions.**

### Supported Shortcut Patterns

1. **Universal Capture** – one entry point for reminders, notes, or calendar items
2. **Create Reminder from Mail (with link) / Share Sheet** – extract commitments from email, Captures an action from an email into Reminders **Inbox** and stores the email link in the reminder note.
3. **Mark as `#scheduled`** – intentionally include items in Upcoming
4. **Link to Context** – Reminder ↔ Note, Calendar ↔ Note. Creates a note and pastes deep links back to the source item so context lives in Notes, action lives in Reminders.
5. **Daily Review Launcher** – opens Reminders Inbox + Mail for intake
6. **Weekly Review Launcher** – opens Active, Upcoming, Backlog, Calendar
7. **End‑of‑Day Flag Reality Check** – protects the meaning of flags

> See the **Shortcuts Appendix** for concrete recipes.

### Automation rules
- Shortcuts may: capture, tag, link, template
- Shortcuts may not: auto‑prioritize, auto‑schedule, move Backlog → Tasks without you choosing

> If a shortcut makes you feel managed instead of supported, delete it.

---
## 2. Organize (Slow & Intentional)
Organization happens **once daily or weekly**, never during execution.
### Lists (Minimal & Intentional)
#### Capture
- **Inbox** – everything enters here; no thinking
#### Storage Lists (Rarely Browsed)
- **Tasks** – real to‑dos you’ve committed to doing eventually
- **Bills** – all bills, regardless of due date
- **Backlog** – ideas, someday items, low‑pressure work
> Storage lists answer: *What kind of thing is this?*
---
## Smart Lists (What You Actually Look At)
### Today
- Due today
- Fully trusted
### Bills Due This Week
- Bills due in the next 7 days
- Fully trusted
### Active
- Flagged
- Not completed
> This is your **“I am actively working on these”** list.
### Upcoming (Early Warning)
Due to Apple Reminders limitations, Upcoming is designed as a **best‑effort heads‑up**, not a perfect filter.
Recommended setup:
- Due in next **5 days** (or 3 / 7 based on preference)
- Uses **`#scheduled`** tag for intentional early warning
#### `#scheduled` Tag Rule
- Applied only to **non‑bill tasks** that deserve advance visibility
- Bills never receive `#scheduled`
> Upcoming is informational, not demanding. Its job is to prevent surprises.
---
## Flags vs Dates (Very Important)
- **Due date** = external commitment or real deadline
- **Flag** = internal focus and intent
Never use flags to mean urgency. Dates already handle that.
---
## Backlog vs Tasks (Clear Boundaries)
### Backlog rules
Backlog items:
- Have **no flags**
- Have **no due dates**
- Are not being worked on
- Are allowed to be forgotten
> Backlog is *pre‑decision*.
### Tasks rules
Tasks:
- Are things you’ve decided you *will* do
- May or may not have dates
- Are not currently active
> Tasks are *post‑decision, pre‑action*.
### Promotion rules
- **Backlog → Tasks** – when you decide something is real
- **Tasks → Flagged (Active)** – when you are actively working on it
Backlog items **never get flagged directly**.
---
## Tags (Optional, Context Only)
Tags support filtering, **not priority or status**.
### Recommended Tags
- **Context**: `#work`, `#home`, `#computer`, `#phone`, `#errands`
- **Area**: `#finance`, `#health`, `#{project}`
- **Signal**: `#scheduled` (intentional early warning)
### Tag Rules
- 0–2 tags per task
- Skip tags if unsure
- If tags feel like work, stop using them
---
## 3. Plan (Very Light)
Planning is a *mode*, not a place.
### Morning Ritual: Today + Active (2 Minutes)
1. Open **Today**
2. Open **Active**
3. Ask:
 > “What are the **1–3 things** that would make today successful?”
4. Unflag everything else if needed
> You are choosing direction, not making a plan.
---
## Reviews
### Daily Review (5–10 Minutes) — Reminders + Mail Intake

This review is **organization**, not execution.

1. **Reminders: process Inbox**
   - Move to Tasks / Bills / Backlog
   - Add a date *only if it truly matters*
   - Flag *only* if you are actively working on it

2. **Mail: intake scan (not a task list)**
   - Scan for: requests, commitments, deadlines, decisions
   - If action is required → capture a Reminder into **Inbox** and (optionally) link back to the message
   - Archive or leave the email; don’t manage tasks from Mail

3. Stop when the Reminders Inbox is empty and the Mail scan is done
### Weekly Review (10–15 Minutes) — Reminders + Calendar
- Reset Active (≤7)
- Quick calendar glance (next 7–10 days): capture prep/follow‑ups into Reminders
- Scan Upcoming
- Promote 1–3 Backlog items
- Check Bills
### Monthly Deep Clean (5–10 Minutes)
This is a **trust reset**, not a re‑organization.
- Prune Tasks
- Remove guilt from Backlog
- Push fake dates
- Unflag everything, then flag only what’s real


**Tool boundary reminder**
- Reviews are allowed to touch: **Reminders, Mail (intake), Calendar (glance)**
- FreshRSS / Wallabag / Second Brain are **not** part of task reviews; they graduate into Reminders only when action is needed.
---
## 4. Execute (No Organizing Allowed)
When executing:
- Look only at **Active** and **Today**
- No backlog browsing
- No tag tuning
- No list restructuring
- No processing email (Mail is intake during review only)
---
## Knowledge & Second Brain Workflow
### Notes & Reference Tools
- Apple Notes (quick thinking, daily notes)
- GitHub repo with `.md` files (Second Brain wiki)
### Reading & Intake
- FreshRSS → Wallabag
- Wallabag → Notes
- Notes → Second Brain (when worth keeping)
### Rule of Separation
- **Reminders** = commitments and actions
- **Calendar** = time‑bound reality
- **Notes / Second Brain** = thinking, reference, synthesis
If something in Notes becomes actionable → it graduates to Reminders.
---
## Linking Strategy
- Reminder → Notes (supporting context)
- Calendar → Notes (meeting thinking)
- Reminder → Mail (source material)
- Calendar → Mail (agenda or follow‑up)
Never duplicate tasks across systems.
---
## Emergency Reset Rule
> **Unflag everything except the next 3 things.**
Instant clarity. No re‑organization required.
---
## When This System Breaks
- Too many flags → You skipped the decision step
- Today feels noisy → Fake dates were added
- Backlog feels heavy → It’s doing its job
- Avoiding the app → Reset flags
---
## Siri & Quick Capture
- All Siri captures → Inbox
- Decide later during Daily Review
---
## Final Mental Model
Every task answers only **one** question at a time:
1. Does it have a date?
2. Am I actively working on it?
3. Otherwise, let it rest quietly
If you follow this, the system stays calm—even when life isn’t.
