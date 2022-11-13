local  isProcessing, isTempChangeU, isTempChangeD, isBagging = false, false, false, false
local Methlab = false
local QBCore = exports['qb-core']:GetCoreObject()

local function ProcessChemicals()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processChemicals')

		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessTempUp()
	isTempChangeU = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.temp_up"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processTempUp')

		ClearPedTasks(playerPed)
		isTempChangeU = false
	end, function()
		ClearPedTasks(playerPed)
		isTempChangeU = false
	end)
end

local function ProcessTempDown()
	isTempChangeD = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.temp_down"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processTempDown')

		ClearPedTasks(playerPed)
		isTempChangeD = false
	end, function()
		ClearPedTasks(playerPed)
		isTempChangeD = false
	end)
end

local function ProcessProduct()
	isBagging = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.packing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processMeth')

		ClearPedTasks(playerPed)
		isBagging = false
	end, function()
		ClearPedTasks(playerPed)
		isBagging = false
	end)
end

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

RegisterNetEvent('qb-drugs:ProcessChemicals', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.MethProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					ProcessChemicals()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {sulfuric_acid = Config.MethProcessing.SulfAcid, hydrochloric_acid = Config.MethProcessing.HydAcid, sodium_hydroxide = Config.MethProcessing.SodHyd})
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('qb-drugs:ChangeTemp', function()
	if not isTempChangeU then
		QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
			if result then
						QBCore.Functions.Notify(Lang:t("success.temp_up"), 'success')
						ProcessTempUp()
					else
						TriggerServerEvent('qb-drugs:cancelProcessing')
						TriggerServerEvent('qb-drugs:processFailUp')
				QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
			end
		end, {liquidmix = 1})
	else
		QBCore.Functions.Notify(Lang:t("error.enough_temp"), 'error')
	end
end)


RegisterNetEvent('qb-drugs:ChangeTemp2', function()
	if not isTempChangeU then
		QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
			if result then
						QBCore.Functions.Notify(Lang:t("success.temp_down"), 'success')
						ProcessTempDown()
					else
						TriggerServerEvent('qb-drugs:cancelProcessing')
						TriggerServerEvent('qb-drugs:processFailUp')

				QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
			end
		end, {chemicalvapor = 1})
	else
		QBCore.Functions.Notify(Lang:t("error.enough_temp"), 'error')
	end
end)


RegisterNetEvent('qb-drugs:ProcessProduct', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.MethBag.coords) < 5 then
		if not isBagging then
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					ProcessProduct()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {methtray=1})
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)
