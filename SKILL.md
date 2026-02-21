---
name: bmad-openclaw
description: Run the BMAD Method inside OpenClaw using structured role prompts, templates, and workflows. Use when you want PRD/architecture/UX/epics/stories created or validated, to launch BMAD sub-agents (architect/dev/reviewer/qa), or to enforce readiness checks and sprint flow.
---

# BMAD × OpenClaw (Clean Workflow)

This skill packages BMAD’s role prompts, templates, checklists, and workflow state machine for use with OpenClaw `sessions_spawn`.

## Credits
- BMAD Method v6 by BMad Code (https://github.com/bmadcode/BMAD-METHOD)
- OpenClaw adaptation by Erwan Lorteau (https://github.com/ErwanLorteau/BMAD_Openclaw)

## What’s included (in references)
- **agents/** — upstream BMAD personas
- **agents-openclaw/** — execution agents tailored to OpenClaw
- **templates/** — PRD, architecture, UX, epics, story, tech spec, readiness report
- **checklists/** — code review, sprint planning, QA, correct-course
- **workflow/** — orchestrator + phases + state machine

## How to use (recommended flow)

**Phase 0 — Human setup (required):**
- Create **Project Brief** + **PRD** + **Architecture** using templates.
- Save in your project repo (e.g., /docs or /planning).

**Phase 1 — Readiness check (gate):**
Run the readiness check agent. It halts if PRD/Architecture/Epics are missing.

**Phase 2 — Create stories:**
Use create-story agent to turn epics into dev stories.

**Phase 3 — Dev execution:**
Run dev-story agent in batches; review after each batch.

**Phase 4 — Review + QA:**
Run code-review + qa-tester agents.

**Phase 5 — Retrospective:**
Run retrospective agent and log improvements.

## Launching agents (examples)
Use sessions_spawn with the agent you want, or the launcher script:
```
skills/bmad-openclaw/scripts/bmad-launcher.sh readiness /path/to/project /path/to/docs
```

```js
sessions_spawn({
  task: "Run readiness check for Project X",
  agentId: "readiness-check",
  label: "bmad-readiness-check"
});
```

```js
sessions_spawn({
  task: "Create stories from epics for Project X",
  agentId: "create-story",
  label: "bmad-create-story"
});
```

```js
sessions_spawn({
  task: "Implement the next dev story in Project X",
  agentId: "dev-story",
  label: "bmad-dev-story"
});
```

## References
All BMAD materials are stored here:
```
skills/bmad-openclaw/references/BMAD_Openclaw/
```

Use them directly for PRD, architecture, UX, epics, sprint status, and readiness reports.

## Guardrails
- Always require a PRD + Architecture before dev-story runs.
- Run in **batch mode** (2–3 hour runs) and review outputs.
- Keep stack consistent to reduce hallucinations.
