# Prototype v0.1 GameState Specification

## Purpose

This document defines the minimal `GameState` required for Prototype v0.1.

The goal is to keep gameplay state explicit, small, and easy for Claude Code to modify safely.

## Location

```text
game/scripts/core/game_state.gd
```

The script is configured as a Godot autoload named:

```text
GameState
```

## State fields

### Constants

```gdscript
const STARTING_DAY: int = 1
const TARGET_PROTOTYPE_DAYS: int = 3
const MAX_GATE_HP: int = 100
const REPAIR_AMOUNT: int = 20
const REPAIR_WOOD_COST: int = 1
```

### Phase constants or enum

Use either an enum or clear string constants.

Recommended enum:

```gdscript
enum Phase {
    MORNING,
    EXPEDITION_RESULT,
    EVENING,
    NIGHT_RESULT,
    MORNING_REPORT,
    PROTOTYPE_COMPLETE,
    GAME_OVER
}
```

### Core fields

```gdscript
var day: int
var food: int
var wood: int
var ammo: int
var gate_hp: int
var phase: Phase
```

### Expedition result fields

```gdscript
var last_expedition_location: String
var last_loot_food: int
var last_loot_wood: int
var last_loot_ammo: int
```

### Night result fields

```gdscript
var last_incoming_damage: int
var last_ammo_used: int
var last_damage_blocked: int
var last_gate_damage: int
var last_gate_hp_before: int
var last_gate_hp_after: int
```

### Repair result fields

```gdscript
var last_wood_used: int
var last_repair_amount: int
```

### Status fields

```gdscript
var is_game_over: bool
var is_prototype_complete: bool
var last_report: String
```

## Starting values

```text
day = 1
food = 3
wood = 3
ammo = 6
gate_hp = 100
phase = MORNING
```

## Required methods

### reset()

Resets the full prototype state.

Expected result:

- day returns to 1
- resources return to starting values
- gate HP returns to 100
- phase returns to MORNING
- result fields are cleared
- game over false
- prototype complete false

### run_forest_expedition()

Resolves the Forest expedition.

Expected result:

- sets last expedition location to `Forest`
- adds loot to resources
- stores loot in last loot fields
- phase becomes `EXPEDITION_RESULT`

### continue_to_evening()

Moves from expedition result to evening.

Expected result:

- phase becomes `EVENING`

### repair_gate()

Repairs the gate if enough wood exists and gate is below max HP.

Expected result:

- if wood >= repair cost and gate_hp < max, spend wood
- increase gate HP up to max
- store last wood used and repair amount
- stay in `EVENING`

### start_night()

Resolves one night attack.

Expected result:

- calculate incoming damage based on day
- use ammo to reduce damage
- apply remaining damage to gate
- store night result fields
- if gate HP <= 0, phase becomes `GAME_OVER`
- otherwise phase becomes `NIGHT_RESULT`

### continue_after_night()

Moves from night result to morning report.

Expected result:

- if game over, stay `GAME_OVER`
- otherwise phase becomes `MORNING_REPORT`

### start_next_day()

Moves to the next day or completes the prototype.

Expected result:

- if day >= target days, phase becomes `PROTOTYPE_COMPLETE`
- otherwise day increases by 1
- phase becomes `MORNING`

## Damage model

Use the balance values from:

```text
docs/prototype-v0.1/BALANCE-TABLE.md
```

## Design constraints

Do not add these fields in v0.1:

- infection
- medicine
- weather
- NPCs
- backpack slots
- weapons
- save data
- account data
- analytics data

## Validation checklist

After implementation, verify:

- reset works
- forest expedition changes resources
- repair consumes wood and increases gate HP
- night reduces ammo and/or gate HP
- game over triggers at 0 gate HP
- day advances after a survived night
- prototype completes after Day 3
