local HotKeys = class("HotKeys", vRP.Extension)


function HotKeys:__construct()
    vRP.Extension.__construct(self)
end


HotKeys.tunnel = {}

function HotKeys.tunnel:lockPersonal()
local user = vRP.users_by_source[source]
local model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 5)
    if model then
vRP.EXT.Garage.remote._vc_toggleLock(user.source, model)
	end
end



vRP:registerExtension(HotKeys)