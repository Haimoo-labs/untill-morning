# Post-Audit Plan + Ammo Economy Root Cause

> **HISTORICAL (2026-07-07):** Sprint 1 and Sprint 2 are complete and re-audited; Sprint 3 (Android APK) is cancelled until the owner explicitly requests it. Canonical phasing is now `docs/game-design-document.md` §21 (ADR-004).

**Date:** 2026-07-07 · **Input:** `docs/reports/team-audit-2026-07-07.md`
**Status:** Awaiting owner approval for Sprint 1 execution and Sprint 2 kickoff.

## Root cause: why ammo runs out

The numbers were tuned for the **old turn-based game, where ammo meant something different**, and were transplanted into the real-time game unchanged:

| | Old (turn-based) | New (real-time) |
|---|---|---|
| Ammo's role | Damage mitigation: 1 ammo auto-blocks 10 incoming damage, max 2 used per night | Kill currency: 1 shot = 1 damage, zombie has 3 HP → **3 ammo per kill** |
| Total need (3 nights) | ~6 ammo | 10 zombies × 3 hits = **30 ammo** for a full clear |
| Supply | 4 start + loot avg exactly 1.0/day → **~7** | unchanged: **~7** |
| Tuning result | "barely enough" (intentional, Ludo's REC) | covers ~2 kills of 10 zombies → **~4× shortfall** |

So ammo doesn't run out because loot is stingy — it runs out because **ammo's job changed from "block 10 damage" to "deliver 1 of 3 hits" without retuning**. Supporting evidence: `DAMAGE_BLOCKED_PER_AMMO` and the whole `start_night()` mitigation formula still sit in `game_state.gd` as dead code from the old design.

**Interim fix (Sprint 1):** zombie `MAX_HEALTH` 3 → **1** (one shot, one kill). Need becomes 10 ammo vs ~7 supply → still scarce, repair still matters, but every shot is meaningful. This is a stopgap; the final economy belongs to the Sprint 2 night redesign.

## Sprint 1 — Uncontroversial fixes (no design decisions)

1. **Ammo economy stopgap:** zombie HP 3 → 1.
2. **Win-path interim unblock** (Ludo P0, can't wait for Sprint 2): shrink the campfire collider and/or widen the center corridor so the gate is reachable *now*; the proper camp re-layout still belongs to Sprint 2.
3. **HUD readability** (Iris HIGH): font outline / dark backdrop on all HUD labels; buttons ≥56px with filled StyleBox; highlight Start Night as the primary CTA.
4. **Portrait lock** (Iris MED): lock orientation via project display settings so the landscape dead-zone layout can't occur (proper landscape support deferred indefinitely — Android-first portrait game).
5. **Async guards** (Themis + Sherlock): `is_inside_tree()` check after awaits in `_spawn_wave`; state guard in `_on_repair_pressed`.
6. **Small code hygiene** (Themis SMALL): explicitly clear default mask bit 1 on projectile and repair zone; free in-flight projectiles in `_end_run`.
7. **Legacy cleanup** (Themis): remove the dead turn-based path — `scenes/main/main.tscn`, `scripts/ui/main_controller.gd`, `GameState.start_night()/continue_after_night()/start_next_day()`-formula internals and `DAMAGE_BLOCKED_PER_AMMO`/`MAX_AMMO_AUTO_USED_PER_NIGHT` — or mark them clearly as legacy if deletion feels premature.
8. Verify (headless + Playwright vs deployed build), redeploy web.

## Sprint 2 — Night redesign (Ludo specs, owner approves before code)

Ludo's audit verdict: the night is passive spectation and must become the game. Spec to cover:
- Defend **at the gate, up close** — combat happens around the player, not 800px away.
- Aimed or positional shooting (no pure auto-homing button mash).
- "Repair now vs shoot now" as a live decision inside the same wave.
- Collision re-layout so the camp is navigable (the current ~50px corridor blocked the win path in audit; Sprint 1's interim widening is a stopgap).
- Final resource economy (supersedes the Sprint 1 stopgap) — **including giving food an actual role** (Ludo: currently inert).
- HUD/control re-layout for one-thumb play (Iris LOW: top-edge buttons require reaching; fold into the new night UI).

Flow: Ludo writes the spec → owner approves → implement → team re-audit (same four roles).

## Sprint 3 — Android APK

After the web build passes the owner's own play test: debug APK via the existing Android export preset + keystore (already configured), delivered for the phone's App Tester.
