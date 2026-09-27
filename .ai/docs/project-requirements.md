# Feedback Inbox requirements

## Purpose and current stage

Build a small feedback inbox to demonstrate AI assisted software delivery from a short project goal. This document is the source of truth for acceptance criteria. The current stage is repository and documentation preparation; application implementation has not started.

The user wants the agent to choose the implementation task breakdown. Do not preassign child tasks or manufacture execution evidence.

## Users and first useful version

A demo user submits synthetic product feedback, reads an inbox, categorizes an item and filters the list. A reviewer inspects the requirements, real issues, code, tests and review evidence.

## Functional requirements

| ID | Requirement | Acceptance |
|---|---|---|
| FR-001 | Submit feedback with a title and description | Valid input creates one item; blank fields are rejected with readable errors and preserved input |
| FR-002 | Browse feedback | Newest items appear first with a deterministic tie break; title, description, category and creation time are visible |
| FR-003 | Assign or change a category | Only `bug`, `feature request` and `other` are accepted; uncategorized submissions start as `other`; changes survive reload |
| FR-004 | Filter by category | Each category shows only its own items; All restores the full list; an empty result is explained |
| FR-005 | Persist local feedback | Created items and category changes survive application restart |
| FR-006 | Handle invalid requests | Reject unsupported category values and missing items without corrupting stored data |
| FR-007 | Provide meaningful tests | Cover valid submission, validation, categorization, category filtering and persistence at appropriate boundaries |
| FR-008 | Make the demo reproducible | Document actual setup, run and test commands; provide a small synthetic sample dataset |

Categories are a manual triage tool. No LLM integration is needed inside the application.

## Inputs and outputs

Inputs are a feedback title, description, category and filter selection. Outputs are a rendered inbox, submission and category controls, confirmation or validation errors. Storage details and length limits will be recorded during runtime bootstrap.

## Quality and boundaries

Keep implementation small and understandable. Use labelled controls, keyboard access, readable errors, escaped user text and server-side validation. Do not introduce credentials, personal information or real customer data. Use synthetic examples only.

Non-goals: authentication, organizations, voting, comments, attachments, email, analytics, automatic categorization, semantic search, microservices and production hosting. A decision to expose the app publicly requires revisiting access and abuse controls first.

Acceptance requires passing meaningful application checks and a manual submit, categorize, filter and reload walkthrough. No performance or reliability measurements are claimed before measurement.

## Workflow evidence

The project issue states the outcome. Project Executor selects scoped goals; implementation PRs retain their link to those goals. Record actual checks, review findings and human decisions. The first demo uses a Project Execution issue in `self-correcting-review auto-merge` mode; eligible delegated goals may be squash-merged after their checks and review pass. A later standalone Agent Goal uses default `/execute-goal` and stops for human review and manual merge. Neither run is started by this bootstrap. Do not start execution merely because an issue was created.

Public adapter checks already available:

```bash
bash tests/test-adapter.sh
./scripts/check-workflow-leak.sh
```

Workflow initialization additionally needs private template access. Application commands and the active stack profile do not exist yet and must be established before readiness passes.

## Assumptions and proposals

Ruby on Rails, SQLite and server-rendered HTML are proposed for a local-only demo. Confirm runtime versions and this architecture before implementation. These are not presented as prior user decisions. Szymon confirmed MIT for the entire project, including new application code.

## Project decision status

`deferred` items below do not block the current documentation task. They must be revisited at their stated trigger; they are not waived for implementation.

| Area | Status | Value / notes | Location / owner / return trigger |
|---|---|---|---|
| Product purpose | decided | Small Feedback Inbox demonstrating AI workflow | Purpose above; user brief |
| Users | decided | Demo user and engineering reviewer | Users above |
| Outcomes | decided | Understandable product and traceable delivery | Functional requirements and workflow evidence |
| Success criteria | decided | Accepted behaviour, real checks and review evidence | FR-001 through FR-008 |
| First useful version | decided | Submit, browse, categorize and filter | Functional requirements |
| Non-goals | decided | Keep a small demo | Quality and boundaries |
| Interfaces | decided | Web UI for the accepted product flows | Functional requirements |
| Inputs and outputs | decided | Feedback text, category, filter and inbox | Inputs and outputs |
| Architecture shape | deferred | Proposed single Rails application; implementation absent | Szymon, runtime bootstrap |
| Boundaries | decided | App independent of the private engineering workflow | README setup and workflow sections |
| Storage and data ownership | deferred | Proposed local SQLite containing synthetic data | Szymon, runtime bootstrap |
| Retention and migrations | deferred | Define migration and sample reset commands when storage exists | Implementing agent, before readiness |
| Integrations and failure handling | decided | No app integrations; workflow setup fails closed if unavailable | Scope and inherited adapter |
| Authentication and authorization | deferred | Proposed local-only unauthenticated demo; no hosting authorized | Szymon, before implementation |
| Secrets, privacy, and sensitive data | decided | Synthetic data only; preserve private workflow separation | Quality and boundaries |
| Language, framework, and dependencies | deferred | Rails proposed; versions and dependencies not selected | Szymon, runtime bootstrap |
| Environments and deployment | deferred | Local execution proposed; production hosting out of scope | Szymon, runtime bootstrap |
| Configuration | deferred | Establish app config when stack is selected | Implementing agent, before readiness |
| Logging, monitoring, and errors | deferred | Readable errors required; logging depends on chosen stack | Implementing agent, before readiness |
| Tests, lint, typecheck, performance | deferred | Adapter checks exist; application validation commands pending | Implementing agent, runtime bootstrap |
| Scale, reliability, and cost | decided | Small synthetic demo; no availability SLA or paid app services | Scope |
| Supported platforms and compatibility | deferred | Select and verify runtime/browser support for demo environment | Implementing agent, runtime bootstrap |
| Accessibility and localization | decided | English interface; labelled keyboard-accessible controls | Quality and boundaries |
| Compliance, backup, and recovery | not-applicable | Disposable synthetic local demo; revisit if real data is introduced | Scope |
| Branching, CI, release, and rollback | deferred | Scoped PRs; project auto-merge and separate human-review goal; Linux adapter CI supplied; remote checks and automation still require verification | Szymon and implementing agent, before readiness |
| License, ownership, and documentation expectations | decided | Szymon owns project decisions; MIT confirmed for all project code; maintain setup and validation documentation | LICENSE, README and decision log |

## Project readiness

| Check | Result | Notes |
|---|---|---|
| Definition coverage complete | Yes | Every decision area classified |
| No `blocking-question` remains | Yes | Future choices explicitly deferred for documentation stage |
| All `deferred` items have reason and return trigger | Yes | Implementation and target configuration do not exist yet; triggers above |
| Template customization complete | Partial | Project documents prepared; target automation and runtime pending |
| Stack profile selected or marked N/A | Pending | Stack proposal not confirmed |
| Real project commands recorded | Partial | Adapter commands only |
| Root README describes the product | Yes | Includes honest current state |
| `AGENTS.md` describes repository role | Yes | Thin entrypoint retained |
| Bootstrap markers removed | Yes | Supplied project placeholders replaced |
| License and ownership decided | Yes | MIT explicitly confirmed by Szymon |
| CI, branch rules, and approvals decided | Partial | Two demo modes documented; target automation unverified |
| Project ready for first product task | No | Complete runtime bootstrap and automation verification first |

This gate deliberately remains incomplete. Do not claim a working app or start product implementation based on this document alone.
