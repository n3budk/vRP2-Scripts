htmlEntities = module("vrp", "lib/htmlEntities")


local lcfg = module("vrp", "cfg/base")
Luang = module("vrp", "lib/Luang")
Lang = Luang()


Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})

Lang:loadLocale(lcfg.lang, module("addons_vrp2", "lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]



local Addons = class("Addons", vRP.Extension)



--Mobile Police Computer
local function menu_computer(self)

  local function m_msearchreg(menu)
    local user = menu.user

    local reg = user:prompt(lang.police.pc.searchreg.prompt(),"")
    local cid = vRP.EXT.Identity:getByRegistration(reg)

    if cid then
      local identity = vRP.EXT.Identity:getIdentity(cid)
      if identity then

        local smenu = user:openMenu("identity", {cid = cid})
        menu:listen("remove", function(menu) menu.user:closeMenu(smenu) end)

      else
        vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
      end
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
    end
  end


  local function m_records(menu)
    local user = menu.user

    local reg = user:prompt(lang.police.pc.searchreg.prompt(),"")
    local tuser
    local cid = vRP.EXT.Identity:getByRegistration(reg)


    if cid then tuser = vRP.users_by_cid[cid] end

    if tuser then
    -- check vehicle

      local smenu = user:openMenu("police_pc.records", {tuser = tuser})
      menu:listen("remove", function(menu) menu.user:closeMenu(smenu) end)
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
    end
  end



  vRP.EXT.GUI:registerMenuBuilder("computer", function(menu)
    local user = menu.user
    menu.title = "Police Computer"
    menu.css.header_color = "rgba(0,125,255,0.75)"

      menu:addOption(lang.police.veh_searchreg.title(), m_msearchreg, lang.police.veh_searchreg.description())
      menu:addOption(lang.police.veh_records.title(), m_records, lang.police.veh_records.description())
  end)

end


worklight = {}
--Police Deployable Items
local function menu_deployable(self)
local function ch_lights(menu)
    local user = menu.user
    local prop = "prop_worklight_03b"
    local closeby = self.remote.closeProp(user.source, prop)

    if user:hasPermission(lang.perms.unli_props()) then
        if closeby then
            self.remote.removeProp(user.source, prop)
        elseif not closeby then
            self.remote.setProp(user.source, prop)
        end
    else
        if closeby and (worklight[user.source]) then
            self.remote.removeProp(user.source, prop)
            worklight[user.source] = false
        elseif closeby and not worklight[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nocarry())
        elseif not closeby and worklight[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nodeploy())
        elseif not closeby and (not worklight[user.source]) then
            self.remote.setProp(user.source, prop)
            worklight[user.source] = true
        end
    end
end


gazebo = {}
local function ch_gazebo(menu)
    local user = menu.user
    local prop = "prop_gazebo_02"
    local closeby = self.remote.closeProp(user.source, prop)

    if closeby and (gazebo[user.source]) then
        self.remote.removeProp(user.source, prop)
        gazebo[user.source] = false
    elseif closeby and not gazebo[user.source] then
        vRP.EXT.Base.remote._notify(user.source, lang.deploy.nocarry())
    elseif not closeby and gazebo[user.source] then
        vRP.EXT.Base.remote._notify(user.source, lang.deploy.nodeploy())
    elseif not closeby and (not gazebo[user.source]) then
        self.remote.setProp(user.source, prop)
        gazebo[user.source] = true
    end
end

local function ch_scone(menu)
    local user = menu.user
    local prop = "prop_roadcone02b"
    local closeby = self.remote.closeProp(user.source, prop)

    if closeby then
        self.remote.removeProp(user.source, prop)
    elseif not closeby then
        self.remote.setProp(user.source, prop)

    end
end

local function ch_bcone(menu)
    local user = menu.user
    local prop = "prop_roadcone01a"
    local closeby = self.remote.closeProp(user.source, prop)

    if closeby then
        self.remote.removeProp(user.source, prop)
    elseif not closeby then
        self.remote.setProp(user.source, prop)

    end
end

barrier = {}

local function ch_barrier(menu)
    local user = menu.user
    local prop = "prop_barrier_work05"
    local closeby = self.remote.closeProp(user.source, prop)

    if user:hasPermission(lang.perms.unli_props()) then
        if closeby then
            self.remote.removeProp(user.source, prop)
        elseif not closeby then
            self.remote.setPropBarrier(user.source, prop)
        end
    else
        if closeby and (barrier[user.source]) then
            self.remote.removeProp(user.source, prop)
            barrier[user.source] = false
        elseif closeby and not barrier[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nocarry())
        elseif not closeby and barrier[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nodeploy())
        elseif not closeby and (not barrier[user.source]) then
            self.remote.setPropBarrier(user.source, prop)
            barrier[user.source] = true
        end
    end
end




local function ch_spikes(menu)
    local user = menu.user
    local prop = "P_ld_stinger_s"
    local closeby = self.remote.closeProp(user.source, prop)

    if user:hasPermission(lang.perms.unli_props()) then
        if closeby then
            self.remote.removeProp(user.source, prop)
        elseif not closeby then
            self.remote.setPropSpike(user.source, prop)
        end
    else
        if closeby and (self.spikes[user.source]) then
            self.remote.removeProp(user.source, prop)
            self.spikes[user.source] = false
        elseif closeby and not self.spikes[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nocarry())
        elseif not closeby and self.spikes[user.source] then
            vRP.EXT.Base.remote._notify(user.source, lang.deploy.nodeploy())
        elseif not closeby and (not self.spikes[user.source]) then
            self.remote.setPropSpike(user.source, prop)
            self.spikes[user.source] = true
        end
    end
end
	  
    vRP.EXT.GUI:registerMenuBuilder("deployable", function(menu)
        local user = menu.user
        menu.title = "Police Objects"
        menu.css.header_color = "rgba(0,125,255,0.75)"
        menu:addOption("Spike", ch_spikes, "Deploy spike strips.")
        menu:addOption("Barrier", ch_barrier, "Deploy a barrier.")	
        menu:addOption("Big Cone", ch_bcone, "Deploy a large traffic cone.")
        menu:addOption("Small Cone", ch_scone, "Deploy a small traffic cone.")	
        menu:addOption("Scene Lights", ch_lights, "Deploy a scene light.")
        menu:addOption("Gazebo", ch_gazebo, "Deploy a scene gazebo.")
		
    end)	
	
end

--Drug Consumable Items
local function menu_consumable(self)

local function ch_cigs(menu)
    local user = menu.user

	if user:hasPermission("!item."..lang.item.cigs()..".>0") and user:hasPermission("!item."..lang.item.lighter()..".>0") then
		user:tryTakeItem(lang.items.cigs(), 1)
		self.remote.setItemOnPlayer(user.source, "prop_amb_ciggy_01")
        vRP.EXT.Survival.remote._varyHealth(user.source, 25)
        vRP.EXT.Base.remote._notify(user.source, "~g~Smoking a cig.")
        local seq = {{"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}}
        vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			SetTimeout(20000, function()
			self.remote.setItemOnPlayer(user.source, "prop_amb_ciggy_01")
			user:varyExp("physical", "addiction", 0.10)			
        end)
	else
	vRP.EXT.Base.remote._notify(user.source, "You need a Lighter and a Cigarette to smoke a cig")
    end
end

local function ch_weed(menu)
    local user = menu.user

	if user:hasPermission("!item."..lang.item.lighter()..".>0") and user:hasPermission("!item."..lang.item.rolly()..".>0") and user:hasPermission("!item."..lang.item.weed()..".>0") then 
		user:tryTakeItem(lang.items.rolly(),1) user:tryTakeItem(lang.item.weed(),1)
        vRP.EXT.Survival.remote._varyHealth(user.source, 25)
        vRP.EXT.Base.remote._notify(user.source, "~g~Smoking weed.")
        local seq = {{"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}}
        vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			SetTimeout(10000, function()
            self.remote.playMovement(user.source, "move_p_m_zero_slow","Male slow", true, true, false, false)
            self.remote.playScreenEffect(user.source, "DrugsDrivingIn", 120)
			user:varyExp("physical", "addiction", 0.05)
        end)
        SetTimeout(120000, function()
            self.remote.resetMovement(user.source, false)
        end)
	else
	vRP.EXT.Base.remote._notify(user.source, "You need a Rolling paper, Lighter and Weed to roll and smoke a joint")
    end
end

local function ch_vodka(menu)
    local user = menu.user

          if user:tryTakeItem("edible|vodka",1) then
            user:varyVital("food",30)
            user:varyVital("water",30)
  		    vRP.EXT.Survival.remote._varyHealth(user.source, 25)

            vRP.EXT.Base.remote._notify(user.source, "~b~Drinking Vodka.")
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRP.EXT.Base.remote._playAnim(user.source, true,seq,false)
			SetTimeout(5000,function()
			  self.remote.playMovement(user.source,"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false)
			  self.remote.playScreenEffect(user.source, "Rampage", 120)
			  user:varyExp("physical", "addiction", 0.08)
			   end)
			  SetTimeout(120000,function()
			  self.remote.resetMovement(user.source,false)
       end)

    end
end

local function ch_meth(menu)
    local user = menu.user

	if user:hasPermission("!item."..lang.item.meth()..".>0") and user:hasPermission("!item."..lang.item.lighter()..".>0") and user:hasPermission("!item."..lang.item.methpipe()..".>0") then 
		user:tryTakeItem(lang.items.meth(),1)
        vRP.EXT.Survival.remote._varyHealth(user.source, 25)
        vRP.EXT.Base.remote._notify(user.source, "~g~Smoking meth.")
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
        vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			SetTimeout(4000, function()
            self.remote.playMovement(user.source, "FEMALE_FAST_RUNNER", true, true, false, false)
            self.remote.playScreenEffect(user.source, "FocusOut", 120)
			self.remote.playerSpeed(user.source, 10.00)
			user:varyExp("physical", "addiction", 0.05)
        end)
        SetTimeout(120000, function()
			self.remote.playerSpeed(user.source, 1.00)
            self.remote.resetMovement(user.source, false)
        end)
	else
	vRP.EXT.Base.remote._notify(user.source, "You need a Meth pipe, Lighter and Meth to smoke meth")
    end
end

local function ch_lsd(menu)
    local user = menu.user

	if user:hasPermission("!item."..lang.item.lsd()..".>0") then 
		user:tryTakeItem(lang.items.lsd(),1)
        vRP.EXT.Survival.remote._varyHealth(user.source, 25)
        vRP.EXT.Base.remote._notify(user.source, "~g~Taking a hit of LSD.")
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
        vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			SetTimeout(4000, function()
            self.remote.playMovement(user.source, "move_f@scared", true, true, false, false)
            self.remote.playScreenEffect(user.source, "PeyoteEndOut", 120)
            self.remote.playScreenEffect(user.source, "FocusOut", 120)	
			user:varyExp("physical", "addiction", 0.05)
        end)
        SetTimeout(120000, function()
            self.remote.resetMovement(user.source, false)
        end)
	else
	vRP.EXT.Base.remote._notify(user.source, "You need LSD to take a hit")
    end
end



vRP.EXT.GUI:registerMenuBuilder("consumable", function(menu)
        menu.title = "Consumable Drugs"
        menu:addOption("Weed", ch_weed, "Roll and Smoke a Joint")
        menu:addOption("Vodka", ch_vodka, "Take a Swig of Vodka")
        menu:addOption("Cigarettes", ch_cigs, "Smoke a cig")	
        menu:addOption("LSD", ch_lsd, "Take a hit of lsd")
        --menu:addOption("Cocaine", ch_coke, "Not in yet")
        menu:addOption("Meth", ch_meth, "Extreme Stimulant")		
end)

end

-- menu: User List
local function menu_users(self)

  vRP.EXT.GUI:registerMenuBuilder("users", function(menu)
    local user = menu.user
    local id = menu.data.id

    menu.title = "Player List"
    menu.css.header_color = "rgba(0,155,155,0.75)"

    for id, user in pairs(vRP.users) do
      menu:addOption(lang.admin.users.user.title({id, htmlEntities.encode(user.name)}), m_user, nil, id)
  end
  end)
end

-- menu: Player menu
local function menu_player(self)

  local function ch_users(menu, id)
    menu.user:openMenu("users", {id = id})
  end

vRP.EXT.GUI:registerMenuBuilder("player", function(menu)
	if menu.user:hasPermission(lang.perms.plist()) then
    menu.title = "Player List"
	menu:addOption("Player List", ch_users)
	end		
end)

end




-- dynamic Fine
local function m_fine(menu)
    local user = menu.user
    local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 5)

    if nplayer then
        nuser = vRP.users_by_source[nplayer]
    end

    if nuser then
        local fine = user:prompt(lang.fine.prompt.amount(), "")

        if fine ~= nil and fine ~= "" then
            local reason = user:prompt(lang.fine.prompt.reason(), "")

            if reason ~= nil and reason ~= "" then
                    if tonumber(fine) > 10000 then
                        fine = 10000
                    end

                    if tonumber(fine) < 50 then
                        fine = 50
                    end

                    if nuser:tryFullPayment(tonumber(fine)) then
                        user:insertPoliceRecord(nuser.source, lang.police.menu.fine.record({reason,fine}))
                        vRP.EXT.Base.remote._notify(user.source, lang.police.menu.fine.fined({reason,fine}))
                        vRP.EXT.Base.remote._notify(nuser.source, lang.police.menu.fine.notify_fined({reason,fine}))
						
                        self.logInfoToFile(lang.fine.file(), lang.fine.log({user.id, nuser.id, fine, reason}))
                        user:closeMenu()
                    end
                else
                    vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
                end
            else
                vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
        end
    else
        vRP.EXT.Base.remote._notify(user.source, lang.common.no_player_near())
    end
end




unjailed = {}

-- dynamic jail
local function menu_dynamicjail(self)

local function ch_jail(menu)
    local user = menu.user
    local tuser = menu.user.id	
	
	local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 5)
    if nplayer then nuser = vRP.users_by_source[nplayer] end
	
	if nuser then
            local jail_time = user:prompt(lang.jail.prompt(), "")
			if jail_time ~= nil and jail_time ~= "" then 
                if tonumber(jail_time) > 30 then
                    jail_time = 30
                end

                if tonumber(jail_time) < 1 then
                    jail_time = 1
                end
				local audio = lang.jail.audio()
				vRP.EXT.Audio.remote._playAudioSource(nuser.source, audio, 0.3, x,y,z, 15)
                vRP.EXT.Base.remote._teleport(nuser.source, 1641.5477294922, 2570.4819335938, 45.564788818359) -- teleport to inside jail
                vRP.EXT.Base.remote._notify(nuser.source, lang.jail.sent.bad())
                vRP.EXT.Base.remote._notify(user.source, lang.jail.sent.good())
                nuser:setVital("food", 1)
                nuser:setVital("water", 1)
				vRP.EXT.Police.remote._setHandcuffed(nuser.source, true)
                jail_clock(tonumber(nuser.id), tonumber(jail_time))
                self.logInfoToFile(lang.jail.file(), lang.jail.log({user.id, nuser.id, jail_time}))
		    end	
       else
            vRP.EXT.Base.remote._notify(user.source, "No player near")			
	end
end


-- dynamic unjail
local function ch_unjail(menu)
    local user = menu.user

    local target = parseInt(menu.user:prompt(lang.admin.users.by_id.prompt(), ""))


	  if target ~= nil and target ~= "" then 
        local value = vRP:getUData(tonumber(target), "vRP:jail:time")

        if value ~= nil then
            custom = json.decode(value)

            if custom ~= nil then
                if tonumber(custom) > 0 or user:hasPermission(lang.unjail.admin()) then

						local nuser = vRP.users[target]		
                        unjailed[tonumber(nuser.id)] = tonumber(target)
                        vRP.EXT.Base.remote._notify(user.source, lang.unjail.released())
                        vRP.EXT.Base.remote._notify(nuser.source, lang.unjail.lowered())
                        self.logInfoToFile(lang.unjail.file(), lang.unjail.log({user.id, target, custom}))
					end
                else
                    vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
                end
            end
        else
            vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
    end
end

vRP.EXT.GUI:registerMenuBuilder("dynamicjail", function(menu)
    menu.title = "Jail Menu"

	menu:addOption(lang.jail.send(), ch_jail)
	menu:addOption(lang.unjail.release(), ch_unjail)
			
end)
end



local function menu_vehicledoors(self)
local function ch_lfdoor(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 0)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

local function ch_rfdoor(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 1)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

local function ch_lrdoor(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 2)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

local function ch_rrdoor(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 3)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

local function ch_hood(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 4)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

local function ch_trunk(menu)
    local user = menu.user
    local vehicle = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 4)

    if vehicle then
        self.remote._vehicleDoors(user.source, 5)
    else
        vRP.EXT.Base.remote._notify(user.source, "Not close enough to vehicle.")
    end
end

vRP.EXT.GUI:registerMenuBuilder("vehicledoors", function(menu)
        menu.title = "Vehicle Doors"
        menu:addOption("Front Left", ch_lfdoor)
        menu:addOption("Front Right", ch_rfdoor)
        menu:addOption("Rear Left", ch_lrdoor)
        menu:addOption("Rear Right", ch_rrdoor)		
        menu:addOption("Hood", ch_hood)
        menu:addOption("Trunk", ch_trunk)			
end)

end

  -- police computer while near PV
  local function m_computer(menu)
    local user = menu.user
    -- check vehicle
    local model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 7)
    if model then

    local menu = user:openMenu("computer")

      local running = true
      menu:listen("remove", function(menu)
        running = false
      end)

      -- task: close menu if not next to the vehicle
      Citizen.CreateThread(function()
        while running do
          Citizen.Wait(8000)
          local check_model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 7)
          if model ~= check_model then
            user:closeMenu(menu)
          end
        end
      end)
    else
      vRP.EXT.Base.remote._notify(user.source, lang.police.connection())
    end
  end

    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
      menu:addOption(lang.police.veh_searchtitle.title(), m_computer)
  end)


  
--[[  -- Police Drag
  local function m_drag(menu)
    local user = menu.user

	local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 5)
    if nplayer then nuser = vRP.users_by_source[nplayer] end
	
	if nuser then	
	
	if vRP.EXT.Police.remote.isHandcuffed(nuser.source) then
	
    	self.remote._policeDrag(user.source)
    else
    	vRP.EXT.Base.remote._notify(user.source, "~r~Not Handcuffed")
    end
  else
    vRP.EXT.Base.remote._notify(user.source, "~r~No Player Near")
  end
end

    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
      menu:addOption("Drag", m_drag,"Drag the nearest handcuffed player")
  end)--]]

