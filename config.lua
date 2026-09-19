--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██╗     ██╗███╗   ██╗██████╗ ███████╗ ██████╗ ██╗     ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██║     ██║████╗  ██║██╔══██╗██╔════╝██╔═══██╗██║     ██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██║     ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║██║     ██║  ██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██║     ██║██║╚██╗██║██║  ██║██╔══╝  ██║   ██║██║     ██║  ██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝███████╗██║██║ ╚████║██████╔╝██║     ╚██████╔╝███████╗██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝      ╚═════╝ ╚══════╝╚═════╝

    LXR Core - Blindfold

    A strip of cloth over someone's eyes. Needs the item, needs the other
    person in reach and restrained (cuffed or tied) unless the config says
    otherwise; the server keeps who is blindfolded, the blindfolded see the
    dark, the one who tied it — or anyone, after a while — takes it off.

    Brand:       LXRCore — Lux Empire eXperience RedM Core
    Product:     wolves.land / The Land of Wolves
    Developer:   iBoss21 / LXRCore
    Website:     https://www.lxrcore.com
    Discord:     https://discord.gg/GAhk8cgXe9
    GitHub:      https://github.com/LXRCore

    Version: 3.0.0
    Performance Target: 0.00 ms idle (interact options; per-frame only while blindfolded)

    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

Config = Config or {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE ██████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████
Config.Lang = 'en'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ THE CLOTH ═════════════════════════════════════════════
-- ████████████████████████████████████████████████████████████████████████████████
Config.Blindfold = {
    item = 'blindfold',           -- taken from the satchel when tied on, returned when taken off
    distance = 2.0,
    onlyRestrained = true,        -- the other person must be cuffed (lxr-lawman) or tied (lxr-lasso)
    selfRemoveAfterMs = 120000,   -- a blindfolded person may pull it off themselves after this (0 = never)
    muteOthers = true,            -- others' names / /me overlay hidden while blind (lxr-me reads the state bag)
    blockControls = { 0xF84FA74F, 0x07CE1E61 }, -- aim, attack
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SECURITY ══════════════════════════════════════════════
-- ████████████████████████████████████████████████████████████████████████████████
Config.Security = { rateLimit = { windowMs = 2000, burst = 6 }, maxDistance = 3.0 }
Config.Debug = { printBanner = true }
