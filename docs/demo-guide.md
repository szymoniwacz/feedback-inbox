# Demo guide

| Approximate time | Show | Explain |
|---|---|---|
| 0:00 to 0:30 | README and [project #2](https://github.com/szymoniwacz/feedback-inbox/issues/2) | Product outcome and delivery evidence table |
| 0:30 to 1:00 | [Requirements](.ai/docs/project-requirements.md) and [decisions](.ai/project/decisions.md) | Context prepared before and during implementation |
| 1:00 to 1:45 | Delegated goals [#5](https://github.com/szymoniwacz/feedback-inbox/issues/5)–[#26](https://github.com/szymoniwacz/feedback-inbox/issues/26) | How Project Executor divided the outcome |
| 1:45 to 2:30 | A representative product PR (e.g. [#13](https://github.com/szymoniwacz/feedback-inbox/pull/13) or [#25](https://github.com/szymoniwacz/feedback-inbox/pull/25)), checks and eligible auto-merge | What was reviewed and corrected, if anything |
| 2:30 to 3:00 | Working app after `db:seed`, [goal #3](https://github.com/szymoniwacz/feedback-inbox/issues/3) PR boundary | Human review boundary and workflow reuse |

This is an edited walkthrough of a real run, not a claim that execution takes three minutes.

## Recorded evidence checklist

After execution, capture:

- [Project issue #2](https://github.com/szymoniwacz/feedback-inbox/issues/2) with `/execute-project self-correcting-review auto-merge`
- Delegated goals and merged PRs (see README delivery table)
- [CI workflow](https://github.com/szymoniwacz/feedback-inbox/actions) on `main` for the latest product merge
- Screenshot or short recording: submit, categorize, filter, and (optionally) restart persistence per [requirements](.ai/docs/project-requirements.md)

Distinguish local checks from CI. Do not manufacture failed tests or review findings.

## Local demo commands

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Open `http://localhost:3000`, use **View feedback inbox**, and confirm one seeded item per category without manual data entry.

Validation run before recording:

```bash
bin/rails db:test:prepare test
bash tests/test-adapter.sh
./scripts/check-workflow-leak.sh
```

## Two runs

| Run | Owner comment after readiness | Expected stopping point |
|---|---|---|
| Project Execution | `/execute-project self-correcting-review auto-merge` | Eligible goals are reviewed, validated and squash-merged; ineligible goals escalate |
| Independent security checklist goal #3 | `/execute-goal` | Review-ready PR; Szymon reviews and merges |

Project Executor delegates; Goal Executor performs eligible merges. This does not require enabling GitHub's delayed auto-merge queue.

The human-review example is [goal #3](https://github.com/szymoniwacz/feedback-inbox/issues/3): a short security checklist in `docs/security-review.md`. Project [#2](https://github.com/szymoniwacz/feedback-inbox/issues/2) must not modify that file. Each run uses an isolated workspace and branch.

Review the checklist for relevance, correct links, accurate private-workflow boundaries and honest status labels. Do not insert deliberate defects to manufacture review feedback.

Record the owner's actual trigger comments and resulting merge evidence. The commands above are reference text, not execution authorization.
