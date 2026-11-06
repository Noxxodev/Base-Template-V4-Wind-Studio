ESX = exports["es_extended"]:getSharedObject()

 
RegisterCommand(Config.Command, function()
    lib.showContext('f5menu')
end)

RegisterKeyMapping(Config.Command, _T('keymapping'), 'keyboard', Config.Key)


lib.registerContext({
    id = 'f5menu',
    title = _T('menu_title'),
    options = {
        {
            title = _T('my_documents'),
            description = _T('my_documents_desc'),
            icon = 'fa-regular fa-id-card',
            onSelect = function()
                lib.showContext('documentmenu')
            end,
        },
        {
            title = _T('vehicle_management'),
            description = _T('vehicle_management'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('voituremenu')
            end,
        },
    }
})

lib.registerContext({
    id = 'documentmenu',
    title = _T('document_menu'),
    menu = 'f5menu',
    options = {
        {
            title = _T('id_card'),
            description = _T('id_card'),
            icon = 'fa-solid fa-address-card',
            onSelect = function()
                local player, distance = ESX.Game.GetClosestPlayer()

                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                else
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                    ESX.ShowNotification(_T('no_player_nearby'))
                end  
            end,
        },
        {
            title = _T('driver_license'),
            description = _T('driver_license'),
            icon = 'fa-solid fa-address-card',
            onSelect = function()
                local player, distance = ESX.Game.GetClosestPlayer()

                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                else
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                    ESX.ShowNotification(_T('no_player_nearby'))
                end
            end,
        },
        {
            title = _T('weapon_license'),
            description = _T('weapon_license'),
            icon = 'fa-solid fa-address-card',
            onSelect = function()
                local player, distance = ESX.Game.GetClosestPlayer()

                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                else
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                    ESX.ShowNotification(_T('no_player_nearby'))
                end
            end,
        },
    }
})

lib.registerContext({
    id = 'voituremenu',
    title = _T('vehicle_menu'),
    menu = 'f5menu',
    options = {
        {
            title = _T('windows_down'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
        {
            title = _T('windows_up'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('fenetrevoituremonter')
            end,
        },
        {
            title = _T('open_doors'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('close_doors'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('change_seat'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                lib.showContext('changerplace')
            end,
        },
        {
            title = _T('engine_toggle'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
                    SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
                end
            end,
        },
    }
})





lib.registerMenu({
    id = 'voituremenu',
    title = _T('vehicle_menu'),
    position = 'top-left',
    options = {
        {label = _T('engine_toggle'), icon = 'fa-solid fa-car', description = _T('engine_toggle')},
    }
}, function(selected, scrollIndex, args)
    if selected == 6 then
        
    end
end)

lib.registerContext({
    id = 'fenetrevoiturebaisser',
    title = _T('window_menu'),
    menu = 'voituremenu',
    options = {
        {
            title = _T('front_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollDownWindow(vehicle, 0)
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
        {
            title = _T('front_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollDownWindow(vehicle, 1)
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
        {
            title = _T('rear_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollDownWindow(vehicle, 2)
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
        {
            title = _T('rear_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollDownWindow(vehicle, 3)
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
        {
            title = _T('all'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollDownWindow(vehicle, 0)
                RollDownWindow(vehicle, 1)
                RollDownWindow(vehicle, 2)
                RollDownWindow(vehicle, 3)
                lib.showContext('fenetrevoiturebaisser')
            end,
        },
    }
})


lib.registerContext({
    id = 'fenetrevoituremonter',
    title = _T('windows_up'),
    menu = 'voituremenu',
    options = {
        {
            title = _T('front_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollUpWindow(vehicle, 0)
                lib.showContext('fenetrevoituremonter')
            end,
        },
        {
            title = _T('front_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollUpWindow(vehicle, 1)
                lib.showContext('fenetrevoituremonter')
            end,
        },
        {
            title = _T('rear_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollUpWindow(vehicle, 2)
                lib.showContext('fenetrevoituremonter')
            end,
        },
        {
            title = _T('rear_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollUpWindow(vehicle, 3)
                lib.showContext('fenetrevoituremonter')
            end,
        },
        {
            title = _T('all'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                RollUpWindow(vehicle, 0)
                RollUpWindow(vehicle, 1)
                RollUpWindow(vehicle, 2)
                RollUpWindow(vehicle, 3)
                lib.showContext('fenetrevoituremonter')
            end,
        },
    }
})

lib.registerContext({
    id = 'ouvrirporte',
    title = _T('door_open_menu'),
    menu = 'voituremenu',
    options = {
        {
            title = _T('front_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 0, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('front_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 1, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('rear_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 2, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('rear_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 3, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('hood'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 4, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('trunk'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 5, false)
                lib.showContext('ouvrirporte')
            end,
        },
        {
            title = _T('all'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorOpen(vehicle, 0, false)
                SetVehicleDoorOpen(vehicle, 1, false)
                SetVehicleDoorOpen(vehicle, 2, false)
                SetVehicleDoorOpen(vehicle, 3, false)
                SetVehicleDoorOpen(vehicle, 4, false)
                SetVehicleDoorOpen(vehicle, 5, false)
                lib.showContext('ouvrirporte')
            end,
        },
    }
})


lib.registerContext({
    id = 'fermerporte',
    title = _T('door_close_menu'),
    menu = 'voituremenu',
    options = {
        {
            title = _T('front_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 0, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('front_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 1, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('rear_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 2, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('rear_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 3, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('hood'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 4, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('trunk'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 5, false)
                lib.showContext('fermerporte')
            end,
        },
        {
            title = _T('all'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleDoorShut(vehicle, 0, false)
                SetVehicleDoorShut(vehicle, 1, false)
                SetVehicleDoorShut(vehicle, 2, false)
                SetVehicleDoorShut(vehicle, 3, false)
                SetVehicleDoorShut(vehicle, 4, false)
                SetVehicleDoorShut(vehicle, 5, false)
                lib.showContext('fermerporte')
            end,
        },
    }
})

lib.registerContext({
    id = 'changerplace',
    title = _T('change_seat'),
    menu = 'voituremenu',
    options = {
        {
            title = _T('front_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
		        local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                lib.showContext('changerplace')
            end,
        },
        {
            title = _T('front_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
		        local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 0)
                lib.showContext('changerplace')
            end,
        },
        {
            title = _T('rear_left'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
		        local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 1)
                lib.showContext('changerplace')
            end,
        },
        {
            title = _T('rear_right'),
            icon = 'fa-solid fa-car',
            onSelect = function()
                local playerPed = GetPlayerPed(-1)
		        local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 2)
                lib.showContext('changerplace')
            end,
        },
    }
})
