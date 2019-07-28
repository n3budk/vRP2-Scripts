local HotKeys = class("HotKeys", vRP.Extension)

local cfg = module("hotkeys_vrp2", "cfg/hotkeys")


-- GLOBAL VARIABLES
handsup = false
crouched = false
pointing = false
engine = true
called = 0

function HotKeys:__construct()
    vRP.Extension.__construct(self)

-- MAIN THREAD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs(cfg.hotkeys) do
		  if IsControlJustPressed(v.group, k) or IsDisabledControlJustPressed(v.group, k) then
		    v.pressed()
		  end

		  if IsControlJustReleased(v.group, k) or IsDisabledControlJustReleased(v.group, k) then
		    v.released()
		  end
		end
	end
end)


-- OTHER THREADS
-- THIS IS FOR KNEEL
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(0,21,true)
        end
    end
end)

-- THIS IS FOR CROUCH
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    if DoesEntityExist(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1)) then 
      DisableControlAction(0,36,true) -- INPUT_DUCK   
    end 
  end
end)

-- THIS IS FOR HANDSUP
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if handsup then
      SetPedStealthMovement(GetPlayerPed(-1),true,"")
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,71,true) -- veh forward
      DisableControlAction(0,72,true) -- veh backwards
      DisableControlAction(0,63,true) -- veh turn left
      DisableControlAction(0,64,true) -- veh turn right
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
    end
  end
end)

-- THIS IS FOR POINTING
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if pointing then
      local camPitch = GetGameplayCamRelativePitch()
      if camPitch < -70.0 then
          camPitch = -70.0
      elseif camPitch > 42.0 then
          camPitch = 42.0
      end
      camPitch = (camPitch + 70.0) / 112.0

      local camHeading = GetGameplayCamRelativeHeading()
      local cosCamHeading = Cos(camHeading)
      local sinCamHeading = Sin(camHeading)
      if camHeading < -180.0 then
          camHeading = -180.0
      elseif camHeading > 180.0 then
          camHeading = 180.0
      end

      camHeading = (camHeading + 180.0) / 360.0

      local blocked = 0
      local nn = 0

      local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
      local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, GetPlayerPed(-1), 7);
      nn,blocked,coords,coords = GetRaycastResult(ray)

      Citizen.InvokeNative(0xD5BB4025AE449A4E, GetPlayerPed(-1), "Pitch", camPitch)
      Citizen.InvokeNative(0xD5BB4025AE449A4E, GetPlayerPed(-1), "Heading", camHeading * -1.0 + 1.0)
      Citizen.InvokeNative(0xB0A6CFD2C69C1088, GetPlayerPed(-1), "isBlocked", blocked)
      Citizen.InvokeNative(0xB0A6CFD2C69C1088, GetPlayerPed(-1), "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    end
  end
end)

-- THIS IS FOR ENGINE-CONTROL
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
    if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
      local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
	  engine = IsVehicleEngineOn(veh)
	end
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) and not engine then
	
	  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	  local damage = GetVehicleBodyHealth(vehicle)
	  SetVehicleEngineOn(vehicle, engine, false, false)
	end
  end
end)

end


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

vRP:registerExtension(HotKeys)
