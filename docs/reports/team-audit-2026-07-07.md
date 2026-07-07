# Team Audit — Until Morning real-time POC (web build)

**Date:** 2026-07-07 · **Build:** gh-pages @ caaa075 (main @ dbc3a44)
**Auditors:** Ludo (game design), Sherlock (QA/abuse), Iris (mobile UI/UX), Themis (code review) — each played the deployed browser build and/or reviewed `game/` sources independently. Coordinated by Hermes.

## Executive summary

**Technically solid, designedly not yet a game.** QA could not break it (0 console errors across every abuse case) and code review passed with conditions (collision matrix verified clean). But the design audit's verdict is blunt: the night phase is passive spectation, and the intended win path (repair) is locked behind an awkward collision maze — so the product promise *"I survived barely, one more day"* does not yet materialize. The next round must be a design round, not a hardening round.

## Convergent findings (multiple auditors independently)

1. **The route to the gate chokes the core loop.** Ludo failed to reach repair range in 4 attempts (campfire r58 + tent colliders leave a ~50px corridor; camera lag hides it); Hermes' scripted runs failed the same way twice. The repair *zone* now works (mask bug fixed pre-audit), but the *path* to it is the real blocker. Severity: **P0 — blocks the only winning strategy.**
2. **`_spawn_wave` async vs. scene reload.** Found by Themis in code and independently probed by Sherlock in play (not currently reproducible — Restart is only visible at game over — but fragile the moment a shortcut/visible-restart is added). Fix: `if not is_night or not is_inside_tree(): return` after each await, plus a state guard in `_on_repair_pressed`. Severity: latent/medium.

## Per-auditor highlights

### Ludo — design (the hard truth)
- Night = 7–8 s of passive watching: combat happens ~800px away in the dark; FIRE is auto-homing button-mashing with no aiming or positioning decision; the player is never personally threatened.
- Balance math: passive damage 30/45/75 vs 100 HP gate → guaranteed loss by night 3 without repairs; ammo economy (~7 total vs 30 hits needed) means shooting alone can never win; repair dominates (20 HP/wood vs ~5 HP/ammo) so the "repair vs shoot" choice isn't real. Food is inert.
- **One change that matters most:** bring the fight to the player — defend at the gate up close, aim shots, and make "repair now vs shoot now" a decision inside the same 30-second wave.

### Sherlock — QA (couldn't break it)
- 0 errors: scavenge/night/fire spam, hidden-button clicks, restart spam, mid-game resize, projectile-vs-dead-zombie, idle — all held. Ammo floors at 0, gate floors at 0, single loot roll per day.
- Two latent guards recommended (see convergent #2).

### Iris — mobile UI/UX
- **HIGH:** HUD text has no outline/backdrop — vanishes over bright areas (campfire glow, pale tents). Add font outline or dark panel.
- **MED:** Buttons ~40px design units → shrink below the 44px touch minimum on narrow (360px) phones; weak tap affordance (no filled background). Raise to ≥56px + StyleBox.
- **MED:** Landscape (1024×768): camera limits leave a huge gray dead zone with HUD floating over it — lock to portrait or center the world.
- **MED:** Primary CTA ("Start Night") doesn't draw the eye; the campfire does.

### Themis — code review: APPROVE with conditions
- Collision layer/mask matrix fully verified — no other pair broken like the RepairZone bug was.
- **MED:** dead legacy loop (scenes/main/main.tscn, main_controller.gd, GameState.start_night()/continue_after_night()/start_next_day() + empty scripts/night, scripts/expedition dirs) coexists with the live path — delete or mark clearly.
- Minor: projectile/repair-zone masks keep default bit 1 (saved only by group checks); `_end_run` doesn't free in-flight projectiles; zombies stack inside each other at the gate (acceptable for POC).
- Style: typed GDScript + single autoload respected. No tests in repo (acceptable at POC; add minimal wave-counter tests if the loop becomes permanent).

## Recommended action plan (priority order)

| # | Action | Source | Class |
|---|---|---|---|
| 1 | **Design rework of the night**: defend at the gate up close; open the path (re-lay campfire/tent colliders); aimed or positional shooting; repair-vs-shoot inside the wave | Ludo P0 ×2 | R2, needs owner OK (design change) |
| 2 | HUD readability (outline/panel) + ≥56px buttons + highlight Start Night | Iris HIGH/MED | R2, cheap |
| 3 | Async guards (`is_inside_tree` in `_spawn_wave`; state guard in `_on_repair_pressed`) | Themis+Sherlock | R2, cheap |
| 4 | Delete/mark the dead legacy phase-UI loop | Themis MED | R1/R2 cleanup |
| 5 | Portrait lock (or landscape layout fix) | Iris MED | R3 (export config) |

Items 2–4 are uncontroversial and can proceed immediately. Item 1 changes gameplay design and needs the owner's go — it is, per Ludo, the difference between "a build that works" and "a game worth one more day."
