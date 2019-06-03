
local lcfg = module("vrp", "cfg/base")
local cfg = module("vrp_bankrobbery", "cfg/bankrobbery")

-- LANG
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]
Lang:loadLocale(lcfg.lang, module("vrp_bankrobbery", "cfg/lang/"..lcfg.lang) or {})


local vRPbankrob = class("vRPbankrob", vRP.Extension)

local function menu_robberys(self)

    local function m_rob(menu)
        local user = menu.user
		if robbing then
		user:closeMenu()
		vRP.EXT.Base.remote._notify(user.source, "~r~Robbing in Progress!!")	
		else	
    if user:request("Are you sure you want to perform a robbery?",15) then
	self.remote._robberyEnter(user.source)
	user:closeMenu()
	    end
	end
end

    vRP.EXT.GUI:registerMenuBuilder("robbery", function(menu)
        local user = menu.user
        menu.title = "Robbery"
        menu.css.header_color = "rgba(255,50,50,0.75)"
        menu:addOption("Perform a Robbery", m_rob)

    end)

end

function vRPbankrob:__construct()
  vRP.Extension.__construct(self)
  menu_robberys(self)
end


function vRPbankrob:sendAlertAudio(x,y,z)

    local targets = {}
    for _,user in pairs(vRP.users) do
      if user:isReady() and user:hasPermission("police.market") then
        table.insert(targets, user)
      end
    end

    -- send notify and alert to all targets
    for _,user in pairs(targets) do

	  
	  local audioalert = "https://vocaroo.com/media_command.php?media=s1PjEKOGDTQT&command=download_mp3"
	  vRP.EXT.Audio.remote._playAudioSource(-1, audioalert, 0.1, 0,0,0, 5, user.source)
	  if user:request("Set a waypoint to the active robbery",30) then
	   vRP.EXT.Base.remote._notify(user.source,"Waypoint set to active Robbery")
       vRP.EXT.Map.remote._setGPS(user.source,x,y)

	   end
	end
end	

robbers = {}
lastrobbed = {}
robbing = false
-- EVENT
vRPbankrob.event = {}

function vRPbankrob.event:playerSpawn(user, first_spawn)
    if first_spawn then
        for k, v in pairs(cfg.bankrobbery) do
            local gcfg = v._config

            if gcfg then
                local x = gcfg.x
                local y = gcfg.y
                local z = gcfg.z
				
                local function enter(user)
                  menu = user:openMenu("robbery")
                end	

            local function leave(user)
                user:closeMenu()
            end				
				
                local ment = clone(gcfg.map_entity)
                ment[2].title = v.name
                ment[2].pos = {x, y, z - 1}
                vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
				user:setArea("vRP:cfg.robberys" .. k, x, y, z, 1, 1.5, enter, leave)				
            end
        end
    end
end

-- TUNNEL
vRPbankrob.tunnel = {}

function vRPbankrob.tunnel:cancelRobbery(robb)
  local player = source
  local robbery = cfg.bankrobbery[robb]
	if(robbers[source])then
	robbers[source] = nil
	canceled = true
	vRP.EXT.Audio.remote._removeAudioSource(-1, robbery.alarm_id)
	TriggerClientEvent('chatMessage', player, lang.robbery.title_robbery(), {255, 0, 0}, lang.robbery.canceled())
	robbing = false
	end
end

function vRPbankrob.tunnel:startRobbery(robb, x,y,z)
  local user = vRP.users_by_source[source]

  if user then
  local canceled = false
  local player = source
  local cops = vRP.EXT.Group:getUsersByPermission(cfg.cops)
  local robbery = cfg.bankrobbery[robb]
  if user:hasPermission(cfg.cops) then
  	self.remote._robberyComplete(player)
    vRP.EXT.Base.remote._notify(user.source, lang.robbery.cant_rob())
  else
    if robbery then
	  if #cops >= robbery.cops then
		if lastrobbed[robb] then
		  local past = os.time() - lastrobbed[robb]
		  local wait = robbery.rob + robbery.wait
		  if past <  wait or vRP.EXT.Survival.remote.isInComa(user.source) then
		    TriggerClientEvent('chatMessage', player, lang.robbery.title_robbery(),{255, 0, 0}, lang.robbery.wait({wait - past}))
			self.remote._robberyComplete(player)
			canceled = true
		  end
		end
		if not canceled then
		robbing = true
		TriggerClientEvent('chatMessage', player, lang.robbery.hold({math.ceil(robbery.rob/60)}))
		  TriggerEvent("cooldownt")
		  lastrobbed[robb] = os.time()
		  robbers[player] = robb

		local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
		local audio = "https://retired.sounddogs.com/previews/2219/mp3/413117_SOUNDDOGS__al.mp3"
		vRP.EXT.Phone:sendServiceAlert(nil, "police" ,x,y,z, lang.robbery.progress({robbery.name})) -- send service alert (call request)
		vRP.EXT.Base.remote._notifyPicture(user.source, "CHAR_LESTER", 1, "WARNING", "Alarm Triggered", "The police were alerted!")
		vRP.EXT.Audio.remote._setAudioSource(-1, robbery.alarm_id, audio, 0.1, x,y,z, 75)
		vRP.EXT.Police.remote.applyWantedLevel(user.source, robbery.stars)
		self:sendAlertAudio(x,y,z)

		  local savedSource = player
		  SetTimeout(robbery.rob*1000, function()
			vRP.EXT.Audio.remote._removeAudioSource(-1, robbery.alarm_id)
			if(robbers[savedSource])then
			  if user then
			    robbing = false
				local reward = math.random(robbery.min,robbery.max)
				user:tryGiveItem("dirty_money",reward,false) 
				user:varyExp("crime", "heist", robbery.apt) --Aptitude for Criminals
				self.remote._robberyComplete(savedSource)
				--vRP.EXT.GUI.remote._announce(-1,"http://i.imgur.com/b2O9WMa.png", lang.robbery.complete({robbery.name,reward}))
 
			  end
			end
		  end)
		end
      		else
		self.remote._robberyComplete(player)
        vRP.EXT.Base.remote._notify(user.source, lang.robbery.not_enough({robbery.cops}))
      end
    end
  end
end
end
  

vRP:registerExtension(vRPbankrob)


