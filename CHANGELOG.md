# Changelog

All notable changes to this plugin land here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.1.5] - 2026-11-05

### Changed
- Plugin icon (`assets/icon.png`) replaced with the Valara mark: black V on a white background, 512x512. The previous file was a flat blue placeholder.

## [0.1.4] - 2026-11-05

### Fixed
- `connect-and-onboard` SKILL.md: quoted the `description` frontmatter value. The unquoted colon made the YAML fail to parse, so the skill loaded with empty metadata.

### Changed
- Added `privacyPolicyUrl` to `plugin.json`.
- README rewritten for public distribution: removed the private-repo install steps and added plain-language data handling and scope disclosures for the plugin directory.

## [0.1.3] - 2026-10-22

### Changed
- Platform host moved from valara.cloud to valara.si: MCP server URL is now `https://valara.si/api/v1/mcp` (`.mcp.json` and the plugin manifest), and all links, homepage and onboarding text use valara.si. valara.cloud still answers, but a connector added here now authorizes against valara.si, so existing users are asked to sign in again after updating the plugin.

## [0.1.2] - 2026-07-06

### Fixed
- MCP server URL repointed from the legacy `https://valara.cloud/api/v1/mcp/api` transport (removed server-side 2026-06-23) to the canonical `https://valara.cloud/api/v1/mcp` in `.mcp.json` + `.claude-plugin/plugin.json`. The legacy URL now returns HTTP 403, which broke OAuth connect: consent completed in the browser but no access token was ever issued, so connections never appeared on /manage/integrations/ai.
- `.claude-plugin/marketplace.json` version pin aligned with `plugin.json` (was stuck at 0.1.0 while plugin.json said 0.1.1).

## [0.1.0] - 2026-05-27

### Added
- Initial plugin manifest + marketplace.json + .mcp.json pointing at https://valara.cloud
- 10 skill skeletons (connect-and-onboard, whoami-and-context, browse-my-properties, deep-dive-on-one-property, tour-state-and-next-steps, check-shoot-availability, triage-my-inbox, pending-actions-and-approvals, draft-property-content, troubleshoot-my-connection)
- 2 slash commands (/valara-status, /valara-connect)
- Local pre-push git hook (`.githooks/pre-push`) running line-limit + forbidden-phrase + manifest-validation gates + auto-sync of skills into the sibling `valara-codex-plugin` clone when skill changes ship
- `scripts/install-hooks.sh` (one-time setup pointing git at `.githooks/`)
- `scripts/release.sh` (manual release flow, also a `DRY_RUN=1`-able local validator)
- MIT license

### Architecture
- Thin-skeletons-public, rich-content-server-side per the [IP-protection design](https://valara.cloud/dev-docs/mcp-plugin-architecture) (TODO: link once published)
- Each SKILL.md stays under 80 lines; rich agent guidance arrives via `_assistant_hint` on tool responses, generated server-side per-call.
