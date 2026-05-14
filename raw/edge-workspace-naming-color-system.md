
Edge Workspace Naming & Color System
This document defines the standard naming and color conventions for Microsoft Edge Workspaces, designed to integrate cleanly into a second-brain / knowledge-management workflow.
The goals of this system are:

Fast visual recognition
Low cognitive overhead
Consistency across time and devices
Clear separation of work contexts rather than individual tasks


Core Rule (TL;DR)

Color = the kind of work
Name = project + what you’re doing right now


If those two things are always true, the system stays trustworthy and easy to maintain.


Naming Convention
Format

LANE | Project | Intent (Env)


Components

LANEFixed vocabulary
ALL CAPS
Always first
ProjectShort, recognizable name (1–2 words)
Avoid dates unless truly necessary
IntentA verb describing current activity
Must reflect what you’re actually doing now
Env (optional)Used when environment matters
Examples: PROD, STG, DEV, LOCAL


Approved Lanes (Fixed Set)
Keep the lane list small (≤7) to preserve fast recognition.

Lane	Color	Meaning	Use When You Are…
OPS	Red 🔴	Production / risk	Handling incidents, SSL, redirects, PROD issues
MIGR	Orange 🟠	Major coordinated change	Site migrations, cutovers, launches
CMS	Blue 🔵	Core CMS / dev work	Building or debugging CMS features
PERF	Green 🟢	Measurement & optimization	Auditing or improving performance
MKTG	Teal 🟦	Marketing systems	Working in D365, forms, attribution
R&D	Purple 🟣	Exploration / spikes	Research, experiments, prototypes
MEET	Gray ⚪	Meetings & notes	Prep, notes, follow-ups

Rule: A workspace never changes lanes. If the kind of work changes, create a new workspace.


Approved Intent Verbs
To avoid unnecessary variation, choose from this fixed list:

Build
Debug
QA
Ship
Research
Review
Monitor
Notes
If none fit cleanly, default to Build, Research, or Monitor.


Example Workspaces
Migration

MIGR | OMAX | Build (STG)
MIGR | OMAX | QA
MIGR | OMAX | Cutover (PROD)


CMS / Development

CMS | Optimizely | Build (LOCAL)
CMS | Global Templates | Review
CMS | Optimizely | Debug


Ops / Production Safety

OPS | Redirects & SSL | Monitor
OPS | Forms | Debug (PROD)
OPS | Analytics | Verify


Performance

PERF | Hypertherm.com | Audit
PERF | Mobile CLS | Fix
PERF | CWV | Monitor


Marketing / D365

MKTG | OMAX D365 | Build
MKTG | Forms | QA
MKTG | Attribution | Review


R&D / Exploration

R&D | Opal | Research
R&D | AI Wiki | Prototype
R&D | Prompt System | Design


Meetings

MEET | Web DevOps | Notes
MEET | Launch Review | Notes
MEET | Optimizely | Prep




Visual Heuristics (How This Is Meant to Feel)

Red visible → immediate attention, risk-aware
Orange active → careful, coordinated work
Blue open → normal dev flow
Purple lingering → check for time-boxing
When you can trust color alone, naming becomes simpler.


Workspace Lifecycle Rules
Daily

If intent changes, rename the workspace immediately Build → Debug → Ship
Weekly

Close or delete workspaces whose intent was: Ship
QA
Monitor and are now complete
Always

Never repurpose an old workspace for a new lane
Delete aggressively—workspaces are temporary context containers


One-Line Cheat Sheet

Color = Lane (OPS red, MIGR orange, CMS blue, PERF green, MKTG teal, R&D purple, MEET gray)
Name = LANE | Project | Intent (Env)




This document is intentionally opinionated. Consistency matters more than edge cases.
