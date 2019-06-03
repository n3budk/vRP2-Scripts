
local Addons = class("Addons", vRP.Extension)


function Addons:vehicleDoors(flag)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    

        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, flag) > 0 then
                SetVehicleDoorShut(veh, flag, false)
            else	
                SetVehicleDoorOpen(veh, flag, false, false)
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, flag) > 0 then
                    SetVehicleDoorShut(vehLast, flag, false)
                else	
                    SetVehicleDoorOpen(vehLast, flag, false, false)
            end
        end
    end
end


--Attach Entity to Player

function Addons:setItemOnPlayer(item)
				local cigar_name = item
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
			end     
		end
	end	

--Add Props

function Addons:setPropSpike(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	h = GetEntityHeading(ped)
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
	prop = GetHashKey(prop)
	local heading = GetEntityHeading(GetPlayerPed(-1))

    RequestModel(prop)
    while not HasModelLoaded(prop) do
      Citizen.Wait(1)
    end

    local object = CreateObject(prop, ox, oy, oz, true, true, false)
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object,heading)
end

function Addons:setPropBarrier(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	h = GetEntityHeading(ped)
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
	prop = GetHashKey(prop)
	local heading = GetEntityHeading(GetPlayerPed(-1))

    RequestModel(prop)
    while not HasModelLoaded(prop) do
      Citizen.Wait(1)
    end

    local object = CreateObject(prop, ox, oy, oz, true, true, false)
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object,heading)
    FreezeEntityPosition(object, true)
end

function Addons:setProp(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	h = GetEntityHeading(ped)
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
	prop = GetHashKey(prop)
	local heading = GetEntityHeading(GetPlayerPed(-1))

    RequestModel(prop)
    while not HasModelLoaded(prop) do
      Citizen.Wait(1)
    end

    local object = CreateObject(prop, ox, oy, oz, true, true, false)
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object,heading)
    FreezeEntityPosition(object, true)	
end


function Addons:closeProp(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey(prop), true) then
	  return true
	else 
	  return false
	end
end

function Addons:removeProp(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey(prop), true) then
        prop = GetClosestObjectOfType(ox, oy, oz, 0.9, GetHashKey(prop), false, false, false)
        SetEntityAsMissionEntity(prop, true, true)
        DeleteObject(prop)
	end
end

function Addons:removeSpikes()
    local prop = "P_ld_stinger_s"
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey(prop), true) then
        prop = GetClosestObjectOfType(ox, oy, oz, 0.9, GetHashKey(prop), false, false, false)
        SetEntityAsMissionEntity(prop, true, true)
        DeleteObject(prop)
	end
end

--LOCK PICK MENU
function Addons:lockpickVehicle(wait,any)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
		if DoesEntityExist(vehicleHandle) then
		  if GetVehicleDoorsLockedForPlayer(vehicleHandle,PlayerId()) or any then
			local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)
			if(IsEntityAnObject(prevObj)) then
				SetEntityAsMissionEntity(prevObj)
				DeleteObject(prevObj)
			end
			self.remote._takePick()
			StartVehicleAlarm(vehicleHandle)
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)

			Citizen.Wait(wait*1000)
			SetVehicleDoorsLocked(vehicleHandle, 1)
			for i = 1,64 do 
				SetVehicleDoorsLockedForPlayer(vehicleHandle, GetPlayerFromServerId(i), false)
			end 
			ClearPedTasksImmediately(GetPlayerPed(-1))
			
			vRP.EXT.Base:notify("Success") -- lang.lockpick.toofar()) -- lang.lockpick.success()
			
		  else
			vRP.EXT.Base:notify("Unlocked") -- lang.lockpick.toofar()
		  end
		else
			vRP.EXT.Base:notify("Not close enough") -- lang.lockpick.toofar()
	end
end


--LOCKin bank van
function Addons:breakBankVan(wait)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

    if DoesEntityExist(vehicleHandle) then
            local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)

            if (IsEntityAnObject(prevObj)) then
                SetEntityAsMissionEntity(prevObj)
                DeleteObject(prevObj)
            end

            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
			self.remote.breakVan()
            Citizen.Wait(wait * 1000)
			SetVehicleDoorOpen(vehicleHandle, 2, false)
            SetVehicleDoorOpen(vehicleHandle, 3, false)				
            ClearPedTasksImmediately(GetPlayerPed(-1))			
		else 
			self.remote.notClose()
	end
end


 
function  Addons:isPlayerNearModel(model,radius)
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  local v = GetClosestVehicle( x+0.0001, y+0.0001, z+0.0001,radius+0.0001,GetHashKey(model),70)
  if IsVehicleModel(v, GetHashKey(model)) then
	return true
  else
    return false
  end
end  
  


  
-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function Addons:playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)

    Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
      Citizen.Wait(math.floor((duration+1)*1000))
      StopScreenEffect(name)
    end)
  end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function Addons:stopScreenEffect(name)
  StopScreenEffect(name)
end

-- MOVEMENT CLIPSET
function Addons:playMovement(clipset,blur,drunk,fade,clear)
  --request anim
  RequestAnimSet(clipset)
  while not HasAnimSetLoaded(clipset) do
    Citizen.Wait(0)
  end
  -- fade out
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
  end
  -- clear tasks
  if clear then
    ClearPedTasksImmediately(GetPlayerPed(-1))
  end
  -- set timecycle
  SetTimecycleModifier("spectator5")
  -- set blur
  if blur then 
    SetPedMotionBlur(GetPlayerPed(-1), true) 
  end
  -- set movement
  SetPedMovementClipset(GetPlayerPed(-1), clipset, true)
  -- set drunk
  if drunk then
    SetPedIsDrunk(GetPlayerPed(-1), true)
  end
  -- fade in
  if fade then
    DoScreenFadeIn(1000)
  end
  