globalbox = false
localbox = false

local function menu_boombox(self)
    local function m_localboom(menu)
        local user = menu.user

	if user:hasPermission("!item."..lang.item.bbox()..".>0") or user:hasPermission(lang.perms.nobbox()) then	
		
        if not globalbox then
            localbox = true
            self.remote.startBoomBox(user.source)
        else
            vRP.EXT.Base.remote._notify(user.source, lang.bbox.gloplay())
        end	
       else
            vRP.EXT.Base.remote._notify(user.source, lang.bbox.inventory())			
    end
  end	

    local function m_globalboom(menu)
        local user = menu.user

        if user:hasPermission(lang.perms.bbox()) then		
		
	if user:hasPermission("!item."..lang.item.bbox()..".>0") or user:hasPermission(lang.perms.nobbox()) then			
            if not localbox then
                globalbox = true
                self.remote.startBoomBox(user.source)
				else
            vRP.EXT.Base.remote._notify(user.source, lang.bbox.localplay())
            end
			  else
            vRP.EXT.Base.remote._notify(user.source, lang.bbox.inventory())
        end
        else
            vRP.EXT.Base.remote._notify(user.source, lang.bbox.no())		
    end
  end


    vRP.EXT.GUI:registerMenuBuilder("boombox", function(menu)
        local user = menu.user
        menu.title = lang.bbox.title()
        menu.css.header_color = "rgba(0,125,255,0.75)"
        menu:addOption(lang.bbox.playlo(), m_localboom)
        menu:addOption(lang.bbox.playglo(), m_globalboom)
    end)
