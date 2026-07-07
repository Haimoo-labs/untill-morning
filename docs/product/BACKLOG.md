# Product Backlog — Until Morning

## Purpose

This backlog keeps the project focused.

It separates what should be built now from what should wait until the core loop is proven.

Commercial priority view (which v0.2–v0.6 items matter most for a revenue project, and gate criteria for Portti 1 / Portti 2): see `docs/business/PRODUCTIZATION-ROADMAP.md`. The tags below summarize that view; they do not change scope.

Design source of truth: `docs/game-design-document.md` (ADR-004). Items below must stay consistent with GDD §6 (v0.1 scope) and §21 (roadmap).

## Now — Prototype v0.1

Goal:

Prove the smallest playable day/night loop.

Build:

- GameState v0.1
- single-scene UI phase flow
- Morning/Base screen
- Forest expedition
- simple loot result
- Evening screen
- gate repair
- simple night resolution
- Morning report
- Game Over screen
- Prototype Complete screen after Day 3
- walkable forest expedition area (GDD §6/§11 — replaces the interim Scavenge button; ADR-004 res. 1)
- numberless gate condition: three visual states intact/damaged/near-broken (GDD §9 — replaces the interim HP bar; ADR-004 res. 2)

Do not build:

- infection
- weather
- NPCs
- save system
- monetization

## Next — Prototype v0.2

Commercial priority: **High** — first depth multiplier on the core loop, feeds retention. Keep.

Goal:

Add infection pressure after the core loop is playable.

Candidate features:

- infection percentage
- medicine resource
- pharmacy expedition
- infector zombie
- simple treatment action

Success question:

> Does infection create a meaningful choice without feeling unfair?

## Next — Prototype v0.3

Commercial priority: **High** — agency and "care what you leave behind" drive replay value. Keep, ahead of weather.

Goal:

Make loot choices more interesting.

Candidate features:

- backpack with 6 slots
- manual loot choice
- hardware store expedition
- wood/metal tradeoff
- better expedition risk meter

Success question:

> Does the player care what they leave behind?

## Later — Prototype v0.4

Commercial priority: **Medium** — variety, not a retention core. First candidate to slim or defer if solo capacity (R-P1) tightens.

Goal:

Add weather that changes rules.

Candidate features:

- clear weather
- rain
- fog
- weather affects expedition and night

Success question:

> Does the same day feel different because of weather?

## Later — Prototype v0.5

Commercial priority: **Medium–high** — trader adds a light economy loop where a future non-predatory meta/monetization can later hang. Keep light, guard against RPG creep.

Goal:

Add lightweight NPCs.

Candidate features:

- trader
- nurse
- simple trade offers
- nurse slows infection

Success question:

> Do NPCs create decisions without turning the game into an RPG?

## Later — Prototype v0.6

Commercial priority: **Critical** — the real commercial gate. Difficulty curve plus "want one more day after several sessions" is where retention proves out or fails. Protect capacity for this milestone.

Goal:

Expand to a 7 Night MVP.

Candidate features:

- seven-night difficulty curve
- readable reports
- basic balancing
- placeholder UI polish
- internal playable build candidate

Success question:

> Does the player want one more day after several sessions?

## Not before v0.6

Phase-specific deferrals — do not build these before the 7 Night MVP:

- full 30-day campaign
- escape vehicle
- boss nights
- season pass
- leaderboards
- final art
- final audio

Permanent product bans (open world, monetization, ads, accounts, cloud saves, multiplayer, etc.) are in `CLAUDE.md` "Hard rules". Money/publish items that need explicit approval are in "Never without explicit approval" below.

## Never without explicit approval

Do not add these without explicit owner approval:

- ads
- IAP
- analytics collecting user data
- accounts
- cloud saves
- Google Play public release
- any committed credential or signing secret

## Backlog rule

If a new idea appears, put it into `FEATURE-PARKING-LOT.md` first unless it directly supports the current prototype goal.
