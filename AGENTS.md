# Agent Instructions

This is Feedback Inbox, a small product application and AI engineering workflow demonstration. The Rails app on `main` delivers FR-001–FR-008 (submit, browse, categorize, filter, persistence, tests, and reproducible demo seeds). Product context lives in `.ai/project/` and `.ai/docs/project-requirements.md`; delivery evidence is in [project issue #2](https://github.com/szymoniwacz/feedback-inbox/issues/2) and the README delivery table.

This repository uses a private reusable AI workflow through the `.ai-template` submodule.

If `.ai/README.md` is not available, run `./scripts/setup-ai-workflow.sh` first. If the private workflow cannot be loaded, stop rather than inventing replacement workflow rules.

After setup, `.ai/` is the source of truth for workflow, policies, skills, review rules, Git rules, and automation instructions.

Read `.ai/README.md` first. For end-to-end goals follow `.ai/skills/execute-goal.md`.

Project-specific context is tracked in `.ai/` as an overlay and must not be overwritten by reusable workflow updates.
