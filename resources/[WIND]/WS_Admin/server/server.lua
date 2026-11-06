ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('WS_Admin:getgroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group == 'admin' or group == 'owner' then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('WS_Admin:gotoplayer')
AddEventHandler('WS_Admin:gotoplayer', function(target)
    local joueur = GetPlayerPed(source)
    local xPlayer = GetPlayerPed(tonumber(target))
    local targetCoords = GetEntityCoords(xPlayer)

    if xPlayer ~= 0 then 
        SetEntityCoords(joueur, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
        TriggerClientEvent('esx:showNotification', source, _T('tp_to_player_done'), "success")
    else
        TriggerClientEvent('esx:showNotification', source, _T('player_not_found'), "error")
    end
end)

RegisterServerEvent('WS_Admin:bringplayer')
AddEventHandler('WS_Admin:bringplayer', function(target)
    local joueur = GetPlayerPed(tonumber(target))
    local xPlayer = GetPlayerPed(source)
    local targetCoords = GetEntityCoords(xPlayer)

    if joueur ~= 0 then 
        SetEntityCoords(joueur, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
        TriggerClientEvent('esx:showNotification', source, _T('bring_player_done'), "success")
    else
        TriggerClientEvent('esx:showNotification', source, _T('player_not_found'), "error")
    end
end)

RegisterServerEvent('WS_Admin:spawncar')
AddEventHandler('WS_Admin:spawncar', function(carname)
    local xPlayer = GetPlayerPed(source)
    local xPlayercoords = GetEntityCoords(xPlayer)

    local hash = GetHashKey(carname)

    local vehicle = CreateVehicle(hash, xPlayercoords.x, xPlayercoords.y, xPlayercoords.z, GetEntityHeading(xPlayer), true, false)
    SetPedIntoVehicle(xPlayer, vehicle, -1)

    TriggerClientEvent('esx:showNotification', source, _T('vehicle_spawned'), "success")
end)

---------------------------------------------------------------------------------------------------------------------
-- Info
print("[^4WIND STUDIO^7] " .. "Template Admin" .. ", [^1VERSION^7] 1.0.0, [^2BY^7] Noxxo, [^5DISCORD^7] https://discord.gg/7SBn6ygS87")

