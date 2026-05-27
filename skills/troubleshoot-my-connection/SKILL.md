---
name: troubleshoot-my-connection
description: Diagnose any Valara MCP error. The server's structured remediation field carries the fix - surface it verbatim.
when_to_use: |
  - "Valara isn't working"
  - "I got an error"
  - "permission denied"
  - "scope missing"
  - "rate limit"
  - any tool returns 401/403/429/400 with a remediation field
---

# Troubleshoot my connection

## What you're doing
Read the server's structured error response. The `error.data.remediation` field contains the plain-English fix - your job is to surface it verbatim and link to the right next step.

## Tool sequence
This skill does not directly call tools - it interprets error responses from other tool calls.

## Reading the error envelope
JSON-RPC errors come in the shape:

```json
{ "error": { "code": <int>, "message": "<short>", "data": { "remediation": "<plain English>" } } }
```

Read `error.data.remediation` and surface it. If the message references re-connecting, hand off to [[connect-and-onboard]].

## When the server returns _assistant_hint
On errors, the server attaches no `_assistant_hint` (it's a successful-response field). The `remediation` field is the equivalent.

## Related skills
- [[connect-and-onboard]] - when a 401/refresh issue requires re-connecting
- [[whoami-and-context]] - to confirm what state the user is in after a fix
- [[pending-actions-and-approvals]] - when a 403 was a manager-chain rejection
