--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    🐺 LXR Core - Blindfold System
    Restraint & Roleplay Immersion for RedM

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:    The Land of Wolves 🐺
    Developer: iBoss21 / The Lux Empire
    Website:   https://www.wolves.land
    Discord:   https://discord.gg/CrKcWdfd3A
    Store:     https://theluxempire.tebex.io

    ═══════════════════════════════════════════════════════════════════════════════

    Version: 2.0.0
    Performance Target: Optimized for minimal server overhead and client FPS impact

    Framework Support:
    - LXR Core  (Primary)
    - RSG Core  (Primary)
    - VORP Core (Supported / Legacy)
    - QBR Core  (Optional)
    - Standalone (Fallback)

    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════

    Script Author: iBoss21 / The Lux Empire for The Land of Wolves

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
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name      = 'The Land of Wolves 🐺',
    developer = 'iBoss21 / The Lux Empire',
    website   = 'https://www.wolves.land',
    discord   = 'https://discord.gg/CrKcWdfd3A',
    store     = 'https://theluxempire.tebex.io',
    github    = 'https://github.com/iBoss21',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
    4. QBR-Core  (Optional)
    5. Standalone (Fallback)
]]

Config.Framework = 'lxr-core' -- 'lxr-core' | 'rsg-core' | 'vorp_core' | 'qbr-core' | 'standalone'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ BLINDFOLD FEATURE FLAGS ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.blindfoldcommand     = true  -- Enable /blindfold and /unblindfold commands
Config.blindfoldselfcommand = true  -- Enable /blindfoldme and /unblindfoldme commands
Config.blindfolditem        = true  -- Require a 'blindfold' item to use the script

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ESCAPE CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.escape = {
    active   = true,
    -- Numbers between 0-5000; when the random roll matches one of these the blindfold breaks
    lotonumb = {5, 6, 20},
    -- Button hash to attempt escape (G key)
    button   = 0x760A9C6F,
    lang = {
        escape = 'Attempt to Break Blindfold',
        button = 'G'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE / LOCALE █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.lang = {
    noplayers = "No players nearby",
    noitem    = "You are out of blindfolds",
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG SETTINGS ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Enable debug prints and extra logging
