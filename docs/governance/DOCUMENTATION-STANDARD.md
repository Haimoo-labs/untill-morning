# Documentation Standard — Until Morning

## Purpose

This document defines how project documentation is written, named, updated, and trusted.

The goal is to keep the repository understandable for the owner, Claude Code, reviewers, and future contributors.

## Source of truth

Repository documentation is the source of truth.

Chat is useful for discussion, but it is not a durable project record.

If a decision, plan, scope, or rule matters later, it must be written into the repository.

## Required documentation types

### Project overview

File:

- `README.md`

Must contain:

- what the project is
- current target
- how to open/run it
- where the key docs are
- current repository status

### Claude Code instructions

File:

- `CLAUDE.md`

Must contain:

- current target
- hard rules
- technical direction
- validation requirements
- coding style
- product rule

### Game design blueprint

File:

- `docs/game-design-blueprint.md`

Must contain:

- one-line concept
- core promise
- target feeling
- product shape
- core loop
- current prototype design target
- included/excluded features
- success criterion

### MVP scope

File:

- `docs/mvp-scope.md`

Must contain:

- what the current prototype must do
- included features
- excluded features
- success criteria
- stop conditions

### Build plan

File:

- `docs/build-plan.md`

Must contain:

- phased work plan
- phase goals
- validation per phase
- explicit non-goals

### ADRs

Path:

- `docs/decisions/ADR-###-short-title.md`

Use ADRs for decisions that are expensive to reverse.

Examples:

- engine choice
- state management approach
- scene architecture
- save system
- Android export pipeline
- monetization policy
- analytics/user-data policy

### Governance docs

Path:

- `docs/governance/*.md`

Must define:

- documentation rules
- versioning rules
- change-control rules
- incident-management rules

### Templates

Path:

- `docs/templates/*.md`

Templates are used for repeatable reports and records.

## File naming

Use lowercase kebab-case for regular documentation:

```text
mvp-scope.md
build-plan.md
change-control.md
incident-management.md
```

Use ADR numbering for decisions:

```text
ADR-001-engine-choice.md
ADR-002-state-management.md
```

## Document status

Long-lived documents may include a status field when useful:

```text
Status: Draft | Active | Superseded | Archived
```

Do not keep outdated active docs. Mark them as superseded or update them.

## Documentation update rules

Update documentation when:

- scope changes
- a major feature is added or removed
- a technical decision is made
- release process changes
- build process changes
- incident process changes
- current project status changes

Do not update documentation for tiny implementation details unless they affect future work.

## Writing style

Documentation should be:

- direct
- short enough to be read
- explicit about what is included and excluded
- useful for Claude Code
- useful for a future human maintainer

Avoid:

- vague plans
- long essays without decisions
- undocumented assumptions
- outdated todo lists

## Claude Code documentation rule

When Claude Code changes behavior or scope, it must either:

1. update the relevant documentation, or
2. explicitly report that documentation was not changed and explain why.

## Documentation quality checklist

Before considering a documentation change complete, check:

- Is the document in the correct location?
- Is the title clear?
- Is the scope explicit?
- Are exclusions clear where needed?
- Does this contradict another canonical document?
- Is the document useful for the next Claude Code task?
