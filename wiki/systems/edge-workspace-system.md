---
type: system
domains: [work]
status: stable
source-confidence: high
updated: 2026-05-14
---

# Edge Workspace Naming & Color System

A standard naming and color convention for **Microsoft Edge Workspaces**, designed for fast visual recognition and low cognitive overhead in a multi-context web development role.

## Core Rule

> **Color = the kind of work. Name = project + what you're doing right now.**

When both are always true, the system stays trustworthy and easy to maintain.

## Naming Format

```
LANE | Project | Intent (Env)
```

| Component | Rules |
|-----------|-------|
| **LANE** | Fixed vocabulary, ALL CAPS, always first |
| **Project** | Short recognizable name (1–2 words); avoid dates |
| **Intent** | Verb describing current activity — must reflect what you're *actually doing now* |
| **Env** *(optional)* | Use when environment matters: `PROD`, `STG`, `DEV`, `LOCAL` |

## Approved Lanes

Keep the lane list at ≤7 to preserve fast recognition. **A workspace never changes lanes.**

| Lane | Color | Meaning | Use when you are… |
|------|-------|---------|-------------------|
| **OPS** | Red 🔴 | Production / risk | Handling incidents, SSL, redirects, PROD issues |
| **MIGR** | Orange 🟠 | Major coordinated change | Site migrations, cutovers, launches |
| **CMS** | Blue 🔵 | Core CMS / dev work | Building or debugging CMS features |
| **PERF** | Green 🟢 | Measurement & optimization | Auditing or improving performance |
| **MKTG** | Teal 🟦 | Marketing systems | Working in D365, forms, attribution |
| **R&D** | Purple 🟣 | Exploration / spikes | Research, experiments, prototypes |
| **MEET** | Gray ⚪ | Meetings & notes | Prep, notes, follow-ups |

## Approved Intent Verbs

Choose from this fixed list to avoid unnecessary variation:

`Build` · `Debug` · `QA` · `Ship` · `Research` · `Review` · `Monitor` · `Notes`

If none fit cleanly, default to **Build**, **Research**, or **Monitor**.

## Examples

**Migration**
```
MIGR | OMAX | Build (STG)
MIGR | OMAX | QA
MIGR | OMAX | Cutover (PROD)
```

**CMS / Development**
```
CMS | Optimizely | Build (LOCAL)
CMS | Global Templates | Review
CMS | Optimizely | Debug
```

**Ops / Production**
```
OPS | Redirects & SSL | Monitor
OPS | Forms | Debug (PROD)
OPS | Analytics | Verify
```

**Performance**
```
PERF | Hypertherm.com | Audit
PERF | Mobile CLS | Fix
PERF | CWV | Monitor
```

**Marketing / D365**
```
MKTG | OMAX D365 | Build
MKTG | Forms | QA
MKTG | Attribution | Review
```

**R&D / Exploration**
```
R&D | Opal | Research
R&D | AI Wiki | Prototype
R&D | Prompt System | Design
```

**Meetings**
```
MEET | Web DevOps | Notes
MEET | Launch Review | Notes
MEET | Optimizely | Prep
```

## Visual Heuristics

- **Red visible** → immediate attention, risk-aware
- **Orange active** → careful, coordinated work
- **Blue open** → normal dev flow
- **Purple lingering** → check for time-boxing

> When you can trust color alone, naming becomes simpler.

## Workspace Lifecycle

**Daily**
- If intent changes, rename immediately: `Build → Debug → Ship`

**Weekly**
- Close or delete workspaces whose intent was `Ship`, `QA`, `Monitor` and are now complete

**Always**
- Never repurpose an old workspace for a new lane
- Delete aggressively — workspaces are temporary context containers

## One-Line Cheat Sheet

```
Color = Lane  (OPS red · MIGR orange · CMS blue · PERF green · MKTG teal · R&D purple · MEET gray)
Name  = LANE | Project | Intent (Env)
```

## Sources

Raw files:
- [edge-workspace-naming-color-system.md](/raw/edge-workspace-naming-color-system.md)
- [Using Workspaces in EDGE.html](/raw/Using%20Workspaces%20in%20EDGE.html) — saved M365 Copilot chat (origin conversation)
