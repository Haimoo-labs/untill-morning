# Governance Light — Until Morning

**Status:** Active · **Last updated:** 2026-07-07

This is the single active governance document for Until Morning. Until Morning is a single-person game prototype, not a production service. Governance stays light: it protects the project from scope creep without slowing early iteration. It stays in force until public Android testing (see "When to tighten governance").

## Governance Light means

1. Repository documentation is the source of truth. Chat is not durable — if a decision must survive, write it into the repo.
2. Work is split into small, verifiable changes.
3. Scope is controlled through the scope documents (see "Scope protection").
4. Significant, hard-to-reverse decisions are recorded as ADRs (`docs/decisions/`, use `docs/templates/ADR-TEMPLATE.md`).
5. Prototypes and builds are versioned (see "Versioning").
6. Every non-trivial Claude Code task has scope, validation, and a completion report.

## Risk classes

Every change is one of these. R0–R1 are allowed directly; R2 needs a branch and validation before merge; R4–R5 need explicit owner approval.

- **R0 — Read-only audit.** Reading, reviewing, summarizing. No changes.
- **R1 — Documentation-only change.** README, scope, ADR, governance, report/template edits. Use a branch when the doc changes project direction.
- **R2 — Local prototype code change.** Godot scenes, GDScript, UI, placeholder assets. Feature branch + validation before merge.
- **R3 — Build / CI / export / release preparation.** Android export, CI, build scripts, signing placeholders. Branch + review, no committed secrets.
- **R4 — Public testing preparation.** Play internal testing, tester distribution, listing, privacy prep. Requires explicit owner approval.
- **R5 — Public / user-data / payment / ads change.** Public release, IAP, ads, analytics, accounts, cloud saves. Requires explicit owner approval, documentation, and a rollback/mitigation plan.

## Scope protection

Do not add features outside the current scope unless the scope document is intentionally updated **first**. Canonical scope sources:

- Permanent product bans: `CLAUDE.md` "Hard rules".
- Current prototype exclusions (v0.1): `docs/mvp-scope.md` "Excluded from v0.1".
- Roadmap and phase deferrals: `docs/product/BACKLOG.md`.
- Money/publish items needing approval: `docs/product/BACKLOG.md` "Never without explicit approval".

A change is scope creep if it adds a system not required by the current prototype. Scope creep is not automatically bad, but it must be intentional: update the relevant scope document before building.

## Evidence-first validation

Do not claim a change works unless it was verified. Acceptable evidence: Godot project opens, scene runs locally, test output, build output, screenshot, manual test notes, commit SHA, or PR link. See `docs/quality/DEFINITION-OF-DONE.md` for the per-risk-class "done" criteria.

## Claude Code task format

Every non-trivial Claude Code task uses this shape:

```text
Read CLAUDE.md and the relevant docs.

Goal:        <one clear outcome>
Scope:       <what may be changed>
Do not change: <explicit exclusions>
Acceptance:  <how we know it is done>
Validation:  <how to test>

After implementation, produce a completion report:
docs/templates/CHANGE-REPORT.md
(changed files, validation, not-verified, known placeholders, scope creep, follow-up)
```

The completion report format is canonical in `docs/templates/CHANGE-REPORT.md`. One writer per mutable area at a time (one Claude Code session per branch); read-only review and audit may run in parallel.

## Versioning

Three layers:

- **Prototype version** — gameplay milestone: `Prototype v0.x — Name` (e.g. `Prototype v0.1 — Core Loop`). Describes design/gameplay scope, not only code. Roadmap mapping v0.1→v0.6 lives in `docs/product/BACKLOG.md`.
- **Build version** — `0.x.y`: `0` = pre-1.0 prototype phase, `x` = prototype milestone, `y` = build iteration. Example: `0.1.0` first complete v0.1 build, `0.1.1` a fix/tuning build.
- **Release tag** — Git tag for a stable playable checkpoint: `prototype-v0.1.0`. Only tag builds that are runnable, documented, validated, and worth returning to.

Bump rules: **patch** (`0.1.0 → 0.1.1`) for bug fixes, balance tuning, UI text, placeholder polish; **minor/prototype** (`0.1.x → 0.2.0`) when a new planned system enters the playable loop. Do **not** use `1.0.0` until there is a real release candidate (stable loop, Android pipeline, save system, polish, release checklist, tested installable build). All pre-1.0 versions are unstable prototypes; breaking changes are allowed but must be intentional and documented when they affect future work.

Record the current version in `README.md`; tagged builds get release notes (template deferred, see below).

## Prototype-stage incidents

While in prototype stage, an incident means "the game will not open or run": stop feature work, fix or revert (prefer the smallest safe repair), confirm the project opens and runs, and note it in the change report. The full severity model, incident report, and release-notes templates are deferred in `docs/governance/deferred/` and activate at Android testing (see next section).

## When to tighten governance

Move from Governance Light to stricter governance — and reactivate `docs/governance/deferred/` — when any of these happen:

- an Android export pipeline is added,
- external testers are invited or public Google Play testing starts,
- ads, IAP, analytics, user data, cloud saves, or accounts are added,
- the project has multiple active contributors.

## Documentation naming and location

- Regular docs: lowercase kebab-case (`mvp-scope.md`, `build-plan.md`). ADRs: `docs/decisions/ADR-###-short-title.md`. Templates: `docs/templates/*.md`. Governance: `docs/governance/*.md`.
- Repository documentation is the source of truth; do not maintain two diverging copies of the same content.
- Long-lived docs show status (Draft | Active | Superseded | Archived) and a "last updated" date. Do not keep outdated docs marked Active — update or mark them superseded.
- When a change alters behavior, scope, architecture, build, or release process, update the relevant doc in the same branch or explicitly report why it was not.
