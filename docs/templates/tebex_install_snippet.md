# 🐺 LXR Blindfold — Quick Install Snippet

> Copy-paste this into your Tebex product installation instructions.

---

## Installation

1. Download and extract the resource
2. Place `lxr-blindfold` into your server's `resources/` folder
3. Add to `server.cfg`:
   ```
   ensure lxr-blindfold
   ```
4. Set your framework in `config.lua`:
   ```lua
   Config.Framework = 'auto' -- or 'lxr-core', 'rsg-core', 'vorp_core', etc.
   ```
5. If using item mode (`Config.blindfolditem = true`):
   - Import the SQL from `items/blindfold.sql` (or the framework-specific variant)
   - Add `blindfold.png` to your inventory images
6. Restart your server

> ⚠️ Do NOT rename the resource folder. It must remain `lxr-blindfold`.

**Support:** https://discord.gg/CrKcWdfd3A

---

> © 2026 iBoss21 / The Lux Empire | wolves.land
