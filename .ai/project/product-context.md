# Product context

Feedback Inbox is a small application for collecting and categorizing product feedback.

The application user reviews a local inbox of synthetic feedback. The demo audience is an engineer or reviewer assessing how Szymon Iwacz uses AI agents to deliver bounded, testable work.

The engineering problem is preserving intent and quality as a short goal becomes implementation. Scope, acceptance criteria and decisions live in files that agents and reviewers can inspect without chat history.

On `main`, the app supports submitting feedback, browsing the inbox, assigning categories (`bug`, `feature request`, `other`), filtering, persistence across restart, and integration tests for the core flows. Sample seed data and documentation alignment for FR-008 are tracked in [goal #26](https://github.com/szymoniwacz/feedback-inbox/issues/26). Delivery evidence for the product build lives in [project issue #2](https://github.com/szymoniwacz/feedback-inbox/issues/2) and the README delivery table.

See [requirements](../docs/project-requirements.md), [scope](scope.md) and [decisions](decisions.md).
