---
name: triage-my-inbox
description: Read + summarize notifications. Mark read with explicit confirmation if more than 5.
when_to_use: |
  - "my inbox"
  - "notifications"
  - "what's new"
  - "any unread"
  - "mark as read"
---

# Triage my inbox

## What you're doing
List notifications via `list_notifications`. Group by tour for readability. Mark read only with explicit confirmation when more than 5 items would be affected.

## Tool sequence
1. `list_notifications(unread_only=true, limit=50)` - default scope.
2. If user asks "mark read": `mark_notifications_read(ids=[...])` with ALL ids only if user confirmed N>5.

## Output format
Group by tour: "**Tour #hmrek1t** (1247 Oak)" then bulleted notifications under each. Actionable items first.

## When the server returns _assistant_hint
`anti_patterns` enforces things to avoid: never auto-mark read + confirm before bulk-read. Surface verbatim.

## Related skills
- [[pending-actions-and-approvals]] - for actionable=true items needing approval
- [[deep-dive-on-one-property]] - if user picks one tour from the inbox
