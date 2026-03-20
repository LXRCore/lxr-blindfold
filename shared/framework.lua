--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    🐺 LXR Core - Blindfold System | FRAMEWORK BRIDGE
    Restraint & Roleplay Immersion for RedM

    ═══════════════════════════════════════════════════════════════════════════════
    FRAMEWORK BRIDGE — ADAPTER PATTERN
    ═══════════════════════════════════════════════════════════════════════════════

    This file implements a Bridge Pattern to abstract framework-specific calls.
    It exposes a clean shared interface for both client and server scripts.

    Detection order: LXR → RSG → VORP → QBR → QR → RedEM → Standalone

    ═══════════════════════════════════════════════════════════════════════════════
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK BRIDGE ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Framework = {}
Framework.Name = nil
Framework.Core = nil

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DETECTION ████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function Framework.Detect()
    local fw = Config.Framework or 'auto'

    if Config.Dev and Config.Dev.forceFramework then
        fw = Config.Dev.forceFramework
    end

    if fw == 'auto' then
        if GetResourceState('lxr-core') == 'started' then
            fw = 'lxr-core'
        elseif GetResourceState('rsg-core') == 'started' then
            fw = 'rsg-core'
        elseif GetResourceState('vorp_core') == 'started' then
            fw = 'vorp_core'
        elseif GetResourceState('redem_roleplay') == 'started' then
            fw = 'redem_roleplay'
        elseif GetResourceState('qbr-core') == 'started' then
            fw = 'qbr-core'
        elseif GetResourceState('qr-core') == 'started' then
            fw = 'qr-core'
        else
            fw = 'standalone'
        end
    end

    Framework.Name = fw
    return fw
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK SETTINGS HELPER █████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function Framework.GetSettings()
    if Config.FrameworkSettings and Framework.Name then
        return Config.FrameworkSettings[Framework.Name] or {}
    end
    return {}
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG LOGGING ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function Framework.Log(msg)
    if Config.Debug then
        print(string.format("[lxr-blindfold][%s] %s", Framework.Name or 'unknown', msg))
    end
end

function Framework.Warn(msg)
    print(string.format("[lxr-blindfold] ⚠️  %s", msg))
end

function Framework.Error(msg)
    print(string.format("[lxr-blindfold] ❌ %s", msg))
end
