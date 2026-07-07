# Next-Version MVP Build Plan — Until Morning

> **Altitude:** this is a **version-level roadmap**, not a bite-sized execution plan.
> The design-pack MVP is a multi-subsystem game, so per the writing-plans scope check
> it is broken into subsystem phases here. Each phase gets its own detailed
> TDD plan (in this same `docs/superpowers/plans/` folder) **when that phase is
> started** — we are planning the next version, not building it now (owner: not yet).

**Goal:** Rebuild Until Morning from the shipped 3-night top-down slice into the design-pack MVP: a day/night base-defence survival game where the player survives 10 days and builds a radio.

**Canon:** `docs/design-pack/` (ADR-005). This plan implements `05-MVP-SCOPE.md`, grounded in `04-GAME-SYSTEMS.md`, `03-UI-UX-SPEC.md`, `07-ASSET-LIST.md`.

**Architecture:** Keep the current Godot 4 / GDScript engine and the real-time joystick+shoot night combat (the reference UI confirms a virtual joystick and weapon slots — this is the single biggest reuse). Expand the `GameState` autoload from run-state into the full survival model. Add a fixed-slot building system, a backpack-limited expedition loop over three locations, and layered pressure systems (infection, thirst, weather).

**Tech Stack:** Godot 4.3, typed GDScript, single `GameState` autoload, placeholder art first, headless integration tests + Playwright browser smoke tests (the toolchain already proven on the shipped slice).

## Global Constraints

- Android-first, portrait 720×1280 (design pack §Platform; current `project.godot` already set).
- Typed GDScript; global state only via the `GameState` autoload (repo `CLAUDE.md`).
- No open world, no massive crafting tree, no online/cloud/multiplayer, no long cutscenes (`CLAUDE.md` hard rules).
- **No monetization or ads in the MVP** — designed for later phases, never pay-to-win (`06-ECONOMY-MONETIZATION.md`, `CLAUDE.md`).
- MVP UI caps (`03-UI-UX-SPEC.md`): ≤6 resources shown, ≤4 tasks, ≤5 build options per panel, ≤4 night items.
- Target feeling preserved: *"not enough time / one more day"* (`CLAUDE.md` product rule, `05-MVP-SCOPE.md` success criteria).

---

## Architecture decisions to lock before building

These are forks the owner/architect must settle at build kickoff. They change the shape of every phase; do not start Phase 0 until they are answered.

1. **Isometric vs. keep top-down.** The pack art is illustrated 2.5D isometric ("cozy apocalypse"); the shipped build is top-down pixel. Options: **(a)** keep the top-down real-time combat and restyle art toward the pack mood (cheapest, preserves all movement/combat code), or **(b)** rebuild rendering as true isometric (matches the board, large art + input + collision cost). Recommendation: **(a) for the MVP**, revisit isometric as a post-MVP art pass. This plan assumes (a); choosing (b) mainly rewrites Phase 2–3 rendering/input, not the systems.
2. **Base HP model.** The pack uses a numeric base-HP bar (reference UI "BASE HP 78/100"). This **replaces** the shipped numberless three-state gate. The gate becomes one building feeding a single base-HP pool.
3. **Persistence.** A 10-day run is long for mobile — needs save/resume (one hard rule bans *cloud* saves, not local). Decide: local `user://` save of `GameState`, or single-session only. Recommendation: local save from Phase 0 (mobile sessions are interrupted).
4. **Combat model at night.** Reference shows joystick + tap/aimed shooting + tower auto-fire. Confirm player-aimed vs. tower-auto split before Phase 3.

## Current-code reuse inventory

| Shipped asset | Fate in MVP |
|---|---|
| `GameState` autoload (explicit run state, `reset()`, day bookkeeping) | **Reuse + expand** — the backbone. Add water/metal/medicine, infection%, buildings, weather, 10-day target, save. |
| `player_controller.gd`, `virtual_joystick.gd`, `projectile.gd` | **Reuse** — real-time move + aimed shooting is still the night model. |
| `zombie.gd` (walk-to-target, claw, breach, retreat) | **Reuse + subclass** — basic zombie stays; runner (fast) and infector (applies infection) extend it. |
| `play_world.gd` orchestrator (day/night loop, spawn schedule, dawn) | **Heavy rework** — the loop survives; phases/building/backpack/weather are layered in. Likely split into phase controllers. |
| `forest_area.gd` + `forest_pickup.gd` (walkable gather) | **Reuse + generalize** — becomes the expedition template for 3 locations; add backpack cap + risk/noise. |
| `gate_controller.gd` (states, cracks, repair flash) | **Repurpose** — folds into the building/base-HP system; numberless states retired per decision 2. |
| Headless test harness (`game/tests/integration_forest_gate.gd`) + Playwright smoke | **Reuse** — same verification pattern per phase. |
| SFX wavs (shot/hit/repair/gate) | **Reuse**, add per the asset list at polish time. |

---

## Phase breakdown (critical path: 0 → 1 → 2 → 3 → 4 → {5,6} → 7)

Each phase is an independently testable slice. At phase start, write its detailed
TDD plan (`docs/superpowers/plans/<date>-mvp-phaseN-<name>.md`) before touching code.

