# ADR-004 — GDD Adopted as Canonical Design Source

## Status

Accepted (owner decision, 2026-07-07)

## Decision

`docs/game-design-document.md` (GDD) and `docs/asset-production-specification.md` are the **canonical design sources** for Until Morning. When design documents disagree, the GDD wins until it is deliberately changed.

The documents were authored in the "Until Morning dokumentaation suunnittelu" project (Ludo + Frida roles) without repository access, imported in commit `1812b0e`, and adopted by explicit owner decision.

## Conflict resolutions

The GDD was reconciled against the pre-existing canon. The owner resolved the four identified conflicts in favor of the new direction:

1. **Forest expedition is a walkable area.** GDD §6 defines the v0.1 expedition as a walkable top-down forest area (move, gather wood). The current build's single Scavenge button is an interim implementation; the walkable forest is now a backlog item, not an immediate task.
2. **Gate condition is read without numbers.** GDD §9 requires three visual gate states (intact / damaged / near-broken) instead of an HP bar. The current HP bar is interim; the numberless gate is a backlog item.
3. **Monetization stays out of the prototype.** GDD §20 describes future commercial direction only. The hard rule in `CLAUDE.md` (no monetization, no ads) and the Portti 3 gate in `docs/business/PRODUCTIZATION-ROADMAP.md` remain in force: all revenue decisions require separate owner approval.
4. **GDD §21 is the canonical phasing.** The v0.1–v0.6 roadmap in the GDD supersedes earlier phasing documents. `PRODUCTIZATION-ROADMAP.md` remains valid as the commercial gates view layered on top of it; `POST-AUDIT-PLAN.md` is historical (its sprints are complete).

## Consequences

- `docs/game-design-blueprint.md` and `docs/mvp-scope.md` are superseded and kept for history with banners pointing here.
- `docs/product/BACKLOG.md` gains the two gameplay items from resolutions 1 and 2.
- New design or asset work must check the GDD (§6 scope, §17 art direction) and the asset spec before implementation, per GDD §24.
