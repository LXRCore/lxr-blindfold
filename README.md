# 🐺 LXR Blindfold
> **Player Restraint System for RedM** — The Land of Wolves  
> **Author:** iBoss21 / The Lux Empire · **Store:** [theluxempire.tebex.io](https://theluxempire.tebex.io) · **Discord:** [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)

---

## Features
- Blindfold the nearest player
- Blindfold yourself
- Commands and item-based blindfold support
- Chance to break free (configurable)
- Multi-framework support: **LXR-Core** (primary), **RSG-Core** (primary), **VORP Core** (supported)
- Fully configurable features and language strings

## Commands
| Command | Description |
|---------|-------------|
| `/blindfold` | Apply blindfold to the nearest player |
| `/unblindfold` | Remove blindfold from the nearest player |
| `/blindfoldme` | Apply a blindfold to yourself |
| `/unblindfoldme` | Remove your self-applied blindfold |

## Installation

### Step 1 — Download & Install
1. Download this resource.
2. Place the `lxr-blindfold` folder into your `resources/` directory.
3. Add `ensure lxr-blindfold` to your `server.cfg`.

### Step 2 — Framework Configuration
Open `config.lua` and set your framework:

```lua
Config.Framework = 'lxr-core'  -- 'lxr-core' | 'rsg-core' | 'vorp_core'
```

### Step 3 — Optional: Item Support
- Add the SQL from `items/blindfold.sql` to your database.
- Add `items/blindfold.png` to your inventory image folder.
- Ensure `Config.BlindFoldItem = true` in `config.lua`.

## Configuration Reference

```lua
Config.Framework          = 'lxr-core'  -- Framework to use
Config.BlindFoldCommand   = true         -- Enable /blindfold & /unblindfold
Config.BlindFoldSelfCommand = true       -- Enable /blindfoldme & /unblindfoldme
Config.BlindFoldItem      = true         -- Require item to apply blindfold

Config.Escape = {
    active   = true,
    lotonumb = {5, 6, 20},   -- Lucky numbers that break the blindfold (0–5000)
    button   = 0x760A9C6F,   -- Key to attempt escape (G)
}
```

---

© 2026 iBoss21 / The Lux Empire | [wolves.land](https://www.wolves.land) | All Rights Reserved
