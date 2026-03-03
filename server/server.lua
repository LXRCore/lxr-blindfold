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
-- ████████████████████████ FRAMEWORK INITIALISATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local Framework = Config.Framework
local CoreObject = nil

if Framework == 'lxr-core' then
    CoreObject = exports['lxr-core']:GetCoreObject()
elseif Framework == 'rsg-core' then
    CoreObject = exports['rsg-core']:GetCoreObject()
elseif Framework == 'qbr-core' then
    CoreObject = exports['qbr-core']:GetCoreObject()
elseif Framework == 'vorp_core' then
    CoreObject = exports.vorp_core:GetCore()
elseif Framework == 'standalone' then
    -- no core object needed
else
    print(string.format("[lxr-blindfold] ⚠️  Unknown framework '%s'. Supported: lxr-core, rsg-core, vorp_core, qbr-core, standalone", Framework))
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ HELPER FUNCTIONS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Send a notification to a player (server-side)
local function Notify(source, message)
    if Framework == 'lxr-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif Framework == 'rsg-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif Framework == 'qbr-core' and CoreObject then
        CoreObject.Functions.Notify(source, message, 'error', 4000)
    elseif Framework == 'vorp_core' then
        TriggerClientEvent('vorp:TipRight', source, message, 4000)
    else
        print(string.format("[lxr-blindfold] Notify -> [%s]: %s", source, message))
    end
end

-- Get item count from the player's inventory
local function GetItemCount(source, item)
    if Framework == 'lxr-core' then
        return exports['lxr-core']:GetInventory().getItemCount(source, item)
    elseif Framework == 'rsg-core' then
        return exports['rsg-core']:GetInventory().getItemCount(source, item)
    elseif Framework == 'qbr-core' then
        return exports['qbr-core']:GetInventory().getItemCount(source, item)
    elseif Framework == 'vorp_core' then
        return exports.vorp_inventory:getItemCount(source, item)
    end
    return 0
end

-- Remove one item from the player's inventory
local function SubItem(source, item, count)
    if Framework == 'lxr-core' then
        exports['lxr-core']:GetInventory().subItem(source, item, count)
    elseif Framework == 'rsg-core' then
        exports['rsg-core']:GetInventory().subItem(source, item, count)
    elseif Framework == 'qbr-core' then
        exports['qbr-core']:GetInventory().subItem(source, item, count)
    elseif Framework == 'vorp_core' then
        exports.vorp_inventory:subItem(source, item, count)
    end
end

-- Close the inventory UI for a player
local function CloseInv(source)
    if Framework == 'lxr-core' then
        exports['lxr-core']:GetInventory().CloseInv(source)
    elseif Framework == 'rsg-core' then
        exports['rsg-core']:GetInventory().CloseInv(source)
    elseif Framework == 'qbr-core' then
        exports['qbr-core']:GetInventory().CloseInv(source)
    elseif Framework == 'vorp_core' then
        exports.vorp_inventory:CloseInv(source)
    end
end

-- Register an item as usable
local function RegisterUsableItem(item, cb)
    if Framework == 'lxr-core' then
        exports['lxr-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif Framework == 'rsg-core' then
        exports['rsg-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif Framework == 'qbr-core' then
        exports['qbr-core']:GetInventory().RegisterUsableItem(item, cb)
    elseif Framework == 'vorp_core' then
        exports.vorp_inventory:RegisterUsableItem(item, cb)
    end
end

-- Retrieve the character skin and clothing components for a player
local function GetCharacterData(player)
    if (Framework == 'lxr-core' or Framework == 'rsg-core' or Framework == 'qbr-core') and CoreObject then
        local Player = CoreObject.Functions.GetPlayer(player)
        if Player then
            local skin  = json.decode(Player.PlayerData.skin  or '{}')
            local comps = Player.PlayerData.comps or '{}'
            return skin, comps
        end
    elseif Framework == 'vorp_core' and CoreObject then
        local User = CoreObject.getUser(player)
        if User then
            local Character = User.getUsedCharacter
            local skin  = json.decode(Character.skin or '{}')
            local comps = Character.comps or '{}'
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
    local passed  = true

    if player ~= nil then
        if Config.blindfolditem and toggle == true then
            local itemCount = GetItemCount(_source, 'blindfold')
            if itemCount > 0 then
                SubItem(_source, 'blindfold', 1)
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
    RegisterUsableItem('blindfold', function(data)
        SubItem(data.source, 'blindfold', 1)
        TriggerClientEvent('lxrblindfold:blindfolditem', data.source)
        CloseInv(data.source)
    end)
end