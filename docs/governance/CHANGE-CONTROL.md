# Change Control — Until Morning

## Purpose

This document defines how changes are planned, implemented, reviewed, and merged.

The goal is to keep Claude Code work safe, scoped, and easy to validate.

## Change classes

### R0 — Read-only audit

Examples:

- reading files
- reviewing code
- checking docs
- summarizing repository status

Allowed directly.

### R1 — Documentation-only change

Examples:

- README update
- scope document update
- ADR update
- governance document update
- report/template update

Allowed directly when low risk.

Use a branch when the document changes project direction.

### R2 — Local prototype code change

Examples:

- Godot scene change
- GDScript gameplay logic
- UI prototype
- placeholder asset changes

Use a feature branch.

Require validation before merge.

### R3 — Build, CI, export, or release preparation

Examples:

- Android export setup
- GitHub Actions
- signing config placeholders
- build scripts
- release packaging

Use a branch and review.

Do not commit secrets.

### R4 — Public testing preparation

Examples:

- Google Play internal testing setup
- public tester distribution
- app listing preparation
- privacy policy preparation
- analytics planning

Requires explicit owner approval.

### R5 — Public production/user-data/payment/ads change

Examples:

- public Google Play release
- IAP
- ads
- analytics collecting user data
- accounts
- cloud saves
- payment-related configuration

Requires explicit owner approval, documentation, and rollback/mitigation plan.

## Branch naming

Use clear branch names.

Examples:

```text
docs/governance-foundation
prototype/v0.1-core-loop
prototype/v0.1-night-resolution
prototype/v0.2-infection
fix/v0.1-gate-damage
chore/android-export-setup
```

## Commit messages

Use simple conventional-style messages:

```text
chore: initialize Godot project skeleton
docs: add MVP scope
feat: add forest expedition flow
fix: prevent gate HP from going below zero
refactor: simplify night resolution
```

## Change request structure

Every non-trivial change should define:

1. Goal
2. Scope
3. Files or areas allowed to change
4. Files or areas not allowed to change
5. Acceptance criteria
6. Validation command/manual test
7. Stop conditions

## Claude Code task format

Use this structure for Claude Code:

```text
Read CLAUDE.md and the relevant docs.

Goal:
<one clear outcome>

Scope:
<what may be changed>

Do not change:
<explicit exclusions>

Acceptance criteria:
<how we know it is done>

Validation:
<how to test>

After implementation:
- list changed files
- explain validation
- identify missing/placeholder parts
- identify scope creep if any
```

## Merge checklist

Before merging R2+ changes, check:

- Does it match `docs/mvp-scope.md`?
- Does it avoid excluded systems?
- Does the Godot project open?
- Does the main scene run?
- Are docs updated if behavior changed?
- Are there unrelated file changes?
- Was validation actually performed?
- Is there a short change report?

## Scope creep rules

A change is scope creep if it adds systems not required by the current prototype.

For Prototype v0.1, scope creep includes:

- infection
- medicine
- weather
- NPCs
- trader
- nurse
- multiple locations
- backpack upgrades
- multiple weapons
- multiple zombie types
- base building
- escape vehicle
- radio
- ads
- IAP
- save system

Scope creep is not automatically bad, but it must be intentional. Update `docs/mvp-scope.md` first if the scope changes.

## Documentation update rule

If a change affects current behavior, scope, architecture, build, or release process, update documentation in the same branch or explicitly report why documentation was not changed.

## Rollback principle

Every R2+ change should be small enough to revert safely.

Prefer reverting a small bad change over trying to repair many unrelated changes at once.

## Stop conditions

Stop work and report if:

- the change requires a major design decision not documented
- files outside scope need modification
- project files become inconsistent
- validation cannot be run
- a secret or credential would be needed
- a change touches ads, IAP, analytics, accounts, cloud saves, or public release setup without explicit approval
