# Demo guide

| Approximate time | Show | Explain |
|---|---|---|
| 0:00 to 0:30 | README and project goal | Product outcome and demo purpose |
| 0:30 to 1:00 | Requirements and decisions | Context prepared before implementation |
| 1:00 to 1:45 | Actual issue and delegated goals | How the agent divided the outcome |
| 1:45 to 2:30 | One project PR, checks and eligible auto-merge | What was reviewed and corrected, if anything |
| 2:30 to 3:00 | Working app, separate goal PR and update mechanism | Human review boundary and workflow reuse |

This is an edited walkthrough of a real run, not a claim that execution takes three minutes.

After execution, record actual URLs for the project issue, delegated goals, representative PR, validation and human review. Add a screenshot or short recording of the implemented app. Distinguish local checks from CI.

Do not manufacture failed tests or review findings. If the run has no correction cycle, say so. Record any real execution pause and its resolution.

Before starting, complete the requirements readiness gate, establish runtime commands, initialize the private workflow, run its doctor and leak check, and verify automation access and triggers. Use the materialized Project Execution issue template with the concise outcome from `demo-project-issue.md`. Creating the issue alone does not authorize execution.

## Two runs

| Run | Owner comment after readiness | Expected stopping point |
|---|---|---|
| Project Execution | `/execute-project self-correcting-review auto-merge` | Eligible goals are reviewed, validated and squash-merged; ineligible goals escalate |
| Later standalone Agent Goal | `/execute-goal` | Review-ready PR; Szymon reviews and merges |

Project Executor delegates; Goal Executor performs eligible merges. This does not require enabling GitHub's delayed auto-merge queue.

A possible later goal is marking feedback as read. It is an optional follow-up, outside the initial project. Choose it after the first run; do not create a prewritten task breakdown or start it concurrently.

Record the owner's actual trigger comments and resulting merge evidence. The commands above are reference text, not execution authorization.
