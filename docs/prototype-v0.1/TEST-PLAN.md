# Prototype v0.1 Test Plan

## Purpose

This document defines the manual validation plan for Prototype v0.1.

The prototype is accepted only when the core loop can be played from Day 1 to Day 3 or until game over.

## Test environment

Expected:

- Godot 4.x
- Project opened from `game/project.godot`
- Main scene: `res://scenes/main/main.tscn`

## Required validation before merge

For R2 gameplay changes, verify at minimum:

1. Godot project opens.
2. Main scene runs.
3. Day 1 starts.
4. Player can go to Forest.
5. Forest gives loot.
6. Evening screen appears.
7. Gate can be repaired with wood.
8. Night resolves.
9. Ammo reduces night damage.
10. Gate HP changes.
11. Morning report appears.
12. Day advances.
13. Prototype completes after Day 3.
14. Game over appears if gate reaches 0 HP.

## Manual test cases

### TC-001 — Project opens

Steps:

1. Open Godot 4.x.
2. Open `game/project.godot`.

Expected:

- Project opens without fatal errors.
- Main scene is available.

### TC-002 — Main scene runs

Steps:

1. Run the main scene.

Expected:

- Until Morning UI appears.
- Day number is visible.
- Food, wood, ammo, and gate HP are visible.

### TC-003 — Forest expedition works

Steps:

1. Start from Morning/Base phase.
2. Click `Go to Forest`.

Expected:

- Expedition result phase appears.
- Forest is shown as location.
- Loot gained is shown.
- Resources are updated.

### TC-004 — Evening appears after expedition

Steps:

1. Complete Forest expedition.
2. Continue to Evening.

Expected:

- Evening phase appears.
- Resources are visible.
- Gate HP is visible.
- Repair action is available if wood exists and gate is damaged.
- Start Night action is available.

### TC-005 — Gate repair works

Steps:

1. Enter Evening with wood > 0 and gate HP < 100.
2. Click `Repair Gate`.

Expected:

- Wood decreases by repair cost.
- Gate HP increases by repair amount.
- Gate HP does not exceed 100.

### TC-006 — Night resolves

Steps:

1. Click `Start Night`.

Expected:

- Night result appears.
- Incoming damage is shown.
- Ammo used is shown.
- Damage blocked is shown.
- Gate damage is shown.
- Gate HP after attack is shown.

### TC-007 — Morning report appears

Steps:

1. Continue after a survived night.

Expected:

- Morning report appears.
- Report explains what happened.
- Continue action is available.

### TC-008 — Day advances

Steps:

1. Continue from Morning Report before Day 3 is complete.

Expected:

- Day increases by 1.
- Phase returns to Morning/Base.

### TC-009 — Prototype complete after Day 3

Steps:

1. Survive Day 3 night.
2. Continue from Morning Report.

Expected:

- Prototype Complete screen appears.
- Restart action is available.

### TC-010 — Game over when gate breaks

Steps:

1. Reach a state where gate HP drops to 0 or below.
2. Resolve night.

Expected:

- Game Over screen appears.
- Day reached is shown.
- Restart action is available.

## Scope validation

Confirm that v0.1 did not add:

- infection
- medicine
- weather
- NPCs
- multiple locations
- backpack upgrades
- weapons
- save system
- ads
- IAP
- analytics

## Test report format

Use this short format in the implementation report:

```text
Manual validation:
- Godot project opens: yes/no/not tested
- Main scene runs: yes/no/not tested
- Core loop Day 1 -> Day 3: yes/no/not tested
- Game over path: yes/no/not tested
- Scope creep found: yes/no
- Notes:
```

## Known limitations allowed in v0.1

These are acceptable:

- placeholder UI
- no animation
- no sound
- no save/load
- simple random loot
- simple automatic ammo usage
- simple text-only reports
