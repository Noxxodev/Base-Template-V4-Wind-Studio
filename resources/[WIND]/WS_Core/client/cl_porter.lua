local carry = {
	EnCours = false,
	cibleSrc = -1,
	type = "",
	personnePorteuse = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personnePortee = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

local function afficherNotificationNative(texte)
    SetTextComponentFormat("STRING")
    AddTextComponentString(texte)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function ObtenirJoueurLePlusProche(rayon)
    local joueurs = GetActivePlayers()
    local distanceLaPlusProche = -1
    local joueurLePlusProche = -1
    local moi = PlayerPedId()
    local mesCoords = GetEntityCoords(moi)

    for _, idJoueur in ipairs(joueurs) do
        local ciblePed = GetPlayerPed(idJoueur)
        if ciblePed ~= moi then
            local coordsCible = GetEntityCoords(ciblePed)
            local distance = #(coordsCible - mesCoords)
            if distanceLaPlusProche == -1 or distanceLaPlusProche > distance then
                joueurLePlusProche = idJoueur
                distanceLaPlusProche = distance
            end
        end
    end
	if distanceLaPlusProche ~= -1 and distanceLaPlusProche <= rayon then
		return joueurLePlusProche
	else
		return nil
	end
end

local function chargerAnimation(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end        
    end
    return animDict
end

RegisterCommand("porter", function(source, args)
    if not carry.EnCours then
        local joueurProche = ObtenirJoueurLePlusProche(3)
        if joueurProche then
            local cibleSrc = GetPlayerServerId(joueurProche)
            if cibleSrc ~= -1 then
                carry.EnCours = true
                carry.cibleSrc = cibleSrc
                TriggerServerEvent("CarryPeople:sync", cibleSrc)
                chargerAnimation(carry.personnePorteuse.animDict)
                carry.type = "porter"
            else
                afficherNotificationNative(_T('nobody_to_carry'))
            end
        else
            afficherNotificationNative(_T('nobody_to_carry'))
        end
    else
        carry.EnCours = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("CarryPeople:stop", carry.cibleSrc)
        carry.cibleSrc = 0
    end
end, false)

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(cibleSrc)
	local ciblePed = GetPlayerPed(GetPlayerFromServerId(cibleSrc))
	carry.EnCours = true
	chargerAnimation(carry.personnePortee.animDict)
	AttachEntityToEntity(PlayerPedId(), ciblePed, 0, carry.personnePortee.attachX, carry.personnePortee.attachY, carry.personnePortee.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "etreporte"
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.EnCours = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.EnCours then
			if carry.type == "etreporte" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personnePortee.animDict, carry.personnePortee.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personnePortee.animDict, carry.personnePortee.anim, 8.0, -8.0, 100000, carry.personnePortee.flag, 0, false, false, false)
				end
			elseif carry.type == "porter" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personnePorteuse.animDict, carry.personnePorteuse.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personnePorteuse.animDict, carry.personnePorteuse.anim, 8.0, -8.0, 100000, carry.personnePorteuse.flag, 0, false, false, false)
				end
			end
		end
		Wait(1)
	end
end)
