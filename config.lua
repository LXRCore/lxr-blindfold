--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    🐺 LXR Core - Blindfold System
    Restraint & Roleplay Immersion for RedM

    This configuration file controls the blindfold and restraint system for RedM.
    Players can blindfold other players or themselves for immersive roleplay scenarios.
    Each action is configurable including item requirements, escape mechanics, and commands.

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted

    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io

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

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name        = 'The Land of Wolves 🐺',
    tagline     = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type        = 'Serious Hardcore Roleplay',
    access      = 'Discord & Whitelisted',

    -- Contact & Links
    website       = 'https://www.wolves.land',
    discord       = 'https://discord.gg/CrKcWdfd3A',
    github        = 'https://github.com/iBoss21',
    store         = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',

    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
    4. RedEM:RP  (Optional - if detected)
    5. QBR-Core  (Optional - if detected)
    6. QR-Core   (Optional - if detected)
    7. Standalone (Fallback)
]]

Config.Framework = 'auto' -- 'auto' or manual: 'lxr-core', 'rsg-core', 'vorp_core', 'redem_roleplay', 'qbr-core', 'qr-core', 'standalone'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK-SPECIFIC SETTINGS ███████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource      = 'lxr-core',
        notifications = 'ox_lib',
        inventory     = 'lxr-inventory',
        events = {
            server   = 'lxr-core:server:%s',
            client   = 'lxr-core:client:%s',
            callback = 'lxr-core:callback:%s',
        },
    },
    ['rsg-core'] = {
        resource      = 'rsg-core',
        notifications = 'ox_lib',
        inventory     = 'rsg-inventory',
        events = {
            server   = 'RSGCore:Server:%s',
            client   = 'RSGCore:Client:%s',
            callback = 'RSGCore:Callback:%s',
        },
    },
    ['vorp_core'] = {
        resource      = 'vorp_core',
        notifications = 'vorp',
        inventory     = 'vorp_inventory',
        events = {
            server = 'vorp:server:%s',
            client = 'vorp:client:%s',
        },
    },
    ['redem_roleplay'] = {
        resource      = 'redem_roleplay',
        notifications = 'redem',
        inventory     = 'redem_inventory',
        events = {
            server = 'redem:%s:server',
            client = 'redem:%s:client',
        },
    },
    ['qbr-core'] = {
        resource      = 'qbr-core',
        notifications = 'ox_lib',
        inventory     = 'qbr-inventory',
        events = {
            server   = 'QBR:Server:%s',
            client   = 'QBR:Client:%s',
        },
    },
    ['qr-core'] = {
        resource      = 'qr-core',
        notifications = 'ox_lib',
        inventory     = 'qr-inventory',
        events = {
            server   = 'QR:Server:%s',
            client   = 'QR:Client:%s',
        },
    },
    ['standalone'] = {
        notifications = 'print',
        inventory     = 'none',
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ BLINDFOLD FEATURE FLAGS ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.blindfoldcommand     = true  -- Enable /blindfold and /unblindfold commands
Config.blindfoldselfcommand = true  -- Enable /blindfoldme and /unblindfoldme commands
Config.blindfolditem        = true  -- Require a 'blindfold' item to use the script

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ITEM CONFIGURATION ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Item name used across all frameworks.
    Make sure the item exists in your framework's item registry / database.
    See items/ folder for SQL inserts per framework.
]]

Config.Items = {
    blindfold = {
        name  = 'blindfold',
        label = 'Blindfold',
        limit = 10,
        type  = 'item_standard',
    },
}

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
        button = 'G',
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE / LOCALE █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en' -- Language for notifications ('en', 'ka')

Config.lang = {
    noplayers       = "No players nearby",
    noitem          = "You are out of blindfolds",
    blindfolded     = "You have been blindfolded",
    unblindfolded   = "The blindfold has been removed",
    selfblindfolded = "You put on a blindfold",
    selfunblind     = "You removed your own blindfold",
    escaped         = "You broke free from the blindfold!",
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SECURITY & ANTI-ABUSE █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Security = {
    enabled            = true,   -- Enable server-side security checks
    maxDistance         = 3.0,    -- Max distance to target player for blindfolding
    maxActionsPerMinute = 10,    -- Rate limit: max blindfold actions per player per minute
    logSuspiciousActivity = true, -- Log suspicious behavior to server console
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG & DEV SETTINGS ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Enable debug prints and extra logging

Config.Dev = {
    printEvents = false, -- Print all event triggers to console
    bypassItems = false, -- Bypass item checks (dev/testing only)
    forceFramework = nil, -- Force a specific framework for testing (nil = use Config.Framework)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ END OF CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████
