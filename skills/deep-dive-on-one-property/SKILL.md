---
name: deep-dive-on-one-property
description: Full record for ONE Valara tour - state, schedule, media, public URL, recent activity.
when_to_use: |
  - "tell me about <address>"
  - "what's the status of <tour>"
  - "is <address> ready"
  - "show me the listing for <address>"
  - "what's happening with tour #<n>"
---

# Deep-dive on one property

## What you're doing
Pull the full record for one Valara tour the user named (by address or tour number) and interpret its state in plain English.

## Tool sequence
1. If the user gave an address (not a tour number), call `list_tours(address_contains=<phrase>, limit=5)`. If multiple matches, ask the user to pick. If one match, use its tour_number.
2. `get_tour_details(tour_number=<n>)` - the primary call.
3. If the state suggests a public page exists (`media_uploaded`, `ready`, `archived`), call `get_property_website(tour_number=<n>)`.

## Output format
Lead with a plain-English status sentence. Then: Status | Address | Tour # | Photographer | Public page | Recent activity (last 3-5 entries).

## When the server returns _assistant_hint
`interpretation` gives state-machine narration (e.g. "media_uploaded means awaiting user approval"). `anti_patterns` may flag specific don'ts for this tour (e.g. don't draft captions yet). `lead_with` flags sandbox mode if applicable.

## Related skills
- [[browse-my-properties]] - back to fleet view
- [[tour-state-and-next-steps]] - if user asks "what next"
- [[draft-property-content]] - if user pivots to writing copy
- [[triage-my-inbox]] - if user asks about notifications for this tour
