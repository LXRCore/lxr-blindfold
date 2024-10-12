# LXR-Blindfold
> A blindfold script for RedM, LXRCore, QBRCore, and RSGCore frameworks

## Features
- Blindfold the nearest player
- Blindfold yourself!
- Commands to blindfold
- Item to blindfold
- Chance to break free
- Configurable features and language support for multiple frameworks!

## Commands
* /blindfold
  - adds blindfold to nearest player
* /blindfoldme
  - adds blindfold to yourself
* /unblindfold
  - removes blindfold from nearest player
* /unblindfoldme
  - removes blindfold from yourself (if you placed it on yourself)

## Installation
### Step 1: Download and Install
* Download this repo.
* Copy and paste the `lxr-blindfold` folder to `resources/lxr-blindfold`.
* Add `ensure lxr-blindfold` to your `server.cfg` file.

### Step 2: Optional Configuration for Item Usage
* _Optional (If you use an item):_ Add the SQL item from `items/blindfold.sql`.
* _Optional (If you use an item):_ Add the image to the inventory system from `items/blindfold.png`.

### Step 3: Configure Framework Support
The script supports LXRCore by default, but also works with QBRCore and RSGCore. Modify the `config.lua` if you need to change framework settings.

```lua
Config.Framework = 'lxr-core' -- or 'qbr-core', 'rsg-core'
