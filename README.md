<img src="https://raw.githubusercontent.com/LXRCore/.github/main/profile/lxrcore-logo.png" alt="LXRCore" width="72" align="left" style="margin-right:12px">

# lxr-blindfold — A cloth over the eyes, for LXRCore

A strip of dark cloth tied over someone's eyes. It needs the `blindfold`
item, the other person in reach and restrained (cuffed by the law or tied
with rope) unless the config says otherwise. The server keeps who is
blindfolded in a state bag; the blindfolded see the dark and lose aim; the
one who tied it takes it off — or, after a while and with free hands, the
blindfolded pull it off themselves.

![The dark](docs/img/dark.png)

## What it does

* Options on people through lxr-interact: **Blindfold** (needs the item,
  taken from the satchel) and **Take the blindfold off** (the item comes
  back to whoever removes it).
* `Player(src).state.blindfolded` for every resource that shows names or
  overlays; `lxr:blindfold:changed (src, on, by)`.
* `Config.Blindfold.onlyRestrained` reads the `cuffed` (lxr-lawman) and
  `tied` (lxr-lasso) state bags.
* Self-removal after `selfRemoveAfterMs` with the X key, never with tied hands.

## Install

```cfg
ensure lxr-core
ensure lxr-interact
ensure lxr-blindfold
```

## API

| Name | Side | Purpose |
|---|---|---|
| `IsBlindfolded(src)` · `Set(src, on)` | server | hooks |
| `IsBlindfolded()` | client | local mirror |

## Licence

© 2026 iBoss21 / LXRCore — All Rights Reserved. See `LICENSE`.
