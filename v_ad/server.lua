	

players = {}
host = nil
local adverts = {
"Personal vehicles are persistent and spawn with you, do not take more vehicles out than needed.",
"If you die, call ems in the menu m/phone/services/Paramedic.",


}

local nextadvert = 1

RegisterServerEvent("Z:newplayer")
AddEventHandler("Z:newplayer", function()
    players[source] = true

    if not host then
        host = source
        TriggerClientEvent("Z:adverthost", source)
    end
end)

AddEventHandler("playerDropped", function(reason)
    players[source] = nil

    if source == host then
        if #players > 0 then
            for mSource, _ in pairs(players) do
                host = mSource
                TriggerClientEvent("Z:adverthost", source)
                break
            end
        else
            host = nil
        end
    end
end)

RegisterServerEvent("Z:timeleftsync")
AddEventHandler("Z:timeleftsync", function(nTimeLeft)
	timeLeft = nTimeLeft
    if timeLeft < 1 then
	   
      vRP.EXT.Base.remote._notifyPicture(-1, "CHAR_FACEBOOK", 1, "Information", "AllCity Roleplay", "" ..adverts[nextadvert])
	  nextadvert = nextadvert + 1
	  
	  if nextadvert == 2 then
		nextadvert = 1
	  end
    end
end)