end

function Addons:resetMovement(fade)
  -- fade
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
  end
  -- reset all
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(GetPlayerPed(-1), 0)
  SetPedIsDrunk(GetPlayerPed(-1), false)
  SetPedMotionBlur(GetPlayerPed(-1), false)
end

local holdingBoombox = false
local boomModel = "prop_boombox_01"
local boomanimDict = "missheistdocksprep1hold_cellphone"
local boomanimName = "hold_cellphone"
local bag_net = nil

    function Addons:startBoomBox()
        if not holdingBoombox then
            RequestModel(GetHashKey(boomModel))

            while not HasModelLoaded(GetHashKey(boomModel)) do
                Citizen.Wait(100)
            end

            while not HasAnimDictLoaded(boomanimDict) do
                RequestAnimDict(boomanimDict)
                Citizen.Wait(100)
            end

            self.remote._setAudio()
            local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
            local boomSpawned = CreateObject(GetHashKey(boomModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
            Citizen.Wait(1000)
            local netid = ObjToNet(boomSpawned)
            SetNetworkIdExistsOnAllMachines(netid, true)
            --NetworkSetNetworkIdDynamic(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            AttachEntityToEntity(boomSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 57005), 0.30, 0, 0, 0, 260.0, 60.0, true, true, false, true, 1, true)
            TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
            TaskPlayAnim(GetPlayerPed(PlayerId()), boomanimDict, boomanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
            bag_net = netid
            holdingBoombox = true
        else
            ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
            DetachEntity(NetToObj(bag_net), 1, 1)
            DeleteEntity(NetToObj(bag_net))
            bag_net = nil
            holdingBoombox = false
            self.remote._stopAudio()
    end
end

function Addons:__construct()
    vRP.Extension.__construct(self)
self.spikes = {}


--tire spikes	
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
	self.remote._removeSpike() --Removed it as deployed on users server side
    if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
         SetVehicleTyreBurst(veh, 0, true, 1000.0)
         SetVehicleTyreBurst(veh, 1, true, 1000.0)
         SetVehicleTyreBurst(veh, 2, true, 1000.0)
         SetVehicleTyreBurst(veh, 3, true, 1000.0)
         SetVehicleTyreBurst(veh, 4, true, 1000.0)
         SetVehicleTyreBurst(veh, 5, true, 1000.0)
         SetVehicleTyreBurst(veh, 6, true, 1000.0)
         SetVehicleTyreBurst(veh, 7, true, 1000.0)
         self.removeSpikes() --deletes the spike
		 
     end
	end
   end
end)	
	

end	





Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15)

        if holdingBoombox then
            while not HasAnimDictLoaded(boomanimDict) do
                RequestAnimDict(boomanimDict)
                Citizen.Wait(100)
            end

            local coords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 44, true) -- INPUT_COVER
            DisableControlAction(0, 37, true) -- INPUT_SELECT_WEAPON
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
        end
    end
end)

function Addons:IsPedInAnyHeli()
  if IsPedInAnyHeli(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end

function Addons:IsPedInAnyPlane()
  if IsPedInAnyPlane(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end

function Addons:freezePed(flag)
  FreezeEntityPosition(GetPlayerPed(-1),flag)
end

function Addons:lockPedVehicle(flag)
SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end


function Addons:freezePedVehicle(flag)
  FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end

function Addons:isPlayerInVehicleModel(model)
  if (IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey(model))) then -- just a function you can use to see if your player is in a taxi or any other car model (use the tunnel)
    return true
  else
    return false
  end
end

function Addons:isInAnyVehicle()
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end 

Addons.tunnel = {}



Addons.tunnel.policeDrag = Addons.policeDrag
Addons.tunnel.isPlayerNearModel = Addons.isPlayerNearModel
Addons.tunnel.breakBankVan = Addons.breakBankVan
Addons.tunnel.setItemOnPlayer = Addons.setItemOnPlayer
Addons.tunnel.vehicleDoors = Addons.vehicleDoors
Addons.tunnel.lockPedVehicle = Addons.lockPedVehicle
Addons.tunnel.IsPedInAnyHeli = Addons.IsPedInAnyHeli
Addons.tunnel.IsPedInAnyPlane = Addons.IsPedInAnyPlane
Addons.tunnel.freezePed = Addons.freezePed
Addons.tunnel.freezePedVehicle = Addons.freezePedVehicle --eg for Client Mission = VRP.EXT.Mission.remote._isInAnyVehicle(user.source,true)
Addons.tunnel.isPlayerInVehicleModel = Addons.isPlayerInVehicleModel
Addons.tunnel.isInAnyVehicle = Addons.isInAnyVehicle

Addons.tunnel.startBoomBox = Addons.startBoomBox
Addons.tunnel.setPropBarrier = Addons.setPropBarrier
Addons.tunnel.setPropSpike = Addons.setPropSpike
Addons.tunnel.setProp = Addons.setProp
Addons.tunnel.closeProp = Addons.closeProp	
Addons.tunnel.removeProp = Addons.removeProp
Addons.tunnel.lockpickVehicle = Addons.lockpickVehicle
Addons.tunnel.playScreenEffect = Addons.playScreenEffect
Addons.tunnel.stopScreenEffect = Addons.stopScreenEffect
Addons.tunnel.playMovement = Addons.playMovement
Addons.tunnel.resetMovement = Addons.resetMovement



	
vRP:registerExtension(Addons)	
	
