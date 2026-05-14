# Appendix: Apple Shortcuts — Recipes + Maturity Model

This appendix contains **simple, safe Apple Shortcuts** that support your system **without automating decisions**.  
**Principle:** Automate capture + linking. Never automate decisions.

**Shortcut maturity model:** **Core** = capture & intake · **Optional** = review & linking · **Advanced** = guardrails & optimization

---

## Maturity Model (what belongs where)

### Core (build first)
- Universal Capture
- Create Reminder from Mail (with Link)

### Optional (adds leverage)
- Mark as Scheduled (`#scheduled`) — Upcoming helper
- Link to Context (Reminder ↔ Note) *(includes “reverse of Mail → Reminder”)*
- Daily Review Launcher
- Weekly Review Launcher
- Inbox Triage Helper
- Weekend Mode Toggle
- Create Reminder from Notes Selection

### Advanced (protects meaning)
- End‑of‑Day Flag Reality Check

> Rule: if a shortcut feels controlling or confusing, delete it.

---

## Shortcut 1 (Core): Universal Capture

**Purpose:** One entry point for quick capture (task / note / calendar) with minimal thinking.

**Best triggers:** Home Screen icon, Action Button, Siri phrase (e.g., “Capture this”), Spotlight

**Recipe (actions):**
1. **Ask for Input** (Text) → Prompt: “What is it?”
2. **Choose from Menu** → Options: “Reminder”, “Note”, “Calendar”
3. If **Reminder**:
   - **Add New Reminder**
     - Title = Provided Input
     - List = **Inbox**
     - Notes = (optional) “Captured via Shortcut”
4. If **Note**:
   - **Create Note** (Apple Notes)
     - Body = Provided Input
     - Folder = your default or “Inbox/Quick Notes”
5. If **Calendar**:
   - **Ask for Input** (Date) → “When?”
   - **Add New Event**
     - Title = Provided Input
     - Start/End = chosen time (or default 30–60 mins)

**Guardrails:** no auto‑dates for reminders, no auto‑flags.

---

## Shortcut 2 (Core): Create Reminder from Mail (with Link)

**Purpose:** Convert an email into a trusted action in Reminders **Inbox**, preserving the email as context.

**Best triggers:** Share Sheet in Mail, Services menu on Mac

**Recipe (actions):**
1. **Receive Share Sheet input** (Mail message)
2. **Get Details of Mail**
   - Subject
   - Message URL (or “Link to Message” if available)
3. **Add New Reminder**
   - Title = Subject
   - List = **Inbox**
   - Notes = Paste the message link
4. (Optional) **Ask for Input** (Text): “What’s the next action?” → append to Notes

**Guardrails:** This does not reply, file, or triage mail. It only captures.

---

## Shortcut 3 (Optional): Mark as Scheduled (Upcoming Helper)

**Purpose:** Work around Smart List filter limits by intentionally including non‑bill tasks in your Upcoming list.

**Best triggers:** Share Sheet in Reminders, Home Screen

**Recipe (actions):**
1. **Find Reminders** (or **Select Reminders** if you prefer manual selection)
2. **Add Tags to Reminders** → add `scheduled` (i.e., `#scheduled`)
3. (Optional) If you want: **If** reminder has no due date → **Ask for Input** (Date) → **Set Due Date**

**Guardrails:** Never add `#scheduled` to Bills (that’s how you keep lists clean).

---

## Shortcut 4 (Optional): Link to Context (Reminder ↔ Note) — includes “Reverse of Mail → Reminder”

**Purpose:** When a reminder needs thinking/context, create a note and link the reminder into it (context in Notes, action in Reminders).

**Best triggers:** Share Sheet from Reminders, Home Screen

**Recipe (actions):**
1. **Receive Input** (Reminder) *(or choose from a list)*
2. **Get Link to Reminder** (or “URL” if available)
3. **Ask for Input** (Text): “Context / notes?” *(optional)*
4. **Create Note** (Apple Notes)
   - Title = Reminder title
   - Body =
     - Context text (optional)
     - Reminder link
