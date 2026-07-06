# Definition of Done — Until Morning

## Purpose

This document defines when work is considered done.

The goal is to prevent half-finished Claude Code changes from being treated as complete.

## Applies to

This Definition of Done applies to:

- documentation changes
- Godot prototype code changes
- build/release preparation
- future Android testing changes

## General Definition of Done

A change is done when:

1. Scope is clear.
2. Implementation matches the agreed scope.
3. No unrelated changes are included.
4. Validation has been performed or explicitly marked as not performed.
5. Changed files are listed in the report.
6. Known limitations are documented.
7. Follow-up work is listed if needed.
8. Documentation is updated if behavior, scope, architecture, build, or release process changed.

## R1 — Documentation-only change is done when

- document is in the correct location
- title and purpose are clear
- content does not contradict canonical docs
- README links are updated if discovery is needed
- no code files were changed

## R2 — Local prototype code change is done when

- Godot project opens, or inability to verify is stated
- main scene runs, or inability to verify is stated
- implementation stays inside current MVP scope
- no excluded systems are added
- basic manual validation is performed
- changed files are listed
- docs are updated if behavior changed

For Prototype v0.1, also confirm:

- Day 1 starts
- Forest expedition works
- Evening screen works
- gate repair works
- night resolves
- morning report appears
- day advances
- prototype completes after Day 3
- game over can appear when gate reaches 0 HP

## R3 — Build/export/release-prep change is done when

- build/export instructions are documented
- no secrets are committed
- build command or manual process is documented
- failure modes are documented
- rollback or revert path is clear

## R4 — Public testing preparation is done when

- owner approval exists
- tester-facing scope is documented
- version is defined
- known issues are listed
- privacy/data behavior is clear
- release notes exist

## R5 — Public/user-data/payment/ads change is done when

- explicit owner approval exists
- privacy and compliance impact is documented
- rollback/mitigation plan exists
- release notes exist
- incident path is clear
- secrets are protected
- user-facing behavior is validated

## Claude Code completion report

Every non-trivial Claude Code task should end with:

```text
Changed files:
- 

Validation:
- 

Not verified:
- 

Known placeholders:
- 

Scope creep:
- yes/no

Follow-up:
- 
```

## Not done examples

A change is not done if:

- it adds features outside scope without updating scope docs
- it claims validation but does not say how it was validated
- it changes unrelated files
- it leaves Godot scene references broken
- it silently changes balance values without updating balance docs
- it introduces ads/IAP/analytics/accounts/cloud saves without approval

## Current project standard

Until Morning is currently in early prototype stage. Prefer speed, clarity, and validation over polish.
