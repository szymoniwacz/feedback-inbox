# Architecture Direction

## Purpose

Describe the intended architecture before implementation starts.

## System shape

Single-process **Ruby on Rails** web application with **server-rendered HTML**
and **SQLite** persistence. Local-only demo: one operator runs the app on their
machine with synthetic feedback data. No separate API service, job workers, or
microservices in v1.

## Main boundaries

| Boundary | Responsibility |
|---|---|
| HTTP / controllers | Request handling, parameter permitting, redirects and flash |
| Domain models | Feedback records, category validation (`bug`, `feature request`, `other`) |
| Persistence | SQLite via Active Record; migrations and seed/sample data |
| Views | Accessible forms, inbox list, filters, error presentation (escaped output) |
| Engineering workflow | Private `.ai/` materialization and automation; not part of app runtime |

External integrations, authentication, and LLM features stay outside the
application boundary for this project.

## Design principles

- Small first version aligned with FR-001–FR-008
- Server-side validation as source of truth; usable forms after errors
- Explicit, testable boundaries (models and request/integration tests)
- Deterministic ordering and filtering behaviour
- Documentation and decisions updated with each scoped goal

## Open questions

Resolved at readiness (no application scaffold yet):

- Stack: Rails + SQLite + server-rendered HTML (see `.ai/project/decisions.md`)
- Local-only, unauthenticated use with synthetic data only

Deferred to the first scaffold-producing goal:

- Exact Ruby and Rails versions and gem choices
- Application setup, run, test, and lint commands recorded in README and stack profile
- Migration and sample-data reset commands once `db/` exists
- Browser/runtime versions verified against the demo environment
