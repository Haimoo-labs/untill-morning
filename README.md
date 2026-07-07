# Until Morning

**Until Morning** is an Android-first 2D / 2.5D zombie survival defence game.

Core promise:

> Loot by day. Build before dark. Survive until morning.

The first goal is not to build the full game. The first goal is to build a small playable prototype that proves the core loop:

1. Morning: check the base status and daily threat.
2. Day: choose one expedition.
3. Expedition: collect loot with limited capacity.
4. Evening: repair or prepare before dark.
5. Night: defend the base.
6. Morning report: see what survived, what broke, and what happens next.

## Current target

**Prototype v0.1 — Survive 3 Nights**

Included:

- Godot 4 project skeleton
- Documentation foundation
- Claude Code working instructions
- Minimal folder structure for scenes, scripts, assets, docs, and tests

Excluded for now:

- Infection
- Weather
- NPCs
- Monetization
- Ads
- Save system
- Multiple locations
- Full campaign

## Recommended local setup

Use Godot 4.x.

Open the project from:

```text
game/project.godot
```

## Working model

Use `CLAUDE.md` as the primary instruction file for Claude Code.

Before implementing gameplay, read:

- `CLAUDE.md`
- `docs/mvp-scope.md`
- `docs/build-plan.md`
- `docs/game-design-blueprint.md`

## Prototype v0.1 planning docs

Read these before implementing the first playable loop:

- `docs/prototype-v0.1/IMPLEMENTATION-BLUEPRINT.md`
- `docs/prototype-v0.1/SCENE-FLOW.md`
- `docs/prototype-v0.1/GAME-STATE-SPEC.md`
- `docs/prototype-v0.1/BALANCE-TABLE.md`
- `docs/prototype-v0.1/TEST-PLAN.md`
- `docs/tasks/CLAUDE-CODE-TASKS-v0.1.md`

Supporting product and quality docs:

- `docs/quality/DEFINITION-OF-DONE.md`
- `docs/product/BACKLOG.md`
- `docs/product/FEATURE-PARKING-LOT.md`

Architecture decisions:

- `docs/decisions/ADR-001-engine-choice.md`
- `docs/decisions/ADR-002-scene-architecture.md`
- `docs/decisions/ADR-003-state-management.md`

## Governance and standards

This repository uses a lightweight governance model covering risk classes, scope protection, versioning, the Claude Code task format, and validation.

Read:

- `docs/governance/GOVERNANCE-LIGHT.md`
- `docs/quality/DEFINITION-OF-DONE.md`

Reusable templates:

- `docs/templates/CHANGE-REPORT.md`
- `docs/templates/ADR-TEMPLATE.md`

Incident management and release-notes governance is deferred until Android testing — see `docs/governance/deferred/`.

## Repository status

This repository currently contains the project foundation and Prototype v0.1 planning package. Gameplay implementation should start from a separate feature branch.
