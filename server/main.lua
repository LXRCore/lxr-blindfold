--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-BLINDFOLD — Server: who is blind, who tied it
     ═══════════════════════════════════════════════════════════════════════════
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

local LXRCore = exports['lxr-core']:GetCoreObject()
local RES = GetCurrentResourceName()
local blind = {}      -- target src → { by = src, at = GetGameTimer() }
local buckets = {}

local function limited(src)
    local b = buckets[src]
    local now = GetGameTimer()
    if not b or now - b.at > Config.Security.rateLimit.windowMs then b = { at = now, n = 0 } buckets[src] = b end
    b.n = b.n + 1
    return b.n > Config.Security.rateLimit.burst
end
local function player(src) return LXRCore.Functions.GetPlayer(src) end
local function notify(src, key, kind, vars) LXRCore.Notify(src, Lang:t(key, vars), kind or 'info') end
local function near(a, b)
    local pa, pb = GetPlayerPed(a), GetPlayerPed(b)
    return pa ~= 0 and pb ~= 0 and #(GetEntityCoords(pa) - GetEntityCoords(pb)) <= Config.Security.maxDistance
end
local function restrained(src)
    local st = Player(src).state
    return st.cuffed == true or st.tied == true
end

local function set(target, on, by)
    if on then blind[target] = { by = by, at = GetGameTimer() } else blind[target] = nil end
    Player(target).state:set('blindfolded', on == true, true)
    TriggerClientEvent('lxr-blindfold:client:set', target, on == true, Config.Blindfold.selfRemoveAfterMs)
    LXRCore.Emit('lxr:blindfold:changed', nil, target, on == true, by)
end

RegisterNetEvent('lxr-blindfold:server:tie', function(targetId)
    local src = source
    if limited(src) then return end
    local P, T = player(src), player(tonumber(targetId) or -1)
    if not P or not T or T.PlayerData.source == src then return end
    local t = T.PlayerData.source
    if not near(src, t) then return notify(src, 'error.too_far', 'error') end
    if blind[t] then return notify(src, 'error.already', 'error') end
    if Config.Blindfold.onlyRestrained and not restrained(t) then return notify(src, 'error.not_restrained', 'error') end
    if Config.Blindfold.item and not P.Functions.RemoveItem(Config.Blindfold.item, 1, nil, 'blindfold tied') then return notify(src, 'error.no_item', 'error') end
    set(t, true, src)
    notify(src, 'info.tied', 'success')
    notify(t, 'info.you_tied', 'inform')
end)

RegisterNetEvent('lxr-blindfold:server:untie', function(targetId)
    local src = source
    if limited(src) then return end
    local P = player(src)
    local t = tonumber(targetId) or src
    if not P or not blind[t] then return end
    if t ~= src and not near(src, t) then return notify(src, 'error.too_far', 'error') end
    if t == src then
        local after = Config.Blindfold.selfRemoveAfterMs
        if after <= 0 or GetGameTimer() - blind[t].at < after then return notify(src, 'error.too_soon', 'error') end
        if restrained(src) then return notify(src, 'error.hands_tied', 'error') end
    end
    set(t, false, src)
    if Config.Blindfold.item then P.Functions.AddItem(Config.Blindfold.item, 1, nil, nil, 'blindfold taken off') end
    notify(src, 'info.untied', 'success')
    if t ~= src then notify(t, 'info.you_untied', 'inform') end
end)

RegisterNetEvent('lxr-blindfold:server:ready', function() local src = source Player(src).state:set('blindfolded', blind[src] ~= nil, true) if blind[src] then TriggerClientEvent('lxr-blindfold:client:set', src, true, Config.Blindfold.selfRemoveAfterMs) end end)
AddEventHandler('playerDropped', function() blind[source] = nil buckets[source] = nil end)
CreateThread(function() if Config.Debug.printBanner then print(('^1[lxr-blindfold]^7 v%s'):format(GetResourceMetadata(RES, 'version', 0))) end end)

exports('IsBlindfolded', function(src) return blind[src] ~= nil end)
exports('Set', function(src, on) if player(src) then set(src, on ~= false, nil) return true end return false end)
