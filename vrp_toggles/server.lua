


RegisterServerEvent('LockToggle:Lock')
AddEventHandler('LockToggle:Lock', function()
local user = vRP.users_by_source[source]
local model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 5)
    if model then
vRP.EXT.Garage.remote._vc_toggleLock(user.source, model)
end
end)

