Config = {}

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 15,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.CircleZones = {
	WeedField = {coords = vector3(5206.13, -5203.34, 15.33), name = ('Weed Farm'), radius = 100.0},
	WeedProcessing = {coords = vector3(2329.12, 2571.86, 46.68), name = ('Weed Process'), radius = 100.0},
	MethProcessing = {coords = vector3(-50.8, 6376.23, 29.29), name = ('Meth Process'), radius = 20.0},
	MethTemp = {coords = vector3(-49.2, 6372.51, 28.82), name = ('Meth Temperature'), radius = 20.0},
	MethBag = {coords = vector3(-50.63, 6365.68, 28.82), name = ('Meth Bagging'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(5457.87, -5469.61, 35.53), name = ('Hydrochloric Acid'), radius = 100.0},
	SulfuricAcidFarm = {coords = vector3(2717.36, 1494.77, 24.5), name = ('Sulfuric Acid'), radius = 100.0},
	SodiumHydroxideFarm = {coords = vector3(-2161.6, 2672.8, 2.84), name = ('Sodium Hydroxide'), radius = 100.0},
	ChemicalsField = {coords = vector3(-1304.81, 5362.57, 2.86), name = ('Chemicals'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(4836.51, -5174.69, 2.19), name = ('Chemicals Process'), radius = 100.0},
	CokeField = {coords = vector3(1857.82, 4897.67, 44.4), name = ('Coke'), radius = 100.0},
	CokeProcessing = {coords = vector3(880.35, -1148.58, 26.04), name = ('Coke Process'), radius = 20.0}, 
	CokePowder = {coords = vector3(881.37, -1142.91, 26.04), name = ('Powder Cutting'), radius = 20.0},
	CokeBrick = {coords = vector3(880.18, -1133.99, 26.04), name = ('Brick Up Packages'), radius = 20.0},
	HeroinField = {coords = vector3(4871.63, -5614.74, 27.96), name = ('Heroin'), radius = 100.0},
	HeroinProcessing = {coords = vector3(1656.26, 6.55, 166.12), name = ('Heroin Process'), radius = 100.0},
	lsdProcessing = {coords = vector3(1532.86, 1728.39, 109.96), name = ('LSD process'), radius = 100.0},
	thionylchlorideProcessing = {coords = vector3(-674.45, 5832.35, 17.33), name = ('Thi Clo Process'), radius = 100.0},
}



Config.CokeProcessing = {
	CokeLeaf = 1,
	ProcessCokeLeaf = math.random(2,7), 
	Coke = 10, 
	BakingSoda = 5, 
	SmallCokeBrick = math.random(2,7),
	finescale = 1,
	SmallBrick = 4, 
	LargeBrick = 1, 
}


Config.MethProcessing = {
	SulfAcid = 1, 
	HydAcid = 1, 
	SodHyd = 1, 
	Meth = math.random(5,12), 
}


Config.HeroinProcessing = {
	Poppy = 2 
}