# Feedback Inbox

A small product feedback app used to demonstrate how I work with AI coding agents: define the product, provide durable context, let an agent break a goal into tasks, and inspect the resulting code, tests and review evidence.

**Status:** Feedback Inbox is implemented on `main` (Ruby 3.2.3, Rails 8.1.4, SQLite). FR-001–FR-007 ship in delegated goals [#12](https://github.com/szymoniwacz/feedback-inbox/issues/12)–[#24](https://github.com/szymoniwacz/feedback-inbox/issues/24) (PRs [#13](https://github.com/szymoniwacz/feedback-inbox/pull/13)–[#25](https://github.com/szymoniwacz/feedback-inbox/pull/25)). FR-008 (sample data and documentation pass) is in progress via goal [#26](https://github.com/szymoniwacz/feedback-inbox/issues/26).

## What the app does

Users submit feedback, browse an inbox, assign a category (`bug`, `feature request` or `other`), and filter the list. The scope is deliberately small so that the engineering process is easy to follow.

This is an independent engineering demo using synthetic data.

## Why I am building this

I want to show how I turn a short product goal into reviewable software using AI. Requirements, context, scope, validation and review need to be explicit as well as the code.

The walkthrough should take about three minutes. Its evidence will be the actual project issue, delegated goals, pull requests and check results.

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

Product task decomposition is intentionally left to Project Executor.

## Application setup

Requires Ruby **3.2.3** (see `.ruby-version`) and Bundler.

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Open `http://localhost:3000` for the home page, then use **View inbox** to browse seeded synthetic feedback.

**Tests**

```bash
bin/rails db:test:prepare test
```

**Database reset** (local development)

```bash
bin/rails db:reset
```

Optional style check: `bin/rubocop` (not required in CI for the scaffold goal).

## Demonstration evidence

| Run | Mode | Evidence |
|---|---|---|
| Build the application | Project [#2](https://github.com/szymoniwacz/feedback-inbox/issues/2) with `/execute-project self-correcting-review auto-merge` | Delegated goals [#5](https://github.com/szymoniwacz/feedback-inbox/issues/5), [#8](https://github.com/szymoniwacz/feedback-inbox/issues/8), [#12](https://github.com/szymoniwacz/feedback-inbox/issues/12)–[#24](https://github.com/szymoniwacz/feedback-inbox/issues/24); merged PRs [#7](https://github.com/szymoniwacz/feedback-inbox/pull/7)–[#25](https://github.com/szymoniwacz/feedback-inbox/pull/25); CI workflow on `main` |
| Independent security checklist | Goal [#3](https://github.com/szymoniwacz/feedback-inbox/issues/3) with `/execute-goal` | Separate branch; human review and manual merge (not part of project auto-merge) |

Project Executor delegated scoped goals; Goal Executor performed eligible squash merges after self-correcting review. The [demo guide](docs/demo-guide.md) lists what to show in a walkthrough recording.

## Reusing and improving the workflow

This project is based on [ai-project-template-adapter](https://github.com/szymoniwacz/ai-project-template-adapter). It connects a public project to my private reusable workflow through the `.ai-template` Git submodule.

| Part | Responsibility |
|---|---|
| Private `ai-project-template` | Shared instructions, planning, review and executor procedures |
| Public template adapter | Setup scripts, tool entrypoints and automation loaders |
| This project | Product requirements, decisions, application code and evidence |

I can improve the shared workflow centrally and bring those improvements into this project:

```bash
./scripts/update-ai-workflow.sh
./scripts/ai-workflow-doctor.sh
./scripts/check-workflow-leak.sh
git diff --submodule=log -- .ai-template
```

Setup fetches the configured upstream revision, materializes the workflow locally, and restores **tracked project documentation** over it. Add new project overlay files to Git before running setup again. I review and commit the changed submodule reference explicitly; updates are not silently published.

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

## Current limits

Sample data and the final documentation consistency pass land with FR-008 (goal [#26](https://github.com/szymoniwacz/feedback-inbox/issues/26)). A recorded demo walkthrough and goal #3 security checklist remain optional follow-ups.

## License

This project uses the [MIT license](LICENSE), including new application code. The inherited adapter notice is retained.
