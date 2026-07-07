# CLAUDE.md

## Project

This project is **Until Morning**, a small Android-first 2D / 2.5D zombie survival defence game.

Canonical design source: `docs/game-design-document.md` + `docs/asset-production-specification.md` (ADR-004). Check GDD §6 scope and §24 agent rules before implementing anything.

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

Build a small playable prototype first. Do not build the full game.

Prototype v0.1 target:

- One base
- Three resources: food, wood, ammo
- One expedition location: forest
- One zombie type: slow zombie
- One base structure: gate
- One night attack
- One morning report
- Survive 3 nights

## Hard rules

Do not add open world exploration.
Do not add complex crafting.
Do not add monetization.
Do not add ads.
Do not add online accounts.
Do not add cloud saves.
Do not add multiplayer.
Do not add story cutscenes.
Do not add procedural world generation.
Do not add more features unless the current prototype loop is playable.

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
