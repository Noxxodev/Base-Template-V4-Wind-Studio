ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    --[[local point = {}
    while true do 
        for k,v in pairs(Config.teleporation) do
            local hash = GetHashKey(v.nameped)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(100)
            end
        
            local ped = CreatePed(4, hash, v.pos.x, v.pos.y, v.pos.z - 1.0, v.pos.h, false, true)
            SetBlockingOfNonTemporaryEvents(ped, v.blocking)
            SetEntityInvincible(ped, v.invincible)
            FreezeEntityPosition(ped, v.freeze)
        
            exports.qtarget:AddBoxZone("pointdeteleportation", vector3(v.pos.x, v.pos.y, v.pos.z), 1.0 , 1.5, {
                name = "pointdeteleportation",
                heading = v.pos.h,
                debugPoly = false,
                minZ = v.pos.z - 1.0,
                maxZ = v.pos.z + 1.0,
            }, {
                options = {
                    {
                        event = "WS_pointdeteleportation:pointdetp",
                        icon = v.icon,
                        label = v.titre,
                        id = v.id,
                    },
                },
                distance = v.distance
            })

            Wait(1)
        end
        break    
    end]]

    for k,v in pairs(Config.teleporation) do 
        if v.blips.active then 
            local blip = AddBlipForCoord(v.blips.pos.x, v.blips.pos.y, v.blips.pos.z)
            SetBlipSprite(blip, v.blips.sprite)
            SetBlipScale(blip, v.blips.scale)
            SetBlipColour(blip, v.blips.colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.blips.name)
            EndTextCommandSetBlipName(blip)
        end

        if v.ped.active then 
            local hash = GetHashKey(v.ped.nameped)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(100)
            end
        
            local ped = CreatePed(4, hash, v.ped.pos.x, v.ped.pos.y, v.ped.pos.z - 1.0, v.ped.pos.h, false, true)
            SetBlockingOfNonTemporaryEvents(ped, v.ped.blocking)
            SetEntityInvincible(ped, v.ped.invincible)
            FreezeEntityPosition(ped, v.ped.freeze)
        end

        exports.qtarget:AddBoxZone("pointdeteleportation", vector3(v.ox_target.pos.x, v.ox_target.pos.y, v.ox_target.pos.z), 1.0 , 1.5, {
            name = "pointdeteleportation",
            heading = v.ox_target.pos.h,
            debugPoly = false,
            minZ = v.ox_target.pos.z - 1.0,
            maxZ = v.ox_target.pos.z + 1.0,
        }, {
            options = {
                {
                    event = "WS_pointdeteleportation:pointdetp",
                    icon = v.ox_target.icon,
                    label = v.ox_target.titre,
                    id = k
                },
            },
            distance = v.ox_target.distance
        })
    end
end)


RegisterNetEvent('WS_pointdeteleportation:pointdetp')
AddEventHandler('WS_pointdeteleportation:pointdetp', function(data)  
    local options = {}

    for k,v in pairs(Config.teleporation) do 
        if data.id == k then 
            for _, info in pairs(v.position) do
                table.insert(options, {
                    title = info.label,
                    onSelect = function()
                        TriggerServerEvent("WS_pointdeteleportation:teleporation", info.pos, info.label)
                    end,
                })
            end
        end
    end

    lib.registerContext({
        id = 'menu_teleportation',
        title = _T('teleport_menu'),
        options = options
    })

    lib.showContext('menu_teleportation')
end)