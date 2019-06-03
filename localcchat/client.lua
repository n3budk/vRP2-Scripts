
local playerColor = {255,255,255}

RegisterNetEvent('sendGlobalMessage')
AddEventHandler('sendGlobalMessage', function(id, tag, vid, name, lname,  message)
	TriggerEvent('chatMessage', "[Tweet] @"..name..""..lname.." "..tag.."(#"..vid..")^7", {29, 161, 242}, message)
end)


RegisterNetEvent('sendOOCMessage')
AddEventHandler('sendOOCMessage', function(id, tag, vid, name, lname,  message)
	TriggerEvent('chatMessage', "[OOC] "..name..", "..lname.." "..tag.."(#"..vid..")^7", {222, 226, 83}, message)
end)

RegisterNetEvent('anonTweet')
AddEventHandler('anonTweet', function(id, tag, vid, name, lname,  message)
		TriggerEvent('chatMessage', "[Tweet] @Anonymous", {29, 161, 242}, message)
end)

RegisterNetEvent('sendGlobalEMS')
AddEventHandler('sendGlobalEMS', function(id, tag, vid, name, lname,  message)
	TriggerEvent('chatMessage', "[EMS] "..name..", "..lname.." "..tag.."(#"..vid..")^7", {36, 163, 32}, message)
end)

RegisterNetEvent('sendGlobalPOL')
AddEventHandler('sendGlobalPOL', function(id, tag, vid, name, lname,  message)
	TriggerEvent('chatMessage', "[Police] "..name..", "..lname.." "..tag.."(#"..vid..")^7", {66, 89, 244}, message)
end)


RegisterNetEvent('sendGlobalWAR')
AddEventHandler('sendGlobalWAR', function(id, tag, vid, name, lname,  message)
	TriggerEvent('chatMessage', "[WARNING] - "..tag, {255, 0, 0}, message)
end)


RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, tag, vid, name, lname,  message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', name..", "..lname.." "..tag.."(#"..vid..")^7", playerColor, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', name..", "..lname.." "..tag.."(#"..vid..")^7", playerColor, message)
	end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, vid, name, lname,  message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6" .. name..", "..lname.." (#"..vid..")".."  ".."  " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6" .. name..", "..lname.." (#"..vid..")".."  ".."  " .. message)
	end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, vid, name, lname,  message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^4" .. name..", "..lname.." (#"..vid..")".."  ".."  " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^4" .. name..", "..lname.." (#"..vid..")".."  ".."  " .. message)
	end
end)


