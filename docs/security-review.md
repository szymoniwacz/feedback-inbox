# Security review checklist — Feedback Inbox

**Baseline:** requirements and adapter documentation at commit [`fb7e767`](https://github.com/szymoniwacz/feedback-inbox/commit/fb7e767) on `main` (bootstrap merged). **Application code does not exist yet**; this is a pre-implementation checklist, not an audit or penetration test.

**Legend:** **Req** = stated in [project requirements](../.ai/docs/project-requirements.md) or [scope](../.ai/project/scope.md). **Assumption** = proposed stack or demo posture not yet implemented. **Not run** = no code or environment to verify yet.

## Adapter and workflow boundary

The public repository must not publish private reusable workflow content.

| What is tracked in Git | What must stay out of Git |
|---|---|
| `.gitmodules` and the `.ai-template` gitlink (pinned submodule revision) | Copied trees from the private template outside `.ai-template/` |
| Project-owned overlay under `.ai/` (allowlisted paths such as [product context](../.ai/project/product-context.md), requirements, scope, decisions) | Materialized reusable `.ai/**` files, `.agents/skills/`, `.cursor/commands/` from setup |
| Public adapter docs ([repository specification](repository-specification.md), [setup](setup.md)) | Submodule credentials, PATs, or local auth material |

**Verification (Req):** after `./scripts/setup-ai-workflow.sh`, run `./scripts/check-workflow-leak.sh` and confirm it passes with only allowlisted `.ai/**` tracked. Review `git status` before commit; submodule content stays under `.ai-template/` only.

## Checklist

| Concern | Risk | Expected safeguard | Verification step | Status |
|---|---|---|---|---|
| Untrusted feedback (XSS) | Stored title/description rendered as HTML could execute script in a reviewer’s browser. | Escape or encode all user-controlled text at output; prefer safe templating defaults; never treat inbox text as HTML. | **Req:** acceptance calls for escaped user text. When UI exists: submit `<script>alert(1)</script>` and literal HTML entities; confirm no execution and visible encoding. **Not run** (no app). | Req |
| Server-side input validation | Client-only checks allow forged requests; blank or oversized fields corrupt UX or storage. | Validate title and description on the server; reject blank required fields with readable errors and preserved input (**FR-001**). | Integration/request tests for blank fields; manual POST bypassing the browser. **Not run**. | Req |
| Category validation | Invalid categories could corrupt data or bypass filters (**FR-003**, **FR-006**). | Accept only `bug`, `feature request`, `other`; default new items to `other`; reject unknown values without corrupting stored rows. | Tests for each allowed value, rejected value, and filter consistency (**FR-004**). **Not run**. | Req |
| Secrets and sensitive data | Real credentials or PII in repo, config, or sample data. | Synthetic demo data only; no app credentials; private workflow auth only in automation/runtime secrets, never committed (**Req** in requirements quality section). | Grep tracked files for key-like patterns; confirm `.env*` and workflow leak checks; review sample data before merge. **Partial:** adapter leak script on CI; app N/A. | Req + partial |
| Private workflow boundary | Accidental commit of materialized private instructions exposes internal process. | Tracking boundary per [repository specification](repository-specification.md) §7; ignore rules for materialized paths; leak check in CI. | Run `check-workflow-leak.sh` locally and on PR; inspect diff for paths outside allowlist. **Req** on adapter; re-run on app PRs that touch `.gitignore` or scripts. | Req |
| Unauthenticated local use | Anyone with network access to a shared or exposed instance can read/write all feedback. | **Assumption:** local-only demo without login until hosting is explicitly authorized; revisit abuse controls before any public deployment (**Req** non-goals). | Document bind address and firewall posture in README when app exists; do not expose without threat review. **Not run**. | Assumption |

## Relative link sanity

From this file’s directory (`docs/`), these requirement links were chosen for review context: [project requirements](../.ai/docs/project-requirements.md), [scope](../.ai/project/scope.md), [product context](../.ai/project/product-context.md). Validate with:

```bash
test -f .ai/docs/project-requirements.md .ai/project/scope.md .ai/project/product-context.md
```

## Open questions (material only)

1. **Stack confirmation:** Rails/SQLite is proposed (**Assumption** in requirements); confirm versions at runtime bootstrap before treating framework defaults as security controls.
2. **Field length limits:** Deferred until storage exists; define upper bounds to reduce DoS via huge payloads in local SQLite.
3. **CSRF:** Server-rendered forms will need session/CSRF strategy once implemented; not specified in bootstrap requirements.

## Review focus for PR

- Checklist matches issue #3 acceptance criteria without inventing findings.
- Only `docs/security-review.md` changed; links resolve from `docs/`.
- No claim of completed app security testing.
