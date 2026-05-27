---
name: connect-and-onboard
description: First-run setup for Valara: open the consent URL, log in, tick scopes, click Allow. Triggers when the user mentions Valara without an active connection or when any Valara tool returns 401.
when_to_use: |
  - "connect Valara"
  - "set up Valara"
  - "I want to add Valara"
  - "how do I connect to Valara"
  - "Valara isn't connected"
  - first user mention of Valara with no prior tool calls
  - any Valara tool call returns 401 with no refresh token
---

# Connect to Valara

## What you're doing
Guide the user through the OAuth 2.1 + PKCE consent flow that authorizes the Valara MCP server. The dashboard handles the heavy lifting; you just walk them through 4 steps.

## Tool sequence
This skill runs BEFORE any Valara MCP tool works, so it does not call tools itself. Once consent is granted, hand off to whichever workflow skill matches what the user originally asked for (e.g. [[browse-my-properties]], [[triage-my-inbox]]).

## Steps the user takes
1. In Claude Code: run `/valara-connect` (the slash command). In Claude Desktop / Claude.ai / mobile: open Settings -> Connectors -> Add custom connector and paste `https://valara.cloud/.well-known/mcp-configuration`.
2. A browser tab opens at valara.cloud's login page. The user signs in with their Valara account.
3. The consent screen shows the requested scopes + a Sandbox-mode checkbox (default ON for first-time users).
4. The user ticks the scopes they want and clicks Allow.

## When the server returns _assistant_hint
Surface `lead_with` first (often a sandbox warning if Sandbox mode is on). Follow `interpretation` for context. Read any `anti_patterns` to the user.

## Related skills
- [[whoami-and-context]] - first call after connection succeeds
- [[troubleshoot-my-connection]] - if 401/403/refresh errors fire later