end
  
local function menu_pmenu(self)


-- Lockpick vehicle
local function m_lockpickveh(menu)
    local user = menu.user
    if user:tryTakeItem(lang.item.lockpick(), 1, true) or user:hasPermission("item.bypass") then
        self.remote.lockpickVehicle(user.source, 20, true)
		else
		 vRP.EXT.Base.remote._notify(user.source, "~r~No lockpick in inventory")
    end
end

-- Lockpick Bank Van
local function m_breakvan(menu)
    local user = menu.user
	local vmod = "stockade"

	local model = self.remote.isPlayerNearModel(user.source, vmod, 5)
	if user:tryTakeItem("plasmacutter", 1, true) or user:hasPermission(lang.perms.lockpick_noapt()) then
	if model then
	self.remote.breakBankVan(user.source, 30)
    else
        vRP.EXT.Base.remote._notify(user.source, "Must be near a unoccupied armored van.")
    end
	    else
		vRP.EXT.Base.remote._notify(user.source, "You need a Plasma Cutter.")
        
	end
end


	
    vRP.EXT.GUI:registerMenuBuilder("player", function(menu)
		menu.title = "Player Menu"	
		menu:addOption("Lock picking kit", m_lockpickveh, lang.lockpick.menu2())
		menu:addOption("Plasma cutter tool", m_breakvan, "Used to open up the back of a armored van.")

		
		
    end)

	end
  
