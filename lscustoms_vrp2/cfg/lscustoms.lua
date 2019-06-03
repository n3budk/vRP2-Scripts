local cfg = {}

cfg.modshop_types = {
  ["Mod Shop"] = {
    _config = {map_entity = {"PoI", {blip_id = 72, blip_color = 4}}},
	}
}


cfg.modshops = {
  {"Mod Shop",-211.53735351562,-1324.2878417968,30.890403747558}, --Benny's Motoworks
  {"Mod Shop",-336.92004394532,-137.4234161377,39.009666442872}, --Los Santos Customs
  {"Mod Shop",733.67822265625,-1088.7719726562,22.168996810914}, --LA Mesa LSC
  {"Mod Shop",1174.2283935546,2638.7834472656,37.763023376464}, --Sandy LSC"
  {"Mod Shop",109.39938354492,6627.7421875,31.787231445312}, --Beekers Garage
}

  
shops = { 
	[0] = {coords = {x = -211.53, y = -1324.28}, title = "Benny's Motoworks"},
	[1] = {coords = {x = -336.92, y = -137.42}, title = "Los Santos Customs"},
	[2] = {coords = {x = 733.67, y = -1088.77}, title = "LA Mesa LSC"},
	[3] = {coords = {x = 1174.22, y = 2638.78}, title = "Sandy LSC"},
	[4] = {coords = {x = 109.39, y = 6627.74}, title = "Beekers Garage"}
}

controls = {up = 27, down = 173, sel = 201, back = 177}


allowGuns = false
allowBPTyres = false
defaultVehPrice = 1500 --Set a vehicle price to calculate the price of each mod 2000 - 8000 average - or set a price below in the messy config

freeText = "No Cost"
cleanfix = 250 -- Price to clean and fix
cfg.minwallet = 100 -- Minimum amount of wallet to enter, can be set to 0
stockText = "Stock"
extraText = "Extra"
mainMenuText = "Main Menu"
customColourText = "Custom Color"
notEnoughMoneyText = "Not enough money"
inviteText = "~n~Press ~r~Enter~w~ to activate~n~~b~"


colNames = {
"Black", "Graphite Black", "Black Steel", "Dark Silver", "Silver", "Blue Silver",
"Steel Gray", "Black Silver", "Stone Silver", "Blue Silver", "Gunsmith",
"Anthracite Gray", "Black", "Gray", "Light Gray", "Black", "Black Polymer",
"Dark Silver", "Silver", "Weapon Metal", "Dark Silver", "Black", "Graphite",
"Silver Gray", "Silver", "Blue Silver", "Black Silver", "Red", "Wine Red",
"Formula Red", "Hot Red", "Elegant Red", "Garnet Red", "Desert Red",
"Cabernet Red", "Candy Red", "Dawn Orange", "Classic Gold", "Orange", "Red",
"Dark red", "Orange", "Yellow", "Red", "Bright red", "Garnet red", "Red",
"Golden red", "Dark red", "Dark green", "Racing green", "Sea green",
"Olive green", "Green", "Petrol blue-green", "Lime green", "Dark green",
"Green", "Dark Green", "Green", "Sea", "Midnight Blue", "Dark Blue",
"Saxon Blue", "Blue", "Seaman Blue", "Coastal Blue", "Diamond Blue", "Wave Color",
"Sea blue", "Bright blue", "Purple blue", "Sailing blue", "Ultra-blue", "Bright blue",
"Dark Blue", "Midnight Blue", "Blue", "Sea Foam", "Lightning", "Blue Polymer", "Bright Blue",
"Dark blue", "Blue", "Midnight blue", "Dark blue", "Blue", "Blue", "Taxi yellow",
"Racing Yellow", "Bronze", "Yellow Bird", "Lime", "Champagne", "Beige", "Dark ivory",
"Chocolate Brown", "Golden Brown", "Light Brown", "Straw Beige",
"Brown Moss", "Biston Brown", "Beech", "Dark Beech", "Chocolate Orange", "Beach Sand",
"Sun-bleached sand", "Cream", "Brown", "Mild brown", "Light brown",
"White", "Frosty White", "Honey Beige", "Brown", "Dark Brown", "Straw Beige",
"Polished steel", "Polished black steel", "Polished aluminum", "Chrome", "Faded white",
"Faded White", "Orange", "Light Orange", "Protective Green", "Taxi Yellow", "Gentle Blue",
"Green", "Brown", "Orange", "White", "White", "Army Green", "Pure White",
"Bright Pink", "Salmon Pink", "Scarlet Pink", "Orange", "Green", "Blue", "Black-Blue",
"Dark Purple", "Black and Red", "Hunting Green", "Purple", "Dark Blue", "Modshop B",
"Purple", "Dark Purple", "Lava Red", "Forest Green", "Dim Olive", "Desert Brown",
"Desert Tan", "Leafy Green", "Base Metal", "Epsilon Blue", "Pure Gold", "Polished Gold"
}

