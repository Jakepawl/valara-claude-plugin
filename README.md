# Valara - Claude Plugin

Connect Claude Code, Cowork, or any Claude product to your [Valara](https://valara.si) real-estate dashboard.

## What you get

- Browse your tours, check schedule, triage notifications, draft listing copy - all from chat
- OAuth 2.1 + PKCE with per-tool scope picking
- Sandbox / live mode toggle (sandbox is the default for first-time users)
- Per-user audit trail at https://valara.si (every tool call logged with your name + agency)

## Install in Claude Code / Cowork

```bash
claude plugin marketplace add Jakepawl/valara-claude-plugin
claude plugin install valara@valara-marketplace
```

Then in any chat, run `/valara-connect` to authorize. The first tool call will pop the consent screen.

## Install in Claude Desktop / Claude.ai / mobile

No plugin needed - paste this URL into Settings -> Connectors -> Add custom connector:

```
https://valara.si/.well-known/mcp-configuration
```

Or use this one-click install link:

```
https://claude.ai/customize/connectors?modal=add-custom-connector&connectorName=Valara&connectorUrl=https%3A%2F%2Fvalara.si%2F.well-known%2Fmcp-configuration
```

## What's inside

- 10 skills covering common workflows (browse, deep-dive, triage, draft, troubleshoot, ...)
- 2 slash commands (`/valara-status`, `/valara-connect`)
- `.mcp.json` pointing at the hosted Valara MCP server

The plugin is a thin wrapper. It contains only markdown and JSON, no executable code, and runs nothing on your machine. Guidance for how Claude should present results ships server-side with each tool response (see `_assistant_hint` in the JSON), so updates land via the Valara backend - no plugin re-install needed. That guidance only affects how results are described to you; it cannot grant additional access.

## Account required

You need a Valara account. Sign up or sign in at https://valara.si. Without one, the connection step will not complete.

## Roles supported

| Role | What you'll see |
|---|---|
| `super_admin` / `admin` | Full system across the platform |
| `media_agency` | All tours in your tenant + your team |
| `team` | Your assigned shoots |
| `broker` | All tours owned by agents in your brokerage |
| `agent` | Tours you own directly |
| `assistant` | Tours via your parent agent (writes route through them for approval) |
| `viewer` | Read-only access to shared tours |

## Permissions and scopes

When you connect, Valara's consent screen lists the scopes requested and lets you tick only the ones you want. Scopes cover reading tours, scheduling and media, and optional write actions (such as tour updates, scheduling, social posting, and billing). Sandbox mode is on by default for first-time users, so nothing touches live data until you turn it off. You can disconnect at any time from your Valara account or from Claude's connector settings.

The skills in this plugin ask Claude to confirm with you before bulk actions (for example marking many notifications read) and never to publish content without your explicit approval.

## Privacy and data handling

- The plugin itself stores nothing and sends nothing. It is manifests and skill text.
- When you use it, Claude sends tool calls to `https://valara.si/api/v1/mcp` over HTTPS with your OAuth token. Responses can include property, scheduling, client, and notification data you already have access to in Valara.
- The only network destination is valara.si. The plugin does not contact any other service.
- OAuth tokens are stored by your Claude client.
- Every tool call is logged in your Valara audit trail.
- Retention and handling of Valara account data are covered in [Valara's privacy policy](https://valara.si/legal/privacy).
- Valara is a business tool for real-estate professionals and is not intended for people under 18.

## Support

[Jacob Allen Media](https://valara.si) - support@jacoballenmedia.com

## License

MIT - see [LICENSE](./LICENSE).