function Addons:__construct()
    vRP.Extension.__construct(self)

self.spikes = {}
	
	  self.cfg = module("vrp", "cfg/garages")

	  
    menu_pmenu(self)
    menu_vehicledoors(self)	
    menu_dynamicjail(self)
    menu_player(self)
    menu_users(self)
    menu_deployable(self)
    menu_consumable(self)
    menu_computer(self)
    menu_boombox(self)

	
--Fines

    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
        menu:addOption("Dynamic Fine", m_fine)
    end)	
	
--Vehicle Doors
    local function m_doors(menu)
        local user = menu.user
            menu.user:openMenu("vehicledoors")
        end

    vRP.EXT.GUI:registerMenuBuilder("vehicle", function(menu)
        menu:addOption("Doors", m_doors)
    end)

--Consumables Drugs	
    local function ch_consumable(menu)
        local user = menu.user
        menu.user:openMenu("consumable")
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("player", function(menu)
	local user = vRP.users_by_source[source]
        menu:addOption("Consumable Drugs", ch_consumable)
    end)	
	
--[[
--Sell Car to Players	
    local function ch_sellcar(menu)
        local user = menu.user
        local smenu = menu.user:openMenu("playerkeys", menu.data)
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("player", function(menu)
        menu:addOption("Keys", ch_sellcar)
    end) --]]

