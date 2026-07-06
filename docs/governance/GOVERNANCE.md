# Governance — Until Morning

## Purpose

This document defines the lightweight project governance model for **Until Morning**.

The goal is to keep the project fast, controlled, and understandable while building with Claude Code and human review.

This is a game prototype, not a production SaaS service. Governance must protect the project from scope creep without slowing down early iteration.

## Governance mode

Use **Governance Light** until the project reaches public Android testing.

Governance Light means:

1. Documentation is the source of truth.
2. Work is split into small, verifiable changes.
3. Scope is controlled through MVP documents.
4. Significant decisions are recorded as ADRs.
5. Releases and prototypes are versioned.
6. Incidents are recorded when builds, releases, data, or public users are affected.
7. Claude Code tasks must include scope, validation, and a report.

## Canonical documents

The canonical project documents are:

- `README.md` — project overview and current status
- `CLAUDE.md` — Claude Code operating instructions
- `docs/game-design-blueprint.md` — product and game design direction
- `docs/mvp-scope.md` — current MVP/prototype scope
- `docs/build-plan.md` — phased implementation plan
- `docs/decisions/*.md` — architecture and product decision records
- `docs/governance/*.md` — governance, documentation, versioning, change, and incident rules

Chat conversations are not canonical. If a decision must survive beyond the chat, it must be written into the repository.

## Operating principles

### Small changes

Prefer small branches and small commits.

A good change has:

- clear scope
- clear validation
- no unrelated file changes
- a short implementation report

### Scope protection

Do not add features outside the current MVP scope unless the scope document is intentionally updated first.

For Prototype v0.1, follow `docs/mvp-scope.md`.

### Evidence-first validation

Do not claim a change works unless it was verified.

Acceptable evidence includes:

- Godot project opens
- scene runs locally
- test output
- build output
- screenshot
- manual test notes
- commit SHA
- PR link

### One writer per mutable area

Only one actor should modify the same mutable area at the same time.

Examples:

- one Claude Code session per branch
- one feature branch per gameplay feature
- one person/agent editing the same major document at a time

Review and audit can happen in parallel because they are read-only.

## Risk classes

Use the project risk model in `docs/governance/CHANGE-CONTROL.md`.

Summary:

- R0 — read-only audit
- R1 — documentation-only change
- R2 — local prototype code change
- R3 — build, CI, export, or release-preparation change
- R4 — public testing preparation
- R5 — public production/store/user-data/payment/ads change

## Required reports

Every non-trivial Claude Code implementation should produce a short report:

- what changed
- files changed
- how it was validated
- what remains missing
- risks or follow-ups

Use `docs/templates/CHANGE-REPORT.md` when useful.

## Review rule

Before merging gameplay or build changes, check:

1. Does it match the current MVP scope?
2. Does the Godot project still open?
3. Is the main scene still runnable?
4. Are docs updated if behavior changed?
5. Is there any unwanted scope creep?

## When to tighten governance

Move from Governance Light to stricter governance when any of these happen:

- Android export pipeline is added
- external testers are invited
- public Google Play testing starts
- ads are added
- IAP is added
- analytics or user data is added
- cloud save or accounts are added
- the project has multiple active contributors
