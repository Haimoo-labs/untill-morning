# MVP Scope — Until Morning

> **SUPERSEDED (2026-07-07):** canonical v0.1 scope is now `docs/game-design-document.md` §6 (see `docs/decisions/ADR-004-gdd-canonical.md`). Kept for history; do not base new work on this file.

## Prototype v0.1

The first version is not the full game. It is a playable loop test.

The player must be able to:

1. Start Day 1.
2. See base status.
3. Choose one expedition.
4. Receive loot.
5. Spend resources to repair the gate.
6. Start the night.
7. Survive or lose against a small zombie wave.
8. See a morning report.
9. Continue to the next day.
10. Repeat until Day 3.

## Included in v0.1

### Resources

- Food
- Wood
- Ammo

### Base

- Gate HP
- Repair gate action

### Expedition

- Forest only
- Random loot result
- Simple risk result

### Night

- Slow zombies only
- Gate takes damage
- Player can spend ammo to reduce zombie damage

### Report

- Day survived
- Resources gained
- Resources spent
- Gate damage
- Next day starts

## Excluded from v0.1

- Infection
- Medicine
- Weather
- NPCs
- Trader
- Nurse
- Backpack upgrades
- Multiple weapons
- Multiple zombie types
- Base building
- Escape vehicle
- Radio
- Ads
- IAP
- Save system
- Audio polish
- Final art

## Success criteria

Prototype v0.1 is successful if the player can complete three day/night cycles and understand the core decision:

> Do I spend resources now, or risk the night?

## Stop conditions for Claude Code

Stop and report instead of continuing if:

- A requested feature is outside this scope.
- Godot project files cannot be generated safely.
- A change requires guessing a major design decision.
- The project cannot be opened or tested locally.
