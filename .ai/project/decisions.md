# Project decisions

| Date | Decision | Rationale and status |
|---|---|---|
| 2026-09-27 | Use Feedback Inbox | Selected in the project discussion; small and understandable product behaviour |
| 2026-09-27 | Use `ai-project-template-adapter` | User requested adapter reuse and an explanation of workflow updates |
| 2026-09-27 | Keep reusable workflow private and product context public | Preserve the adapter's separation and leak checks |
| 2026-09-27 | Keep the project issue short | User wants the agent to perform task decomposition |
| 2026-09-27 | Describe evidence honestly | Distinguish completed preparation from future execution |
| 2026-09-27 | MIT for the project and new application code | Explicitly confirmed by Szymon |
| 2026-09-27 | Demonstrate two execution modes | Project run with eligible automatic squash merges and independent security-checklist goal #3 with human review and manual merge; concurrent where executor coordination permits |
| 2026-09-27 | Linux adapter CI for this demo | No native platform application is in scope; one runner avoids an unnecessary matrix |

## Proposals before application implementation

| Proposal | Rationale | Owner / return trigger |
|---|---|---|
| Ruby on Rails, SQLite, server-rendered HTML | Familiar stack with few moving parts | Szymon, before runtime bootstrap |
| Local-only execution, synthetic data, no authentication | Bounded demo; hosting needs a separate access decision | Szymon, before implementation |

These proposals do not constitute a completed project readiness gate.
