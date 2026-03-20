# 🐺 LXR Blindfold — Support Response Template

> Use these templates for responding to customer support tickets.

---

## General Installation Help

Hello! Thank you for purchasing LXR Blindfold.

To install:

1. Place the `lxr-blindfold` folder in your `resources/` directory
2. Add `ensure lxr-blindfold` to your `server.cfg`
3. Set your framework in `config.lua`
4. Import the SQL for your framework from the `items/` folder
5. Restart your server

Please check the docs in the `docs/` folder for detailed guides.

If you're still having issues, join our Discord: https://discord.gg/CrKcWdfd3A

---

## Resource Name Error

If you see "RESOURCE NAME MISMATCH", the resource folder has been renamed.

Please rename the folder back to `lxr-blindfold` — this is a security requirement and cannot be changed.

---

## Framework Not Detected

Set `Config.Framework = 'auto'` in `config.lua` for automatic detection, or specify your framework manually:

```lua
Config.Framework = 'lxr-core' -- or 'rsg-core', 'vorp_core', etc.
```

Make sure your framework resource is started before `lxr-blindfold` in your `server.cfg`.

---

## Item Not Working

1. Make sure `Config.blindfolditem = true` in `config.lua`
2. Import the correct SQL file from `items/` for your framework
3. Add the `blindfold.png` image to your inventory system
4. Restart your server

---

> 🐺 wolves.land — The Land of Wolves
> © 2026 iBoss21 / The Lux Empire
