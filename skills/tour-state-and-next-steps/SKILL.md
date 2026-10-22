---
name: tour-state-and-next-steps
description: Diagnose what's blocking a tour and what the user should do next.
when_to_use: |
  - "what's next for <tour>"
  - "why is <tour> stuck"
  - "what do I need to do for <address>"
  - "is <tour> ready to publish"
---

# Tour state and next steps

## What you're doing
Translate a tour's current state into a clear "here's what's blocking it / here's what to do next" answer. The server-side hint carries the state-machine narration; you mostly forward it.

## Tool sequence
1. `get_tour_details(tour_number=<n>)` - primary call.

## Output format
Two short paragraphs: "Where it is" + "What's next". If the next step requires the dashboard UI (not an MCP tool), include the deep link `https://valara.si/manage/tours/edit/<tour_number>`.

## When the server returns _assistant_hint
`interpretation` carries the canonical state-machine narration - surface it verbatim. `format_hint` confirms the two-paragraph structure.

## Related skills
- [[deep-dive-on-one-property]] - if user wants more context
- [[check-shoot-availability]] - if next step is rescheduling
- [[draft-property-content]] - if next step is writing captions
