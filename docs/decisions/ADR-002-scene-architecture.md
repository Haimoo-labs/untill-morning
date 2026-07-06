# ADR-002 — Prototype Scene Architecture

## Status

Accepted

## Date

2026-07-07

## Context

Until Morning is currently an early Godot prototype.

Prototype v0.1 must prove the day/night loop, not establish a complex production architecture.

The prototype needs these phases:

- Morning/Base
- Expedition result
- Evening
- Night result
- Morning report
- Prototype complete
- Game over

A larger scene architecture could be useful later, but it would add complexity before the gameplay loop is proven.

## Decision

Use one main Godot scene for Prototype v0.1:

```text
game/scenes/main/main.tscn
```

Use one main UI controller:

```text
game/scripts/ui/main_controller.gd
```

The controller renders simple UI based on the current `GameState` phase.

## Options considered

### Option 1 — Single main scene with phase renderer

Pros:

- fastest to implement
- easiest for Claude Code to modify
- fewer broken scene references
- good fit for text/UI-heavy prototype
- keeps focus on gameplay loop

Cons:

- may become messy if the prototype grows too far
- later refactor may be needed

### Option 2 — Separate scene per phase

Pros:

- clearer separation when the game grows
- reusable screens later
- closer to production structure

Cons:

- more setup overhead
- more scene transitions to debug
- more risk of broken paths during early Claude Code work

### Option 3 — Full gameplay scene architecture from the start

Pros:

- scalable if the game immediately grows

Cons:

- overengineering for v0.1
- slows down loop validation
- increases scope creep risk

## Rationale

Prototype v0.1 is a loop test. The project should optimize for speed, clarity, and low breakage.

A single-scene phase renderer is the safest starting point.

## Consequences

- v0.1 UI will be simple and possibly temporary.
- Later prototypes may split phases into separate scenes.
- Scene architecture should be revisited after the 7 Night MVP or earlier if the controller becomes hard to maintain.

## Follow-up

- Implement the phase renderer in `main_controller.gd`.
- Keep methods small.
- Avoid adding a manager for every system.
