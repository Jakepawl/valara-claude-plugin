---
name: check-shoot-availability
description: Calendar query for shoot scheduling. Walks the manager chain for OAuth; respects user's preferred timezone.
when_to_use: |
  - "is <date> available"
  - "when can I shoot <address>"
  - "next available slot"
  - "photographer availability"
---

# Check shoot availability

## What you're doing
Query the photographer's Google Calendar via `get_availability`. The OAuth credentials live with the media_agency at the top of the manager chain; the tool walks `assistant -> agent -> media_agency` to resolve them.

## Tool sequence
1. `get_availability(start_date=<iso>, end_date=<iso>, duration_minutes=<int>)`.

## Output format
List slots as "<day name> <date> @ <time>-<time>". If empty, say so plainly. Use the user's preferred timezone (the server defaults to the media_agency's timezone per Rule 59).

## When the server returns _assistant_hint
`interpretation` may explain manager-chain resolution if it kicked in. `lead_with` flags sandbox mode (sandbox availability is fake test slots, not real bookings).

## Related skills
- [[browse-my-properties]] - to see which tours need scheduling
- [[troubleshoot-my-connection]] - if the calendar OAuth is broken (manager chain resolution failed)
