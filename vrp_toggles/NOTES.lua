***Replace this function in vrp/client/garage.lua***



-- return true if locked, false if unlocked
function Garage:vc_toggleLock(model)
  local vehicle = self.vehicles[model]
  if vehicle then
    local veh = vehicle
    local locked = GetVehicleDoorLockStatus(veh) >= 2
    if locked then -- unlock
      SetVehicleDoorsLockedForAllPlayers(veh, false)
      SetVehicleDoorsLocked(veh,1)
      SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
	  vRP.EXT.Base:notify("~g~unlocked.") --Notify
      return false
    else -- lock
      SetVehicleDoorsLocked(veh,2)
      SetVehicleDoorsLockedForAllPlayers(veh, true)
	  vRP.EXT.Base:notify("~r~locked.") --Notify
      return true
    end
  end
end


