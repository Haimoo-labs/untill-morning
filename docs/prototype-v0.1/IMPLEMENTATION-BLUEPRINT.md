# Prototype v0.1 Implementation Blueprint — Until Morning

## Status

Active

## Purpose

This blueprint defines the exact implementation target for **Prototype v0.1 — Core Loop**.

The goal is to build the smallest playable version of Until Morning that proves the day/night survival defence loop.

## Prototype goal

A player can complete three simple day/night cycles:

1. Start Day 1.
2. See the base status.
3. Choose the Forest expedition.
4. Receive simple loot.
5. Repair the gate during evening.
6. Start the night.
7. Resolve a slow zombie attack.
8. See a morning report.
9. Continue to the next day.
10. Finish after Day 3 or lose if the gate reaches 0 HP.

## Core player decision

The prototype must make this decision understandable:

> Do I spend resources now, or risk the night?

## Included systems

### Game state

- Day number
- Food
- Wood
- Ammo
- Gate HP
- Current phase
- Last expedition result
- Last night result
- Prototype completion state
- Game over state

### Phases

- Morning/Base
- Expedition result
- Evening
- Night result
- Morning report
- Prototype complete
- Game over

### Resources

- Food
- Wood
- Ammo

### Base

- One gate
- Gate HP starts at 100
- Gate can be repaired with wood

### Expedition

- Forest only
- Forest gives simple random loot
- Loot can include food, wood, or ammo

### Night

- Slow zombies only
- Night damage increases by day
- Ammo can reduce damage
- Gate takes remaining damage
- Gate at 0 HP means game over

### Report

Morning report shows:

- day survived
- loot gained
- ammo used
- wood used
- gate damage taken
- current resources
- current gate HP

## Excluded systems

Do not implement these in v0.1:

- infection
- medicine
- weather
- NPCs
- trader
- nurse
- multiple expedition locations
- backpack slots
- manual loot selection
- multiple weapons
- multiple zombie types
- base building
- escape vehicle
- radio
- save system
- settings screen
- ads
- IAP
- analytics
- online accounts
- cloud saves

## File areas allowed for v0.1 implementation

Expected areas:

- `game/project.godot`
- `game/scenes/main/main.tscn`
- `game/scenes/ui/`
- `game/scripts/core/`
- `game/scripts/ui/`
- `game/scripts/expedition/`
- `game/scripts/night/`
- `docs/prototype-v0.1/`

Do not modify governance documents unless the implementation process changes.

## Suggested implementation order

1. Expand `GameState`.
2. Define phase enum or constants.
3. Implement UI state rendering in `main_controller.gd`.
4. Add Morning/Base view.
5. Add Forest expedition resolution.
6. Add Evening repair action.
7. Add Night resolution.
8. Add Morning report.
9. Add prototype complete and game over states.
10. Run manual validation using `TEST-PLAN.md`.

## Acceptance criteria

v0.1 implementation is accepted when:

- Godot project opens.
- Main scene runs.
- Day 1 starts.
- Food, wood, ammo, gate HP, and day number are visible.
- Player can run Forest expedition.
- Loot changes resources.
- Player can repair gate using wood.
- Night resolves.
- Ammo reduces damage.
- Gate HP changes.
- Game over appears if gate reaches 0.
- Day advances after a survived night.
- Prototype complete appears after Day 3 is survived.
- No excluded systems are implemented.

## Validation requirement

Implementation must report:

- changed files
- whether Godot opened
- whether main scene ran
- manual test result
- known placeholders
- any scope creep found

## Current non-goal

Do not make the prototype beautiful yet.

The purpose is to prove the loop, not visual polish.