colInd = {
	metallic = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 49, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 66, 67, 68, 69, 127, 70, 71, 72, 73, 74, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 125, 137, 141, 142, 143, 145, 146, 150, 135, 136, 138, 139, 140, 144, 147, 157, 111, 112, 134},
	util = {15, 16, 17, 18, 19, 20, 43, 44, 45, 56, 57, 75, 76, 77, 78, 79, 80, 81, 108, 109, 110, 122},
	matte = {12, 13, 39, 40, 41, 42, 55, 82, 83, 84, 128, 129, 131, 148, 149, 151, 152, 153, 154, 155},
	worn = {21, 22, 23, 24, 25, 26, 46, 47, 48, 58, 59, 60, 85, 86, 87, 113, 114, 115, 116, 121, 123, 124, 126, 130, 132, 133},
	metal = {120, 156, 117, 118, 119, 159, 158}
}

neonLayouts = {"Both Sides", "Front", "Back"}

colours = { 
	{name = "White", 				colour = {255,255,255}	},
	{name = "Black", 				colour = {1,1,1}		},
	{name = "Blue", 				colour = {0,0,255}		},
	{name = "Electric blue", 	colour = {0,150,255}	},
	{name = "Mint Green", 		colour = {50,255,155}	},
	{name = "Lime Green", 	colour = {0,255,0}		},
	{name = "Yellow", 				colour = {255,255,0}	},
	{name = "Sunny Yellow", 	colour = {255,245,170}	},
	{name = "Crimson Red", 	colour = {255,0,30}		},
	{name = "Gold", 				colour = {204,204,0}	},
	{name = "Orange", 			colour = {255,128,0}	},
	{name = "Red", 				colour = {255,0,0}		},
	{name = "Pony Red", 		colour = {255,102,255}	},
	{name = "Hot Pink", 		colour = {255,0,255}	},
	{name = "Purple", 			colour = {153,0,153}	}
}

unlisted = {
	[11] = {"Engine Mod, Level 1", "Engine Mod, Level 2", "Engine Mod, Level 3", "Engine Mod, Level 4"},
	[12] = {"Street Brakes", "Sports Brakes", "Racing Brakes"},
	[13] = {"Street transmission", "Sports transmission", "Racing transmission", "Super Transmission"},
	[14] = {"Truck", "Policeman", "Clown", "Musical 1", "Musical 2", "Musical 3", "Musical 4",
	"Musical 5", "Sad trombone", "Classic  1", "Classic  2", "Classic  3", "Classic  4",
	"Classic 5", "Classic 6", "Classic 7", "Do", "Re", "Mi", "Fa", "So", "La", "Te", "High",
	"Jazz 1", "Jazz 2", "Jazz 3", "Jazz (repeat)", "Anthem 1", "Anthem 2", "Anthem 3", "Anthem 4",
	"Classic (repeat) 1", "Classic 8", "Classic (repeat) 2", "Classic 9", "Classic 10",
	"Classic 11", "Classic (repeat) 3", "Classic 12", "Classic (repeat) 4", "Classic 13",
	"Theme 1 (repeat)", "Theme 1", "Theme 2 (repeat)", "Theme 2", "Christmas 1 (repeat)",
	"Christmas 2 (repeat)", "Classic (repeat) 5"},
	[15] = {"Lowered suspension", "Street suspension", "Sports suspension", "Competitive suspension"},
	[16] = {"Armor 20%", "Armor 40%", "Armor 60%", "Armor 80%", "Armor 100%"},
	[18] = {"Turbo"},
	[22] = {"Xenon headlights"},
	[62] = {"White 1", "Black", "Blue", "White 2", "White 3", "Yankton"},
	[69] = {"None", "Maximum dark", "Dark", "Light", "Limo"}
}

