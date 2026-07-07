# Game Design Blueprint v0.1 — Until Morning

> **SUPERSEDED (2026-07-07):** the canonical design source is now `docs/game-design-document.md` (see `docs/decisions/ADR-004-gdd-canonical.md`). Kept for history; do not base new work on this file.

## One-line concept

**Until Morning** is a small Android-first zombie survival defence game where every day is preparation for the next night.

## Core promise

**Loot by day. Build before dark. Survive until morning.**

## Target feeling

The player should regularly feel:

> I survived barely. One more day.

## Product shape

This is not a full open-world survival game.

It is a tight mobile survival defence loop:

1. One day begins with a clear problem.
2. The player chooses one meaningful action before night.
3. The action creates tradeoffs.
4. The night tests the decision.
5. The morning report creates pressure for the next day.

## Core loop

1. **Morning** — Check day number, resources, gate condition, and daily threat.
2. **Day** — Choose one expedition location.
3. **Expedition** — Gather loot, accept risk, and return before night.
4. **Evening** — Repair or prepare using limited resources.
5. **Night** — Zombies attack the base.
6. **Morning report** — Show damage, loot, resource use, and next pressure.

## Prototype v0.1 design target

The first prototype must prove the loop with the smallest possible system set.

### Included

- One base
- One gate
- Three resources: food, wood, ammo
- One expedition: forest
- One enemy type: slow zombie
- Simple night resolution
- Morning report
- Three playable days

### Excluded

- Infection
- Medicine
- Weather
- NPCs
- Trader
- Nurse
- Multiple locations
- Backpack upgrades
- Escape vehicle
- Radio
- Monetization
- Ads
- Save system

## Design principle

The player should never be able to do everything in one day.

Good pressure:

- Repair the gate or collect food?
- Save ammo or reduce night damage?
- Spend wood now or risk the next night?

Bad pressure:

- Too many resources
- Too many buttons
- Too many systems before the loop works
- Punishing the player without giving a clear choice

## First success criterion

Prototype v0.1 is successful if a player can complete three day/night cycles and understand this decision:

> Do I spend resources now, or risk the night?
