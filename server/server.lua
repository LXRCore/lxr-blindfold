
    -- Detect framework
    local Framework = Config.framework
    if Framework == 'lxr-core' then
        LXRcore = exports['lxr-core']:GetCoreObject()
    elseif Framework == 'qbr-core' then
        QBRcore = exports['qbr-core']:GetCoreObject()
    elseif Framework == 'rsg-core' then
        RSGcore = exports['rsg-core']:GetCoreObject()
    else
        print("Unsupported framework, please set Config.framework correctly.")
    end
    


RegisterNetEvent('lxrblindfold:toggleblindfold')
AddEventHandler('lxrblindfold:toggleblindfold', function(player, toggle)
	local _source = source
	local passed = true
	if player ~= nil then
		if Config.blindfolditem and toggle == true then
			local itemCount = 
    if Framework == 'lxr-core' then
        LXRInv = exports['lxr-core']:GetInventory()
    elseif Framework == 'qbr-core' then
        QBRInv = exports['qbr-core']:GetInventory()
    elseif Framework == 'rsg-core' then
        RSGInv = exports['rsg-core']:GetInventory()
    end
    .getItemCount(_source, 'blindfold')
			if itemCount > 0 then
				
    if Framework == 'lxr-core' then
        LXRInv = exports['lxr-core']:GetInventory()
    elseif Framework == 'qbr-core' then
        QBRInv = exports['qbr-core']:GetInventory()
    elseif Framework == 'rsg-core' then
        RSGInv = exports['rsg-core']:GetInventory()
    end
    .subItem(_source, 'blindfold', 1)
			else
				passed = false
				
    if Framework == 'lxr-core' then
        LXRcore.Functions.Notify
    elseif Framework == 'qbr-core' then
        QBRcore.Functions.Notify
    elseif Framework == 'rsg-core' then
        RSGcore.Functions.Notify
    else
        print("Unsupported framework.")
    end
    (_source, Config.lang.noitem,4000)
			end
		end

		if passed then
			if player == 'self' then
				player = source
			end
		
			local Character = VORPcore.getUser(player).getUsedCharacter
		
			local skin = json.decode(Character.skin)
			local comps = Character.comps
			local playerSex = string.gsub(tostring(skin["sex"]), "mp_", "")
		
			TriggerClientEvent('lxrblindfold:togblindfold', player, playerSex, comps, toggle)
		end
	else
		
    if Framework == 'lxr-core' then
        LXRcore.Functions.Notify
    elseif Framework == 'qbr-core' then
        QBRcore.Functions.Notify
    elseif Framework == 'rsg-core' then
        RSGcore.Functions.Notify
    else
        print("Unsupported framework.")
    end
    (_source, Config.lang.noplayers,4000)
	end
end)

if Config.blindfolditem then
	-- Facemask Usable Item
	
    if Framework == 'lxr-core' then
        LXRInv = exports['lxr-core']:GetInventory()
    elseif Framework == 'qbr-core' then
        QBRInv = exports['qbr-core']:GetInventory()
    elseif Framework == 'rsg-core' then
        RSGInv = exports['rsg-core']:GetInventory()
    end
    .RegisterUsableItem('blindfold', function(data)
		-- 
    if Framework == 'lxr-core' then
        LXRInv = exports['lxr-core']:GetInventory()
    elseif Framework == 'qbr-core' then
        QBRInv = exports['qbr-core']:GetInventory()
    elseif Framework == 'rsg-core' then
        RSGInv = exports['rsg-core']:GetInventory()
    end
    .subItem(data.source, 'blindfold', 1)
		TriggerClientEvent("lxrblindfold:blindfolditem", data.source)
		
    if Framework == 'lxr-core' then
        LXRInv = exports['lxr-core']:GetInventory()
    elseif Framework == 'qbr-core' then
        QBRInv = exports['qbr-core']:GetInventory()
    elseif Framework == 'rsg-core' then
        RSGInv = exports['rsg-core']:GetInventory()
    end
    .CloseInv(data.source)
	end)		
end