--Player
--Players Menu
    local function ch_players(menu)
        local user = menu.user
        menu.user:openMenu("player")
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("main", function(menu)
        menu:addOption("Player", ch_players)

    end)	

--BoomBox
    local function m_boom(menu)
        local user = menu.user
            menu.user:openMenu("boombox")
        end

    vRP.EXT.GUI:registerMenuBuilder("player", function(menu)
        menu:addOption("Boom Box", m_boom)
    end)
	
--Jail in Mobile PC
    local function ch_mjail(menu)
        local user = menu.user
        menu.user:openMenu("dynamicjail")
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("police_pc", function(menu)
	    if menu.user:hasPermission(lang.perms.jailer()) then
        menu:addOption(lang.jail.menu(), ch_mjail)
		end
    end)

--Jail in police menu
    local function ch_mjail(menu)
        local user = menu.user
        menu.user:openMenu("dynamicjail")
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
	    if menu.user:hasPermission(lang.perms.jailer_mobile()) then --mobile prison options for admin/mod
        menu:addOption(lang.jail.menu(), ch_mjail)
		end
    end)	

		
--Deployable Police Items	
    local function ch_police(menu)
        local user = menu.user
        menu.user:openMenu("deployable")
    end	
	
    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
		if menu.user:hasPermission(lang.perms.pol_props()) then
        menu:addOption(lang.police.extras(), ch_police)
		end
    end)	
	





