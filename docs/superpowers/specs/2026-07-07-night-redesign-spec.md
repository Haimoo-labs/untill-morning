# Sprint 2 — Night Redesign Spec (Until Morning v0.1)

**Author:** Ludo (game design) · **Date:** 2026-07-07 · **Status:** owner-approved sprint, ready to implement
**Source verdict:** `docs/reports/team-audit-2026-07-07.md`, `docs/business/POST-AUDIT-PLAN.md`
**Touches:** `game/scenes/play/play_world.tscn`, `game/scripts/play/*.gd`, `game/scripts/core/game_state.gd`

## 0. The problem this fixes, in one paragraph

Today the night is passive spectation: the fight happens ~800px away at the top of the map while the
player idles at the bottom, FIRE is an auto-homing button you mash, nothing threatens the player, and the
only winning move (repair) is walled off behind a collision maze. This spec turns the night into a **fixed
last-stand turret defence**: the player is anchored at the gate, the horde streams straight down at the
gate in front of them, the player **taps zombies to fire aimed straight shots**, and **holding REPAIR
stops the shooting** — so "patch the gate now vs. thin the horde now" becomes a live, thumb-level decision
inside the same wave. The night is a **countdown to dawn**; you don't have to kill everything, you have to
hold until morning.

The single most important change: **there is no more walking.** The player stands still at the gate for the
whole run. This deletes the P0 collision maze outright (no path to choke), removes the second thumb (no
joystick), fixes the camera-lag complaint (fixed camera), and lets every design decision below be about the
fight, not the navigation.

---

## 1. Defence setup (positions, camera, threat)

All coordinates are **world-space** in the existing 720×1600 scene. The visible portrait band is the top
~0–1280; keep all gameplay and readable art inside it.

### Layout (top = threat/outside, bottom = camp/player)

| Element | Position | Shape / size | Notes |
|---|---|---|---|
| **Zombie spawn line** | `ZombieSpawn` Marker2D at `(360, 120)` | — | spawn x = `360 + randf_range(-160, 160)` → x∈[200,520]; y=120 |
| **Approach lane** | y = 120 → 525 | — | zombies walk straight down |
| **Gate (palisade)** | `Gate` at `(360, 560)` | `RectangleShape2D(400, 40)` | full-lane horizontal barrier, x∈[160,560]; **replaces** the old 140×60 gate at (360,400) |
| **Player (watchman)** | `Player` at `(360, 720)` | keep capsule | **fixed for the whole run**, faces up; ~160px behind the gate |
| **Muzzle** | child Marker2D `(0, -24)` → world `(360, 696)` | — | shots originate here |
| **Camp backdrop** | y ≈ 800–1250 | **visual only, no colliders** | campfire/tents/survivor as set dressing behind the player |

### Camera

