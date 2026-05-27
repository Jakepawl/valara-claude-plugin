---
name: pending-actions-and-approvals
description: Items routed for the user's approval (manager-chain write requests, scheduled changes, etc.). Cautious bulk handling.
when_to_use: |
  - "what needs my approval"
  - "pending requests"
  - "anything waiting on me"
  - "approve <something>"
---

# Pending actions and approvals

## What you're doing
List notifications where `actionable=true` (server-side filter). These represent write requests routed from assistants to their parent agent, or other approval-gated state changes.

## Tool sequence
1. `list_notifications(actionable_only=true)` - server returns only the actionable subset.

## Output format
Table: Requester | Request | Tour # | Action needed. Lead with count.

## When the server returns _assistant_hint
`interpretation` clarifies the manager-chain context (who requested what, why it's gated). `anti_patterns` lists things to avoid - typically "confirm before bulk approve".

## Related skills
- [[deep-dive-on-one-property]] - to inspect the affected tour before approving
- [[troubleshoot-my-connection]] - if an approval action returns 403
