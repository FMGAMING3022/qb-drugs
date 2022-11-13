local QBCore = exports['qb-core']:GetCoreObject()
local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing, inCokeField = false, false, false

local function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

local function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(ped)
end


local function ProcessCoke()
	isProcessing = true
	local playerPed = PlayerPedId()
	
	local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'

    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
	FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
    knifeProp = CreateObject(GetHashKey('v_ret_gc_scissors'),PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
    AttachEntityToEntity(knifeProp, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.09, 0.02, 40.0, 0.0, 0.0, false, false, false, false, 2, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), Config.Delays.CokeProcessing, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processCocaLeaf')

		FreezeEntityPosition(GetPlayerPed(-1),false)
		DeleteEntity(knifeProp)
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		FreezeEntityPosition(GetPlayerPed(-1),false)
		DeleteEntity(knifeProp)
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end


local function ValidateCocaLeafCoord(plantCoord)
	local validate = true
	if spawnedCocaLeaf > 0 then
		for k, v in pairs(CocaPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inCokeField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZCoke(x, y)
	local groundCheckHeights = { 1.0, 25.0, 50.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end

local function GenerateCocaLeafCoords()
	while true do
		Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)

		weedCoordX = Config.CircleZones.CokeField.coords.x + modX
		weedCoordY = Config.CircleZones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

local function SpawnCocaPlants()
    while spawnedCocaLeaf < 15 do
        Wait(0)
        local weedCoords = GenerateCocaLeafCoords()
        RequestModel(`h4_prop_bush_cocaplant_01`)
        while not HasModelLoaded(`h4_prop_bush_cocaplant_01`) do
            Wait(100)
        end
        local obj = CreateObject(`h4_prop_bush_cocaplant_01`, weedCoords.x, weedCoords.y, weedCoords.z, false, true, false)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        table.insert(CocaPlants, obj)
        spawnedCocaLeaf += 1
    end
end


local function CutCokePowder()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processCocaPowder')

		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessBricks()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.packing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processCocaBrick')

		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('qb-drugs:ProcessCocaFarm', function()
	local coords = GetEntityCoords(PlayerPedId())

	if #(coords-Config.CircleZones.CokeProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					ProcessCoke()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coca_leaf = Config.CokeProcessing.CokeLeaf, trimming_scissors = 1})
		end
	end
end)

RegisterNetEvent('qb-drugs:ProcessCocaPowder', function()
	local coords = GetEntityCoords(PlayerPedId())
	local amount = 10
	local amount2 = 5
	
	if #(coords-Config.CircleZones.CokePowder.coords) < 5 then
		if not isProcessing then
			local check = {
				coke = Config.CokeProcessing.Coke,
				bakingsoda = Config.CokeProcessing.BakingSoda,
				finescale = 1
			}
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					CutCokePowder()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, check)
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('qb-drugs:ProcessBricks', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	local amount = 4
	
	if #(coords-Config.CircleZones.CokeBrick.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					ProcessBricks()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coke_small_brick = Config.CokeProcessing.SmallBrick, finescale = 1})
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)


RegisterNetEvent('qb-drugs:pickCocaLeaves', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #CocaPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 2 then
			nearbyObject, nearbyID = CocaPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

			QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.collecting"), 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				ClearPedTasks(playerPed)
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)

				table.remove(CocaPlants, nearbyID)
				spawnedCocaLeaf = spawnedCocaLeaf - 1

				TriggerServerEvent('qb-drugs:pickedUpCocaLeaf')
				isPickingUp = false
			end, function()
				ClearPedTasks(playerPed)
				isPickingUp = false
			end)
		end
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

RegisterCommand('clearskin', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

CreateThread(function()
	local cokeZone = CircleZone:Create(Config.CircleZones.CokeField.coords, 10.0, {
		name = "ps-cokezone",
		debugPoly = false
	})
	cokeZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inCokeField = true
            SpawnCocaPlants()
        else
            inCokeField = false
        end
    end)
end)