- **Move `Camera2D` off the Player** and make it a static child of `PlayWorld` at `(360, 600)`.
- `position_smoothing_enabled = false` (no follow, no lag — kills Iris's "camera lag hides the corridor").
- Tune `position.y` (and optionally `zoom`) in playtest so the player sits ~55–60% down the screen with the
  spawn line (y120), the gate (y560) and the player (y720) all visible, and the bottom thumb-zone free for
  the REPAIR button. Starting value `(360, 600)`.

### Where zombies go, and whether the player is threatened

- **Normal night:** zombies target the **gate**. Each walks straight down toward `(own_x, gate_y)`, stops
  when within `GATE_STOP_OFFSET = 35`px of the gate line (~y525), and **claws the gate** (see §5). The gate
  collider physically blocks them; they never reach the player. The player is safe *as long as the gate
  holds* — the threat is to the gate, felt as gate-HP pressure.
- **Breach (the personal threat):** the instant `gate_hp` reaches 0 during a night, the gate is **breached**:
  disable the gate collider, set `breached = true`, and **retarget every living zombie onto the player**
  (`zombie.target = player`). A breached-in zombie that comes within `PLAYER_CONTACT_RADIUS = 40`px of the
  player ends the run (**GAME OVER — overrun**). The player has **no HP bar**; contact is instant loss.
  Because the player is fixed and rushers arrive in ~3s, a breach is a near-certain loss with a slim
  last-ammo comeback — dramatic, cheap to build, and it gives a crisp answer to "what happens on contact."

This keeps the fail state semantically identical to today (you lose when the gate is overrun) while making
the player genuinely threatened at the climax.

---

## 2. Aiming on a touchscreen

**Model: fixed player + discrete tap-to-shoot with straight (non-homing) projectiles. One thumb.**

Rationale: because the player never moves, we spend the *entire* input budget on aiming instead of splitting
it between a movement stick and a fire button. A dual-stick (move + aim) layout is the wrong fit for an
Android-first portrait game held one-handed (Iris flagged the two-thumb + top-edge reach). With movement
removed, **one thumb tapping the world** is the whole control scheme, and every tap is a chosen target and a
spent bullet — the opposite of the auto-homing mash the audit killed.

### Input

- Add a full-rect `Control` node **`AimCatcher`** on `CanvasLayer/HUD`, `mouse_filter = STOP`, layered
  **below** the HUD buttons so buttons capture their own taps first.
- On a tap/click **inside AimCatcher during night** (`InputEventScreenTouch.pressed` /
  `InputEventMouseButton` left down): convert the event position to a world point (via the viewport canvas
  transform / `get_global_mouse_position()`), then call `player.fire_at(world_point)`.
- **One tap = one shot.** No hold-to-autofire (that drifts back toward the mash). Rapid tapping fires
  rapidly, bounded only by the cooldown and ammo.
- Taps are ignored while the repair channel is active (see §3) and when `run_over`/not night.

### Shot logic (rewrite `projectile.gd` + `player.fire`)

- **Straight shot, no homing.** Remove `TURN_RATE` and the per-frame `slerp` toward target. Direction is
  fixed at spawn: `direction = (world_point - muzzle.global_position).normalized()`.
- `PROJECTILE_SPEED = 500`, `LIFETIME = 2.5`, `DAMAGE = 1`.
- Keep the `Area2D` + `body_entered` hit; damages the first zombie it overlaps, then frees. Give a forgiving
  hit radius (~7px projectile vs ~24px zombie) so a tap *on* a zombie reliably connects but a tap into a gap
  **misses** — misses are possible, so wasting ammo has a cost. This is the skill floor: pick the right
  target, don't spray.
- `player.fire_at()` gates on `GameState.ammo > 0` and the fire cooldown; on success `ammo -= 1`, spawn the
  shot, play `shot_sfx`. Empty → `message_label` "Out of ammo!". No target-search needed (player aims).
- **Fire cooldown:** `FIRE_COOLDOWN_FED = 0.35`s, `FIRE_COOLDOWN_STARVING = 0.70`s (see §5 food).

**Zombie HP stays 1 (one shot, one kill) — this is now the final economy, not the Sprint 1 stopgap.** One
ammo = one dead zombie = a clean, legible mental model for the player.

---

## 3. Repair vs. shoot, inside the wave

Repair becomes a **hold-to-channel** action, and channelling **locks out shooting**. That single lockout is
what makes "repair now vs. shoot now" a real-time decision.

### Mechanic

- **REPAIR button** (bottom thumb-zone, §7). Press-and-hold to channel.
- While held **and** `gate_hp < MAX_GATE_HP` **and** `GameState.wood >= 1`:
  - Run a channel timer of `REPAIR_CHANNEL_FED = 1.5`s (`REPAIR_CHANNEL_STARVING = 2.5`s when starving, §5).
  - On each completed interval: `wood -= 1`, `gate_hp = min(MAX, gate_hp + REPAIR_AMOUNT)` (`REPAIR_AMOUNT`
    stays **20**), play `repair_sfx`, then **restart** the interval if still held and still needed
    (continuous repair, one wood per interval).
- **While channelling, `player` cannot fire** — AimCatcher taps are ignored. Releasing the button (or wood
  hitting 0, or gate reaching full) stops the channel.
- **Partial progress is lost** if you release before an interval completes — so interrupting your own repair
  to snipe a fresh arrival costs you that started interval. This is deliberate friction.
- Same button/behaviour in the day phase; with no zombies it is just a brief uninterrupted hold.

### Why it's tense (the numbers do the work)

During one 1.5s channel, `U` zombies clawing at `CLAW_DPS = 2.5` each deal `1.5 × 2.5 × U = 3.75U` to the
gate. Net gate change per channel = `+20 − 3.75U`:

| Clawers U | Net HP per channel | Read |
|---|---|---|
| 1 | +16 | repair freely |
| 2 | +12 | fine |
| 3 | +9 | fine |
| 4 | +5 | falling behind |
| 5 | +1 | breaking even — you're losing the night |
| 6+ | negative | **repair is futile — you MUST shoot to thin the horde first** |

So when only a couple are at the gate, patch; when the gate is swarmed, repairing loses ground and you have
to spend your thumb (and ammo) killing before a repair even makes sense. That decision surface falls out of
the constants — no scripted moments.

---

## 4. Wave structure and pacing

**The night is a countdown to dawn.** Zombies spawn on a fixed schedule during the night; at dawn the timer
ends, any survivors retreat, and if the gate still stands you survived. You hold *until morning* — you do
not have to kill everything.

### Per-night constants

| Night | `NIGHT_DURATION` (s) | Zombies | Spawn times (s from night start) | Zombie `SPEED` (px/s) |
|---|---|---|---|---|
| 1 | 45 | 4 | 0, 8, 16, 24 | 45 |
| 2 | 60 | 6 | 0, 6, 12, 20, 28, 36 | 55 |
| 3 | 75 | 8 | 0, 5, 10, 16, 22, 30, 38, 46 | 65 |

Store as dictionaries keyed by day (mirror the existing `ZOMBIES_PER_NIGHT` pattern). Each spawn uses the
x-spread from §1. Travel time spawn→gate ≈ 405px / speed ≈ 9s (N1) → 6.2s (N3).

### Night flow

1. `Start Night` → begin a `night_time` countdown from `NIGHT_DURATION`; consume food (§5); spawn per
   schedule (drive spawns off the countdown, not a chain of awaits — see async note below).
2. Player holds: taps to kill, holds REPAIR to patch.
3. **Dawn** (`night_time <= 0`): stop spawns; make any remaining zombies **retreat** (quick fade + free,
   they do not claw during retreat); lighten the night overlay as a dawn transition; if `gate_hp > 0` →
   **night survived** → advance day. Reuse `_night_survived()` / `advance_after_realtime_night()`.
4. **Gate 0 at any point** → breach → overrun path (§1) → `_end_run(false)`.

The "juuri ja juuri" moment is engineered by the **late cluster**: night 3's last two spawns (t=38, 46)
arrive at ~44s and ~53s with only ~22–31s left, so if you burned all your ammo early they claw the gate to
the wire while you ration your last shots and repairs against the clock.

### Async safety (carry Sprint 1's guard forward)

Do **not** rebuild the wave as a chain of `await create_timer` calls that can outlive a scene reload. Drive
spawning from the per-frame countdown (accumulate elapsed time, pop the next scheduled spawn when due) and
guard any remaining `await` with `if not is_night or not is_inside_tree(): return`. Guard `_on_repair_*`
against firing after `run_over`.

---

## 5. Resource economy (final — supersedes the Sprint 1 stopgap)

Loot is unchanged: start 4 ammo / 3 wood / 3 food; forest loot averages ≈ +1 of each per scavenge (one
scavenge/day). Typical availability: **ammo ~4→7, wood ~3→6, food ~3→6** across nights 1–3.

### Ammo (kill currency)

- 1 ammo = 1 shot = 1 kill (zombie HP 1). Total zombies over 3 nights = 4+6+8 = **18**; total ammo ≈ **7**.
  You can kill **most but never all** of the horde — the residual must be handled by repair. This is the
  intended scarcity: **you cannot shoot your way to victory**, and you cannot ignore shooting either
  (unkilled zombies stack past the point repair can out-heal, §3 table).
- **Design invariant to preserve while tuning:** ammo kills the majority of a night's spawns; wood-repair
  covers the surviving clawers; a *simultaneous* pile-up of clawers overwhelms single-channel repair. If
  playtest shows guaranteed wins, raise zombie count/speed or `CLAW_DPS`; guaranteed losses, lower them.

### Wood (gate integrity)

- `REPAIR_AMOUNT = 20` per `1` wood per channel interval (unchanged values, now channelled). ~6 wood by
  night 3 = up to +120 HP of buffer across the night, spent under fire.

### Zombie claw (the drain)

- On reaching the gate: `CLAW_DAMAGE = 5` every `CLAW_INTERVAL = 2.0`s (**2.5 DPS**), first claw on arrival,
  repeating until the zombie is killed or dawn. Play `gate_hit_sfx` per claw.
- (Replaces today's single 15-dmg-then-despawn hit. Remove the `queue_free()` on reaching the gate; the
  zombie now persists and claws.)

### Food — give it a real, light role (no new resource, no infection)

Food fuels the watchman. **Consume 1 food at the START of each night** (moved from end-of-night). Branch the
night's player stats on whether food was available:

- **Fed** (had ≥1 food at nightfall, −1 consumed): `FIRE_COOLDOWN_FED = 0.35`s, `REPAIR_CHANNEL_FED = 1.5`s.
- **Starving** (0 food at nightfall): `FIRE_COOLDOWN_STARVING = 0.70`s (shots come half as fast) and
  `REPAIR_CHANNEL_STARVING = 2.5`s (repairs take longer). Show a "Starving — slow to fire and mend" HUD note.

Now skipping food tangibly weakens your defence that night, so the day-time decision "scavenge for food vs.
wood vs. ammo" has real weight — without adding a system, a health bar, or infection. Stays in v0.1 spirit.

---

## 6. Camp layout — delete the maze

Navigation is gone, so the obstacle maze has no reason to exist. In `play_world.tscn`, **remove these
colliders** (keep the sprites/art as backdrop if desired; only the `CollisionShape2D`s go):

- `Obstacles/WallTop` (360,500) — was a full-width wall; would now block shots and zombies short of the gate.
- `Obstacles/Campfire` (363,1160)
- `Obstacles/Survivor` (283,1062)
- `Obstacles/TentLeft` (100,920)
- `Obstacles/TentRightUpper` (610,940)
- `Obstacles/TentRightLower` (610,1220)

**Keep** `WallLeft` (-10,800), `WallRight` (730,800), `WallBottom` (360,1560) as harmless world bounds. The
**Gate** collider (new §1 rect) becomes the only obstacle zombies interact with. This alone closes the P0 —
there is no path to choke because there is no path.

Sprint 1's interim campfire-shrink / corridor-widen is **superseded and can be reverted**; this re-layout is
the real fix.

---

## 7. HUD / controls at night (one thumb)

The only interactive night elements are **tapping the world (shoot)** and **one big REPAIR button**.
Everything else is glanceable read-only, so nothing forces an awkward top-edge reach (Iris).

- **Top stat bar** (`CanvasLayer/HUD`, pinned top, full width, ~96px tall, dark panel `Color(0,0,0,0.5)`):
  - Left: `Day x/3` + a **Gate HP bar** (green→red) with numeric `hp/100`.
  - Right: **Ammo** count (with a bullet glyph) + **Food** status (fed / "Starving").
  - White text with a 2px dark outline (carry Sprint 1's outline fix). Read-only — never tapped.
- **REPAIR button** (bottom thumb-zone): anchor bottom, size **≥ 220×96**, offset ~40px up from the bottom
  edge, filled `StyleBox`, label "REPAIR (hold)". Visible/enabled only when `gate_hp < MAX` and `wood >= 1`.
  Shows a **channel progress ring/bar** over the player or gate while held.
- **Remove** the `VirtualJoystick` and `FireButton` nodes (and the joystick script wiring) — no movement, no
  fire button; the world is the fire surface via `AimCatcher`.
- **Day-phase buttons** (`Scavenge`, `Start Night`, and the same REPAIR): keep as large (≥56px) filled
  bottom buttons; **highlight `Start Night`** as the primary CTA (accent fill), per Iris. Hidden at night
  except REPAIR.
- Keep `MessageLabel` for one-line feedback (waves, out-of-ammo, starving, dawn, breach).

---

## 8. Implementation order (independent, testable steps)

Each step ends in a headless or in-editor check before the next.

1. **Layout + fixed camera + delete maze.** Move Gate to (360,560)/400×40, Player fixed at (360,720),
   Camera2D → static child of PlayWorld (smoothing off), remove the 6 colliders in §6, remove
   VirtualJoystick node. *Test:* run, player anchored; hand-spawn one zombie → it walks down and is stopped
   by the gate; no maze; camera framing shows spawn+gate+player.
2. **Tap-to-shoot straight projectiles.** Add `AimCatcher`; rewrite `projectile.gd` (remove homing) and
   `player.fire_at(world_point)`; wire cooldown. *Test:* tapping a zombie kills it in one shot; tapping a
   gap wastes a shot and misses; cooldown throttles rapid taps; ammo decrements and floors at 0.
3. **Zombie claw model.** Zombies persist at the gate and claw `CLAW_DAMAGE`/`CLAW_INTERVAL`; remove the
   reach-gate despawn. *Test:* N zombies at the gate drain gate HP at ~2.5·N DPS; killing one stops its
   drain.
4. **Night = timed dawn + schedules.** Countdown-driven spawner with the §4 per-night tables; dawn ends the
   night, survivors retreat, `gate_hp>0` → survived → advance day; async guards in place. *Test:* each night
   ends at its duration; surviving with gate>0 advances the day; the 3-night loop completes.
5. **Repair hold-channel + shoot lockout + food fed/starving.** Channel timer, wood/HP per interval, taps
   ignored while channelling, partial-progress loss on release; consume food at night start and apply
   fed/starving cooldown+channel modifiers. *Test:* holding REPAIR blocks firing and adds +20/interval per
   wood; releasing mid-interval yields no HP; 0-food night visibly slows fire and repair.
6. **Breach + overrun game-over, then HUD polish.** Gate 0 → disable gate collider, retarget zombies to
   player, contact within 40px → `_end_run(false)`; then build the §7 HUD (stat bar with HP bar/outline, big
   REPAIR with channel indicator, remove FireButton, Start-Night CTA), dawn overlay transition, per-claw and
   per-hit feedback. *Test:* draining the gate to 0 spawns a rush that reaches and kills the player;
   surviving to dawn wins; HUD is readable over the campfire glow and all touch targets ≥56px.

---

## 9. Non-goals (scope guard — do NOT do these)

- **No player movement / no joystick** at night. The turret stance is the design, not a limitation to
  "fix." (Repositioning is a possible v0.2 idea; out of scope here.)
- **No new enemy types** — one slow zombie only.
- **No new weapons / no weapon switching / no upgrades.** One tap-shot.
- **No forest / expedition scene.** Scavenge stays a single button; the day is not a playable level.
- **No player health bar, no infection, no new resources.** Food's role is the cooldown/channel modifier in
  §5 and nothing more. Three resources stay: food, wood, ammo.
- **No procedural waves.** Spawn schedules are the fixed §4 tables.
- **No auto-fire / no auto-aim / no homing.** Every shot is a chosen tap on a chosen point.
- CLAUDE.md hard rules remain in force (no open world, crafting, monetization, ads, accounts, cloud saves,
  multiplayer, story cutscenes, procedural generation).

---

## 10. Constant summary (drop-in reference)

```
# Gate / repair (GameState + gate_controller)
MAX_GATE_HP            = 100
REPAIR_AMOUNT         = 20      # HP per interval per 1 wood
REPAIR_WOOD_COST      = 1
REPAIR_CHANNEL_FED    = 1.5     # seconds per repair interval, fed
REPAIR_CHANNEL_STARVING = 2.5   # seconds per repair interval, starving

# Player fire (player_controller + projectile)
FIRE_COOLDOWN_FED     = 0.35
FIRE_COOLDOWN_STARVING= 0.70
PROJECTILE_SPEED      = 500
PROJECTILE_LIFETIME   = 2.5
PROJECTILE_DAMAGE     = 1        # (no homing — straight shot)

# Zombie (zombie.gd)
ZOMBIE_HEALTH         = 1        # one shot, one kill (final)
CLAW_DAMAGE           = 5
CLAW_INTERVAL         = 2.0      # => 2.5 DPS per zombie
GATE_STOP_OFFSET      = 35
SPEED_BY_NIGHT        = {1: 45, 2: 55, 3: 65}

# Player threat
PLAYER_CONTACT_RADIUS = 40       # breach rushers this close = GAME OVER

# Night structure (play_world)
NIGHT_DURATION        = {1: 45, 2: 60, 3: 75}   # seconds
ZOMBIES_PER_NIGHT     = {1: 4,  2: 6,  3: 8}
SPAWN_SCHEDULE        = {1: [0,8,16,24],
                         2: [0,6,12,20,28,36],
                         3: [0,5,10,16,22,30,38,46]}
SPAWN_X_SPREAD        = 160      # x = 360 +/- 160

# Positions (play_world.tscn, world-space)
GATE_POS      = (360, 560)  # RectangleShape2D(400, 40)
PLAYER_POS    = (360, 720)  # fixed all run
SPAWN_POS     = (360, 120)
CAMERA_POS    = (360, 600)  # static, smoothing off
```

All numbers above are **starting values for playtest tuning**, not frozen truth. The design invariants that
must survive tuning: ammo kills most-but-not-all; repair covers the residual but a swarm out-drains a single
channel; food neglect measurably weakens the night; the night is a survivable-but-scary countdown that
tightens toward dawn.
