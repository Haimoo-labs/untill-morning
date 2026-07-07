# Canon Status — This Pack Is Now Canonical

> **Status: CANONICAL design source (owner decision, 2026-07-07, ADR-005).**
> Adopted over the previous ADR-004 GDD after the conflicts below were surfaced.

This design pack (`docs/design-pack/`) is the source of truth for Until Morning. It replaced the earlier GDD (`docs/game-design-document.md`) and asset spec, which are superseded and kept only for history.

## What changed on adoption

The owner was shown that this pack conflicts with the previous canon and the shipped v0.1 build, and chose to adopt the pack anyway (option B). The resulting canon:

- **Art direction:** "cozy apocalypse", stylized/illustrated 2.5D isometric base-defence (`02-ART-DIRECTION.md`) — replaces the old young-survivor / top-down-pixel-art lock.
- **Base HP:** numeric base-HP model per the reference UI — the shipped numberless three-state gate now diverges from canon (a future rebuild item).
- **Scope:** the pack MVP (`05-MVP-SCOPE.md`) — 3 locations, 6 resources, 3 buildings, 3 zombie types, 3 weather states, 2 NPCs, backpack, survive 10 days + build a radio.
- **Monetization:** in scope as a later-phase system, never pay-to-win (`06-ECONOMY-MONETIZATION.md`); real IAP/ads still deferred until the loop is proven, per the pack's own MVP and `CLAUDE.md`.

## What is unchanged

The **shipped v0.1 build** (real-time top-down, young survivor, numberless gate, walkable forest) stays live at haimoo-labs.github.io/untill-morning. Adopting this pack as canon is a design decision, not an order to rebuild. Reworking the build toward this pack's MVP is a separate, planned effort.

See `docs/decisions/ADR-005-design-pack-canonical.md`.
