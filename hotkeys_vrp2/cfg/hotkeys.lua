

cfg = {}

cfg.hotkeys = {

[243] = { 
    -- Lock Toggle ~
    group = 1, 
    pressed = function() 
	vRP.EXT.HotKeys.remote._lockPersonal()
    end,
    released = function()
	  -- Do nothing on release because it's toggle.
    end,
  },

[168] = {
    -- F6 Toggle Kneel Surrender
    group = 1, 
    pressed = function() 
	local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not handcuffed then -- Comment to allow use in vehicle
        local player = GetPlayerPed( -1 )
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
            loadAnimDict( "random@arrests" )
            loadAnimDict( "random@arrests@busted" )
            if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
                TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (3000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
            else
                TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (4000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (500)
                TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (1000)
                TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
            end     
        end
      end -- Comment to allow use in vehicle
    end,
    released = function()
	  -- Do nothing on release because it's toggle.
    end,
  },

  [323] = { --73 includes X on controllers 323 Excludes X on controllers
    -- X toggle HandsUp
    group = 1, 
	pressed = function() 
		local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not handcuffed then -- Comment to allow use in vehicle
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
	
				RequestAnimDict( "random@mugging3" )
	
				while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
					Citizen.Wait( 100 )
				end
	
				if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
					ClearPedSecondaryTask(ped)
				else
					TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
					local prop_name = prop_name
					local secondaryprop_name = secondaryprop_name
					DetachEntity(prop, 1, 1)
					DeleteObject(prop)
					DetachEntity(secondaryprop, 1, 1)
					DeleteObject(secondaryprop)
				end
			end
		end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [29] = {
    -- B toggle Point
    group = 0, 
	pressed = function() 
		local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not handcuffed then  -- Comment to allow use in vehicle
		RequestAnimDict("anim@mp_point")
		while not HasAnimDictLoaded("anim@mp_point") do
          Wait(0)
		end
        pointing = not pointing 
		if pointing then 
		  SetPedCurrentWeaponVisible(GetPlayerPed(-1), 0, 1, 1, 1)
		  SetPedConfigFlag(GetPlayerPed(-1), 36, 1)
		  Citizen.InvokeNative(0x2D537BA194896636, GetPlayerPed(-1), "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
		  RemoveAnimDict("anim@mp_point")
        else
		  Citizen.InvokeNative(0xD01015C7316AE176, GetPlayerPed(-1), "Stop")
		  if not IsPedInjured(GetPlayerPed(-1)) then
		    ClearPedSecondaryTask(GetPlayerPed(-1))
		  end
		  if not IsPedInAnyVehicle(GetPlayerPed(-1), 1) then
		    SetPedCurrentWeaponVisible(GetPlayerPed(-1), 1, 1, 1, 1)
		  end
		  SetPedConfigFlag(GetPlayerPed(-1), 36, 0)
		  ClearPedSecondaryTask(PlayerPedId())
        end 
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [36] = {
    -- CTRL toggle Crouch
    group = 0, 
	pressed = function() 
	  local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not handcuffed then  -- Comment to allow use in vehicle
        RequestAnimSet("move_ped_crouched")
		while not HasAnimSetLoaded("move_ped_crouched") do 
          Citizen.Wait(0)
        end 
        crouched = not crouched 
		if crouched then 
          ResetPedMovementClipset(GetPlayerPed(-1), 0)
        else
          SetPedMovementClipset(GetPlayerPed(-1), "move_ped_crouched", 0.25)
        end 
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [167] = {
    -- F6 toggle Vehicle Engine
    group = 1, 
	pressed = function() 
		local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and IsPedInAnyVehicle(GetPlayerPed(-1), false) and not handcuffed then
		engine = not engine
		SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), engine, false, false)
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [71] = {
    -- W starts Vehicle Engine
    group = 1, 
	pressed = function() 
		local handcuffed = vRP.EXT.Police:isHandcuffed()
      if not IsPauseMenuActive() and IsPedInAnyVehicle(GetPlayerPed(-1), false) and not handcuffed then
		engine = true
		SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), engine, false, false)
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
	},
	
}



return cfg
