# Apple Shortcuts Recipes for the Task System

Practical Apple Shortcuts that support the Calm Task System by automating **capture and linking** — never automating decisions.

## Maturity Model

Build these in order:

### Core (Build First)
- Universal Capture
- Create Reminder from Mail (with Link)

### Optional (Adds Leverage)
- Mark as Scheduled (`#scheduled`)
- Link to Context (Reminder ↔ Note)
- Daily Review Launcher
- Weekly Review Launcher
- Inbox Triage Helper
- Weekend Mode Toggle
- Create Reminder from Notes Selection

### Advanced (Protects Meaning)
- End-of-Day Flag Reality Check

> Rule: if a shortcut feels controlling or confusing, delete it.

---

## Shortcut 1 (Core): Universal Capture

**Purpose:** One entry point for any quick capture — task, note, or calendar event — with no thinking required.

**Best triggers:** Home Screen icon, Action Button, Siri ("Capture this"), Spotlight

**Actions:**
1. Ask for Input (Text) → "What is it?"
2. Choose from Menu → "Reminder" / "Note" / "Calendar"
3. **If Reminder:**
   - Add New Reminder, List = Inbox, no date, no flag
4. **If Note:**
   - Create Note in Apple Notes → default or "Inbox/Quick Notes" folder
5. **If Calendar:**
   - Ask for Input (Date) → "When?"
   - Add New Event

**Guardrail:** No auto-dates, no auto-flags on Reminders.

---

## Shortcut 2 (Core): Create Reminder from Mail (with Link)

**Purpose:** Convert an email into a trusted action in Reminders Inbox, preserving the email as context.

**Best triggers:** Share Sheet in Mail, Services menu on Mac

**Actions:**
1. Receive Share Sheet input (Mail message)
2. Get Details of Mail → Subject + Message URL
3. Add New Reminder:
   - Title = Email Subject
   - List = Inbox
   - Notes = paste the message link
4. (Optional) Ask for Input → "What's the next action?" → append to Notes

**Guardrail:** Does not reply, file, or triage mail — only captures.

---

## Shortcut 3 (Optional): Mark as Scheduled

**Purpose:** Tag a reminder with `#scheduled` so it appears in Upcoming with intent.

**Actions:**
1. Receive reminder from Share Sheet or search
2. Get Notes of Reminder
3. Set Notes = current notes + " #scheduled"
4. (Optional) Ask "When?" and set a due date

---

## Shortcut 4 (Optional): Link to Context (Reminder ↔ Note)

**Purpose:** Create a Note and paste deep links back to the source so context lives in Notes, action lives in Reminders.

**Actions:**
1. Ask for Input → "What's the context?" 
2. Create Note with that content
3. Get URL of new Note
4. Add New Reminder (or update existing) with Note URL in the Notes field
5. Copy Reminder deep link → paste into the Note

---

## Shortcut 5 (Optional): Daily Review Launcher

**Purpose:** One tap to open both Reminders Inbox and Mail for your daily intake.

**Actions:**
1. Open Reminders (filtered to Inbox list)
2. Open Mail (Inbox)

---

## Shortcut 6 (Optional): Weekly Review Launcher

**Purpose:** One tap to open all review surfaces — Active, Upcoming, Backlog, Calendar.

**Actions:**
1. Open Reminders → Active list
2. Open Reminders → Upcoming list
3. Open Reminders → Backlog list
4. Open Calendar (week view)

---

## Shortcut 7 (Advanced): End-of-Day Flag Reality Check

**Purpose:** Protect the meaning of flags — surfaces everything flagged so you can decide if it's truly active.

**Actions:**
1. Find Reminders where Flagged = true and Completed = false
2. Show results
3. Ask: "Remove flags from all?" → if Yes, loop and remove flags
4. (Optional) Log to a note: "Flags reset at [date]"

---

## Sources
- `productivity/raw/task-system-APPENDIX-apple-shortcuts-RECIPES.md`
- `productivity/raw/task-system-FULL.md`

## Related
- [[task-system]] — The full task system these shortcuts support
- [[README]] — Productivity wiki home
