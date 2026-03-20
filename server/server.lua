--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    🐺 LXR Core - Blindfold System | SERVER SCRIPT
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
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ RESOURCE NAME PROTECTION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    This protection is placed server-side so that after Tebex escrow encryption
    the logic becomes unreadable and cannot be bypassed by buyers.
    The resource must be named exactly as expected to start.
]]

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
    return
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK INITIALISATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local detectedFramework = nil
local CoreObject        = nil

-- Auto-detect framework or use manual setting
local function DetectFramework()
    local fw = Config.Framework

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

    return fw
end

detectedFramework = DetectFramework()

if detectedFramework == 'lxr-core' then
    CoreObject = exports['lxr-core']:GetCoreObject()
elseif detectedFramework == 'rsg-core' then
    CoreObject = exports['rsg-core']:GetCoreObject()
elseif detectedFramework == 'qbr-core' then
    CoreObject = exports['qbr-core']:GetCoreObject()
elseif detectedFramework == 'qr-core' then
    CoreObject = exports['qr-core']:GetCoreObject()
elseif detectedFramework == 'vorp_core' then
    CoreObject = exports.vorp_core:GetCore()
elseif detectedFramework == 'redem_roleplay' then
    CoreObject = exports.redem_roleplay:GetCore()
elseif detectedFramework == 'standalone' then
    -- no core object needed
else
    print(string.format("[lxr-blindfold] ⚠️  Unknown framework '%s'. Supported: lxr-core, rsg-core, vorp_core, redem_roleplay, qbr-core, qr-core, standalone", detectedFramework))
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ANTI-ABUSE / RATE LIMITING ████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local playerActionLog = {}

