# Claude Code Tasks — Prototype v0.1

## Purpose

This document provides copy-paste-ready Claude Code tasks for implementing Prototype v0.1.

Use one task at a time. Do not ask Claude Code to implement all tasks in one run.

## Global rules for all tasks

Before every task, Claude Code must read:

- `CLAUDE.md`
- `docs/mvp-scope.md`
- `docs/prototype-v0.1/IMPLEMENTATION-BLUEPRINT.md`
- relevant v0.1 docs for the task

For every task:

- stay inside scope
- list changed files
- report validation
- report placeholders
- report scope creep if any

## Task 001 — Expand GameState

```text
Read CLAUDE.md, docs/mvp-scope.md, docs/prototype-v0.1/IMPLEMENTATION-BLUEPRINT.md, docs/prototype-v0.1/GAME-STATE-SPEC.md, and docs/prototype-v0.1/BALANCE-TABLE.md.

Goal:
Implement the Prototype v0.1 GameState only.

Scope:
- Update game/scripts/core/game_state.gd.
- Add the fields, constants, phase enum, and methods defined in GAME-STATE-SPEC.md.
- Implement reset, forest expedition, evening transition, gate repair, night resolution, continue after night, and next day/prototype completion state.

Do not change:
- main scene UI
- assets
- governance docs
- systems outside v0.1

Acceptance criteria:
- GameState has all v0.1 fields.
- GameState methods are small and readable.
- No infection, weather, NPC, save, ads, or IAP fields are added.

Validation:
- Explain how the methods can be manually exercised from UI in the next task.
- If Godot can be run locally, verify the script parses.

After implementation:
- list changed files
- explain validation
- identify placeholders
- identify scope creep if any
```

## Task 002 — Implement Main UI Phase Renderer

```text
Read CLAUDE.md, docs/mvp-scope.md, docs/prototype-v0.1/SCENE-FLOW.md, and docs/prototype-v0.1/GAME-STATE-SPEC.md.

Goal:
Implement the single-scene UI phase renderer for Prototype v0.1.

Scope:
- Update game/scenes/main/main.tscn if needed.
- Update game/scripts/ui/main_controller.gd.
- Render the current GameState phase as simple placeholder UI.
- Add buttons for phase transitions and actions.

Do not change:
- gameplay balance values unless required by missing GameState integration
- governance docs
- excluded v0.1 systems

Acceptance criteria:
- Morning/Base screen appears.
- Forest expedition can be triggered.
- Expedition result appears.
- Evening appears.
- Repair gate button works if available.
- Start Night button works.
- Night result appears.
- Morning report appears.
- Prototype Complete and Game Over screens can render.

Validation:
- Run the main scene in Godot if available.
- Manually click through at least one day/night cycle.

After implementation:
- list changed files
- explain validation
- identify placeholders
- identify scope creep if any
```

## Task 003 — Manual Test Pass

```text
Read CLAUDE.md and docs/prototype-v0.1/TEST-PLAN.md.

Goal:
Run the v0.1 manual test plan and report results.

Scope:
- Do not implement new features.
- Only fix critical blockers that prevent the test plan from running, and only if the fix is small.

Do not change:
- MVP scope
- excluded systems
- governance docs unless a test process issue is discovered

Acceptance criteria:
- TC-001 through TC-010 are attempted.
- Results are reported clearly.
- Any failure includes likely cause and recommended next action.

Validation:
- Use the manual test plan.

After implementation/test:
- list changed files, if any
- report each test case as pass/fail/not tested
- identify blockers
- identify scope creep if any
```

## Task 004 — Balance Pass

```text
Read CLAUDE.md, docs/prototype-v0.1/BALANCE-TABLE.md, and docs/prototype-v0.1/TEST-PLAN.md.

Goal:
Tune only the v0.1 numeric values so Day 1 is easy, Day 2 is risky, and Day 3 can be lost if the player makes poor choices.

Scope:
- Adjust only v0.1 balance constants.
- Update BALANCE-TABLE.md if values change.

Do not change:
- feature scope
- scene architecture
- new systems
- visual polish

Acceptance criteria:
- Three-day loop remains playable.
- Balance values in code match BALANCE-TABLE.md.
- No excluded systems are introduced.

Validation:
- Run at least one manual playthrough.

After implementation:
- list changed files
- explain validation
- identify balance concerns
- identify scope creep if any
```

## Task 005 — v0.1 Completion Report

```text
Read CLAUDE.md, docs/prototype-v0.1/TEST-PLAN.md, docs/governance/GOVERNANCE-LIGHT.md, and docs/templates/CHANGE-REPORT.md.

Goal:
Produce a v0.1 completion report after the prototype loop is implemented and tested.

Scope:
- Create a change report under docs/reports/ if the project uses reports.
- Do not implement gameplay changes unless a tiny documentation correction is needed.

Acceptance criteria:
- Report summarizes what works.
- Report lists validation evidence.
- Report lists known issues.
- Report recommends whether to tag prototype-v0.1.0.

Validation:
- Report references the manual test results.

After implementation:
- list changed files
- identify whether v0.1 is tag-ready
```
