local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    exports["qb-target"]:AddBoxZone("chemmenu", vector3(4836.51, -5174.69, 2.19), 1.65, 2.4, {
        name = "chemmenu",
        heading = 290,
        debugPoly = false,
        minZ = 0.26,
        maxZ = 3.74,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:chemicalmenu",
                icon = "fas fa-vials",
                label = Lang:t("target.chemmenu"),
            },
        },
    distance = 2.5
    })
    exports["qb-target"]:AddBoxZone("methprocess", vector3(-50.8, 6376.23, 29.29), 1.6, 1.8, {
        name = "methprocess",
        heading = 315,
        debugPoly = false,
        minZ = 25.74,
        maxZ = 29.74,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ProcessChemicals",
                icon = "fas fa-vials",
                label = Lang:t("target.methprocess"),
            },
        },
    distance = 3.5
    })

    exports["qb-target"]:AddBoxZone("lsdprocess", Config.CircleZones.lsdProcessing.coords, 2.0, 2.0, {
        name = "lsdprocess",
        heading = 280,
        debugPoly = false,
        minZ = 107.36,
        maxZ = 111.36,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:lsdprocessingTarget",
                icon = "fas fa-vials",
                label = "Process LSD",
            },
        },
    distance = 3.5
    })

    exports["qb-target"]:AddBoxZone("methtempup", vector3(-49.2, 6372.51, 28.82), 1.2, 1.4, {
        name = "methtempup",
        heading = 310,
        debugPoly = false,
        minZ = 25.87,
        maxZ = 29.87,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ChangeTemp",
                icon = "fas fa-temperature-empty",
                label = Lang:t("target.methtempup"),
            },
        },
    distance = 3.5
    })
    exports["qb-target"]:AddBoxZone("methtempdown", vector3(-52.3, 6371.51, 28.81), 1.2, 0.5, {
        name = "methtempdown",
        heading = 315,
        debugPoly = false,
        minZ = 25.51,
        maxZ = 29.51,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ChangeTemp2",
                icon = "fas fa-temperature-full",
                label = Lang:t("target.methtempdown"),
            },
        },
    distance = 3.5
    })
    exports["qb-target"]:AddBoxZone("methbagging", vector3(-50.63, 6365.68, 28.82), 7.65, 1.2, {
        name = "methbagging",
        heading = 315,
        debugPoly = false,
        minZ = 24.82,
        maxZ = 28.82,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ProcessProduct",
                icon = "fas fa-box",
                label = Lang:t("target.bagging"),
            },
        },
    distance = 3.5
    })

    exports["qb-target"]:AddBoxZone("cokeleafproc", vector3(880.35, -1148.58, 26.04), 2.5, 1.4, {
        name = "cokeleafproc",
        heading=270,
        minZ=21.99,
        maxZ=25.99,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ProcessCocaFarm",
                icon = "fas fa-scissors",
                label = Lang:t("target.cokeleafproc"),
            },
        },
    distance = 3.5
    })
    exports["qb-target"]:AddBoxZone("cokepowdercut", vector3(881.37, -1142.91, 26.04), 7.65, 1.2, {
        name = "cokepowdercut",
        heading = 180,
        debugPoly = false,
        minZ=21.99,
        maxZ=25.99,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ProcessCocaPowder",
                icon = "fas fa-weight-scale",
                label = Lang:t("target.cokepowdercut"),
            },
        },
    distance = 3.5
    })
    exports["qb-target"]:AddBoxZone("cokebricked", vector3(880.18, -1133.99, 26.04), 2.6, 1.0, {
        name = "cokebricked",
        heading = 270,
        debugPoly = false,
        minZ=21.99,
        maxZ=25.99,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:ProcessBricks",
                icon = "fas fa-weight-scale",
                label = Lang:t("target.bagging"),
            },
        },
    distance = 3.5
    })
    exports["qb-target"]:AddBoxZone("weedproces", vector3(2328.53, 2570.99, 46.61), 2.5, 2.5, {
        name = "weedproces",
        heading = 331.74,
        debugPoly = false,
        minZ = 45.99,
        maxZ = 47.59,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:processWeed",
                icon = "fas fa-envira",
                label = Lang:t("target.weedproces"),
            },
        },
    distance = 3.5
    })
	exports["qb-target"]:AddBoxZone("heroinproces", vector3(1656.26, 6.55, 166.12), 2.5, 2.5, {
        name = "heroinproces",
        heading = 306,
        debugPoly = false,
        minZ = 163.37,
        maxZ = 167.37,
    }, {
        options = {
            {
                type = "client",
                event = "qb-drugs:processHeroin",
                icon = "fas fa-envira",
                label = Lang:t("target.heroinproces"),
            },
        },
    distance = 3.5
    })
    exports['qb-target']:AddBoxZone("thychloride", vector3(-674.45, 5832.35, 17.33), 1, 1, {
		name="thychloride",
		heading=45,
		debugPoly=false,
		minZ = 13.28,
		maxZ = 17.28,
	},{
	   options = {
			{
				type = "client",
				event = "qb-drugs:processingThiChlo",
				icon = "fas fa-biohazard",
				label = Lang:t("target.process_thionyl_chloride"),
			},
		},
	distance = 2.5
	})
    exports['qb-target']:AddBoxZone("heroinproc", vector3(1413.7, -2041.77, 52.0), 1, 1, {
		name="heroinproc",
		heading=352.15,
		debugPoly=false,
		minZ = 51.00,
		maxZ = 53.00,
	},{
	    options = {
			{
				type = "client",
				event = "qb-drugs:ProcessPoppy",
				icon = "fas fa-leaf",
				label = Lang:t("target.heroinproc"),
			},
			},
	distance = 2.5
	})
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel("h4_prop_bush_cocaplant_01", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickCocaLeaves",
                icon = "fas fa-leaf",
                label = Lang:t("target.pickCocaLeaves"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("prop_plant_01b", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickHeroin",
                icon = "fas fa-leaf",
                label = Lang:t("target.pickHeroin"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mw_weed_plant", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickWeed",
                icon = "fas fa-envira",
                label = Lang:t("target.pickWeed"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mw_sodium_barrel", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickSodium",
                icon = "fas fa-dna",
                label = Lang:t("target.pickSodium"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mw_sulfuric_barrel", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickSulfuric",
                icon = "fas fa-shield-virus",
                label = Lang:t("target.pickSulfuric"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mw_chemical_barrel", {
        options = {
            {
                type = "client",
                event = "qb-drugs:pickChemicals",
                icon = "fas fa-radiation",
                label = Lang:t("target.pickChemicals"),
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mw_hydro_barrel", {
        options = {
            {
                type = "client",
                event = "qb-drugs:client:hydrochloricacid",
                icon = "fas fa-radiation",
                label = Lang:t("target.hydrochloricacid"),
            },
        },
        distance = 4.0
    })
end)
