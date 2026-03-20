# 🐺 LXR Blindfold — Troubleshooting

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## COMMON ISSUES
## ═══════════════════════════════════════════════════════

### ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH

**Cause:** The resource folder has been renamed.

**Fix:** Rename the folder back to `lxr-blindfold`. This name is protected and cannot be changed.

---

### ⚠️ Unknown framework detected

**Cause:** `Config.Framework` is set to a value that doesn't match any supported framework.

**Fix:** Set `Config.Framework = 'auto'` or use one of the supported values:
- `'lxr-core'`
- `'rsg-core'`
- `'vorp_core'`
- `'redem_roleplay'`
- `'qbr-core'`
- `'qr-core'`
- `'standalone'`

---

### Blindfold item not working

**Cause:** The item hasn't been added to the database.

**Fix:**
1. Check `Config.blindfolditem` is `true`
2. Import the correct SQL from the `items/` folder for your framework
3. Add `blindfold.png` to your inventory's image folder
4. Restart the server

---

### Commands not responding

**Cause:** Commands may be disabled in config.

**Fix:** Verify in `config.lua`:
```lua
Config.blindfoldcommand     = true
Config.blindfoldselfcommand = true
```

---

### Rate limiting messages

**Cause:** A player is performing too many blindfold actions too quickly.

**Fix:** Adjust in `config.lua`:
```lua
Config.Security.maxActionsPerMinute = 10  -- increase if needed
```

---

### Escape mechanic not working

**Cause:** Escape may be disabled or key binding mismatch.

**Fix:** Verify in `config.lua`:
```lua
Config.escape.active = true
Config.escape.button = 0x760A9C6F  -- G key
```

---

## ═══════════════════════════════════════════════════════
## DEBUG MODE
## ═══════════════════════════════════════════════════════

Enable debug mode for detailed console output:

```lua
Config.Debug = true
```

For development/testing, bypass item requirements:

```lua
Config.Dev.bypassItems = true
```

---

## Need Support?

- 💬 [Discord](https://discord.gg/CrKcWdfd3A)
- 🌐 [Website](https://www.wolves.land)
- 🛒 [Store](https://theluxempire.tebex.io)

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
