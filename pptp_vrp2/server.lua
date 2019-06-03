

local PPtp = class("PPtp", vRP.Extension)

  
  
function PPtp:__construct()
    vRP.Extension.__construct(self)


end

PPtp.event = {}

function PPtp.event:playerStateLoaded(user)
 
  self.remote._setStateReady(user.source, true)
end
	
-- TUNNEL
PPtp.tunnel = {}

function PPtp.tunnel:ownedVhicleCheck()
  local blockEnter = false
  local user = vRP.users_by_source[source]

  if user:hasPermission("police.pc") then
  self.remote._blockEnter(user.source,blockEnter)
  else
    local blockEnter = true
		self.remote._blockEnter(user.source,blockEnter)
	end

end

vRP:registerExtension(PPtp)	
