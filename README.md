# Feedback Inbox

A small product feedback app used to demonstrate how I work with AI coding agents: define the product, provide durable context, let an agent break a goal into tasks, and inspect the resulting code, tests and review evidence.

**Status:** Feedback Inbox runs locally on Ruby 3.2.3, Rails 8.1.4, and SQLite. Users can submit feedback, browse the inbox, assign categories (`bug`, `feature request`, `other`), and filter the list (FR-001–FR-007 on `main`). Sample data and documentation for a reproducible demo are delivered in [goal #26](https://github.com/szymoniwacz/feedback-inbox/issues/26).

## What the app does

Users submit feedback, browse an inbox (newest first), change categories, and filter by category or view all items. The scope is deliberately small so that the engineering process is easy to follow.

This is an independent engineering demo using synthetic data only.

## Why I am building this

I want to show how I turn a short product goal into reviewable software using AI. Requirements, context, scope, validation and review need to be explicit as well as the code.

The walkthrough should take about three minutes. Its evidence is the actual [project issue #2](https://github.com/szymoniwacz/feedback-inbox/issues/2), delegated goals, pull requests, and CI results listed below.

## Delivery evidence (project #2)

| Area | Issue | Pull request |
|---|---|---|
| Runtime readiness | [#5](https://github.com/szymoniwacz/feedback-inbox/issues/5) | [#7](https://github.com/szymoniwacz/feedback-inbox/pull/7) |
| Rails scaffold | [#8](https://github.com/szymoniwacz/feedback-inbox/issues/8) | [#9](https://github.com/szymoniwacz/feedback-inbox/pull/9) |
| FR-001 Submit | [#12](https://github.com/szymoniwacz/feedback-inbox/issues/12) | [#13](https://github.com/szymoniwacz/feedback-inbox/pull/13) |
| FR-002 Browse | [#14](https://github.com/szymoniwacz/feedback-inbox/issues/14) | [#15](https://github.com/szymoniwacz/feedback-inbox/pull/15) |
| FR-003 Categorize | [#16](https://github.com/szymoniwacz/feedback-inbox/issues/16) | [#17](https://github.com/szymoniwacz/feedback-inbox/pull/17) |
| FR-004 Filter | [#18](https://github.com/szymoniwacz/feedback-inbox/issues/18) | [#19](https://github.com/szymoniwacz/feedback-inbox/pull/19) |
| FR-005 Persistence | [#20](https://github.com/szymoniwacz/feedback-inbox/issues/20) | [#21](https://github.com/szymoniwacz/feedback-inbox/pull/21) |
| FR-006 Invalid requests | [#22](https://github.com/szymoniwacz/feedback-inbox/issues/22) | [#23](https://github.com/szymoniwacz/feedback-inbox/pull/23) |
| FR-007 Tests | [#24](https://github.com/szymoniwacz/feedback-inbox/issues/24) | [#25](https://github.com/szymoniwacz/feedback-inbox/pull/25) |
| FR-008 Demo & docs | [#26](https://github.com/szymoniwacz/feedback-inbox/issues/26) | (this goal's PR) |

Independent [security checklist goal #3](https://github.com/szymoniwacz/feedback-inbox/issues/3) uses default `/execute-goal` and does not inherit project auto-merge.

## What I prepared

I used AI assistance to prepare this documentation from my project brief. I own the intended outcome, scope and review decisions.

| Preparation | Where to inspect it |
|---|---|
| Defined the product, users and purpose | [Product context](.ai/project/product-context.md) |
| Set acceptance criteria and recorded unresolved choices | [Project requirements](.ai/docs/project-requirements.md) |
| Kept the demo small with explicit non-goals | [Scope](.ai/project/scope.md) |
| Recorded decisions and their rationale | [Decision log](.ai/project/decisions.md) |
| Prepared a short goal without prescribing child tasks | [Project issue draft](docs/demo-project-issue.md) |
| Reused my workflow through the template adapter | [Workflow setup](docs/setup.md) |

## Application setup

Requires Ruby **3.2.3** (see `.ruby-version`) and Bundler.

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Open `http://localhost:3000` and use **View feedback inbox** to see seeded sample items (one per category).

**Tests**

```bash
bin/rails db:test:prepare test
```

**Database reset** (local development; reapplies schema and seeds)

```bash
bin/rails db:reset
```

Optional style check: `bin/rubocop` (not required in CI).

## Demonstration modes

| Run | Mode | What it demonstrates |
|---|---|---|
| Build the application from [project #2](https://github.com/szymoniwacz/feedback-inbox/issues/2) | `self-correcting-review auto-merge` | Task decomposition, implementation, review, correction and eligible automatic squash merges |
| Independent security checklist [goal #3](https://github.com/szymoniwacz/feedback-inbox/issues/3) | Default `/execute-goal` | A review-ready PR followed by human review and manual merge |

Project Executor selects and delegates goals. Goal Executor performs eligible merges after validation and self-correcting review. High-risk or otherwise ineligible changes still require human review.

The [demo guide](docs/demo-guide.md) describes the evidence to capture for a recorded walkthrough.

## Reusing and improving the workflow

This project is based on [ai-project-template-adapter](https://github.com/szymoniwacz/ai-project-template-adapter). It connects a public project to my private reusable workflow through the `.ai-template` Git submodule.

| Part | Responsibility |
|---|---|
| Private `ai-project-template` | Shared instructions, planning, review and executor procedures |
| Public template adapter | Setup scripts, tool entrypoints and automation loaders |
| This project | Product requirements, decisions, application code and evidence |

```bash
./scripts/update-ai-workflow.sh
./scripts/ai-workflow-doctor.sh
./scripts/check-workflow-leak.sh
git diff --submodule=log -- .ai-template
```

Setup fetches the configured upstream revision, materializes the workflow locally, and restores **tracked project documentation** over it. Add new project overlay files to Git before running setup again.

This updates the private workflow. Changes to public adapter scripts must be reviewed and incorporated separately. Private workflow files must not be committed into this public repository.

## Setup and validation

Workflow setup requires read access to the private template:

```bash
./scripts/setup-ai-workflow.sh
./scripts/ai-workflow-doctor.sh
```

Public adapter checks do not require private template access:

```bash
bash tests/test-adapter.sh
./scripts/check-workflow-leak.sh
```

CI on pull requests runs the adapter contract job and `bin/rails test` when the application is present.

Public readers can inspect project documentation and implementation evidence without private workflow access. Running the application must not require that access.

## License

This project uses the [MIT license](LICENSE), including new application code. The inherited adapter notice is retained.
