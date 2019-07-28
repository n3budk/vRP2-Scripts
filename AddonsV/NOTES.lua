*************addons_vrp2************

Find all permissions in the lang file

Features:
Mobile police computer registration and records search while near PV
Dynamic Jail/Unjail Options added to Police Computers, permission to have prison options in police menu
Deployable police options with permissions - spikes, barriers, cones, gazebo, scene light
Consumable Drugs deach with different effect
Player Menu containing most options
vrp menu Players List
Lockpicking vehicle options
Vehicle Doors controls options in vehicle menu
BoomBox Options with permissions

Permissions:
"police_props", --Add to police to allow police extra menu	
"player_list", -- Add to use to allow Player List
"jailer_police_pc", -- Add to police to allow Prison Options in the "police computer"		
"always_lockpick", --Add to who should be able to lock pick vehicles with no criminal aptitudes
		
		[[--Admin or extra options--]],
		
"jailer_mobile", -- Add to police to allow Prison Options in the "police menu"		
"police_props_xtra", --unlimited barriers and scene lights in police extra menu
"boombox", --Global DJ Option for DJ or Admin
"no_boombox_req", --no boombox is required in inventory
		
		
Items are now added directly in the server.lua and can be used directly in the inventory of the given drug or item
[[
  ["lighter"] = {"Lighter","",nil,0.09},
  ["rolly"] = {"Rolling Paper","",nil,0.01},
  ["weed"] = {"Weed","",nil,0.05},
  ["vodka"] = {"Vodka","",nil,1.0},
  ["cocaine"] = {"Cocaine","",nil,0.1},
  ["lsd"] = {"LSD","",nil,0.01},
  ["methpipe"] = {"Meth Pipe","",nil,0.5},
  ["meth"] = {"Meth","",nil,0.1},
  ["cigs"] = {"Cigarettes","",nil,0.05},

  ["boom_box"] = {"Boom Box","",nil,1.2},
  ["lockpick"] = {"Lock Pick","",nil,0.5},
  ["plasmacutter"] = {"Plasma Cutter","",nil,1.0},
  ]]