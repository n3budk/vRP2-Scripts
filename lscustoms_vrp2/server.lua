local LsCustoms = class("LsCustoms", vRP.Extension)

function LsCustoms:__construct()
    vRP.Extension.__construct(self)
	  self.cfg = module("lscustoms_vrp2","cfg/lscustoms")
end

-- TUNNEL
LsCustoms.tunnel = {}

function LsCustoms.tunnel:checkClean()
    local user = vRP.users_by_source[source]

    if user:request("Clean and Fix Vehicle -$"..cleanfix, 15) then
        if user:tryFullPayment(cleanfix) then
            self.remote.applyClean(user.source)
        else
            vRP.EXT.Base.remote._notify(user.source, "~r~Not enough money")
        end
    end
end

function LsCustoms.tunnel:ownedVhicleCheck()
  local source = source
  local blockEnter = false
  local user = vRP.users_by_source[source]
  if user:getWallet() >= self.cfg.minwallet  then 
  if user:hasPermission("!in_owned_vehicle") then
  self.remote._blockEnter(user.source,blockEnter)
  else
    local blockEnter = true
		vRP.EXT.Base.remote._notify(user.source, "~r~Only a personal vehicle can be modified!")
		self.remote._blockEnter(user.source,blockEnter)
	end
  else 
    local blockEnter = true
	vRP.EXT.Base.remote._notify(user.source, "~r~You must have at least ~g~$" ..self.cfg.minwallet.. " ~n~~b~in your wallet to enter!")
		self.remote._blockEnter(user.source,blockEnter)	
	end
end

function LsCustoms.tunnel:lockCar()
  local user = vRP.users_by_source[source]
vRP.EXT.Addons.remote._freezePedVehicle(user.source, true)
vRP.EXT.Police.remote._setHandcuffed(user.source, true)
vRP.EXT.Addons.remote.lockPedVehicle(user.source, 4)
vRP.EXT.Base.remote._notify(user.source, "~b~Welcome!")
end

function LsCustoms.tunnel:payGarage(totalPrice)
  local source = source
  local user = vRP.users_by_source[source]
	totalPrice = tonumber(totalPrice)
    if totalPrice == nil then totalPrice = 0 end
	if user:tryFullPayment(tonumber(totalPrice)) then
	vRP:save()
	vRP.EXT.Garage.remote.setStateReady(user.source, true)
	local audio = "https://vocaroo.com/media_command.php?media=s0jpEYX1kKFH&command=download_mp3"
	local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
		vRP.EXT.Audio.remote._playAudioSource(-1, audio, 0.8, x,y,z, 15)	
		self.remote._installMods(user.source)
		vRP.EXT.Base.remote._notify(user.source, "~g~Please wait while your vehicle is prepared...")
		SetTimeout(10000,function()
		self.remote._goBack(user.source)
		vRP.EXT.Addons.remote._freezePedVehicle(user.source, false)
		vRP.EXT.Addons.remote.lockPedVehicle(user.source, 0)
		vRP.EXT.Police.remote._setHandcuffed(user.source, false)
		vRP.EXT.Base.remote._notify(user.source, "~b~Vehicle Ready ~w~- Paid ~g~$"..totalPrice)
		end)
	else
		vRP.EXT.Base.remote._notify(user.source, "~r~Not enough money")
		vRP.EXT.Addons.remote._freezePedVehicle(user.source, false)
		vRP.EXT.Addons.remote.lockPedVehicle(user.source, 0)
		vRP.EXT.Police.remote._setHandcuffed(user.source, false)
		self.remote._revertMods(user.source)
		vRP.EXT.Garage.remote.setStateReady(user.source, true)
	end
end

function LsCustoms.tunnel:killVState()
  local user = vRP.users_by_source[source]
  vRP.EXT.Garage.remote.setStateReady(user.source, false)
  end

function LsCustoms.tunnel:repair()
  local user = vRP.users_by_source[source]
  vRP.EXT.Garage.remote.setStateReady(user.source, false)
  end

-- EVENT
LsCustoms.event = {}

function LsCustoms.event:playerSpawn(user, first_spawn)
  if first_spawn then
    for k,v in pairs(self.cfg.modshops) do
      local gtype,x,y,z = table.unpack(v)
      local group = self.cfg.modshop_types[gtype]

      if group then
        local gcfg = group._config

        local ment = clone(gcfg.map_entity)
        ment[2].title = "Mod Shop"
        ment[2].pos = {x,y,z-1}
        vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
      end
    end
  end
end  
  
vRP:registerExtension(LsCustoms) 
  