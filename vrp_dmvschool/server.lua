

htmlEntities = module("vrp", "lib/htmlEntities")


cfg = module("vrp_dmvschool", "cfg/dmv")

Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(cfg.lang, module("vrp", "cfg/lang/"..cfg.lang) or {})
Lang:loadLocale(cfg.lang, module("vrp_dmvschool", "cfg/lang/"..cfg.lang) or {})
lang = Lang.lang[cfg.lang]


local vRPdmv = class("vRPdmv", vRP.Extension)



vRPdmv.event = {}

function vRPdmv.event:playerSpawn(user, first_spawn)
    if first_spawn then
        local data = vRP:getCData(user.id, "vRP:dmv:license")

        if data then
            local license = json.decode(data)

            if license and license ~= 0 then
                self.remote.setcLicense(user.source, true)
            end
        end
    end
end

local function menu_license(self)

local function ch_checklicense(menu)
    local user = menu.user
    local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source,10)

    if nplayer then nuser = vRP.users_by_source[nplayer] end
	
	if nuser then
    vRP.EXT.Base.remote._notify(user.source,lang.dmv.police.ask())
    if nuser:request(lang.dmv.police.request(),15) then
    local data = vRP:getUData(nuser.id,"vRP:dmv:license")
      if data then
	    local license = json.decode(data)
		if license and license ~= 0 then
          local identity = vRP.EXT.Identity:getIdentity(nuser.source)
          if identity then

            local name = identity.name
            local firstname = identity.firstname
            local age = identity.age
            local phone = identity.phone
            local registration = identity.registration
          
            local content = lang.dmv.police.license({name,firstname,age,registration,phone,license})
            vRP.EXT.GUI.remote._setDiv(user.source,"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content)
			
            user:request(lang.dmv.police.request_hide(), 1000)
            vRP.EXT.GUI.remote._removeDiv(user.source, "police_identity")
          end
        end
	  else
	    vRP.EXT.Base.remote._notify(user.source,lang.dmv.police.no_license())
      end
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.request_refused())
    end
  else
    vRP.EXT.Base.remote._notify(user.source,lang.common.no_player_near())
  end
end



local function ch_takelicense(menu)
    local user = menu.user
	local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source,10)
	
	
    if nplayer then nuser = vRP.users_by_source[nplayer] end
	
	if user:hasPermission("take.license") then	
	if nuser then
	
    if user:request(lang.dmv.police.confirm(),15) then
	  local data = vRP:getUData(nuser.id,"vRP:dmv:license")
      if data then
	    local license = json.decode(data)
		if license and license ~= 0 then
          self.remote._setcLicense(nuser.source, false)
	      vRP:setUData(nuser.id,"vRP:dmv:license",json.encode())
	      vRP.EXT.Base.remote._notify(nuser.source,lang.dmv.police.license_taken())
	      vRP.EXT.Base.remote._notify(user.source,lang.dmv.police.took_license())
		  end
	  else
	    vRP.EXT.Base.remote._notify(user.source,lang.dmv.police.no_license())
      end
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.request_refused())
    end
  else
      vRP.EXT.Base.remote._notify(user.source,lang.common.no_player_near())
	end
	  else
	    vRP.EXT.Base.remote._notify(user.source,"Only a supervisor can take a license")
  end
end

vRP.EXT.GUI:registerMenuBuilder("license", function(menu)
        menu.title = "Licenses"
        menu:addOption("Check DL", ch_checklicense, "Check for a Drivers License")
        menu:addOption("Take DL", ch_takelicense, "Take away someones Drivers License")		
end)

end
 
local function menu_dmvtest(self)

local function ch_info(menu)
    local user = menu.user
self.remote.startIntro(user.source)
 user:closeMenu()
end

local function ch_theory(menu)
    local user = menu.user
self.remote.payTheory(user.source)
 user:closeMenu()
end

local function ch_practical(menu)
    local user = menu.user
self.remote.payPractical(user.source)
 user:closeMenu()
end

vRP.EXT.GUI:registerMenuBuilder("dmvtest", function(menu)
        menu.title = "DMV License"

        menu:addOption("Basics", ch_info, "Learn the basics to pass the theory test")
        menu:addOption("Theory", ch_theory, "Pass the theory test to advance to the Practical")	
        menu:addOption("Practical", ch_practical, "Take away License")		
end)

end


function vRPdmv:__construct()
    vRP.Extension.__construct(self)

  self.cfg = module("vrp_dmvschool", "cfg/dmv")

    menu_license(self)
    menu_dmvtest(self)

  local function m_license(menu)
    local user = menu.user
	user:openMenu("license")
  end

    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
      menu:addOption("Licenses", m_license)
  end)

  
end

vRPdmv.event = {}

function vRPdmv.event:playerSpawn(user, first_spawn)
    if first_spawn then
        for k, v in pairs(self.cfg.mdmv) do
            local gcfg = v._config

            if gcfg then
                local x = gcfg.x
                local y = gcfg.y
                local z = gcfg.z

                local function enter(user)
                    menu = user:openMenu("dmvtest")
                end

            local function leave(user)
                user:closeMenu()
            end

        local ment = clone(gcfg.map_entity)
        ment[2].title = "DMV School"
        ment[2].pos = {x,y,z-1}
        vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
        user:setArea("vRP:cfg.mdmv" .. k, x, y, z, 1, 1.5, enter, leave)

    	    end
	end
    end
end



vRPdmv.tunnel = {}

function vRPdmv.tunnel:payTheory()
	local user = vRP.users_by_source[source]
	if user:tryFullPayment(250) then
        self.remote.startTheory(user.source)
	else
	vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
	end
end

function vRPdmv.tunnel:payPractical()
	local user = vRP.users_by_source[source]
	if user:tryFullPayment(1500) then
        self.remote.startPractical(user.source)
	else
	vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
	end
end  

function vRPdmv.tunnel:setLicense()
	local user = vRP.users_by_source[source]
	vRP:setUData(user.id,"vRP:dmv:license",json.encode(os.date("%x")))
end


vRP:registerExtension(vRPdmv)	
