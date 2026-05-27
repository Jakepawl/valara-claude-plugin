---
name: whoami-and-context
description: Establish identity, role, agency, and sandbox-vs-live mode at the start of a Valara conversation. Call once per session; cache for the rest of the chat.
when_to_use: |
  - "who am I"
  - "what role am I"
  - "am I in sandbox"
  - "what agency am I"
  - first Valara tool call of a conversation (run silently before the actual ask)
---

# Whoami and context

## What you're doing
Call the `whoami` MCP tool to learn who the user is and how they're connected. Establishes context for every subsequent tool call (role determines visible tours; sandbox mode determines which database).

## Tool sequence
1. `whoami(arguments={})` - no parameters needed.

## Output format
One short sentence: "You're <name> (<role> rank <N>) at <agency>. Sandbox: <true/false>."

## When the server returns _assistant_hint
The hint's `interpretation` field gives role-rank-specific context (e.g. "as an assistant you see tours via the manager chain"). Surface it verbatim if the user asked an explicit identity question.

## Related skills
- [[browse-my-properties]] - the natural next call after identity is known
- [[troubleshoot-my-connection]] - if whoami returns 401

(If the user asks "what's sandbox mode?", surface the server's `_assistant_hint.lead_with` text verbatim - it already explains sandbox vs live in plain English.)
