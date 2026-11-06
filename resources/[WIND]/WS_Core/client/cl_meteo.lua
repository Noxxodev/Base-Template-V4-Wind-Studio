CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

-- Événement pour mettre à jour la météo
RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NouvelleMeteo, nouveauBlackout)
    CurrentWeather = NouvelleMeteo
    blackout = nouveauBlackout
end)

-- Thread de synchronisation météo
Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0) -- Transition météo en 15 secondes
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Petite pause pour éviter les crashs
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

-- Événement pour mettre à jour l'heure
RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

-- Thread de synchronisation de l'heure
Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(1)
        local newBaseTime = baseTime
        if GetGameTimer() - 500 > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime + timeOffset) / 60) % 24)
        minute = math.floor((baseTime + timeOffset) % 60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

-- Demande la synchronisation au spawn du joueur
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

-- Ajout des suggestions de commandes dans le chat
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', _T('sugg_weather'), {
        { name = _T('sugg_weather_param'), help = _T('sugg_weather_help') .. "extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween" }
    })
    TriggerEvent('chat:addSuggestion', '/time', _T('sugg_time'), {
        { name = _T('sugg_hours'), help = _T('sugg_hours_help') },
        { name = _T('sugg_minutes'), help = _T('sugg_minutes_help') }
    })
    TriggerEvent('chat:addSuggestion', '/freezetime', _T('sugg_freezetime'))
    TriggerEvent('chat:addSuggestion', '/freezeweather', _T('sugg_freezeweather'))
    TriggerEvent('chat:addSuggestion', '/morning', _T('sugg_morning'))
    TriggerEvent('chat:addSuggestion', '/noon', _T('sugg_noon'))
    TriggerEvent('chat:addSuggestion', '/evening', _T('sugg_evening'))
    TriggerEvent('chat:addSuggestion', '/night', _T('sugg_night'))
    TriggerEvent('chat:addSuggestion', '/blackout', _T('sugg_blackout'))
end)


