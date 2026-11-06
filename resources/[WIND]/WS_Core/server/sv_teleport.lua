ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('WS_pointdeteleportation:teleporation')
AddEventHandler('WS_pointdeteleportation:teleporation', function(pos, posname)
    local xPlayer = GetPlayerPed(source)
    local xPlayerID = ESX.GetPlayerFromId(source)
    if xPlayer ~= 0 then 
        SetEntityCoords(xPlayer, pos.x, pos.y, pos.z, false, false, false, true)
        TriggerClientEvent('esx:showNotification', source, _T('teleported_to', posname))
    else
        TriggerClientEvent('esx:showNotification', source, _T('player_not_found'))
    end
end)

print("[^4WIND STUDIO^7] " .. "Téléportation" .. ", [^1VERSION^7] 1.0.0, [^2BY^7] Noxxo, [^5DISCORD^7] https://discord.gg/7SBn6ygS87")