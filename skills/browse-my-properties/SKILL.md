---
name: browse-my-properties
description: Fleet-level view of the user's tours. Use for "what's on my plate", "this week's shoots", "all my listings".
when_to_use: |
  - "show me my tours"
  - "what's on my plate"
  - "this week's shoots"
  - "my listings"
  - "any new tours"
  - any fleet-level question (no specific address)
---

# Browse my properties

## What you're doing
List the user's tours via the `list_tours` MCP tool. Filter by state if the user gave a hint ("scheduled", "ready"). For "what's scheduled this week", combine with `get_availability` to cross-reference photographer calendars.

## Tool sequence
1. `list_tours(state=<optional>, limit=25)` - default page 25.
2. If user asked about a specific period (today/this-week), call `get_availability` and align results.

## Output format
Markdown table: Status | Address | Tour # | Next step. If more than 25 results, lead with a state-count breakdown before the table.

## When the server returns _assistant_hint
The hint's `lead_with` may flag sandbox mode; `interpretation` describes what the role sees ("media_agency: tenant-wide", "agent: your own", "assistant: via manager chain"); `format_hint` confirms the table structure.

## Related skills
- [[deep-dive-on-one-property]] - when the user picks one tour
- [[check-shoot-availability]] - when the user pivots to scheduling
- [[whoami-and-context]] - if role context isn't established yet
