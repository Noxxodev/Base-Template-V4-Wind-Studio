------------------ MODIFIEZ CECI -------------------

-- Mettez cette valeur sur false si vous ne voulez pas que la météo change automatiquement toutes les 10 minutes.
DynamicWeather = true

---------------------------------------------------
debugprint = false -- ne touchez pas à ceci sauf si vous savez ce que vous faites ou si Vespura vous a demandé d’activer cela.
---------------------------------------------------

-------------------- NE PAS MODIFIER --------------------
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

function isAllowedToChange(player)
    local playerSRC = player
    local xPlayer = ESX.GetPlayerFromId(playerSRC)
    local rank = xPlayer.getGroup()    
    local allowed = false

    for k,needrank in pairs(Config.adminweather) do 
        if rank == needrank then
            allowed = true
        end
    end
    if allowed == false then
        TriggerClientEvent("esx:showNotification", playerSRC, _T('no_permission'))
    end
    return allowed
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('esx:showNotification', source, _T('time_frozen'))
            else
                TriggerClientEvent('esx:showNotification', source, _T('time_unfrozen'))
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _T('no_permission_chat'))
        end
    else
        freezeTime = not freezeTime
        print(freezeTime and _T('time_frozen_console') or _T('time_unfrozen_console'))
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('esx:showNotification', source, _T('weather_dynamic_off'))
            else
                TriggerClientEvent('esx:showNotification', source, _T('weather_dynamic_on'))
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _T('no_permission_chat'))
        end
    else
        DynamicWeather = not DynamicWeather
        print(DynamicWeather and _T('weather_unfrozen_console') or _T('weather_frozen_console'))
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local function isValidWeatherType(wtype)
            for _, type in ipairs(AvailableWeatherTypes) do
                if wtype == type then return true end
            end
            return false
        end

        if args[1] == nil then
            local errorMsg = (source == 0)
                and _T('weather_syntax_console')
                or _T('weather_syntax_chat')
            print(errorMsg)
            return
        end

        local newWeather = string.upper(args[1])
        if not isValidWeatherType(newWeather) then
            local validList = table.concat(AvailableWeatherTypes, ' ')
            local errorMsg = (source == 0)
                and _T('weather_invalid_console', validList)
                or _T('weather_invalid_chat', validList)
            print(errorMsg)
            return
        end

        CurrentWeather = newWeather
        newWeatherTimer = 10
        TriggerEvent('vSync:requestSync')
        print(_T('weather_updated'))
    elseif isAllowedToChange(source) then 
        local function isValidWeatherType(wtype)
            for _, type in ipairs(AvailableWeatherTypes) do
                if wtype == type then return true end
            end
            return false
        end

        if args[1] == nil then
            local errorMsg = (source == 0)
                and _T('weather_syntax_console')
                or _T('weather_syntax_chat')
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, errorMsg)
            return
        end

        local newWeather = string.upper(args[1])
        if not isValidWeatherType(newWeather) then
            local validList = table.concat(AvailableWeatherTypes, ' ')
            local errorMsg = (source == 0)
                and _T('weather_invalid_console', validList)
                or _T('weather_invalid_chat', validList)
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, errorMsg)
            return
        end

        CurrentWeather = newWeather
        newWeatherTimer = 10
        TriggerEvent('vSync:requestSync')
        TriggerClientEvent('esx:showNotification', source, _T('weather_will_change', string.lower(args[1])))
    end
end, false)

RegisterCommand('blackout', function(source)
    blackout = not blackout
    if source == 0 then
        print(blackout and _T('blackout_on_console') or _T('blackout_off_console'))
    elseif isAllowedToChange(source) then
        TriggerClientEvent('esx:showNotification', source, blackout and _T('blackout_on') or _T('blackout_off'))
        TriggerEvent('vSync:requestSync')
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then print(_T('time_console_hint')) return end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('esx:showNotification', source, _T('time_morning'))
        TriggerEvent('vSync:requestSync')
    end
end)

RegisterCommand('noon', function(source)
    if source == 0 then print(_T('time_console_hint')) return end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerClientEvent('esx:showNotification', source, _T('time_noon'))
        TriggerEvent('vSync:requestSync')
    end
end)

RegisterCommand('evening', function(source)
    if source == 0 then print(_T('time_console_hint')) return end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerClientEvent('esx:showNotification', source, _T('time_evening'))
        TriggerEvent('vSync:requestSync')
    end
end)

RegisterCommand('night', function(source)
    if source == 0 then print(_T('time_console_hint')) return end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerClientEvent('esx:showNotification', source, _T('time_night'))
        TriggerEvent('vSync:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - (((baseTime + timeOffset) % 60) - minute)
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ((((baseTime + timeOffset) / 60) % 24) - hour) * 60
end

RegisterCommand('time', function(source, args)
    local h, m = tonumber(args[1]), tonumber(args[2])
    if source == 0 then
        if h and m then
            ShiftToHour(math.min(h, 23))
            ShiftToMinute(math.min(m, 59))
            print(_T('time_changed_console', h, m))
            TriggerEvent('vSync:requestSync')
        else
            print(_T('time_syntax'))
        end
    elseif isAllowedToChange(source) then
        ShiftToHour(math.min(h or 0, 23))
        ShiftToMinute(math.min(m or 0, 59))
        TriggerClientEvent('esx:showNotification', source, _T('time_changed'))
        TriggerEvent('vSync:requestSync')
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
    if debugprint then
        print("[vSync] Un nouveau type de météo aléatoire a été généré : " .. CurrentWeather .. ".\n")
        print("[vSync] Le minuteur a été réinitialisé à 10 minutes.\n")
    end
end


