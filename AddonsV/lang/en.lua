

local lang = {

	item = { --Add these to items
	    lighter = "lighter", --Item
		rolly = "rolly", --Item	
		weed = "weed", --Item
		vodka = "vodka", --Item
		cocaine = "cocaine", --Item
		lsd = "lsd", --Item
		methpipe = "methpipe", --Item
		meth = "meth", --Item	
		bbox = "boom_box", --Item		
		lockpick = "lockpick", --Item	
		cigs = "cigs", --Item
		
},
	itemcheck = {
		lockpick = "!aptitude.crime.crime.>4", --required aptitude for lockpicking		
},

	perms = {
	    pol_props = "police_props", --Add to police to allow police extra menu	
		plist = "player_list", -- Add to use to allow Player List
		jailer = "jailer_police_pc", -- Add to police to allow Prison Options in the "police computer"		
		lockpick_noapt = "always_lockpick", --Add to who should be able to lock pick vehicles with no criminal aptitudes
		
		[[--Admin or extra options--]],
		
		jailer_mobile = "jailer_mobile", -- Add to police to allow Prison Options in the "police menu"		
		unli_props = "police_props_xtra", --unlimited barriers and scene lights in police extra menu
		bbox = "boombox", --Global DJ Option for DJ or Admin
		nobbox = "no_boombox_req", --no boombox is required in inventory
	
},
	bbox = {
		localplay = "Music is already playing Locally!!",
		gloplay = "Music is already playing Globally!!",
		no = "Only DJs and Staff can play globally",
		inventory = "No Boombox in inventory",		
		playlo = "Play Locally",
		playglo = "Play Globally",
		title = "Boom Box",
		audio = "http://198.7.59.204:20244/stream.ogg",
		playinglo = "Playing Boombox - Global",	
		playinlo = "Playing Boombox - Local",			
  },
	jail = {
		desc = "Jails a nearby player.",
		send = "Send to Prison",
		menu = "Prison Menu",		
		free = "~b~You've been set free.",
		audio = "https://vocaroo.com/media_command.php?media=s08Yfq6XaTk2&command=download_mp3",--Jail door slam once jailed 	
		resent = "~r~Finish your sentence!",
		timer = "Time remaining: {1} minute(s).",
		prompt = "Sentence Time:",
		file = "jailer.lua",
		log = "{1} sent {2} to jail for {3} minutes",	
		sent = {
			bad = "~r~You were sent to jail!",
			good = "~g~Player sent to jail.",
  }		
},
	fine = {
		button = "Fine",
		perm = "police.bmfine",
		prompt = {
			amount = "Fine Value:",
			reason = "Fine Reason:",
		},
		file = "fine.lua",
		log = "{1} fined {2} for ${3} - {4}",
		sent = {
			bad = "~r~You were sent to jail!",
			good = "~g~Player sent to jail.",
		},
	},

	unjail = {
		prompt = "User ID:",
		release = "Release from Prison",		
		released = "~g~You released a player from his sentence.",
		lowered = "~g~Your sentence has been lowered.",
		file = "jailer.lua",
		log = "{1} unjailed {2} from {3} minutes remaining",		
	},

	police = {
	  extras = "Police Extras Menu",
	  connection = "No connection... You must be near your PV to access the LSPD Network.",
      veh_searchtitle = {
        title = "Police Computer",
        description = "Access the mobile police computer."
      },	
      veh_searchreg = {
        title = "Registration search",
        description = "Search identity by registration."
      },
      veh_records = {
        title = "Record Search",
        description = "Manage police records by registration number."
    }
  },
	lockpick = {
		menu = "Lock Pick",
		menu2 = "Vehicle lock pick",
		apti = "Need lvl 5 Criminal aptitude to use the vehicle lock pick",

	},
    player = {
        menu = "Player",
    },	

	deploy = { 
		nocarry = "~r~You can't carry any more",
		nodeploy = "~r~You can't deploy any more!",

	},
	fine = {
		button = "Fine",
		desc = "Fines a nearby player.",
		prompt = {
			amount = "Fine Value:",
			reason = "Fine Reason:",
		},
		file = "fine.log",
		log = "{1} fined {2} for ${3} - {4}",
		sent = {
			bad = "~r~You were sent to jail!",
			good = "~g~Player sent to jail.",
		},
	},	
}

return lang
