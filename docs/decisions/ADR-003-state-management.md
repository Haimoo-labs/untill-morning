# ADR-003 — Prototype State Management

## Status

Accepted

## Date

2026-07-07

## Context

Until Morning Prototype v0.1 needs a small amount of explicit state:

- day
- food
- wood
- ammo
- gate HP
- current phase
- last expedition result
- last night result
- game over / prototype complete status

The project is not yet large enough to need a complex state architecture.

## Decision

Use a single Godot autoload named `GameState` for Prototype v0.1.

Location:

```text
game/scripts/core/game_state.gd
```

Godot autoload name:

```text
GameState
```

`GameState` owns the prototype run state and exposes small methods for phase actions.

## Options considered

### Option 1 — Single GameState autoload

Pros:

- simple
- explicit
- easy for Claude Code to use
- easy for UI to read
- enough for v0.1

Cons:

- can become too large if all future systems are added into it
- later refactor may be needed

### Option 2 — Separate managers per system

Examples:

- ResourceManager
- ExpeditionManager
- NightManager
- BaseManager

Pros:

- cleaner boundaries later
- easier to scale for larger game

Cons:

- too much structure for v0.1
- more files and references
- easier to overengineer before the loop is proven

### Option 3 — State stored directly in UI controller

Pros:

- fastest possible implementation

Cons:

- mixes UI and game logic
- harder to test and refactor
- not good for later prototypes

## Rationale

A single `GameState` autoload is the best fit for the prototype stage.

It keeps gameplay state separate from UI while avoiding premature architecture.

## Consequences

- v0.1 game logic lives mostly in `GameState`.
- UI should call `GameState` methods instead of duplicating logic.
- If `GameState` grows too large after v0.3, split it into smaller systems.

## Guardrails

Do not add these to `GameState` in v0.1:

- infection
- weather
- NPC data
- save data
- ads
- IAP
- analytics
- account data

## Follow-up

- Implement according to `docs/prototype-v0.1/GAME-STATE-SPEC.md`.
- Revisit architecture after v0.3 or before save system work.