end


function Addons.takePick()
local user = vRP.users_by_source[source]
user:tryTakeItem(lang.item.lockpick(), 1, false)
end
		
-- EVENT
Addons.event = {}

function Addons.event:playerSpawn(user, first_spawn)
    if first_spawn then
    SetTimeout(25000, function()
        if user and user:isReady() then

  	    local custom = {}
            local value = vRP:getUData(user.id, "vRP:jail:time")

            if value ~= nil then
                custom = json.decode(value)

                if custom ~= nil then
                    if tonumber(custom) > 0 then
						local audio = lang.jail.audio()
						vRP.EXT.Audio.remote._playAudioSource(user.source, audio, 0.3, x,y,z, 15)
						vRP.EXT.Police.remote._setHandcuffed(user.source, true)
                        vRP.EXT.Base.remote._teleport(user.source, 1641.5477294922, 2570.4819335938, 45.564788818359) -- teleport inside jail
						user:setVital("food", 1)
						user:setVital("water", 1)
                        vRP.EXT.Base.remote._notify(user.source, lang.jail.resent())
                        jail_clock(tonumber(user.id), tonumber(custom))
                        self.logInfoToFile(lang.unjail.file(), lang.jail.log2({user.id, custom}))
						
                    end
                end
            end
        end
    end)
	end
