

AddEventHandler("chatMessage", function(source, name, message)
    if message:sub(1, 1) == "/" then
        fullcmd = stringSplit(message, " ")
        cmd = fullcmd[1]
		local msg = fullcmd[2]
		for k,v in ipairs(fullcmd) do
			if k > 2 then
				msg = msg .. " " .. fullcmd[k]
			end
		end

	local user = vRP.users_by_source[source]
	    local identity = vRP.EXT.Identity:getIdentity(user.cid)
		local civ = "[Citizen]"
		local staff = "[Staff]"
		local admin = "[Admin]"
		local ems = "[Medic]"	
		local pol = "[Police]"		
		local none = ""		
        if cmd == "/me" then
			TriggerClientEvent("sendProximityMessageMe", -1, source, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
		
        if cmd == "/do" then
			TriggerClientEvent("sendProximityMessageDo", -1, source, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
		
        if cmd == "/tweet" and not user:hasPermission("civ.chattitle") and not user:hasPermission("staff.chattitle") and not user:hasPermission("admin.chattitle") then
			TriggerClientEvent("sendGlobalMessage", -1, source, none, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/tweet" and user:hasPermission("civ.chattitle") then
			TriggerClientEvent("sendGlobalMessage", -1, source, civ, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end	
        if cmd == "/tweet" and user:hasPermission("staff.chattitle") then
			TriggerClientEvent("sendGlobalMessage", -1, source, staff, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/tweet" and user:hasPermission("admin.chattitle") then
			TriggerClientEvent("sendGlobalMessage", -1, source, admin, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/ooc" and not user:hasPermission("civ.chattitle") and not user:hasPermission("staff.chattitle") and not user:hasPermission("admin.chattitle") then
			TriggerClientEvent("sendOOCMessage", -1, source, none, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/ooc" and user:hasPermission("civ.chattitle") then
			TriggerClientEvent("sendOOCMessage", -1, source, civ, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end	
        if cmd == "/ooc" and user:hasPermission("staff.chattitle") then
			TriggerClientEvent("sendOOCMessage", -1, source, staff, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/ooc" and user:hasPermission("admin.chattitle") then
			TriggerClientEvent("sendOOCMessage", -1, source, admin, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end			
		if cmd == "/pol" and user:hasPermission("pol.chattitle") then
			TriggerClientEvent("sendGlobalPOL", -1, source, pol, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end
        if cmd == "/warn" and user:hasPermission("war.chattitle") then
			TriggerClientEvent("sendGlobalWAR", -1, source, staff, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
        end	
        if cmd == "/anon" then
			TriggerClientEvent("anonTweet", -1, source, civ, user.id, identity.firstname, identity.name,tostring(msg))
        	CancelEvent()
	end	

	else


		local user = vRP.users_by_source[source]
		local identity = vRP.EXT.Identity:getIdentity(user.cid)
		local civ = "[Citizen]"
		local staff = "[Staff]"
		local admin = "[Admin]"
		local none = ""
		if not user:hasPermission("civ.chattitle") and not user:hasPermission("staff.chattitle") and not user:hasPermission("admin.chattitle") then
		TriggerClientEvent("sendProximityMessage", -1, source, none, user.id, identity.firstname, identity.name, message)
        CancelEvent()
		else
		if user:hasPermission("civ.chattitle") then
		TriggerClientEvent("sendProximityMessage", -1, source, civ, user.id, identity.firstname, identity.name, message)
        CancelEvent()
		end
		if user:hasPermission("staff.chattitle") then
		TriggerClientEvent("sendProximityMessage", -1, source, staff, user.id, identity.firstname, identity.name, message)
        CancelEvent()
		end		
		if user:hasPermission("admin.chattitle") then
		TriggerClientEvent("sendProximityMessage", -1, source, admin, user.id, identity.firstname, identity.name, message)
        CancelEvent()			
		   end
		end
	end
end)


function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


RegisterServerEvent('localchatps')
AddEventHandler('localchatps', function()
	local player = source
	local r = math.random(10,249)
	local g = math.random(10,249) 
	local b = math.random(10,249)
	TriggerClientEvent("setPlayerColor", player, r, g, b)
end)


