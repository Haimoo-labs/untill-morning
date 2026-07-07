# Deferred governance

**Status:** Deferred (not active) · **Last updated:** 2026-07-07

## Why these are here

This folder holds governance that is written but **not yet in force**. Until Morning is a single-person prototype with zero users and zero published builds. Incident management (SEV-1/SEV-2), incident reports, and release notes all describe things that cannot happen yet: public users, store releases, payments, ads, leaked signing keys, tagged shipped builds.

Keeping this machinery active would be process theatre. Keeping it in the repo (instead of deleting it) means it is ready the moment it becomes real.

While deferred, the only incident rule in force is the light one in `docs/governance/GOVERNANCE-LIGHT.md`: in prototype stage an incident means "the game will not open or run" → stop, fix or revert, and note it in the change report.

## Files

- `INCIDENT-MANAGEMENT.md` — full SEV-1…SEV-4 severity model and response process.
- `INCIDENT-REPORT.md` — incident report template for SEV-3 and higher.
- `RELEASE-NOTES.md` — release notes template for tagged, shipped builds.

## When to reactivate

Activate this folder (move the files back and treat them as canonical) when the "when to tighten governance" trigger in `GOVERNANCE-LIGHT.md` fires — in practice around **Portti 3 / Android testing**, i.e. any of:

- an Android export pipeline is added,
- external testers are invited or Google Play testing starts,
- the first playable build is tagged and shipped,
- ads, IAP, analytics, accounts, or cloud saves are introduced.

## How to reactivate

1. `git mv docs/governance/deferred/INCIDENT-MANAGEMENT.md docs/governance/INCIDENT-MANAGEMENT.md`
2. `git mv docs/governance/deferred/INCIDENT-REPORT.md docs/templates/INCIDENT-REPORT.md`
3. `git mv docs/governance/deferred/RELEASE-NOTES.md docs/templates/RELEASE-NOTES.md`
4. Fix the `INCIDENT-REPORT.md` path reference inside `INCIDENT-MANAGEMENT.md` back to `docs/templates/`.
5. Re-add these files to the governance/templates lists in `README.md` and link them from `GOVERNANCE-LIGHT.md`.
