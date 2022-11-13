local isPickingUp, isProcessing = false, false
local QBCore = exports['qb-core']:GetCoreObject()

local function Processlsd()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:Processlsd')

		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function Processthionylchloride()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('qb-drugs:processThionylChloride')

		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('qb-drugs:lsdprocessingTarget', function()
	QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
		if result.ret then
			Processlsd()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {lsa = 1, thionyl_chloride = 1})
end)


RegisterNetEvent('qb-drugs:processingThiChlo', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.thionylchlorideProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('qb-drugs:validate_items', function(result)
				if result.ret then
					Processthionylchloride()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {lsa = 1, chemicals = 1})
		end
	end
end)
