--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-BLINDFOLD — Client: the dark, and the option to tie one on
     ═══════════════════════════════════════════════════════════════════════════
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

local LXRCore = exports['lxr-core']:GetCoreObject()
local blind = false

local function sid(e) return GetPlayerServerId(NetworkGetPlayerIndexFromPed(e)) end

RegisterNetEvent('lxr-blindfold:client:set', function(on, selfAfter)
    blind = on == true
    SendNUIMessage({ action = blind and 'on' or 'off', selfAfter = selfAfter, brand = LXRCore.Brand, lang = Config.Lang, locale = Lang.bundle() })
    if blind then
        CreateThread(function()
            while blind do
                for _, c in ipairs(Config.Blindfold.blockControls) do DisableControlAction(0, c, true) end
                Wait(0)
            end
        end)
    end
end)

RegisterCommand('blindfold_off', function() if blind then TriggerServerEvent('lxr-blindfold:server:untie') end end, false)
RegisterKeyMapping('blindfold_off', 'Pull the blindfold off', 'keyboard', 'X')

CreateThread(function()
    while GetResourceState('lxr-interact') ~= 'started' do Wait(1000) end
    exports['lxr-interact']:AddGlobal('lxr-blindfold:player', 'player', { label = Lang:t('ui.person'), distance = Config.Blindfold.distance, options = {
        { label = Lang:t('ui.tie'), key = 'X', item = Config.Blindfold.item,
          canInteract = function(e) if not e then return false end local st = Player(sid(e)).state return st.blindfolded ~= true and (not Config.Blindfold.onlyRestrained or st.cuffed == true or st.tied == true) end,
          onSelect = function(d) TriggerServerEvent('lxr-blindfold:server:tie', sid(d.entity)) end },
        { label = Lang:t('ui.untie'), key = 'X', canInteract = function(e) return e and Player(sid(e)).state.blindfolded == true end,
          onSelect = function(d) TriggerServerEvent('lxr-blindfold:server:untie', sid(d.entity)) end },
    }})
end)

RegisterNetEvent('lxr:client:loaded', function() Wait(1500) TriggerServerEvent('lxr-blindfold:server:ready') end)
exports('IsBlindfolded', function() return blind end)
