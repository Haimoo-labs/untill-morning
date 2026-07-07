# Design: Real-Time Top-Down Proof of Concept

**Date:** 2026-07-07
**Status:** Approved by owner, in implementation
**Supersedes (for this slice only):** ADR-002 (single-scene phase renderer) and ADR-003's phase-driven UI model. `GameState.gd`'s resource fields (day/food/wood/ammo/gate_hp) are NOT superseded — they remain the source of truth.

## Context

The v0.1 text/button phase-renderer (Task 001-002) was deliberately scoped as a menu-driven prototype per ADR-002/ADR-003, with a note to revisit after v0.3. The owner reviewed it after art assets were wired in and rejected it: no movement, no animation, not "a playable game" in the sense they mean. Clarified through brainstorming that the intended game is a real-time, seamless, top-down action-survival game (movement via virtual joystick, real-time ranged combat against zombies), not a turn-based menu loop — while the underlying resource/day-night strategy layer (food/wood/ammo/gate HP, the "Loot by day, build before dark" promise) stays exactly as designed.

## Decision

Build the smallest real vertical slice first (owner's explicit instruction: "build just one scene so we can see if it works"): one Godot scene proving movement + real-time ranged combat + walk-up-to-repair, wired to the real `GameState` fields, exported to browser first for approval before Android.

## Scope of this slice

**In:**
- One scene, one continuous space (base camp area), no scene reload between Evening and Night — a mode switch within the same scene.
- Player: `CharacterBody2D`, `vahtija.png` sprite, moved via an on-screen virtual joystick (touch/mouse drag).
- Ranged combat: player fires at the nearest zombie; each shot consumes real `GameState.ammo`.
- Gate: `StaticBody2D` obstacle blocking zombie movement; an in-range "Repair Gate" HUD button calls the existing `GameState.repair_gate()` (real wood cost, real HP gain).
- One zombie (slow type only), spawns on "Start Night", walks straight toward the gate at constant speed, dies after a few hits, deals one fixed hit to `GameState.gate_hp` if it reaches the gate.
- HUD: same Day/Food/Wood/Ammo/Gate HP readout as before, fixed on screen (`CanvasLayer`), plus contextual Repair/Start Night buttons.

**Out (explicitly, for this slice):**
- Walkable forest expedition (stays as a future extension once this slice feels right).
- Full day-counter / morning-report chain (`continue_after_night`, `start_next_day`) — this slice ends the test at night-resolved (win or gate hit), it does not loop to Day 2 yet.
- Multiple zombies, zombie variety, infection, NPCs — unchanged exclusions from `mvp-scope.md`.
- Android export — browser export first; Android only after the owner confirms the feel is right.

## Components

- `game/scenes/play/play_world.tscn` — the scene (background, gate, player, HUD, spawn point).
- `game/scripts/play/player_controller.gd` — movement (reads joystick vector, `move_and_slide()`), facing/flip, fire input.
- `game/scripts/play/virtual_joystick.gd` — touch-drag joystick Control, exposes a normalized `Vector2`.
- `game/scripts/play/gate.gd` — repair-range detection (`Area2D`) + calls `GameState.repair_gate()`; visually reflects `gate_hp` (intact/damaged texture swap threshold).
- `game/scripts/play/zombie.gd` — move-toward-gate, health, death, on-hit-gate damage callback.
- `game/scripts/play/projectile.gd` — travels in a direction, damages zombie on contact, frees itself.
- `game/scripts/play/hud.gd` — reads `GameState` fields each frame/on-change, renders labels + contextual buttons.

## Data flow

Evening (scene start): player walks freely, can repair gate (real `GameState.repair_gate()`). "Start Night" button flips an internal mode flag: lighting darkens, one zombie instance spawns at a fixed off-screen point and begins moving toward the gate. Player fires at it (real `GameState.ammo -= 1` per shot, enforced not to go below 0). Two end states: zombie dies before reaching the gate (night "won", no gate damage), or zombie reaches the gate (deals a fixed test damage to `GameState.gate_hp` once, then despawns). Either way the scene shows a simple "Night over" label — no further phase chaining in this slice.

## Testing / verification

Godot headless boot check (parse/runtime errors) at each step. Xvfb + screenshot captures of: idle base view, mid-repair, zombie mid-approach, zombie killed, gate-hit end state — visually confirm movement/combat reads correctly before exporting. Export to Web first (GitHub Pages, same pipeline already validated this session) for the owner to test in-browser. Android export only after explicit approval of the browser build.

## Open follow-ups (not blocking this slice)

- Walkable forest expedition scene/zone.
- Wiring night-resolved back into `continue_after_night()` / `start_next_day()` for a full loop.
- Multiple/varied zombies, real spawn pacing instead of one fixed instance.
