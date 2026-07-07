# Incident Management — Until Morning

## Purpose

This document defines how incidents are handled.

In early prototype stage, most incidents are local development problems. Later, incidents may affect testers, builds, store releases, ads, analytics, saves, or user data.

## What counts as an incident?

An incident is any unexpected event that blocks development, breaks a playable build, affects testers, risks data, or damages the release process.

Examples:

- Godot project no longer opens
- main scene crashes
- Android export fails unexpectedly
- tagged build is not runnable
- save data is corrupted
- public test build has a critical blocker
- store listing has wrong information
- analytics collects data without approval
- IAP or ads behave incorrectly
- secret or credential is accidentally committed

## Incident severity

### SEV-4 — Minor development issue

Impact:

- local issue only
- no released build affected
- no tester impact

Examples:

- broken placeholder scene
- minor script error
- local Godot warning

Expected action:

- fix in normal workflow
- mention in change report if relevant

### SEV-3 — Prototype blocker

Impact:

- playable prototype cannot run
- main loop broken
- development blocked

Examples:

- project cannot open
- main scene crashes
- GameState autoload missing
- core loop cannot advance

Expected action:

- stop feature work
- create issue/report
- fix or revert
- validate project opens/runs

### SEV-2 — Release/test blocker

Impact:

- Android build/export broken
- internal test build unusable
- tagged release invalid
- tester-facing feature broken

Examples:

- APK/AAB cannot be produced
- internal test build crashes at start
- release notes do not match build
- wrong version shipped to testers

Expected action:

- pause release
- document incident
- assign owner
- fix or rollback
- produce validation evidence

### SEV-1 — Public/user-data/payment/ads issue

Impact:

- public users affected
- user data affected
- ads/IAP/payment behavior wrong
- privacy or compliance risk
- secrets leaked

Examples:

- public build crashes for many users
- analytics collects unapproved data
- IAP charges incorrectly
- ad behavior violates policy
- signing key or credential leaked

Expected action:

- immediate owner notification
- stop affected release/change
- remove/disable affected feature if possible
- document timeline
- produce postmortem
- define prevention actions

## Incident response process

1. **Detect** — identify the problem and affected area.
2. **Classify** — assign severity.
3. **Contain** — stop further damage or scope expansion.
4. **Fix or rollback** — prefer the smallest safe repair.
5. **Validate** — prove the fix works.
6. **Document** — write incident report when severity is SEV-3 or higher.
7. **Prevent** — add a checklist, test, doc update, or process change.

## Incident report requirement

Use `docs/governance/deferred/INCIDENT-REPORT.md` for SEV-3 or higher.

SEV-4 can be handled in a normal change report.

## Minimum incident report fields

- Incident title
- Date/time
- Severity
- Affected version/build/commit
- What happened
- Impact
- Root cause, if known
- Immediate action taken
- Validation evidence
- Follow-up actions
- Owner

## Rollback guidance

Rollback is preferred when:

- the broken change is small and recent
- the cause is unclear
- fixing would require broad changes
- a playable build is needed quickly

Fix forward is acceptable when:

- the cause is clear
- the fix is small
- rollback would lose important safe work

## Secrets and credentials

If a secret or credential is committed:

1. Treat as SEV-1.
2. Do not only delete the file.
3. Rotate the credential.
4. Remove or invalidate affected access.
5. Document the event.
6. Add prevention if missing.

## Public release rule

Before any public or tester-facing release, confirm:

- version is correct
- release notes exist
- build was tested
- privacy/data behavior is documented
- ads/IAP are not present unless explicitly approved
- known issues are listed

## Current project stage

Until Morning is currently in early prototype stage.

Most incidents are expected to be SEV-4 or SEV-3 until Android builds, testers, ads, IAP, analytics, accounts, or cloud saves are introduced.
