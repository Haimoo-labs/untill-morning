# CLAUDE.md

## Project

This project is **Until Morning**, an Android-first 2D / 2.5D zombie survival base-defence game.

Canonical design source: the design pack `docs/design-pack/` (ADR-005). Read `docs/design-pack/00-INDEX.md`, and check `05-MVP-SCOPE.md` before implementing anything. The older `docs/game-design-document.md` is superseded.

Core loop:

1. Morning: show the base status and daily threat.
2. Day: choose one expedition location.
3. Expedition: collect loot with limited backpack capacity.
4. Evening: repair, build, trade, or use medicine.
5. Night: defend the base against zombie waves.
6. Morning report: show damage, consumed resources, gained loot, infection changes, and next threat.

Core promise:

**Loot by day. Build before dark. Survive until morning.**

## Current target

Build the MVP, not the full game. Target: `docs/design-pack/05-MVP-SCOPE.md`.

MVP scope:

- One base with buildable defences (wall, spike trap, shooting tower)
- Six resources: food, water, wood, metal, ammo, medicine
- Three expedition locations: forest, hardware store, pharmacy
- Three zombie types: basic, runner, infector
- Three weather states: clear, rain, fog
- Two NPCs: trader, nurse
- Backpack: 6 slots, one upgrade to 9
- Survive 10 days and build a radio

Note: a real-time top-down v0.1 slice (survive 3 nights, single forest, numberless
gate) is already shipped and live. It predates this MVP and diverges from it;
reworking it toward the MVP above is a separate, planned effort.

## Hard rules

Do not add open world exploration.
Do not add a massive crafting tree (buildings and simple upgrades are fine).
Do not add online accounts.
Do not add cloud saves.
Do not add multiplayer.
Do not add long story cutscenes (story is event-based).
Do not add procedural world generation.
Do not add more features unless the current loop is playable.

Monetization and ads are **out of the MVP** but in scope as later-phase systems,
designed fair and never pay-to-win (see `docs/design-pack/06-ECONOMY-MONETIZATION.md`).
Do not wire real IAP or ads until the core loop is proven.

## Technical direction

Use Godot 4 and GDScript.
Use placeholder art.
Keep game state explicit.

## Validation

After each implementation task:

1. Explain what changed.
2. List changed files.
3. State how to run or test it.
4. State what is still missing.
5. Do not claim something works unless it was run or manually verified.

## Coding style

Avoid global state except for a clearly named `GameState` autoload.
Use typed GDScript where practical.

## Product rule

The game must create this feeling:

> I survived barely. One more day.
