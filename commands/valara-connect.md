---
name: valara-connect
description: Trigger the Valara OAuth consent flow (or re-trigger if a token expired or scope is missing).
---

If the `valara` MCP server is registered but the user has no active OAuth token, the next tool call will trigger consent automatically. Run `whoami` first as a no-op call to force the OAuth handshake. If consent is already granted but a scope is missing, the response will be a `scope_missing` error - surface its `error.data.remediation` field verbatim and instruct the user to disconnect + reconnect with the broader scope ticked.

Reference: the `connect-and-onboard` skill in this plugin covers the user-facing flow.