### Phase 0 — Foundation: GameState model + persistence + HUD frame
- **Delivers:** expanded `GameState` (6 resources, infection%, day 1–10, building registry, weather field, win flag), local save/load to `user://`, and a top-bar HUD showing the MVP resource set. No new gameplay yet.
- **Depends on:** architecture decisions 2 & 3.
- **Reuse:** `GameState` autoload wholesale.
- **Testable:** headless test — set state, save, reload scene, assert restored; HUD renders all six resources.

### Phase 1 — Day + expedition loop with backpack (3 locations)
- **Delivers:** day-phase base view with the "Go on expedition" flow generalized to **forest / hardware store / pharmacy**, each with a loot table, risk level, and duration; a **backpack** (6 slots) that forces a take/leave choice when full; return-to-base.
- **Depends on:** Phase 0.
- **Reuse:** `forest_area.gd`/`forest_pickup.gd` as the location template; the shipped re-entry/return logic.
- **Testable:** each location rolls its own loot; backpack caps at 6 and blocks over-collection; three locations reachable and distinct.

### Phase 2 — Base + fixed-slot building system + base HP
- **Delivers:** fixed build slots around the base; three buildable defences (**wall, spike trap, shooting tower**) with resource costs and a build/repair panel; a single **numeric base-HP** pool that buildings and the gate feed.
- **Depends on:** Phase 0 (resources), decision 1 (render) & 2 (base HP).
- **Reuse:** `gate_controller` collider/repair mechanics generalized to buildings.
- **Testable:** build consumes resources and places a defence on a slot; base HP shows and repairs; illegal builds (no resources / occupied slot) rejected.

### Phase 3 — Night defence with three zombie types
- **Delivers:** wave-based night (60–120 s), **basic / runner / infector** zombies, buildings participating (spike traps damage, shooting tower auto-fires, walls absorb), player joystick+aimed shooting, emergency repair; base survives / damaged / falls.
- **Depends on:** Phase 2 (buildings + base HP), decision 4 (combat model).
- **Reuse:** `zombie.gd`, `player_controller.gd`, `projectile.gd`, night spawn scheduler.
- **Testable:** each zombie type behaves distinctly (runner speed, infector applies infection on contact); towers/traps deal damage; base HP falls to game-over path.

### Phase 4 — Survival pressure: infection + medicine, food + water
- **Delivers:** infection meter (0/25/50/75/100 with the pack's escalating penalties), medicine slows/reduces it; food and water as non-instant pressures (movement/aim/regen penalties when depleted); water refill (barrel).
- **Depends on:** Phase 3 (infector as infection source), Phase 1 (medicine/water as loot).
- **Reuse:** `GameState` fields from Phase 0.
- **Testable:** infector contact raises infection; medicine lowers it; empty food/water applies the specified penalties; infection at 100 triggers the crisis path.

### Phase 5 — Weather (3 states) + radio forecast
- **Delivers:** clear / rain / fog with rule modifiers (rain fills barrels + cuts visibility + weakens fire traps; fog delays zombie visibility + boosts light-tower value); radio building shows next-day forecast.
- **Depends on:** Phase 1 (expedition), Phase 3 (night).
- **Testable:** each weather state applies its documented modifier; radio surfaces the upcoming state.

### Phase 6 — NPCs (trader, nurse) + morning report
- **Delivers:** trader (barter valve), nurse (infection management), and the full morning report (kills, damage, resources spent, rewards, NPC event, next weather).
- **Depends on:** Phase 1 (economy), Phase 4 (infection).
- **Testable:** trader swaps resources; nurse reduces infection for a cost; morning report shows accurate totals.

### Phase 7 — Progression, win condition, balance, HUD polish
- **Delivers:** 10-day arc with rising difficulty, the **build-a-radio win condition**, day/night/expedition HUD layouts per `03-UI-UX-SPEC.md`, balance pass, notifications.
- **Depends on:** all prior phases.
- **Testable:** a full 10-day run is winnable by building the radio and losable by neglect; "not enough time / one more day" holds in a balance simulation (reuse the shipped headless-sim approach).

## Explicitly out of the MVP (later phases)
Monetization/tokens/IAP/ads, season passes, the escape vehicle, extra zombie types (thick/screamer/sneaker/boss/frozen/mutant), extra weather (storm/cold-night/heat/toxic-rain/dark-night), extra NPCs (mechanic/scout/guard/wounded/child), multiple bases, isometric re-render (unless decision 1 picks it up front). All are designed in the pack and slot in after the 10-day loop proves fun.

## Risks & open questions
- **Scope is a full game.** Seven phases; the shipped slice covers maybe Phase 0–3 partially. Sequence strictly; ship a playable subset early (Phase 0–3 = a playable defended night) before the pressure/weather/NPC layers.
- **Isometric decision (1)** dominates cost — settle before Phase 2.
- **HUD overload** is the pack's own stated top UI risk; honor the MVP caps.
- **Balance** is where the shipped slice needed 3 tuning iterations — budget a real Phase 7 sim pass, not a guess.
- **Save format** must version from day one or 10-day saves break on every field addition.

---

## Not building yet
Per owner: the rebuild is the **next version**, not now. This roadmap is the plan of record. When a phase is greenlit, write its detailed TDD plan first, build against `docs/design-pack/`, and verify with the existing headless + browser harness before moving on.