local function IsRateLimited(source)
    if not Config.Security or not Config.Security.enabled then
        return false
    end

    local now = os.time()
    local maxActions = Config.Security.maxActionsPerMinute or 10

    if not playerActionLog[source] then
        playerActionLog[source] = {}
    end

    -- Remove entries older than 60 seconds
    local recent = {}
    for _, t in ipairs(playerActionLog[source]) do
        if (now - t) < 60 then
            recent[#recent + 1] = t
        end
    end

    if #recent >= maxActions then
        if Config.Security.logSuspiciousActivity then
            print(string.format("[lxr-blindfold] ⚠️  Rate limit exceeded for player %s (%d actions/min)", source, #recent))
        end
        playerActionLog[source] = recent
        return true
    end

    recent[#recent + 1] = now
    playerActionLog[source] = recent
    return false
end

-- Clean up rate limit data when player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    playerActionLog[src] = nil
end)

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ HELPER FUNCTIONS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Send a notification to a player (server-side)
local function Notify(source, message)
    if detectedFramework == 'lxr-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif detectedFramework == 'rsg-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif detectedFramework == 'qbr-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif detectedFramework == 'qr-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif detectedFramework == 'vorp_core' then
        TriggerClientEvent('vorp:TipRight', source, message, 4000)
    elseif detectedFramework == 'redem_roleplay' then
        TriggerClientEvent('redem:notification', source, message, 4000)
    else
        print(string.format("[lxr-blindfold] Notify -> [%s]: %s", source, message))
    end
end

-- Get item count from the player's inventory
local function GetItemCount(source, item)
    if Config.Dev and Config.Dev.bypassItems then
        return 1
    end

    if detectedFramework == 'lxr-core' then
        return exports['lxr-core']:GetInventory().getItemCount(source, item)
    elseif detectedFramework == 'rsg-core' then
        return exports['rsg-core']:GetInventory().getItemCount(source, item)
    elseif detectedFramework == 'qbr-core' then
        return exports['qbr-core']:GetInventory().getItemCount(source, item)
    elseif detectedFramework == 'qr-core' then
        return exports['qr-core']:GetInventory().getItemCount(source, item)
    elseif detectedFramework == 'vorp_core' then
        return exports.vorp_inventory:getItemCount(source, item)
    elseif detectedFramework == 'redem_roleplay' then
        return exports.redem_inventory:getItemCount(source, item)
    end
    return 0
end

-- Remove one item from the player's inventory
local function SubItem(source, item, count)
    if Config.Dev and Config.Dev.bypassItems then
        return
    end

    if detectedFramework == 'lxr-core' then
        exports['lxr-core']:GetInventory().subItem(source, item, count)
    elseif detectedFramework == 'rsg-core' then
        exports['rsg-core']:GetInventory().subItem(source, item, count)
    elseif detectedFramework == 'qbr-core' then
        exports['qbr-core']:GetInventory().subItem(source, item, count)
    elseif detectedFramework == 'qr-core' then
        exports['qr-core']:GetInventory().subItem(source, item, count)
    elseif detectedFramework == 'vorp_core' then
        exports.vorp_inventory:subItem(source, item, count)
    elseif detectedFramework == 'redem_roleplay' then
        exports.redem_inventory:subItem(source, item, count)
    end
end

-- Close the inventory UI for a player
local function CloseInv(source)
    if detectedFramework == 'lxr-core' then
        exports['lxr-core']:GetInventory().CloseInv(source)
    elseif detectedFramework == 'rsg-core' then
        exports['rsg-core']:GetInventory().CloseInv(source)
    elseif detectedFramework == 'qbr-core' then
        exports['qbr-core']:GetInventory().CloseInv(source)
    elseif detectedFramework == 'qr-core' then
        exports['qr-core']:GetInventory().CloseInv(source)
    elseif detectedFramework == 'vorp_core' then
        exports.vorp_inventory:CloseInv(source)
    elseif detectedFramework == 'redem_roleplay' then
        exports.redem_inventory:CloseInv(source)
    end
end

-- Register an item as usable
local function RegisterUsableItem(item, cb)
    if detectedFramework == 'lxr-core' then
        exports['lxr-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif detectedFramework == 'rsg-core' then
        exports['rsg-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif detectedFramework == 'qbr-core' then
        exports['qbr-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif detectedFramework == 'qr-core' then
        exports['qr-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif detectedFramework == 'vorp_core' then
        exports.vorp_inventory:RegisterUsableItem(item, cb)
    elseif detectedFramework == 'redem_roleplay' then
        exports.redem_inventory:RegisterUsableItem(item, cb)
    end
end

-- Retrieve the character skin and clothing components for a player
local function GetCharacterData(player)
    if (detectedFramework == 'lxr-core' or detectedFramework == 'rsg-core' or detectedFramework == 'qbr-core' or detectedFramework == 'qr-core') and CoreObject then
        local Player = CoreObject.Functions.GetPlayer(player)
        if Player then
            local skin  = json.decode(Player.PlayerData.skin  or '{}')
            local comps = Player.PlayerData.comps or '{}'
            return skin, comps
        end
    elseif detectedFramework == 'vorp_core' and CoreObject then
        local User = CoreObject.getUser(player)
        if User then
            local Character = User.getUsedCharacter
            local skin  = json.decode(Character.skin or '{}')
            local comps = Character.comps or '{}'
            return skin, comps
        end
    elseif detectedFramework == 'redem_roleplay' and CoreObject then
        local User = CoreObject.getUser(player)
        if User then
            local skin  = json.decode(User.skin or '{}')
            local comps = User.comps or '{}'
            return skin, comps
        end
    end
    return {}, '{}'
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ MAIN EVENT: TOGGLE BLINDFOLD ██████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

RegisterNetEvent('lxrblindfold:toggleblindfold')
AddEventHandler('lxrblindfold:toggleblindfold', function(player, toggle)
    local _source = source

    -- Anti-abuse: rate limiting
    if IsRateLimited(_source) then
        Notify(_source, "Action rate limited. Please wait.")
        return
    end

    -- Sanity check: validate source is a real player
    if not _source or _source <= 0 then
        return
    end

    local passed = true

    if player ~= nil then
        if Config.blindfolditem and toggle == true then
            local itemName  = (Config.Items and Config.Items.blindfold and Config.Items.blindfold.name) or 'blindfold'
            local itemCount = GetItemCount(_source, itemName)
            if itemCount > 0 then
                SubItem(_source, itemName, 1)
            else
                passed = false
                Notify(_source, Config.lang.noitem)
            end
        end

        if passed then
            if player == 'self' then
                player = _source
            end

            local skin, comps = GetCharacterData(player)
            local playerSex   = string.gsub(tostring(skin['sex'] or 'male'), 'mp_', '')

            TriggerClientEvent('lxrblindfold:togblindfold', player, playerSex, comps, toggle)
        end
    else
        Notify(_source, Config.lang.noplayers)
    end
end)

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ USABLE ITEM REGISTRATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

if Config.blindfolditem then
    local itemName = (Config.Items and Config.Items.blindfold and Config.Items.blindfold.name) or 'blindfold'

    RegisterUsableItem(itemName, function(data)
        SubItem(data.source, itemName, 1)
        TriggerClientEvent('lxrblindfold:blindfolditem', data.source)
        CloseInv(data.source)
    end)
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ STARTUP BANNER ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

CreateThread(function()
    Wait(1000)
    print([[

        ═══════════════════════════════════════════════════════════════════════════════

            ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
            ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
            ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
            ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
            ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
            ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

        ═══════════════════════════════════════════════════════════════════════════════
        🐺 BLINDFOLD SYSTEM - SUCCESSFULLY LOADED
        ═══════════════════════════════════════════════════════════════════════════════

        Version:     2.0.0
        Server:      ]] .. (Config.ServerInfo and Config.ServerInfo.name or 'Unknown') .. [[

        Framework:   ]] .. detectedFramework .. [[

        Debug:       ]] .. (Config.Debug and 'ENABLED' or 'DISABLED') .. [[

        ═══════════════════════════════════════════════════════════════════════════════

        Developer:   iBoss21 / The Lux Empire
        Website:     https://www.wolves.land
        Discord:     https://discord.gg/CrKcWdfd3A

        ═══════════════════════════════════════════════════════════════════════════════

    ]])
end)