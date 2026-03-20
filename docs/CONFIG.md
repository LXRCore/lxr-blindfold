# 🐺 LXR Blindfold — Configuration Reference

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## CONFIG.LUA — BUYER CONTROL PANEL
## ═══════════════════════════════════════════════════════

All user-tunable settings are located in `config.lua`.

---

### Config.ServerInfo

Server branding and contact information.

```lua
Config.ServerInfo = {
    name        = 'The Land of Wolves 🐺',
    website     = 'https://www.wolves.land',
    discord     = 'https://discord.gg/CrKcWdfd3A',
    store       = 'https://theluxempire.tebex.io',
    developer   = 'iBoss21 / The Lux Empire',
}
```

---

### Config.Framework

Set the active framework. Use `'auto'` for automatic detection.

```lua
Config.Framework = 'auto'
-- Options: 'auto', 'lxr-core', 'rsg-core', 'vorp_core', 'redem_roleplay', 'qbr-core', 'qr-core', 'standalone'
```

---

### Config.FrameworkSettings

Per-framework resource names, inventory systems, and event naming conventions.

---

### Feature Flags

```lua
Config.blindfoldcommand     = true  -- Enable /blindfold and /unblindfold
Config.blindfoldselfcommand = true  -- Enable /blindfoldme and /unblindfoldme
Config.blindfolditem        = true  -- Require a 'blindfold' item
```

---

### Config.Items

Item configuration for the blindfold.

```lua
Config.Items = {
    blindfold = {
        name  = 'blindfold',
        label = 'Blindfold',
        limit = 10,
        type  = 'item_standard',
    },
}
```

---

### Config.escape

Escape mechanic settings.

```lua
Config.escape = {
    active   = true,           -- Enable escape attempts
    lotonumb = {5, 6, 20},    -- Winning numbers (0–5000)
    button   = 0x760A9C6F,    -- G key hash
}
```

---

### Config.lang

Notification messages.

```lua
Config.lang = {
    noplayers   = "No players nearby",
    noitem      = "You are out of blindfolds",
    blindfolded = "You have been blindfolded",
    -- ... see config.lua for full list
}
```

---

### Config.Security

Server-side anti-abuse settings.

```lua
Config.Security = {
    enabled             = true,
    maxDistance          = 3.0,
    maxActionsPerMinute = 10,
    logSuspiciousActivity = true,
}
```

---

### Config.Debug / Config.Dev

```lua
Config.Debug = false

Config.Dev = {
    printEvents    = false,
    bypassItems    = false,
    forceFramework = nil,
}
```

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
