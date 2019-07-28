

local PPtp = class("PPtp", vRP.Extension)

  
  
function PPtp:__construct()
    vRP.Extension.__construct(self)
end

PPtp.event = {}
	

function PPtp.event:playerStateLoaded(user)
if user and user:isReady() then
self.remote._setStateReady(user.source, true) --only allow to activate when user state is ready
    if user:hasPermission("police.market") then
        self.remote._checkPermission(user.source, true)
    else
        self.remote._checkPermission(user.source, false)
		end
    end
end

function PPtp.event:playerJoinGroup(user)
    if user:hasPermission("police.market") then
        self.remote._checkPermission(user.source, true)
    else
        self.remote._checkPermission(user.source, false)
    end
end



vRP:registerExtension(PPtp)	
