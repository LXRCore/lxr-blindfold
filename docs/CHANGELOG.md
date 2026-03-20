# 🐺 LXR Blindfold — Changelog

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## VERSION HISTORY
## ═══════════════════════════════════════════════════════

### v2.0.0 — Production Release

**Date:** 2026-03-20

**Added:**
- Server-side resource name protection (escrow-protected)
- Auto-detect framework support (`Config.Framework = 'auto'`)
- `Config.FrameworkSettings` with per-framework configuration
- `Config.Items` section for item configuration
- `Config.Security` section with rate limiting and anti-abuse
- `Config.Dev` section for development/testing controls
- Framework bridge (`shared/framework.lua`)
- Locale support (English `en`, Georgian `ka`)
- SQL item files for LXR/RSG, VORP, and RedEM frameworks
- Full documentation (INSTALL, CONFIG, FRAMEWORKS, EVENTS, TROUBLESHOOTING)
- Tebex templates for product distribution
- `escrow_ignore` in fxmanifest for Tebex escrow compliance
- Server startup banner with framework and version info
- Rate limiting on blindfold actions
- Player source validation on server events
- Support for QR-Core and RedEM:RP frameworks
- Extended notification messages in `Config.lang`

**Changed:**
- Resource name guard moved from `config.lua` to `server/server.lua`
- Framework detection refactored to use auto-detect pattern
- Item name now reads from `Config.Items.blindfold.name`
- `.gitignore` updated with proper distribution control entries
- Branding style updated to match lxr-proploot reference format

**Removed:**
- Resource name protection from `config.lua` (buyer-editable file)

---

### v1.0.0 — Initial Release

**Date:** 2026-01-01

- Initial blindfold system
- LXR-Core, RSG-Core, VORP Core, QBR-Core support
- Blindfold commands and item usage
- Escape mechanic
- NUI overlay

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
