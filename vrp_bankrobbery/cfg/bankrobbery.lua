

cfg = {}

cfg.lang = "en"
cfg.cops = "police.service"

cfg.bankrobbery = { -- list of robberies
	["fleeca2"] = { 
	 _config = {x = -2957.66, y = 481.45, z = 15.69, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Fleeca Bank (Great Ocean Highway)", 
	  pos = {-2957.6674804688, 481.45776367188, 15.697026252747}, 
	  dist = 9.5, rob = 360, wait = 2700, cops = 4, stars = 3, apt = 0.50 , alarm_id = b1,  min = 50000, max = 175000 --100-200
	},
	["blainecounty"] = { 
 	_config = {x = -107.06, y = 6474.80, z = 31.62, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Blaine County Savings (Paleto Bay)", 
	  pos = {-107.06505584717, 6474.8012695313, 31.62670135498}, 
	  dist = 9.5, rob = 360, wait = 2700, cops = 4, stars = 3, apt = 0.50 , alarm_id = b2,  min = 50000, max = 175000
	},
	["fleeca3"] = { 
 	_config = {x = -1212.25, y = -336.12, z = 37.79, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Fleeca Bank (Rockford Hills)", 
	  pos = {-1212.2568359375, -336.128295898438, 37.7907638549805}, 
	  dist = 9.5, rob = 360, wait = 2700, cops = 4, stars = 3, apt = 0.50 , alarm_id = b3, min = 50000, max = 175000
	},
	["fleeca6"] = { 
 	_config = {x = 1176.86, y = 2711.91, z = 38.09, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Fleeca Bank (Route 68)", 
	  pos = {1176.86,2711.91,38.09}, 
	  dist = 9.5, rob = 360, wait = 2700, cops = 4, stars = 3 , apt = 0.50 , alarm_id = b4,  min = 50000, max = 175000
	},
	["pacific"] = { 
 	_config = {x = 255.00, y = 225.85, z = 102.00, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Pacific Standards (Downtown Vinewood)", 
	  pos = {255.001098632813, 225.855895996094, 102.005694274902}, 
	  dist = 25.0, rob = 360, wait = 2700, cops = 6, stars = 4 , apt = 1.00 , alarm_id = b5,  min = 150000, max = 225000
	},
	["gas1"] = { 
 	_config = {x = 2550.02, y = 385.94, z = 108.62, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "24/7 (Palomino Fwy)", 
	  pos = {2550.0231933594,385.9401550293,108.62302398682}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1 , apt = 0.03 , alarm_id = g1,  min = 250, max = 1000
	},
	["gas2"] = { 
 	_config = {x = -43.26, y = -1749.09, z = 29.42, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Gas Station (Davis Ave Grove St)", 
	  pos = {-43.26522064209,-1749.0943603516,29.421014785766}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1 , apt = 0.03 , alarm_id = g2,   min = 250, max = 1000
	},
	["gas3"] = { 
 	_config = {x = 1396.25, y = 3612.05, z =34.98, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Liquor Ace (Sandy Shores)", 
	  pos = {1396.2565917968,3612.0524902344,34.98093032837}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1 , apt = 0.03 , alarm_id = g3,  min = 250, max = 1000
	},
	["gas4"] = { 
 	_config = {x = 1706.79, y = 4920.08, z =42.06, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Gas Station (Grape Seed)", 
	  pos = {1706.7935791016,4920.087890625,42.063678741456}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1, apt = 0.03 , alarm_id = g4,  min = 250, max = 1000
	},
	["gas5"] = { 
 	_config = {x = 1735.39, y = 6419.48, z =35.03, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "24/7 (Senora Fwy)", 
	  pos = {1735.3999023438,6419.4858398438,35.03722000122}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1, apt = 0.03 , alarm_id = g5,  min = 250, max = 1000
	},	
	["gas6"] = { 
 	_config = {x = -3249.06, y = 1006.01, z = 12.83, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "27/7 (Barbareno Rd)", 
	  pos = {-3249.0610351562,1006.0192871094,12.830708503724}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1, apt = 0.03 , alarm_id = g6,  min = 250, max = 1000
	},
	["gas7"] = { 
 	_config = {x = -2959.03, y = 388.23, z = 14.04, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "Robs Liquor (Great Ocean Highway)", 
	  pos = {-2959.0327148438,388.23156738282,14.043151855468}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1, apt = 0.03 , alarm_id = g7,  min = 250, max = 1000
	},
	["gas8"] = { 
 	_config = {x = 544.33, y = 2663.37, z = 42.15, map_entity = {"PoI", {blip_scale = 0.8, blip_id = 431, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 50, 50,125} }}},
	  name = "24/7 (Route 68)", 
	  pos = {544.33850097656,2663.37109375,42.156497955322}, 
	  dist = 12.0, rob = 180, wait = 900, cops = 0, stars = 1, apt = 0.03 , alarm_id = g8,  min = 250, max = 1000
	}	
}


return cfg

