---
name: draft-property-content
description: AI caption drafting for social / MLS / email. Always verify specs via get_tour_details first; require explicit user confirmation before any publishing step.
when_to_use: |
  - "draft a caption"
  - "write the description"
  - "social copy for <tour>"
  - "MLS blurb"
  - "email blast text"
---

# Draft property content

## What you're doing
Use the `draft_property_caption` MCP tool to generate copy in one of three styles: `social`, `mls`, or `email`. Always pull `get_tour_details` first so the spec data is canonical.

## Tool sequence
1. `get_tour_details(tour_number=<n>)` - to feed real specs (never fabricate).
2. `draft_property_caption(tour_number=<n>, style=<social|mls|email>)`.
3. If user asks for iteration (different style or length), re-call `draft_property_caption` with a refined parameter (the server's prompt is tuned for the dashboard's voice; the agent should NOT edit output locally).

## Output format
Present the draft inside a quoted block. After it, ask whether to iterate or use as-is.

## When the server returns _assistant_hint
`anti_patterns` lists things to avoid - always includes the no-auto-publish rule. `format_hint` confirms the style's length default (social ~100-150 chars, mls 250-400 words, email 50-100 words).

## Related skills
- [[deep-dive-on-one-property]] - for context if needed (the deep-dive's `get_property_website` call returns the public URL to compare against, if one exists)
