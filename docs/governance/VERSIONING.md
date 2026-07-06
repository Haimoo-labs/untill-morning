# Versioning — Until Morning

## Purpose

This document defines how prototypes, builds, releases, and tags are versioned.

The project is currently in prototype stage. Versioning should be simple, understandable, and useful for tracking progress.

## Version layers

Until Morning uses three version layers:

1. **Prototype version** — product/gameplay milestone
2. **Build version** — generated playable build
3. **Release tag** — Git tag for a stable milestone

## Prototype versioning

Use this format:

```text
Prototype v0.x
```

Examples:

- `Prototype v0.1 — Core Loop`
- `Prototype v0.2 — Infection Pressure`
- `Prototype v0.3 — Meaningful Loot Choices`
- `Prototype v0.4 — Weather`
- `Prototype v0.5 — NPC Light`
- `Prototype v0.6 — 7 Night MVP`

Prototype versions describe design and gameplay scope, not only code.

## Build versioning

Use this format for internal builds:

```text
0.x.y
```

Meaning:

- `0` — pre-1.0 prototype phase
- `x` — prototype milestone
- `y` — build iteration within that prototype milestone

Examples:

- `0.1.0` — first complete v0.1 prototype build
- `0.1.1` — fix/tuning build for v0.1
- `0.2.0` — first infection prototype build
- `0.6.0` — first 7 Night MVP build

## Release tags

Use Git tags for stable playable checkpoints.

Format:

```text
prototype-v0.1.0
prototype-v0.1.1
prototype-v0.2.0
```

Only tag builds that are:

- runnable
- documented
- validated
- worth returning to later

## Version source

Current version should be documented in:

- `README.md` for human overview
- release notes for tagged builds
- optionally a future project config or build metadata file

Do not rely only on chat to know the current version.

## Version bump rules

### Patch bump

Use patch bump when:

- fixing bugs
- tuning balance
- fixing UI text
- improving placeholder visuals
- making small internal improvements

Example:

```text
0.1.0 -> 0.1.1
```

### Minor/prototype bump

Use prototype bump when a new planned system enters the playable loop.

Examples:

```text
0.1.x -> 0.2.0  # infection added
0.2.x -> 0.3.0  # backpack/loot choice added
0.3.x -> 0.4.0  # weather added
```

### Major bump

Do not use `1.0.0` until the project is a real release candidate with:

- stable gameplay loop
- Android build pipeline
- save system
- basic polish
- release checklist
- tested installable build

## Prototype roadmap mapping

| Prototype | Build series | Meaning |
|---|---:|---|
| v0.1 | 0.1.x | Core loop, survive 3 nights |
| v0.2 | 0.2.x | Infection pressure |
| v0.3 | 0.3.x | Meaningful loot choices |
| v0.4 | 0.4.x | Weather changes rules |
| v0.5 | 0.5.x | Lightweight NPCs |
| v0.6 | 0.6.x | 7 Night MVP |

## Release notes

Every tagged playable build should have release notes.

Use:

- `docs/templates/RELEASE-NOTES.md`

Release notes should include:

- version
- date
- commit SHA
- included changes
- excluded/not yet implemented items
- validation evidence
- known issues

## Pre-release rule

All versions before `1.0.0` are unstable prototypes. Breaking changes are allowed, but they must be intentional and documented when they affect future work.
