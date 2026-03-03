--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██╗     ██╗███╗   ██╗██████╗ ███████╗ ██████╗ ██╗     ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██║     ██║████╗  ██║██╔══██╗██╔════╝██╔═══██╗██║     ██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██║     ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║██║     ██║  ██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██║     ██║██║╚██╗██║██║  ██║██╔══╝  ██║   ██║██║     ██║  ██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝███████╗██║██║ ╚████║██████╔╝██║     ╚██████╔╝███████╗██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝      ╚═════╝ ╚══════╝╚═════╝

    🐺 LXR Blindfold — Server Script
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 FRAMEWORK INITIALISATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Framework = Config.Framework
local Core, Inv

if Framework == 'lxr-core' then
    Core = exports['lxr-core']:GetCoreObject()
    Inv  = exports['lxr-core']:GetInventory()
elseif Framework == 'rsg-core' then
    Core = exports['rsg-core']:GetCoreObject()
    Inv  = exports['rsg-core']:GetInventory()
elseif Framework == 'vorp_core' then
    Core = exports['vorp_core']:GetVorp()
else
    print('[lxr-blindfold] ⚠ Unsupported framework: ' .. tostring(Framework) .. '. Set Config.Framework correctly.')
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 FRAMEWORK HELPER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

local function Notify(src, message, duration)
    duration = duration or 4000
    if Framework == 'lxr-core' or Framework == 'rsg-core' then
        Core.Functions.Notify(src, message, duration)
    elseif Framework == 'vorp_core' then
        TriggerClientEvent('vorp:TipRight', src, message, duration)
    else
        print('[lxr-blindfold] Notification (' .. tostring(src) .. '): ' .. tostring(message))
    end
end

local function GetItemCount(src, item)
    if Framework == 'lxr-core' or Framework == 'rsg-core' then
        return Inv.getItemCount(src, item)
    elseif Framework == 'vorp_core' then
        local character = Core.getUser(src).getUsedCharacter
        return character and character.getItemCount(item) or 0
    end
    return 0
end

local function RemoveItem(src, item, count)
    if Framework == 'lxr-core' or Framework == 'rsg-core' then
        Inv.subItem(src, item, count)
    elseif Framework == 'vorp_core' then
        local character = Core.getUser(src).getUsedCharacter
        if character then character.subItem(item, count) end
    end
end

local function GetCharacterData(playerId)
    if Framework == 'lxr-core' or Framework == 'rsg-core' then
        local Player = Core.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData then
            local skin = Player.PlayerData.skin or {}
            local sex  = string.gsub(tostring(skin.sex or 'mp_male'), 'mp_', '')
            return sex, json.encode(Player.PlayerData.comps or {})
        end
    elseif Framework == 'vorp_core' then
        local character = Core.getUser(playerId).getUsedCharacter
        if character then
            local skin = json.decode(character.skin)
            local sex  = string.gsub(tostring(skin['sex']), 'mp_', '')
            return sex, character.comps
        end
    end
    return 'male', '{}'
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 BLINDFOLD TOGGLE EVENT
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterNetEvent('lxrblindfold:toggleblindfold')
AddEventHandler('lxrblindfold:toggleblindfold', function(player, toggle)
    local _source = source
    local passed  = true

    if player == nil then
        Notify(_source, Config.Lang.noplayers, 4000)
        return
    end

    if Config.BlindFoldItem and toggle == true then
        local itemCount = GetItemCount(_source, 'blindfold')
        if itemCount > 0 then
            RemoveItem(_source, 'blindfold', 1)
        else
            passed = false
            Notify(_source, Config.Lang.noitem, 4000)
        end
    end

    if passed then
        local targetId = (player == 'self') and _source or player
        local playerSex, comps = GetCharacterData(targetId)
        TriggerClientEvent('lxrblindfold:togblindfold', targetId, playerSex, comps, toggle)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 USABLE ITEM REGISTRATION
-- ═══════════════════════════════════════════════════════════════════════════════

if Config.BlindFoldItem then
    if Framework == 'lxr-core' or Framework == 'rsg-core' then
        Inv.RegisterUsableItem('blindfold', function(data)
            RemoveItem(data.source, 'blindfold', 1)
            TriggerClientEvent('lxrblindfold:blindfolditem', data.source)
            Inv.CloseInv(data.source)
        end)
    elseif Framework == 'vorp_core' then
        exports['vorp_inventory']:registerUsableItem('blindfold', function(data)
            RemoveItem(data.source, 'blindfold', 1)
            TriggerClientEvent('lxrblindfold:blindfolditem', data.source)
        end)
    end
end