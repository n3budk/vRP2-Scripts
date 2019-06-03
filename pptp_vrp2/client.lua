local PPtp = class("PPtp", vRP.Extension)

--- DO NOT EDIT THIS
local holstered = true
local usageAllowed = false  
  
function PPtp:__construct()
    vRP.Extension.__construct(self)

  self.state_ready = false
	
-- RADIO ANIMATIONS --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait( 1 )
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) then
			if not IsPauseMenuActive() then 
				loadAnimDict( "random@arrests" )
				if IsControlJustReleased( 0, 246 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
				self.remote._ownedVhicleCheck() -- permission check for personal vehicle

				if usageAllowed then
					--TriggerServerEvent('InteractSound_SV:PlayOnSource', 'off', 0.1)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				end
				else
					if IsControlJustPressed( 0, 246 ) and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						self.remote._ownedVhicleCheck() -- permission check for personal vehicle

						if usageAllowed then
						--TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						end
					elseif IsControlJustPressed( 0, 246 ) and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						self.remote._ownedVhicleCheck() -- permission check for personal vehicle

						if usageAllowed then
						--TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)

					end 
					end
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
						DisableActions(ped)
					elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
						DisableActions(ped)

					end
				end
			end 
		end 
	end
end )



-- HOLD WEAPON HOLSTER ANIMATION --

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 1 )
		      if self.state_ready then
		HideHudComponentThisFrame(9) -- Street Name
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then 
			DisableControlAction( 0, 20, true ) -- INPUT_MULTIPLAYER_INFO (Z)
			if not IsPauseMenuActive() then 

				loadAnimDict( "reaction@intimidation@cop@unarmed" )		
				if IsDisabledControlJustReleased( 0, 20 ) then -- INPUT_MULTIPLAYER_INFO (Z)
				self.remote._ownedVhicleCheck() -- permission check for personal vehicle
				if usageAllowed then
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
					end
				else
					if IsDisabledControlJustPressed( 0, 20 ) then -- INPUT_MULTIPLAYER_INFO (Z)
						self.remote._ownedVhicleCheck() -- permission check for personal vehicle

						if usageAllowed then
						SetEnableHandcuffs(ped, true)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true) 
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						end
					end
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
						DisableActions(ped)
						end
					end	
				end
			end 
		end 
	end
end )

-- HOLSTER/UNHOLSTER PISTOL --
 
 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		      if self.state_ready then
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true)  then
			loadAnimDict( "rcmjosh4" )
			loadAnimDict( "weapons@pistol@" )
			if CheckWeapon(ped) then
				if holstered then
				self.remote._ownedVhicleCheck() -- permission check for personal vehicle

				if usageAllowed then
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					holstered = false
					end
				end
				--SetPedComponentVariation(ped, 9, 0, 0, 0)
			elseif not CheckWeapon(ped) then
				if not holstered then
				self.remote._ownedVhicleCheck() -- permission check for personal vehicle
				if usageAllowed then
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)
					holstered = true
					end
				end
				--SetPedComponentVariation(ped, 9, 1, 0, 0)
				end
			end
		end
	end
end)

end




-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
}





function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

function PPtp:blockEnter(blockEnter)
	usageAllowed = not blockEnter
	
end

	
-- TUNNEL
PPtp.tunnel = {}

function PPtp.tunnel:setStateReady(state)
  self.state_ready = state
end

PPtp.tunnel.blockEnter = PPtp.blockEnter

vRP:registerExtension(PPtp)	