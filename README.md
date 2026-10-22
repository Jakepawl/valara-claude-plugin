# Valara - Claude Plugin

Connect Claude Code, Cowork, or any Claude product to your [Valara](https://valara.si) real-estate dashboard.

## What you get

- Browse your tours, check schedule, triage notifications, draft listing copy - all from chat
- OAuth 2.1 + PKCE with per-tool scope picking
- Sandbox / live mode toggle (sandbox is the default for first-time users)
- Per-user audit trail at https://valara.si (every tool call logged with your name + agency)

## Install in Claude Code / Cowork

This repo is PRIVATE. Before running `claude plugin marketplace add`, authenticate the GitHub CLI so Claude can clone it:

```bash
gh auth login   # interactive; needs the 'repo' scope
# OR set GITHUB_TOKEN in your shell env to a token with 'repo' scope
```

Then install:

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

The plugin is a thin wrapper. The rich agent guidance ships server-side with each tool response (see `_assistant_hint` in the JSON), so updates land via the Valara backend - no plugin re-install needed.

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

## Privacy

This plugin only stores its manifests + skill descriptions locally - it doesn't transmit anything itself. All Valara queries go to `valara.si` over HTTPS with your OAuth token; tokens are stored in your OS keychain by Claude Code. See [Valara's privacy policy](https://valara.si/legal/privacy) for what the dashboard does with your data.

## License

MIT - see [LICENSE](./LICENSE).

## Maintainer

[Jacob Allen Media](https://valara.si) - support@jacoballenmedia.com
