local HotKeys = class("HotKeys", vRP.Extension)


function HotKeys:__construct()
    vRP.Extension.__construct(self)
end


--Coming soon LOL

-- TUNNEL
HotKeys.tunnel = {}

function HotKeys.tunnel:docsOnline()
  local docs = vRP.EXT.Group:getUsersByPermission("emergency.revive")
  return #docs
end

function HotKeys.tunnel:helpComa(x,y,z)
  vRP.EXT.Phone:sendServiceAlert("emergency",x,y,z,"Help! I've fallen and can't get up!")
end


function HotKeys.tunnel:isComa()
local user = vRP.users_by_source[source]
local dead = vRP.EXT.Survival.remote._isInComa(user.source)
if dead then
return true 
else 
return false
	end
end


vRP:registerExtension(HotKeys)