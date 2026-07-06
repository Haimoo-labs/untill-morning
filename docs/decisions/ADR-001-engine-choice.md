# ADR-001 — Engine Choice

## Status

Accepted

## Decision

Use **Godot 4** with **GDScript** for the first playable prototype.

## Context

Until Morning is an Android-first 2D / 2.5D survival defence game. The early project needs fast iteration, simple scene management, readable scripts, and low overhead.

The first milestone is not commercial launch. The first milestone is proving the core loop.

## Options considered

### Godot 4

Pros:

- Good fit for 2D and lightweight 2.5D games
- Simple project structure
- GDScript is easy to iterate with Claude Code
- Good for small prototypes
- Lower overhead than Unity for this stage

Cons:

- Mobile monetization stack is less turnkey than Unity
- Commercial mobile LiveOps tooling may require more custom work later

### Unity

Pros:

- Strong commercial mobile ecosystem
- Mature IAP, Ads, analytics, and LiveOps tooling
- Large asset ecosystem

Cons:

- Heavier for this prototype
- More setup overhead
- Easier to overbuild too early

## Rationale

The project should first prove the day/night survival defence loop. Godot 4 is the better fit for this stage because it lets the team move quickly without committing to a heavy commercial mobile stack too early.

## Consequences

- Build the prototype in Godot 4.
- Keep monetization out of the early prototype.
- Re-evaluate engine choice only if the project moves toward full commercial mobile production and Godot becomes a constraint.
