# Prototype v0.1 Balance Table

## Purpose

This document defines the first playable balance values for Prototype v0.1.

These values are not final. They exist so Claude Code does not invent gameplay numbers during implementation.

## Starting state

| Value | Amount | Notes |
|---|---:|---|
| Starting day | 1 | Prototype starts at Day 1 |
| Target days | 3 | Prototype completes after surviving Day 3 |
| Food | 3 | Used as visible survival pressure only in v0.1 |
| Wood | 3 | Used for gate repair |
| Ammo | 6 | Used to reduce night damage |
| Gate HP | 100 | Main lose condition |

## Gate repair

| Value | Amount | Notes |
|---|---:|---|
| Max gate HP | 100 | Gate cannot exceed this |
| Wood repair cost | 1 | One repair action costs 1 wood |
| Repair amount | 20 | Adds up to 20 HP, capped at max |
| Repair allowed at max HP | No | Disable or no-op if gate is full |

## Forest loot

Forest expedition should grant one simple loot bundle.

Recommended deterministic/simple random options:

| Option | Food | Wood | Ammo | Notes |
|---|---:|---:|---:|---|
| A | 2 | 1 | 0 | Food-heavy |
| B | 0 | 2 | 1 | Repair-focused |
| C | 1 | 0 | 2 | Defence-focused |
| D | 1 | 1 | 1 | Balanced |

Use any simple random selection between these options.

## Night damage

| Day | Incoming damage | Notes |
|---:|---:|---|
| 1 | 25 | Easy intro night |
| 2 | 40 | Risk appears |
| 3 | 60 | Can lose if poorly prepared |

## Ammo mitigation

| Value | Amount | Notes |
|---|---:|---|
| Damage blocked per ammo | 10 | One ammo blocks 10 incoming damage |
| Max ammo auto-used per night | 3 | Prevents all ammo from disappearing instantly |
| Minimum gate damage | 0 | Damage cannot go below zero |

Recommended formula:

```text
ammo_needed = ceil(incoming_damage / damage_blocked_per_ammo)
ammo_used = min(current_ammo, ammo_needed, max_ammo_auto_used_per_night)
damage_blocked = ammo_used * damage_blocked_per_ammo
gate_damage = max(0, incoming_damage - damage_blocked)
```

## Food behavior in v0.1

Food is visible but should not kill the player in v0.1.

Recommended simple behavior:

- consume 1 food per survived night
- if food reaches 0, show warning text
- do not add starvation death yet

## Win/loss

### Game over

Game over triggers when:

```text
gate_hp <= 0
```

### Prototype complete

Prototype complete triggers when:

```text
Day 3 night is survived and the player continues from the morning report.
```

## Balance target

Expected feeling:

- Day 1: player understands the loop
- Day 2: player sees resources are limited
- Day 3: player can win or lose depending on repair/ammo state

## Do not tune yet

Do not balance around:

- infection
- weather
- NPC bonuses
- backpack limits
- weapons
- base upgrades
- ads/IAP

Those systems do not exist in v0.1.
