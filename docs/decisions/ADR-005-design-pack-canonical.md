# ADR-005 — Design Pack Adopted as Canonical (supersedes ADR-004)

## Status

Accepted (owner decision, 2026-07-07)

## Decision

The **Until Morning design pack** (`docs/design-pack/`) is the canonical design source for the project. It supersedes ADR-004 and the documents ADR-004 made canonical.

The owner was shown the full list of conflicts between the design pack and the ADR-004 canon (see `docs/design-pack/CONCEPT-STATUS.md`) and chose to adopt the pack as the new canon (option B).

## What this changes

- **Canonical design:** `docs/design-pack/` (brief, art direction, UI/UX, systems, MVP scope, economy, asset list). `docs/game-design-document.md` and `docs/asset-production-specification.md` are superseded and kept for history.
- **Art direction:** "cozy apocalypse", stylized/illustrated 2.5D isometric; base-defence framing. The young-survivor / top-down-pixel-art lock from the old GDD no longer applies.
- **Gate / base HP:** the design uses a base-HP model (numeric bar in the reference UI). The numberless three-state gate shipped in v0.1 (`main` @ 23b0ff0) now diverges from canon and is a future implementation change.
- **Scope:** the pack's MVP (`docs/design-pack/05-MVP-SCOPE.md`) is the target: one base, 3 expedition locations (forest / hardware store / pharmacy), 6 resources, 3 buildings (wall / spike trap / shooting tower), 3 zombie types (basic / runner / infector), 3 weather states, 2 NPCs (trader / nurse), backpack (6 slots, one upgrade), survive 10 days + build a radio.
- **Monetization:** now an in-scope, later-phase system, never pay-to-win (`docs/design-pack/06-ECONOMY-MONETIZATION.md`). The pack's own MVP still excludes real IAP and ads until the loop is proven; `CLAUDE.md` is updated to match.

## What this does NOT change yet

- The **shipped v0.1 build** on `main` (real-time top-down, young survivor, numberless gate, walkable forest) stays live at haimoo-labs.github.io/untill-morning. Adopting the pack as canon is a design decision, not an instruction to rebuild the game. Reworking the build toward the pack's MVP is a separate, planned effort that needs its own go-ahead.

## Consequences

- ADR-004 is superseded; `docs/game-design-document.md` and `docs/asset-production-specification.md` get superseded banners pointing here.
- `CLAUDE.md` is updated: canon pointer → design pack; current target → pack MVP; monetization/ads rules → deferred-not-forbidden.
- The next build effort should plan against `docs/design-pack/05-MVP-SCOPE.md`, not the old GDD.
