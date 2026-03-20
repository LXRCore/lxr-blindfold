# 🐺 LXR Blindfold — Installation Guide

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## REQUIREMENTS
## ═══════════════════════════════════════════════════════

| Requirement   | Version     |
|---------------|-------------|
| RedM Server   | Latest      |
| Framework     | LXR-Core, RSG-Core, VORP Core, QBR-Core, or Standalone |
| Lua 5.4       | Required    |

---

## ═══════════════════════════════════════════════════════
## STEP 1 — DOWNLOAD & INSTALL
## ═══════════════════════════════════════════════════════

1. Download or purchase the resource from [The Lux Empire Store](https://theluxempire.tebex.io).
2. Extract/copy the `lxr-blindfold` folder into your server's `resources/` directory.
3. Add the following line to your `server.cfg`:

```
ensure lxr-blindfold
```

> ⚠️ **Do NOT rename the resource folder.** The resource name `lxr-blindfold` is protected.

---

## ═══════════════════════════════════════════════════════
## STEP 2 — CONFIGURE FRAMEWORK
## ═══════════════════════════════════════════════════════

Open `config.lua` and set your framework:

```lua
Config.Framework = 'auto' -- auto-detect, or set manually: 'lxr-core', 'rsg-core', 'vorp_core', 'qbr-core', 'standalone'
```

---

## ═══════════════════════════════════════════════════════
## STEP 3 — DATABASE ITEM SETUP
## ═══════════════════════════════════════════════════════

If `Config.blindfolditem = true`, players need a `blindfold` item in their inventory.

Import the correct SQL for your framework:

| Framework          | SQL File                      |
|--------------------|-------------------------------|
| LXR-Core / RSG-Core | `items/blindfold.sql`        |
| VORP Core          | `items/blindfold_vorp.sql`    |
| RedEM:RP           | `items/blindfold_redem.sql`   |

Add the item image (`items/blindfold.png`) to your inventory system's image folder.

---

## ═══════════════════════════════════════════════════════
## STEP 4 — RESTART SERVER
## ═══════════════════════════════════════════════════════

Restart your server or use:

```
refresh
ensure lxr-blindfold
```

Check the server console for the startup banner confirming successful load.

---

## Need Support?

- 💬 [Discord](https://discord.gg/CrKcWdfd3A)
- 🌐 [Website](https://www.wolves.land)
- 🛒 [Store](https://theluxempire.tebex.io)

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
