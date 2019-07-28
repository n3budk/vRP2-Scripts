local AddonsV = class("AddonsV", vRP.Extension)


function AddonsV:getVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

function AddonsV:getNearestVehicle(radius)
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
      return GetVehiclePedIsIn(ped, true)
    else
      -- flags used:
      --- 8192: boat
      --- 4096: helicos
      --- 4,2,1: cars (with police)

      local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+5.0001, 0, 8192+4096+4+2+1)  -- boats, helicos
      if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+5.0001, 0, 4+2+1) end -- cars
      return veh
    end
end

function AddonsV:deleteVehicleInFrontOrInside(offset)
  local ped = GetPlayerPed(-1)
  local veh = nil
  if (IsPedSittingInAnyVehicle(ped)) then 
    veh = GetVehiclePedIsIn(ped, false)
  else
    veh = self:getVehicleInDirection(GetEntityCoords(ped, 1), GetOffsetFromEntityInWorldCoords(ped, 0.0, offset, 0.0))
  end
  
  if IsEntityAVehicle(veh) then
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    vRP.EXT.Base:notify("Success")
  else
    vRP.EXT.Base:notify("Too far")
  end
end


function AddonsV:deleteNearestVehicle(radius)
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  local veh = self:getNearestVehicle(radius)
  
  if IsEntityAVehicle(veh) then
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    vRP.EXT.Base:notify("Success")
  else
    vRP.EXT.Base:notify("Too far")
  end
end

function AddonsV:spawnVehicle(model) 
    local i = 0
    local mhash = GetHashKey(model)
    while not HasModelLoaded(mhash) and i < 1000 do
	  if math.fmod(i,100) == 0 then
	    vRP.EXT.Base:notify("loading") -- lang.spawnveh.invalid()
	  end
      RequestModel(mhash)
      Citizen.Wait(30)
	  i = i + 1
    end

    -- spawn car if model is loaded
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.EXT.Base:getPosition()
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  
	  SetVehicleDoorsLocked(nveh, 1)
		for i = 1,64 do 
		SetVehicleDoorsLockedForPlayer(nveh, GetPlayerFromServerId(i), false)
	end 
	  
      SetModelAsNoLongerNeeded(mhash)
	  vRP.EXT.Base:notify("Success") -- lang.spawnveh.invalid()
	else
	  vRP.EXT.Base:notify("invalid") -- lang.spawnveh.invalid()
	end
end

local isRadarExtended = false
local showblip = false
local showsprite = false

function AddonsV:showBlips()
	showblip = not showblip
	if showblip then
		showsprite = true
		vRP.EXT.Base:notify("Blips on") -- lang.blips.off()
	else
		showsprite = false
		vRP.EXT.Base:notify("Blips off") -- lang.blips.off()
	end
end

function AddonsV:showSprites()
	showsprite = not showsprite
	if showsprite then
		vRP.EXT.Base:notify("Sprites on") -- lang.sprites.off()
	else
		vRP.EXT.Base:notify("Sprites off") -- lang.sprites.off()
	end
end


function AddonsV:tpToWaypoint()

	local targetPed = GetPlayerPed(-1)
	local targetVeh = GetVehiclePedIsUsing(targetPed)
	if(IsPedInAnyVehicle(targetPed))then
		targetPed = targetVeh
    end

	if(not IsWaypointActive())then
		vRP.EXT.Base:notify("Waypoint not found") --lang.tptowaypoint.notfound()
		return
	end

	local waypointBlip = GetFirstBlipInfoId(8) -- 8 = waypoint Id
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 

	-- ensure entity teleports above the ground
	local ground
	local groundFound = false
	local groundCheckHeights = {100.0, 150.0, 50.0, 0.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(targetPed, x,y,height, 0, 0, 1)
		Wait(10)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if(ground) then
			z = z + 3
			groundFound = true
			break;
		end
	end

	if(not groundFound)then
		z = 1000
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- parachute
	end

	SetEntityCoordsNoOffset(targetPed, x,y,z, 0, 0, 1)
	vRP.EXT.Base:notify("Teleported") -- lang.tptowaypoint.success()
end


local fwindowup = true
function AddonsV:frontvehicleWindows()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
            SetEntityAsMissionEntity( playerCar, true, true )
		
			if ( fwindowup ) then
				RollDownWindow(playerCar, 0)
				RollDownWindow(playerCar, 1)
				fwindowup = false
			else
				RollUpWindow(playerCar, 0)
				RollUpWindow(playerCar, 1)
				fwindowup = true
			end
		end
	end
end

local bwindowup = true
function AddonsV:backvehicleWindows()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
            SetEntityAsMissionEntity( playerCar, true, true )
		
			if ( bwindowup ) then
				RollDownWindow(playerCar, 2)
				RollDownWindow(playerCar, 3)
				bwindowup = false
			else
				RollUpWindow(playerCar, 2)
				RollUpWindow(playerCar, 3)
				bwindowup = true
			end
		end
	end
end

function AddonsV:vehicleDoors(flag)
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

function AddonsV:setItemOnPlayer(item)
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

function AddonsV:setPropSpike(prop)
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

function AddonsV:setPropBarrier(prop)
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

function AddonsV:setProp(prop)
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


function AddonsV:closeProp(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey(prop), true) then
	  return true
	else 
	  return false
	end
end

function AddonsV:removeProp(prop)
    local ped = GetPlayerPed(-1)
    x, y, z = table.unpack(GetEntityCoords(ped, true))
	ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0))
    if DoesObjectOfTypeExistAtCoords(ox, oy, oz, 0.9, GetHashKey(prop), true) then
        prop = GetClosestObjectOfType(ox, oy, oz, 0.9, GetHashKey(prop), false, false, false)
        SetEntityAsMissionEntity(prop, true, true)
        DeleteObject(prop)
	end
