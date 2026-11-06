ESX = exports["es_extended"]:getSharedObject()

RegisterKeyMapping('menuadmin', _T('keymapping_menu'), 'keyboard', 'F10')

RegisterKeyMapping('adminnoclip', _T('keymapping_noclip'), 'keyboard', 'F9')

RegisterCommand('menuadmin', function()
    staff_menu()
end)

RegisterCommand('adminnoclip', function()
    noclip()
end)

function staff_menu()
    ESX.TriggerServerCallback('WS_Admin:getgroup', function(access)
        if access then
            lib.registerMenu({
                id = 'menu_staff',
                title = _T('menu_title'),
                position = positionmenu,
                options = {
                    {label = _T('heal'), icon = "heart-pulse", iconColor = "#ef4444"},
                    {label = _T('revive'), icon = "user-plus", iconColor = "#22c55e"},
                    {label = _T('tp_marker'), icon = "location-arrow", iconColor = "#3b82f6"},
                    {label = _T('tp_to_player'), icon = "person-walking", iconColor = "#3b82f6"},
                    {label = _T('bring_player'), icon = "people-arrows", iconColor = "#3b82f6"},
                    {label = _T('spawn_vehicle'), icon = "car", iconColor = "#f59e0b"},
                    {label = _T('repair'), icon = "screwdriver-wrench", iconColor = "#22c55e"},
                    {label = _T('clean'), icon = "spray-can-sparkles", iconColor = "#60a5fa"},
                    {label = _T('delete'), icon = "trash", iconColor = "#dc2626"},
                }
            }, function(selected, scrollIndex, args)
                if selected == 1 then
                    ExecuteCommand("heal me")

                elseif selected == 2 then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)

                    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
                    SetEntityHealth(ped, 200)
                    ClearPedTasksImmediately(ped)
                    ClearPedBloodDamage(ped)
                    ResetPedVisibleDamage(ped)
                    ClearPedLastWeaponDamage(ped)

                    TriggerEvent('esx_basicneeds:resetStatus')
                    TriggerEvent('esx:onPlayerSpawn')

                elseif selected == 3 then
                    local playerped = PlayerPedId()
                    local markerpoint = GetFirstBlipInfoId(8)

                    if DoesBlipExist(markerpoint) then
                        Citizen.CreateThread(function()
                            local markercoords = GetBlipInfoIdCoord(markerpoint)
                            local foundGround, zCoords, zPos = false, -500.0, 0.0

                            while not foundGround do
                                zCoords = zCoords + 10.0
                                RequestCollisionAtCoord(markercoords.x, markercoords.y, zCoords)
                                Citizen.Wait(1)
                                foundGround, zPos = GetGroundZFor_3dCoord(markercoords.x, markercoords.y, zCoords)

                                if not foundGround and zCoords >= 2000.0 then
                                    foundGround = true
                                end
                            end

                            SetPedCoordsKeepVehicle(playerped, markercoords.x, markercoords.y, zPos)
                            ESX.ShowNotification(_T('tp_marker_success'), "success")
                        end)
                    else
                        ESX.ShowNotification(_T('no_marker'), "error")
                    end

                elseif selected == 4 then
                    local input = lib.inputDialog(_T('input_tp_to_player'), {
                        {type = 'number', label = _T('input_id')},
                    })

                    if not input then return end
                    TriggerServerEvent('WS_Admin:gotoplayer', input[1])

                elseif selected == 5 then
                    local input = lib.inputDialog(_T('input_bring_player'), {
                        {type = 'number', label = _T('input_id')},
                    })

                    if not input then return end
                    TriggerServerEvent('WS_Admin:bringplayer', input[1])

                elseif selected == 6 then
                    local input = lib.inputDialog(_T('input_spawn_vehicle'), {
                        {type = 'input', label = _T('input_name')},
                    })

                    if not input then return end
                    TriggerServerEvent('WS_Admin:spawncar', input[1])

                elseif selected == 7 then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                    if vehicle and DoesEntityExist(vehicle) then
                        SetVehicleFixed(vehicle)
                        ESX.ShowNotification(_T('vehicle_repaired'), "success")
                    else
                        ESX.ShowNotification(_T('no_vehicle'), "error")
                    end

                elseif selected == 8 then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                    if vehicle and DoesEntityExist(vehicle) then
                        SetVehicleDirtLevel(vehicle, 0.0)
                        ESX.ShowNotification(_T('vehicle_cleaned'), "success")
                    else
                        ESX.ShowNotification(_T('no_vehicle'), "error")
                    end

                elseif selected == 9 then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                    if vehicle and DoesEntityExist(vehicle) then
                        DeleteEntity(vehicle)
                        ESX.ShowNotification(_T('vehicle_deleted'), "success")
                    else
                        ESX.ShowNotification(_T('no_vehicle'), "error")
                    end
                end
            end)

            lib.showMenu('menu_staff')
        else
            ESX.ShowNotification(_T('no_permission'), "error")
        end
    end)
end



local active = false
local speed = 1.0

function noclip()
    ESX.TriggerServerCallback('WS_Admin:getgroup', function(access)
        if access then
            local ped = PlayerPedId()

            if active then 
                active = false
                activenoclip(false)

                SetEntityInvincible(ped, false)
                SetEntityVisible(ped, true, false)
                FreezeEntityPosition(ped, false)
                SetEntityCollision(ped, true, true)
                SetPedGravity(ped, true)

            else
                active = true
                activenoclip(true)

                SetEntityInvincible(ped, true)
                FreezeEntityPosition(ped, true)
                SetEntityCollision(ped, false, false)
                SetPedGravity(ped, false)
                SetEntityVisible(ped, false, false)

                ESX.ShowNotification(_T('noclip_on'), "success")
            end
        else
            ESX.ShowNotification(_T('no_permission'), "error")
        end
    end)
end

function activenoclip(state)
    local ped = PlayerPedId()

    if not state then
        ESX.ShowNotification(_T('noclip_off'), "error")
        return
    end

    Citizen.CreateThread(function()
        while active do
            local waitTime = 10000
            local entity = ped
            local x, y, z = table.unpack(GetEntityCoords(entity, true))
            local dx, dy, dz = GetCamDirection()
            
    
            local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(ped)
            SetEntityHeading(entity, heading)
    
            SetEntityVelocity(entity, 0.0, 0.0, 0.0)
            waitTime = 10  
    
            -- Déplacement Avant / Arrière
            if IsControlPressed(0, 71) then -- Avancer
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end
    
            if IsControlPressed(0, 72) then -- Reculer
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end
    
            -- Monter/Descendre
            if IsControlPressed(0, 22) then -- Monter
                z = z + speed
            end
    
            if IsControlPressed(0, 36) then -- Descendre
                z = z - speed
            end
    
            -- Gestion de la vitesse
            if IsControlJustPressed(1, 241) then
                speed = math.min(speed + 0.5, 10.0)
            end
            
            if IsControlJustPressed(1, 242) then
                speed = math.max(speed - 0.5, 0.1)
            end
    
            SetEntityCoordsNoOffset(entity, x, y, z, true, true, false)
    
            if not active then
                break
            end
    
            Wait(waitTime)
        end
    end)
    
end

function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)

    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end

    return x, y, z
end
