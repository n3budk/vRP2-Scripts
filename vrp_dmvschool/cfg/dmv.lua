

cfg = {}

cfg.mdmv = {
--locations 238.46395874024,-1382.1953125,33.7417678833
["1"] = {
      _config = {x = -1541.69, y = -446.38, z = 35.88, map_entity = {"PoI", {blip_id = 545, blip_color = 26,marker_id = 1, scale = {1.0,1.0,1.0},color={0, 155, 155,125} }}}, 
  }
}

cfg.lang = "en"

cfg.dmv = {
  warn = false,

  price = {
    theory = 250,
    practical = 500
  }
}

cfg.speed = {
  mult = 2.25, -- 3.6 is kmh / 2.25 is mph (don't ask me why)
  control = { -- https://wiki.fivem.net/wiki/Controls
    toggle = 73, -- X
	up = 27, -- UP
	down = 173 -- DOWN
  },
  area = {
    {
      name = "Residential",
	  limit = 35.0
	},
    {
      name = "City",
	  limit = 50.0
	},
    {
      name = "Freeway",
	  limit = 75.0
	},
  }
}

cfg.intro = {
  {
    pos = {-1632.2426757812,-608.95056152344,62.163249969482},
    msg = "<b style='color:#1E90FF'>DMV Introduction</b> <br /><br />Theory and practice are both important elements of driving instruction.<br />This introduction will cover the basics and ensure you are prepared with enough information and knowledge for your test.<br /><br />The information from your theory lessons combined with the experience from your practical lesson are vital for negotiating the situations and dilemmas you will face on the road.<br /><br />Sit back and enjoy the ride as we start. It is highly recommended that you pay attention to every detail, most of these questions can be existent under your theory test."
  },

  {
    pos = {-1378.67578125,-583.3687133789,57.56788635254},
    msg = "<b style='color:#1E90FF'>Residential Area</b> <br /><br /> Maintain an appropriate speed - Never faster than the posted limit, slower if traffic is heavy.<br /><br />The 50mp/h limit usually applies to all traffic on all roads with street lighting unless otherwise specified.<br /><br />The speed limit in a Freeway/Motorway Area is 75mp/h.<br /><br />The speed limit in a Residential Area is 35mp/h.<br />"
  },

  {
    pos = {-1446.9305419922,-431.12069702148,47.1704788208},
    msg = "<b style='color:#1E90FF'>Alcohol</b> <br /><br />Drinking while driving is very dangerous, alcohol and/or drugs impair your judgment. Impaired judgment affects how you react to sounds and what you see. However, the DMV allows a certain amount of alcohol concentration for those driving with a valid drivers license.<br /><br />0.08% is the the legal limit for a driver's blood alcohol concentration (BAC)<br />"
  },
}

cfg.practical = {
  intro = {
	  "<b style='color:#1E90FF'>DMV Instructor:</b> <br /><br /> Use the <b style='color:#DAA520'>Cruise Control</b> feature to avoid <b style='color:#87CEFA'>speeding</b>, activate this during the test by pressing the <b style='color:#20B2AA'>X</b> button on your keyboard.<br /><br /><b style='color:#87CEFA'>Evaluation:</b><br />- Try not to crash the vehicle or go over the posted speed limit. You will receive <b style='color:#A52A2A'>Error Points</b> whenever you fail to follow these rules<br /><br />- Too many <b style='color:#A52A2A'>Error Points</b> accumulated will result in a <b style='color:#A52A2A'>Failed</b> test",
	 "<b style='color:#1E90FF'>DMV Instructor:</b> <br /><br /> We are currently preparing your vehicle for the test, meanwhile you should read a few important lines.<br /><br /><b style='color:#87CEFA'>Speed limit:</b><br />- Pay attention to the traffic, and stay under the <b style='color:#A52A2A'>speed</b> limit<br /><br />- By now, you should know the basics, however we will try to remind you whenever you <b style='color:#DAA520'>enter/exit</b> an area with a posted speed limit",
  },
max_errors = 5,
  spawn = {-1519.7545166016,-416.43099975586,35.44221496582},
  steps = {
    {
	  pos = {-1515.9367675782,-455.5520324707,35.34638595581},
	  stop = "Do a quick ~r~stop~s~ and watch your ~y~LEFT~s~ before entering traffic",
	  msg = "~g~Great!~s~ now take a ~y~RIGHT~s~ and pick the right lane",
	  area = 2,
	},
    {
	  pos = {-1558.5821533204,-488.86157226562,35.523586273194},
	  msg = "Watch the traffic ~y~lights~s~ !",
	},
    {
	  pos = {-1648.360961914,-557.35632324218,33.446151733398},
	  stop = "Stop here then take a right~s~ !",	  
	},
	
    {
	  pos = {-1685.4031982422,-548.53045654296,35.96619796753},
	  msg = "Go straight through the lights",
	},	
	
    {
	  pos = {-1750.1938476562,-450.05392456054,42.019104003906},
	  stop = "Take a left here into the residential streets~s~ !",
	  area = 1,
	},
    {
	  pos = {-1806.2438964844,-441.19003295898,42.513610839844},

	},	
    {
	  pos = {-1917.9184570312,-345.89596557618,48.027881622314},
	},
    {
	  pos = {-1920.2858886718,-207.86404418946,35.525485992432},
	  stop = "Take a left here back onto the city streets~s~!",
	  area = 2,
	},
    {
	  pos = {-2076.2133789062,-185.45152282714,23.00472831726},
	},
    {
	  pos = {-2151.1774902344,-269.05645751954,13.81706905365},
	  msg = "Take a left at the lights~s~!",
	},
    {
	  pos = {-2090.625,-389.85739135742,12.217877388},
	  msg = "The highway is coming up",
	},
    {
	  pos = {-2035.2840576172,-430.20858764648,11.367559432984},
	  area = 3,
	},
    {
	  pos = {-1875.8599853516,-568.29302978516,11.644200325012},
	},
    {
	  pos = {-1758.4061279296,-667.9585571289,10.398222923278},
	},
    {
	  pos = {-1691.5689697266,-718.21844482422,10.883734703064},
	},	

    {
	  pos = {-1650.6868896484,-745.42962646484,10.269953727722},
	  msg = "Stay in this lane",
	},
    {
	  pos = {-1600.388671875,-779.4789428711,11.335312843322},
	  msg = "Entering city streets, speed is reducing up ahead",
	},
    {
	  pos = {-1477.6691894532,-828.09997558594,15.143235206604},
	  area = 2,
	},
    {
	  pos = {-1413.4639892578,-839.92388916016,17.733741760254},
	  msg = "Take a left at the lights",
	},
    {
	  pos = {-1419.9522705078,-762.31591796875,23.188934326172},
	},
    {
	  pos = {-1494.5034179688,-700.86865234375,27.023742675782},
	  msg = "Take a right at the lights",
	},
    {
	  pos = {-1497.2567138672,-638.52880859375,29.999921798706},
	},
    {
	  pos = {-1426.0247802734,-592.04705810546,30.665042877198},
	  msg = "Take a left at the stop",
	},
    {
	  pos = {-1425.0137939454,-492.8930053711,33.487743377686},
	  msg = "Take a left and pull into where we started!",
	},
    {
	  pos = {-1534.8177490234,-435.26705932618,35.442134857178},


	}
  }
}

return cfg