end



function jail_clock(target_id,timer)


	uuser = vRP.users[tonumber(target_id)]

  local online = false
  for k,v in pairs(vRP.users) do  
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then


	
    if timer>0 then
	  vRP.EXT.Base.remote._notify(uuser.source, lang.jail.timer({timer}))
      vRP:setUData(tonumber(target_id),"vRP:jail:time",json.encode(timer))
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
			end
		  end
		uuser:setVital("food", 1)
		uuser:setVital("water", 1)
	    jail_clock(tonumber(target_id), timer-1)
	  end) 
    else
	  vRP.EXT.Base.remote._teleport(uuser.source,425.7607421875,-978.73425292969,30.709615707397) -- teleport to outside jail
	  vRP.EXT.Police.remote._setHandcuffed(uuser.source, false)	
	  uuser:setVital("food", 0)
	  uuser:setVital("water", 0)
      vRP.EXT.Base.remote._notify(uuser.source, lang.jail.free())
	  vRP:setUData(tonumber(target_id),"vRP:jail:time",json.encode(-1))
	  vRP:save(uuser.id)
  
	  end
	end
end

-- LOG FUNCTION
function Addons.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end
	
-- TUNNEL
Addons.tunnel = {}

function Addons.tunnel:notClose()
    local user = vRP.users_by_source[source]
		vRP.EXT.Base.remote._notify(user.source, "The plasma cutter must touch the vehicle.") 
end


function Addons.tunnel:breakVan()
    local user = vRP.users_by_source[source]
	local audio = "https://vignette.wikia.nocookie.net/soundeffects/images/a/a3/Hollywoodedge%2C_Car_Alarm_Rapid_Highp_PE074901.ogg"
	local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)

	if user:tryTakeItem("plasmacutter", 1) then
		local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
		vRP.EXT.Phone:sendServiceAlert(nil, "police" ,x,y,z, "Armored Van Robbery in Progress")
		vRP.EXT.Base.remote._notifyPicture(user.source, "CHAR_LESTER", 1, "WARNING", "Alarm Triggered", "The police were alerted!")
		vRP.EXT.Audio.remote._playAudioSource(-1, audio, 0.7, x,y,z, 75)    
	end
end
	
	
function Addons.tunnel:removeSpike()
    local user = vRP.users_by_source[source]
self.spikes[user.source] = false
end


function Addons.tunnel:setAudio()
    local audio = lang.bbox.audio()
    local user = vRP.users_by_source[source]

    if globalbox then
        vRP.EXT.Audio.remote._setAudioSource(-1, user.id, audio, 0.3, 0, 0, 0, 30, user.source)
        vRP.EXT.Base.remote._notify(user.source, lang.bbox.playinglo())
    else
        vRP.EXT.Audio.remote._setAudioSource(user.source, user.id, audio, 0.3, 0, 0, 0, 30, user.source)
        vRP.EXT.Base.remote._notify(user.source, lang.bbox.playinlo())
    end
end

function Addons.tunnel:stopAudio()
    local user = vRP.users_by_source[source]

    if globalbox then
        globalbox = false
        vRP.EXT.Audio.remote._removeAudioSource(-1, user.id)
    else
        localbox = false
        vRP.EXT.Audio.remote._removeAudioSource(user.source, user.id)
    end
end


vRP:registerExtension(Addons)	
