local LoadFreeze = class("LoadFreeze", vRP.Extension)


function LoadFreeze:__construct()
  vRP.Extension.__construct(self)
  end

local frozen = true
local unfrozen = false  
  
 Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				Wait(1)
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				frozen = false
			else
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1),false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
		end
		Citizen.Wait(1)
	end
end)

function LoadFreeze:unFreeze(flag)
	unfrozen = flag
end

LoadFreeze.tunnel = {}
LoadFreeze.tunnel.unFreeze = LoadFreeze.unFreeze


vRP:registerExtension(LoadFreeze)