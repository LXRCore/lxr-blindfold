--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██╗     ██╗███╗   ██╗██████╗ ███████╗ ██████╗ ██╗     ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██║     ██║████╗  ██║██╔══██╗██╔════╝██╔═══██╗██║     ██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██║     ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║██║     ██║  ██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██║     ██║██║╚██╗██║██║  ██║██╔══╝  ██║   ██║██║     ██║  ██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝███████╗██║██║ ╚████║██████╔╝██║     ╚██████╔╝███████╗██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝      ╚═════╝ ╚══════╝╚═════╝

    🐺 LXR Blindfold - Player Restraint System for RedM

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    Store:       https://theluxempire.tebex.io

    ═══════════════════════════════════════════════════════════════════════════════

    Framework Support:
    - LXR Core  (Primary)
    - RSG Core  (Primary)
    - VORP Core (Supported / Legacy)
    - Standalone (Fallback)

    ═══════════════════════════════════════════════════════════════════════════════

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-blindfold"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[

        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════

        Expected: %s
        Got:      %s

        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.

        🐺 wolves.land - The Land of Wolves

        ═══════════════════════════════════════════════════════════════════════════════

    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
    4. Standalone (Fallback)

    Set to the framework your server uses:
    'lxr-core' | 'rsg-core' | 'vorp_core' | 'standalone'
]]

Config.Framework = 'lxr-core'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ESCAPE MECHANICS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Escape = {
    active   = true,
    lotonumb = {5, 6, 20},  -- Numbers 0-5000; a match breaks the blindfold free
    button   = 0x760A9C6F,  -- Button to attempt escape (default: G key)
    lang = {
        escape = 'Attempt to Break Blindfold',
        button = 'G'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE / NOTIFICATIONS ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = {
    noplayers = "No players nearby",
    noitem    = "You are out of blindfolds"
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FEATURE TOGGLES ███████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.BlindFoldCommand     = true  -- Enable /blindfold & /unblindfold commands
Config.BlindFoldSelfCommand = true  -- Enable /blindfoldme & /unblindfoldme commands
Config.BlindFoldItem        = true  -- Require a 'blindfold' item to apply a blindfold

