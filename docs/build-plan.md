# Build Plan — Until Morning

**Status:** Active · **Last updated:** 2026-07-07

## What this document is

Per-phase *validation criteria*: how we know a phase is playable and can close.

The canonical roadmap — phase goals, candidate features, commercial priority, and scope (what to build now, what to defer, what is banned) — lives in `docs/product/BACKLOG.md`. This document does not repeat it.

## Working principle

Build the game in small, verifiable steps. Do not ask Claude Code to build the full game at once. Each phase closes only when its validation criteria pass with real evidence (see `docs/quality/DEFINITION-OF-DONE.md`).

## Phase validation criteria

### Phase 0 — Foundation

Done when: README, CLAUDE.md, MVP scope, game design blueprint, Godot project skeleton, and folder structure exist.

### Phase 1 — Prototype v0.1 Core Loop

Done when:

- Godot project opens.
- Day 1 starts.
- Player can go to the forest expedition and receive loot.
- Player can repair the gate in the evening.
- Night resolves.
- Morning report appears and the day advances.
- Game can end after Day 3 (Prototype Complete), and Game Over can appear when gate HP reaches 0.

### Phase 2 — Prototype v0.2 Infection Pressure

Done when: infection percentage, medicine resource, pharmacy expedition, infector zombie, and a treatment action are in the playable loop, and infection creates a meaningful choice without feeling unfair.

### Phase 3 — Prototype v0.3 Meaningful Loot Choices

Done when: the 6-slot backpack, manual loot choice, hardware store expedition, and wood/metal tradeoff are playable, and the player visibly cares what they leave behind.

### Phase 4 — Prototype v0.4 Weather

Done when: clear / rain / fog states exist and change expedition and night rules (not only visuals).

### Phase 5 — Prototype v0.5 NPC Light

Done when: trader and nurse create decisions while staying lightweight (no RPG system).

### Phase 6 — 7 Night MVP

Done when: the loop runs seven nights with a difficulty curve, readable reports, and basic balancing, and a player wants "one more day" after several sessions.

## Non-goals

Non-goals are defined once in the canonical sources, not here:

- Permanent product bans: `CLAUDE.md` "Hard rules".
- Phase-deferred items before the 7 Night MVP: `docs/product/BACKLOG.md` "Not before v0.6".
- Money/publish items needing owner approval: `docs/product/BACKLOG.md` "Never without explicit approval".
