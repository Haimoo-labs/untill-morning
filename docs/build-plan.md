# Build Plan — Until Morning

## Working principle

Build the game in small, verifiable steps.

Do not ask Claude Code to build the full game at once.

## Phase 0 — Foundation

Status: current repository foundation.

Deliverables:

- README
- CLAUDE.md
- MVP scope
- Game design blueprint
- Godot project skeleton
- Folder structure

## Phase 1 — Prototype v0.1 Core Loop

Goal:

A player can complete three simple day/night cycles.

Tasks:

1. Create `GameState` autoload.
2. Add day number, resources, gate HP, and game status.
3. Create a simple main scene.
4. Add Morning/Base screen.
5. Add Forest expedition button.
6. Resolve simple forest loot.
7. Add Evening screen.
8. Add gate repair action.
9. Add Night resolution.
10. Add Morning Report.
11. Stop after Day 3 with Prototype Complete screen.

Validation:

- Godot project opens.
- Day 1 starts.
- Player can go to forest.
- Player can repair gate.
- Night can resolve.
- Day advances.
- Game can end after Day 3.

## Phase 2 — Prototype v0.2 Infection Pressure

Only after v0.1 is playable.

Add:

- Infection percentage
- Medicine resource
- Pharmacy expedition
- Infector zombie
- Simple treatment action

Do not add monetization.

## Phase 3 — Prototype v0.3 Meaningful Loot Choices

Only after infection is playable.

Add:

- Backpack with 6 slots
- Manual loot choice
- Hardware store expedition
- Wood / metal tradeoff
- Better expedition risk meter

## Phase 4 — Prototype v0.4 Weather

Add only three weather states:

- Clear
- Rain
- Fog

Weather must affect gameplay, not only visuals.

## Phase 5 — Prototype v0.5 NPC Light

Add:

- Trader
- Nurse

NPCs must stay lightweight. No complex RPG system.

## Phase 6 — 7 Night MVP

Expand from 3 nights to 7 nights.

Add:

- Difficulty curve
- More readable reports
- Basic balancing
- Placeholder UI polish

## Explicit non-goals before 7 Night MVP

- Full 30-day campaign
- Escape vehicle
- Boss nights
- Season pass
- In-app purchases
- Ads
- Online accounts
- Cloud saves
- Leaderboards
- Final art
- Final audio
