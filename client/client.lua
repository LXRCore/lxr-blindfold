--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║██████╔╝█████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██╗██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗╚██████╔╝██║  ██║███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    🐺 LXR Core - Blindfold System | CLIENT SCRIPT
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
-- ████████████████████████ STATE ████████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

local active     = false
local selfblinded = false

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ESCAPE MECHANIC ███████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

if Config.escape.active then
    Citizen.CreateThread(function()
        active = true
        while true do
            Wait(0)
            if active then
                if IsControlJustPressed(0, Config.escape.button) then
                    SendNUIMessage({
                        type  = 'escapekeypress',
                        state = true
                    })

                    local rando = math.random(0, 5000)

                    if Config.escape.lotonumb[rando] then
                        TriggerServerEvent('lxrblindfold:toggleblindfold', 'self', false)
                        active = false
                    end
                end

                if IsControlJustReleased(0, Config.escape.button) then
                    SendNUIMessage({
                        type  = 'escapekeypress',
                        state = false
                    })
                end
            end
        end
    end)
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ WEARABLE / CLOTHING HELPERS ███████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function SetWearable(pcomps, playerSex, playerPed, toggle)
    for k, v in pairs(pcomps) do
        local catHash = CategoryDBName[k]
        if playerSex == "male" then
            if v <= 0 then
                if catHash == 0xE06D30CE then
                    Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, 0x662AC34, 0)
                end
                Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, catHash, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, 0)
            else
                if catHash == 0xE06D30CE then
                    Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, 0x662AC34, 0)
                    Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, 0)
                end
                Citizen.InvokeNative(0x59BD177A1A48600A, playerPed, catHash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, v, true, false, false)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, v, true, true, false)
            end
        else
            if v <= 0 then
                Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, catHash, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, 0)
            else
                Citizen.InvokeNative(0x59BD177A1A48600A, playerPed, catHash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, v, true, false, true)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, v, true, true, true)
            end
        end
        Citizen.Wait(5)
    end
    SendNUIMessage({
        type    = 'toggle',
        visible = toggle,
        config  = Config
    })
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ CLOSEST PLAYER HELPER █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    local closest = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(tgt)
            local distance     = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closest = {
                    client = players[i],
                    server = GetPlayerServerId(players[i])
                }
                closestDistance = distance
            end
        end
    end
    return closest, closestDistance
end

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ NET EVENTS ████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

RegisterNetEvent('lxrblindfold:togblindfold')
AddEventHandler('lxrblindfold:togblindfold', function(playerSex, comps, toggle)
    local playerPed = PlayerPedId()
    local pcomps    = json.decode(comps)

    if toggle == true then
        if playerSex == "male" then
            pcomps['EyeWear'] = 0x10464C0B
        else
            pcomps['EyeWear'] = 0xDA872AED
        end
    end

    active = true
    SetWearable(pcomps, playerSex, playerPed, toggle)
end)

RegisterNetEvent('lxrblindfold:blindfolditem')
AddEventHandler('lxrblindfold:blindfolditem', function()
    selfblinded = false
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer.client ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('lxrblindfold:toggleblindfold', closestPlayer.server, true)
    end
end)

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ COMMANDS ██████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

if Config.blindfoldcommand then
    RegisterCommand("blindfold", function(source, args, rawCommand)
        selfblinded = false
        local closestPlayer, closestDistance = GetClosestPlayer()
        if closestPlayer.client ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('lxrblindfold:toggleblindfold', closestPlayer.server, true)
        end
    end, false)

    RegisterCommand("unblindfold", function(source, args, rawCommand)
        local closestPlayer, closestDistance = GetClosestPlayer()
        if closestPlayer.client ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('lxrblindfold:toggleblindfold', closestPlayer.server, false)
        end
    end, false)
end

if Config.blindfoldselfcommand then
    RegisterCommand("blindfoldme", function(source, args, rawCommand)
        selfblinded = true
        TriggerServerEvent('lxrblindfold:toggleblindfold', 'self', true)
    end, false)

    RegisterCommand("unblindfoldme", function(source, args, rawCommand)
        if selfblinded then
            TriggerServerEvent('lxrblindfold:toggleblindfold', 'self', false)
        end
    end, false)
end