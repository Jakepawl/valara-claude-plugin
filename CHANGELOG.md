# Changelog

All notable changes to this plugin land here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.1.0] - 2026-05-27

### Added
- Initial plugin manifest + marketplace.json + .mcp.json pointing at https://valara.cloud
- 10 skill skeletons (connect-and-onboard, whoami-and-context, browse-my-properties, deep-dive-on-one-property, tour-state-and-next-steps, check-shoot-availability, triage-my-inbox, pending-actions-and-approvals, draft-property-content, troubleshoot-my-connection)
- 2 slash commands (/valara-status, /valara-connect)
- CI workflow with line-limit + forbidden-phrase + manifest-validation gates
- MIT license

### Architecture
- Thin-skeletons-public, rich-content-server-side per the [IP-protection design](https://valara.cloud/dev-docs/mcp-plugin-architecture) (TODO: link once published)
- Each SKILL.md stays under 80 lines; rich agent guidance arrives via `_assistant_hint` on tool responses, generated server-side per-call.