end

function AddonsV:removeSpikes()
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
function AddonsV:lockpickVehicle(wait,any)
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
function AddonsV:breakBankVan(wait)
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
			vRP.EXT.Base:notify("The plasma cutter must touch the vehicle.") 
	end
end


 
function  AddonsV:isPlayerNearModel(model,radius)
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
function AddonsV:playScreenEffect(name, duration)
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
function AddonsV:stopScreenEffect(name)
  StopScreenEffect(name)
end

-- MOVEMENT CLIPSET
function AddonsV:playMovement(clipset,blur,drunk,fade,clear)
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

function AddonsV:resetMovement(fade)
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

    function AddonsV:startBoomBox()
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

function AddonsV:__construct()
    vRP.Extension.__construct(self)



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

end	





function AddonsV:IsPedInAnyHeli()
  if IsPedInAnyHeli(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end

function AddonsV:IsPedInAnyPlane()
  if IsPedInAnyPlane(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end

function AddonsV:freezePed(flag)
  FreezeEntityPosition(GetPlayerPed(-1),flag)
end

function AddonsV:lockPedVehicle(flag)
SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end


function AddonsV:freezePedVehicle(flag)
  FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end

function AddonsV:isPlayerInVehicleModel(model)
  if (IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey(model))) then -- just a function you can use to see if your player is in a taxi or any other car model (use the tunnel)
    return true
  else
    return false
  end
end

function AddonsV:isInAnyVehicle()
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
	return true
  else
    return false
  end
end 




AddonsV.tunnel = {}



AddonsV.tunnel.deleteVehicleInFrontOrInside = AddonsV.deleteVehicleInFrontOrInside

AddonsV.tunnel.spawnVehicle = AddonsV.spawnVehicle
AddonsV.tunnel.tpToWaypoint = AddonsV.tpToWaypoint

AddonsV.tunnel.frontvehicleWindows = AddonsV.frontvehicleWindows
AddonsV.tunnel.backvehicleWindows = AddonsV.backvehicleWindows
AddonsV.tunnel.isPlayerNearModel = AddonsV.isPlayerNearModel
AddonsV.tunnel.breakBankVan = AddonsV.breakBankVan
AddonsV.tunnel.setItemOnPlayer = AddonsV.setItemOnPlayer
AddonsV.tunnel.vehicleDoors = AddonsV.vehicleDoors
AddonsV.tunnel.lockPedVehicle = AddonsV.lockPedVehicle
AddonsV.tunnel.IsPedInAnyHeli = AddonsV.IsPedInAnyHeli
AddonsV.tunnel.IsPedInAnyPlane = AddonsV.IsPedInAnyPlane
AddonsV.tunnel.freezePed = AddonsV.freezePed
AddonsV.tunnel.freezePedVehicle = AddonsV.freezePedVehicle --eg for Client Mission = VRP.EXT.Mission.remote._isInAnyVehicle(user.source,true)
AddonsV.tunnel.isPlayerInVehicleModel = AddonsV.isPlayerInVehicleModel
AddonsV.tunnel.isInAnyVehicle = AddonsV.isInAnyVehicle

AddonsV.tunnel.startBoomBox = AddonsV.startBoomBox
AddonsV.tunnel.setPropBarrier = AddonsV.setPropBarrier
AddonsV.tunnel.setPropSpike = AddonsV.setPropSpike
AddonsV.tunnel.setProp = AddonsV.setProp
AddonsV.tunnel.closeProp = AddonsV.closeProp	
AddonsV.tunnel.removeProp = AddonsV.removeProp
AddonsV.tunnel.lockpickVehicle = AddonsV.lockpickVehicle
AddonsV.tunnel.playScreenEffect = AddonsV.playScreenEffect
AddonsV.tunnel.stopScreenEffect = AddonsV.stopScreenEffect
AddonsV.tunnel.playMovement = AddonsV.playMovement
AddonsV.tunnel.resetMovement = AddonsV.resetMovement



	
vRP:registerExtension(AddonsV)	
	
