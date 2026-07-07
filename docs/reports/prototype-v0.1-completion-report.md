# Change Report — Prototype v0.1 Completion (Task 001–004)

## Summary

Implemented and balance-tuned the Prototype v0.1 day/night core loop: `GameState` (Task 001), the single-scene UI phase renderer (Task 002), and a retuned `BALANCE-TABLE.md` (Task 004) so a loss is always attributable to the repair decision rather than loot RNG. Commits `7aa0226` (implementation) and `6765ec4`/`43fb598` (unrelated governance/design docs, listed for completeness).

## Scope

What was included?

- `GameState` autoload: phases, expedition/repair/night/day-progression methods, all fields from `GAME-STATE-SPEC.md`.
- `main_controller.gd` + `main.tscn`: single-scene UI that renders each phase and wires buttons to `GameState` per `SCENE-FLOW.md`.
- Balance retune (night damage 30/50/80, ammo cap 2/night, starting ammo 4) per `docs/business/BALANCE-TUNING-RECOMMENDATION.md`, with `BALANCE-TABLE.md` updated to match.

What was explicitly excluded?

- Infection, medicine, weather, NPCs, multiple locations, backpack slots, weapons, save system, ads/IAP/analytics/accounts/cloud saves — none added. No excluded system from `mvp-scope.md` / `IMPLEMENTATION-BLUEPRINT.md` was touched.
- No visual polish or real art (placeholder-only, per project non-goal).

## Changed files

- `game/scripts/core/game_state.gd`
- `game/scripts/ui/main_controller.gd`
- `game/scenes/main/main.tscn`
- `docs/prototype-v0.1/BALANCE-TABLE.md`
- `docs/product/BACKLOG.md` (commercial priority tags, additive)

## Risk class

R2 — local prototype code change.

## Validation

What was checked (mapped to `TEST-PLAN.md` TC-001…TC-010 and the DoD R2 checklist):

- TC-001 Project opens — pass (Godot 4.3 headless boot, no errors).
- TC-002 Main scene runs — pass (day number, food/wood/ammo, gate HP visible).
- TC-003 Forest expedition works — pass.
- TC-004 Evening appears after expedition — pass.
- TC-005 Gate repair works (wood −1, HP +20, capped at 100, no-op at full HP) — pass.
- TC-006 Night resolves (incoming/ammo used/blocked/gate damage shown) — pass.
- TC-007 Morning report appears — pass.
- TC-008 Day advances — pass.
- TC-009 Prototype Complete after Day 3 — pass.
- TC-010 Game Over when gate breaks — pass.
- Scope validation (no infection/medicine/weather/NPCs/multiple locations/backpack/weapons/save/ads/IAP/analytics) — confirmed clean.

Evidence:

- Godot 4.3.stable headless boot with no parse/runtime errors, before and after the balance retune.
- An automated integration test instantiated `main.tscn` inside the real project (autoloads active) and drove the full TC-001…010 path via `button.pressed.emit()`, asserting phase transitions and label content — **not** a human manually clicking through the UI.
- Balance verification: 500 simulated runs per strategy post-retune — `never_repair` 0/500 wins (dies night 3 every time), `always_repair` 500/500 wins with final gate HP 10–30 of 100.
- All temporary test scripts/scenes used for the above were deleted after each run; `project.godot`'s `run/main_scene` was restored to `main.tscn` in every case. `git status` confirms no leftover temp files.

```text
Manual validation:
- Godot project opens: not tested (automated headless only, see Evidence)
- Main scene runs: not tested (automated headless only, see Evidence)
- Core loop Day 1 -> Day 3: not tested (automated headless only, see Evidence)
- Game over path: not tested (automated headless only, see Evidence)
- Scope creep found: no
- Notes: All evidence above is automated (headless Godot + a scripted button-driven walkthrough), run in an environment with no display. No human has yet opened the game in the Godot editor and clicked through it by hand. This is the first real gap before Portti 2 (the owner's own fun-test) can be evaluated.
```

## Known issues

- **No human playtest yet.** This is the most important open item — automated verification confirms the code does what the spec says, not that it feels right in a human's hands. Portti 2 (see `docs/business/PRODUCTIZATION-ROADMAP.md`) is still pending.
- UI is intentionally placeholder text/buttons only (`Label`/`Button`, no styling) — expected per `IMPLEMENTATION-BLUEPRINT.md`'s non-goal ("do not make the prototype beautiful yet").
- No animation, sound, or save/load — all explicitly acceptable v0.1 limitations per `TEST-PLAN.md`.
- Forest loot uses `randi()` with no seed control — acceptable per spec ("simple random loot"), but means exact repro of a specific run isn't currently possible without capturing the RNG state.

## Follow-up

- Get the owner's own hands-on playtest (Portti 2) — this report's automated evidence cannot substitute for it.
- Per `docs/business/FEELS-LIKE-A-GAME-MILESTONE.md`, v0.3 (loot choice) is the design team's estimate for where the loop stops feeling like a proven mechanic and starts feeling like a real game — v0.1 is deliberately narrower in scope than that.
- Tag recommendation: **not yet ready for `prototype-v0.1.0`.** Code and automated validation are complete, but the project's own Definition of Done / governance model treats "done" as evidence-based, and the one piece of evidence that matters most here — a human playing it — doesn't exist yet. Recommend tagging only after the owner's playtest confirms the loop holds up (or after any fixes that playtest surfaces).

## Commit / PR

Commit SHA: `7aa0226` (implementation + balance retune), `6765ec4` and `43fb598` (unrelated docs work in the same branch history)

PR: none — pushed directly to `main` per the owner's own instruction for this project.
