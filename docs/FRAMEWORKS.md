# 🐺 LXR Blindfold — Framework Support

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## SUPPORTED FRAMEWORKS
## ═══════════════════════════════════════════════════════

| Framework       | Priority  | Status              | Notes                      |
|-----------------|-----------|---------------------|----------------------------|
| LXR-Core        | Primary   | ✅ Fully Supported  | Recommended                |
| RSG-Core        | Primary   | ✅ Fully Supported  |                            |
| VORP Core       | Legacy    | ✅ Supported        | Legacy support             |
| RedEM:RP        | Optional  | ✅ Supported        | If detected                |
| QBR-Core        | Optional  | ✅ Supported        | If detected                |
| QR-Core         | Optional  | ✅ Supported        | If detected                |
| Standalone      | Fallback  | ✅ Basic Support    | Minimal functionality      |

---

## ═══════════════════════════════════════════════════════
## AUTO-DETECTION
## ═══════════════════════════════════════════════════════

When `Config.Framework = 'auto'`, the system detects frameworks in this order:

1. `lxr-core`
2. `rsg-core`
3. `vorp_core`
4. `redem_roleplay`
5. `qbr-core`
6. `qr-core`
7. `standalone` (fallback)

The first framework found running will be used.

---

## ═══════════════════════════════════════════════════════
## MANUAL OVERRIDE
## ═══════════════════════════════════════════════════════

To force a specific framework:

```lua
Config.Framework = 'rsg-core' -- or any supported framework name
```

---

## ═══════════════════════════════════════════════════════
## FRAMEWORK-SPECIFIC ITEM SQL
## ═══════════════════════════════════════════════════════

| Framework            | SQL File                    |
|----------------------|-----------------------------|
| LXR-Core / RSG-Core  | `items/blindfold.sql`      |
| VORP Core            | `items/blindfold_vorp.sql`  |
| RedEM:RP             | `items/blindfold_redem.sql` |

---

## ═══════════════════════════════════════════════════════
## BRIDGE ARCHITECTURE
## ═══════════════════════════════════════════════════════

The framework bridge (`shared/framework.lua`) provides:

- `Framework.Detect()` — Detect and set the active framework
- `Framework.GetSettings()` — Get framework-specific settings from config
- `Framework.Log()` — Debug logging
- `Framework.Warn()` — Warning output
- `Framework.Error()` — Error output

Server-side helpers handle framework-specific inventory and notification calls.

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