menuInfo = {
	[1] 			= {modID = nil, 	nameCar = "Mods", 		nameBike = "Mods", 		parent = 0, 	_type = "", 		price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
	[2] 		= {modID = 0, 		nameCar = "Spoiler", 			nameBike = "Spoiler", 			parent = 1, 	_type = "get", 		price = 3,			prog = 0,			children = 0, 		set = -1, 		cart = -1},
	[3] 		= {modID = nil, 	nameCar = "Bumpers", 			nameBike = "Bumpers",			parent = 1, 	_type = "", 		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[4] 	= {modID = 1, 		nameCar = "Front bumper", 	nameBike = "Front bumper", 	parent = 3, 	_type = "get", 		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[5] 	= {modID = 2, 		nameCar = "Rear bumper", 		nameBike = "Rear bumper", 		parent = 3, 	_type = "get", 		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[6] 		= {modID = 3, 		nameCar = "Side Skirts", 			nameBike = "Side Skirts", 	parent = 1, 	_type = "get", 		price = 4, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[7] 		= {modID = 4, 		nameCar = "Exhaust", 			nameBike = "Exhaust", 			parent = 1, 	_type = "get", 		price = 3, 			prog = 0,			children = 0, 		set = -1, 		cart = -1},
		[8] 		= {modID = 5, 		nameCar = "Roll Cage", 				nameBike = "Engine Frame", 		parent = 1, 	_type = "get", 		price = 4, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[9] 		= {modID = 6, 		nameCar = "Grille", 			nameBike = "Oil Tank", 		parent = 1, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[10] 		= {modID = 7, 		nameCar = "Hood", 				nameBike = "Seat", 			parent = 1, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[11] 		= {modID = 8, 		nameCar = "Fender Flares", 			nameBike = "Fender Flares", 				parent = 1, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[12] 		= {modID = 9, 		nameCar = "Additionally", 		nameBike = "Additionally", 	parent = 1, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[13] 		= {modID = 10, 		nameCar = "Roof", 				nameBike = "Roof", 				parent = 1, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[14] 		= {modID = 14, 		nameCar = "Horn Sound", 	nameBike = "Horn Sound", 	parent = 1, 	_type = "unlstd", 	price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[15] 		= {modID = nil, 	nameCar = "Benny Mods", 	nameBike = "Benny Mods", parent = 1, 	_type = "bs", 		price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[16] 	= {modID = 25, 		nameCar = "Plate Frame", 	nameBike = "Plate Frame", 	parent = 15, 	_type = "get", 		price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[17] 	= {modID = 26, 		nameCar = "Vanity Plate", 	nameBike = "Vanity Plate", 	parent = 15, 	_type = "get", 		price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[18] 	= {modID = 27, 		nameCar = "Dash Board", 				nameBike = "Upholstery", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[19] 	= {modID = 28, 		nameCar = "Decorations", 			nameBike = "Decorations", 		parent = 15, 	_type = "get", 		price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[20] 	= {modID = 29, 		nameCar = "Dashboard", 	nameBike = "Dashboard", 	parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[21] 	= {modID = nil, 	nameCar = "Dash Board trim", 		nameBike = "Dash Board", 	parent = 15, 	_type = "dcol", 	price = 0.5, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[22] 	= {modID = 30, 		nameCar = "Devices", 			nameBike = "Devices", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[23] 	= {modID = 31, 		nameCar = "Door trim", 	nameBike = "Door trim", 	parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[24] 	= {modID = 32, 		nameCar = "The seats", 			nameBike = "The seats", 			parent = 15, 	_type = "get", 		price = 4, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[25] 	= {modID = nil, 	nameCar = "Upholstery color", 		nameBike = "Upholstery color", 		parent = 15, 	_type = "incol", 	price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[26] 	= {modID = 33, 		nameCar = "Steering wheel", 	nameBike = "Steering wheel", 				parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[27] 	= {modID = 34, 		nameCar = "Gearshift lever", 			nameBike = "Gearshift lever", 		parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[28] 	= {modID = 35, 		nameCar = "Vanity Plaque", 			nameBike = "Vanity Plaque", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[29] 	= {modID = 36, 		nameCar = "Speakers", 			nameBike = "Speakers", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[30] 	= {modID = 37, 		nameCar = "Trunk", 			nameBike = "Trunk", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[31] 	= {modID = 38, 		nameCar = "Hydraulics", 		nameBike = "Hydraulics", 		parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[32] 	= {modID = 39, 		nameCar = "Engine block", 	nameBike = "Engine block", 	parent = 15, 	_type = "get", 		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[33] 	= {modID = 40, 		nameCar = "Air filter", 	nameBike = "Air filter", 	parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[34] 	= {modID = 41, 		nameCar = "Spacers", 			nameBike = "Spacers", 			parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[35] 	= {modID = 42, 		nameCar = "Headlamp Fender", 	nameBike = "Headlight cover", 		parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[36] 	= {modID = 43, 		nameCar = "Fog / Antenna", nameBike = "Antenna", 		parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[37] 	= {modID = 44, 		nameCar = "Additionally", 		nameBike = "Additionally", 	parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[38] 	= {modID = 45, 		nameCar = "Rama / Buck", 		nameBike = "Rama / Buck", 		parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[39] 	= {modID = 46, 		nameCar = "Window", 				nameBike = "Window", 				parent = 15, 	_type = "get", 		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[40] 	= {modID = 48, 		nameCar = "Livery", 		nameBike = "Livery", 		parent = 15, 	_type = "get", 		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[41] 		= {modID = nil, 	nameCar = "Wheels", 			nameBike = "Wheels", 			parent = 1, 	_type = "", 		price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[42]	= {modID = nil, 	nameCar = "Wheel type", 			nameBike = "Wheel type",			parent = 41, 	_type = "wtype", 	price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[43]= {modID = 23, 		nameCar = "Sports", 		nameBike = "Sports", 		parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[44]= {modID = 23, 		nameCar = "Muscle", 				nameBike = "Muscle", 			parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[45]= {modID = 23, 		nameCar = "Lowrider", 			nameBike = "Lowrider", 			parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[46]= {modID = 23, 		nameCar = "SUV", 				nameBike = "SUV", 				parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[47]= {modID = 23, 		nameCar = "Off road", 		nameBike = "Off road", 		parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[48]= {modID = 23, 		nameCar = "Tuner", 				nameBike = "Tuner", 			parent = 42, 	_type = "wheel", 	price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[49]= {modID = 23, 		nameCar = "Front wheels", 	nameBike = "Front wheels", 	parent = 42, 	_type = "wheel", 	price = 1.5, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[50]= {modID = 23, 		nameCar = "Super", 	nameBike = "Super", 	parent = 42, 	_type = "wheel", 	price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[51]= {modID = 23, 		nameCar = "Bennys' Originals", 	nameBike = "Bennys' Originals", parent = 42, 	_type = "bwheel", 	price = 6, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[52]= {modID = 24, 		nameCar = "Rear wheels", 		nameBike = "Rear wheels", 	parent = 42, 	_type = "wheel",	price = 1.5, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[53] 	= {modID = nil,		nameCar = "Tire covers", 			nameBike = "Tire covers", 			parent = 41, 	_type = "tyres", 	price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[54]= {modID = nil, 	nameCar = "Smoke color", 			nameBike = "Smoke color", 		parent = 53, 	_type = "tsc", 		price = 0.5, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[55]= {modID = 20, 		nameCar = "Tire Smoke", 		nameBike = "Tire Smoke", 		parent = 53, 	_type = "ts", 		price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[56]= {modID = 23, 		nameCar = "Special tires", 	nameBike = "Special tires", 	parent = 53, 	_type = "ct",		price = 8, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[57]= {modID = 24, 		nameCar = "Rear specials. tires", 	nameBike = "Rear specials. tires", parent = 53, 	_type = "ctb",		price = 3, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[58]= {modID = nil, 	nameCar = "Bulletproof tires", 	nameBike = "Bulletproof tires", 	parent = 53, 	_type = "bt", 		price = 20, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[59] 	= {modID = nil,		nameCar = "Wheel color", 		nameBike = "Wheel color",		parent = 41, 	_type = "wcol", 	price = 0.5, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[60] 		= {modID = nil, 	nameCar = "Lighting", 			nameBike = "Lighting", 		parent = 1, 	_type = "lights", 	price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[61] 	= {modID = nil, 	nameCar = "Under Glow", 	nameBike = "Under Glow", 	parent = 60, 	_type = "n",		price = 5, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[62]= {modID = nil, 	nameCar = "Color", 				nameBike = "Color", 				parent = 61, 	_type = "nc", 		price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[63] 	= {modID = 22, 		nameCar = "Xenon headlights", 	nameBike = "Xenon headlights", 	parent = 60, 	_type = "xl",		price = 0.7, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[64] 		= {modID = 62, 		nameCar = "License Plate Color", 		nameBike = "License Plate Color", 		parent = 1, 	_type = "lp", 		price = 0.1, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[65] 		= {modID = 69, 		nameCar = "Tinted glass", 	nameBike = "Tinted glass", 	parent = 1, 	_type = "wtint", 	price = 0.2, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[66] 		= {modID = nil, 	nameCar = "Body color", 		nameBike = "Body color", 		parent = 1, 	_type = "bcol", 	price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[67] 	= {modID = 66,		nameCar = "Main", 			nameBike = "Main",			parent = 66, 	_type = "pcol", 	price = 0.01, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[68]= {modID = nil, 	nameCar = "Metallic", 			nameBike = "Metallic", 			parent = 67, 	_type = "mtlc", 	price = 0.4,		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[69]= {modID = nil, 	nameCar = "Cheap", 			nameBike = "Cheap", 			parent = 67, 	_type = "util", 	price = 0.2,		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[70]= {modID = nil, 	nameCar = "Matt", 			nameBike = "Matt", 			parent = 67, 	_type = "matte", 	price = 0.4, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[71]= {modID = nil, 	nameCar = "Worn out", 		nameBike = "Worn out", 		parent = 67, 	_type = "worn", 	price = 0.2, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[72]= {modID = nil, 	nameCar = "Metal", 				nameBike = "Metal", 			parent = 67, 	_type = "metal", 	price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[73] 	= {modID = 67,		nameCar = "Secondary", 			nameBike = "Secondary",			parent = 66, 	_type = "scol", 	price = 0.01, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[74]= {modID = nil, 	nameCar = "Metallic", 			nameBike = "Metallic", 			parent = 73, 	_type = "mtlc", 	price = 0.4, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[75]= {modID = nil, 	nameCar = "Cheap", 			nameBike = "Cheap", 			parent = 73, 	_type = "util", 	price = 0.2, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[76]= {modID = nil, 	nameCar = "Matt", 			nameBike = "Matt", 			parent = 73, 	_type = "matte", 	price = 0.4, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[77]= {modID = nil, 	nameCar = "Worn out", 		nameBike = "Worn out", 		parent = 73, 	_type = "worn", 	price = 0.2, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
				[78]= {modID = nil, 	nameCar = "Metal", 				nameBike = "Metal", 			parent = 73, 	_type = "metal", 	price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
			[79] 	= {modID = nil,		nameCar = "Color Chameleon", 		nameBike = "Color Chameleon",		parent = 66, 	_type = "pscol", 	price = 1, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
	[80] 			= {modID = nil, 	nameCar = "Performance", 	nameBike = "Performance", 	parent = 0, 	_type = "", 		price = 0, 			prog = 0, 			children = 0, 		set = -1, 		cart = -1},
		[81] 		= {modID = 11, 		nameCar = "Engine", 			nameBike = "Engine", 		parent = 80, 	_type = "unlstd", 	price = 8, 			prog = 0.5, 		children = 0, 		set = -1, 		cart = -1},
		[82] 		= {modID = 12, 		nameCar = "Brakes", 			nameBike = "Brakes", 			parent = 80, 	_type = "unlstd", 	price = 3, 			prog = 0.3, 		children = 0, 		set = -1, 		cart = -1},
		[83] 		= {modID = 13, 		nameCar = "Transmission", 		nameBike = "Transmission", 		parent = 80, 	_type = "unlstd", 	price = 8, 			prog = 0.5, 		children = 0, 		set = -1, 		cart = -1},
		[84] 		= {modID = 15, 		nameCar = "Suspension", 			nameBike = "Suspension", 			parent = 80, 	_type = "unlstd", 	price = 8, 			prog = 0.5, 		children = 0, 		set = -1, 		cart = -1},
		[85] 		= {modID = 16, 		nameCar = "Armour", 			nameBike = "Armour", 			parent = 80, 	_type = "unlstd", 	price = 10, 		prog = 1, 			children = 0, 		set = -1, 		cart = -1},
		[86] 		= {modID = 18, 		nameCar = "Turbo", 		nameBike = "Turbo", 		parent = 80, 	_type = "turbo", 	price = 10, 		prog = 0, 			children = 0, 		set = -1, 		cart = -1},
	[87] 			= {modID = nil, 	nameCar = "Vehicle Extras", 		nameBike = "Vehicle Extras", 		parent = 0, 	_type = "extra", 	price = 1, 			prog = 0, 			children = 0,		set = -1, 		cart = -1},
	[88] 			= {modID = nil, 	nameCar = "Fix and Clean", 			nameBike = "Fix and Clean", 			parent = 0, 	_type = "rep", 		price = 0, 			prog = 0, 			children = 0,		set = -1, 		cart = -1},
	[89] 			= {modID = nil, 	nameCar = "Exit", 		nameBike = "Exit", 		parent = 0, 	_type = "inst",		price = 0, 			prog = 0, 			children = 0,		set = -1, 		cart = -1},
}


return cfg