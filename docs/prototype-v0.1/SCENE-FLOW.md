# Prototype v0.1 Scene Flow

## Purpose

This document defines the intended scene and UI flow for Prototype v0.1.

The goal is to prevent the prototype from becoming a confusing set of disconnected Godot scenes.

## Decision

Prototype v0.1 should use one main scene and a simple UI state flow.

Do not create a large scene tree or many independent gameplay scenes yet.

## Main scene

```text
game/scenes/main/main.tscn
```

The main scene owns the visible UI for the prototype.

It reads from and writes to:

```text
game/scripts/core/game_state.gd
```

## UI phases

Prototype v0.1 has these phases:

```text
MORNING
EXPEDITION_RESULT
EVENING
NIGHT_RESULT
MORNING_REPORT
PROTOTYPE_COMPLETE
GAME_OVER
```

## Flow diagram

```text
Start
  ↓
MORNING / BASE
  ↓ Go to Forest
EXPEDITION_RESULT
  ↓ Continue to Evening
EVENING
  ↓ Start Night
NIGHT_RESULT
  ↓ If gate HP <= 0
GAME_OVER
  ↓ Otherwise continue
MORNING_REPORT
  ↓ If Day 3 survived
PROTOTYPE_COMPLETE
  ↓ Otherwise next day
MORNING / BASE
```

## Phase responsibilities

### MORNING / BASE

Shows:

- day number
- food
- wood
- ammo
- gate HP
- simple daily prompt

Actions:

- Go to Forest

### EXPEDITION_RESULT

Shows:

- location name: Forest
- loot gained
- updated resources

Actions:

- Continue to Evening

### EVENING

Shows:

- resources
- gate HP
- repair cost

Actions:

- Repair gate
- Start Night

### NIGHT_RESULT

Shows:

- incoming zombie damage
- ammo used
- damage reduced by ammo
- final gate damage
- resulting gate HP

Actions:

- Continue

### MORNING_REPORT

Shows:

- survived day
- resource summary
- gate status
- next day prompt

Actions:

- Continue to next day

### PROTOTYPE_COMPLETE

Shows:

- prototype completion message
- final stats

Actions:

- Restart prototype

### GAME_OVER

Shows:

- reason for loss
- day reached
- final stats

Actions:

- Restart prototype

## Implementation preference

For v0.1, use a simple single-scene UI renderer.

Good approach:

- `main.tscn` contains a root `Control`.
- `main_controller.gd` rebuilds simple UI based on the current phase.
- Buttons call small methods that update `GameState` and re-render.

Avoid for v0.1:

- multiple nested scene transitions
- animations as required logic
- separate managers for every system
- complex signal architecture
- persistent save/load

## Future note

Later prototypes can split phases into separate reusable scenes if the single-scene controller becomes hard to maintain.

Do not optimize early.
