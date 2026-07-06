# Feature Parking Lot — Until Morning

## Purpose

This document stores good ideas that should not be built yet.

A parked feature is not rejected. It is intentionally delayed until the current prototype loop is proven.

## Rule

If a feature is not needed for the current prototype, park it here.

Do not implement parked features unless the MVP scope or build plan is updated first.

## Parked for after v0.1

### Infection

Potential later scope:

- infection percentage
- medicine
- pharmacy
- infector zombie
- treatment action

Reason parked:

- v0.1 must prove the basic day/night loop first.

### Weather

Potential later scope:

- clear
- rain
- fog
- weather modifies night and expedition risk

Reason parked:

- weather is valuable, but only after the core loop is playable.

### NPCs

Potential later scope:

- trader
- nurse
- simple trade offers
- nurse slows infection

Reason parked:

- NPCs can create scope creep before the loop works.

### Multiple expedition locations

Potential later locations:

- pharmacy
- hardware store
- gas station
- police station
- supermarket

Reason parked:

- v0.1 uses Forest only to prove flow.

### Backpack slots

Potential later scope:

- 6-slot backpack
- manual loot selection
- larger items use more slots

Reason parked:

- should be added only after basic expedition works.

### Base building

Potential later scope:

- traps
- tower
- reinforced gate
- generator
- radio

Reason parked:

- v0.1 only needs one gate and repair.

### Escape vehicle

Potential later scope:

- armored car parts
- long-term escape goal
- 30-day campaign arc

Reason parked:

- too large before 7 Night MVP.

### Boss nights

Potential later scope:

- every 7th night boss
- high damage zombie
- unique defence challenge

Reason parked:

- requires stable night combat first.

### Monetization

Potential later scope:

- cosmetics
- support pack
- no ads
- optional reward ads
- season/event pass

Reason parked:

- monetization must not be designed before the game is fun.

### Ads and IAP

Reason parked:

- high risk and not needed for prototype.
- requires explicit owner approval.

### Save system

Potential later scope:

- local save
- continue run
- reset run

Reason parked:

- v0.1 can be session-only.

### Analytics

Potential later scope:

- local debug counters
- privacy-safe analytics for testing

Reason parked:

- user data and analytics increase governance risk.

## Revisit order

Recommended revisit order:

1. Infection
2. Backpack and loot choice
3. Weather
4. NPCs
5. 7 Night MVP
6. Save system
7. Android export
8. Monetization discussion

## Parking lot rule for Claude Code

Claude Code may add ideas to this file when it finds useful future work.

Claude Code must not implement parked features unless a task explicitly updates the active scope.