5. (Optional) **Copy to Clipboard** the note link for easy back‑reference

**Guardrails:** Don’t duplicate tasks in Notes. Notes are supporting context only.

---

## Shortcut 5 (Optional): Daily Review Launcher

**Purpose:** Enter **Organize mode** instantly by opening the right surfaces.

**Best triggers:** Home Screen, Dock, Scheduled automation (weekday morning)

**Recipe (actions):**
1. **Open App** → Reminders
2. (Optional) **Open URL** deep‑link to Reminders Inbox if you use URL schemes (otherwise stop at opening Reminders)
3. **Open App** → Mail

**Guardrails:** This is a launcher only—no auto‑processing.

---

## Shortcut 6 (Optional): Weekly Review Launcher

**Purpose:** Line up your review surfaces (Active, Upcoming, Backlog, Calendar) so the review stays short.

**Best triggers:** Home Screen, Scheduled automation (e.g., Sunday evening or Monday morning)

**Recipe (actions):**
1. **Open App** → Reminders
2. (Optional) Show a **Menu**:
   - “Open Active”
   - “Open Upcoming”
   - “Open Backlog”
   - “Open Calendar Week”
3. **Open App** → Calendar

**Guardrails:** Keep it as navigation, not automation.

---

## Shortcut 7 (Advanced): End‑of‑Day Flag Reality Check

**Purpose:** Protect the meaning of flags by preventing “flag drift.”

**Best triggers:** Scheduled automation (weekday evening), Home Screen

**Recipe (actions):**
1. **Find Reminders** where **Flagged is True** and **Not Completed**
2. **Choose from List** (multiple selection enabled)
3. Show a **Menu**:
   - “Unflag selected” → **Set Flag** off for selected items
   - “Keep as is” → end
   - (Optional) “Unflag all but top 3” → requires you to select 3 to keep, then unflag the rest

**Guardrails:** Never unflag silently; always prompt.

---

## Shortcut 8 (Optional): Inbox Triage Helper

**Purpose:** Speed up Inbox processing by reducing taps while keeping decisions explicit.

**Best triggers:** Share Sheet from Reminders, Home Screen

**Recipe (actions):**
1. **Find Reminders** in list **Inbox** (or select a reminder)
2. **Choose from Menu**:
   - “Move to Tasks” → **Move Reminders** to Tasks
   - “Move to Backlog” → **Move Reminders** to Backlog
   - “Move to Bills” → **Move Reminders** to Bills
   - “Add date” → **Ask for Input** (Date) → **Set Due Date**

**Guardrails:** Don’t flag here. Flagging belongs to “I’m doing this now.”

---

## Shortcut 9 (Optional): Weekend Mode Toggle

**Purpose:** A tiny posture shift: weekends optimize ease (Active can be empty).

**Best triggers:** Scheduled automation (Sat morning), Home Screen

**Recipe (actions):**
1. **Show Notification**:
   - Title: “Weekend mode”
   - Body: “Active can be 0–3. Dates only for real commitments. Backlog untouched.”
2. **Open App** → Reminders (optional)

**Guardrails:** No task manipulation needed.

---

## Shortcut 10 (Optional): Create Reminder from Notes Selection

**Purpose:** Graduate a thought from Notes into a real action in Reminders (Inbox) with a backlink.

**Best triggers:** Share Sheet from Notes, Services menu on Mac

**Recipe (actions):**
1. **Receive Input** (Text) from Notes selection
2. (Optional) **Get Link to Note** (if available)
3. **Add New Reminder**
   - Title = selected text (or prompt for a cleaner title)
   - List = **Inbox**
   - Notes = note link (optional) + any extra context

**Guardrails:** Notes stay for thinking; Reminders holds commitments.

---

## Automation Guardrails (keep the system trustworthy)

Shortcuts may automate:
- capture
- tagging
- linking
- navigation/launching
- lightweight templates

Shortcuts must NOT:
- auto‑prioritize
- auto‑schedule tasks based on heuristics
- move Backlog → Tasks without you choosing
- silently unflag or rewrite your lists

> If a shortcut makes you feel managed instead of supported, delete it.
