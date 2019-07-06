local LoadFreeze = class("LoadFreeze", vRP.Extension)


function LoadFreeze:__construct()
  vRP.Extension.__construct(self)
  end

frozen = true
unfrozen = false  
  
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


function LoadFreeze:Freeze(flag)
	frozen = flag
end

LoadFreeze.tunnel = {}
LoadFreeze.tunnel.Freeze = LoadFreeze.Freeze
LoadFreeze.tunnel.unFreeze = LoadFreeze.unFreeze


vRP:registerExtension(LoadFreeze)
