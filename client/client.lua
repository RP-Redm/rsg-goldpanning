local QRCore = exports['qr-core']:GetCoreObject()
local entity

RegisterNetEvent('rsg-goldpanning:client:StartGoldPan')
AddEventHandler('rsg-goldpanning:client:StartGoldPan', function()
	local Panning = false
    if not Panning then 
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
		local canPan = false
		for k,v in pairs(Config.WaterTypes) do 
			if water == Config.WaterTypes[k]["waterhash"]  then
				canPan = true           
				break            
			end
		end
		if canPan then
			Panning = true
			CrouchAnimAndAttach()
			Wait(6000)
			ClearPedTasks(ped)
			GoldShake()
			local randomwait = math.random(12000,28000)
			Wait(randomwait)
			ClearPedTasks(ped)
			DeleteObject(entity)
			DeleteEntity(entity)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TriggerServerEvent('rsg-goldpanning:server:reward')
			Panning = false
        else
			QRCore.Functions.Notify('you need to be by the river to goldpan', 'primary')
        end
    else
		QRCore.Functions.Notify('you are already goldpanning!', 'error')
	end
end)

function CrouchAnimAndAttach()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    local modelHash = GetHashKey("P_CS_MININGPAN01X")
    LoadModel(modelHash)
    entity = CreateObject(modelHash, coords.x+0.3, coords.y,coords.z, true, false, false)
    SetEntityVisible(entity, true)
    SetEntityAlpha(entity, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
    SetModelAsNoLongerNeeded(modelHash)
    AttachEntityToEntity(entity,ped, boneIndex, 0.2, 0.0, -0.2, -100.0, -50.0, 0.0, false, false, false, true, 2, true)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function GoldShake()
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end