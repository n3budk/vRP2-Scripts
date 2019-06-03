--[[-----------------
 	Doors Control By XanderWP from Ukraine with <3
 ------------------------]]--

local cfg = module("vrp_doors", "config")

local Doors = class("Doors", vRP.Extension)

Citizen.CreateThread(function()
  Citizen.Wait(500)
  TriggerClientEvent('vrpdoorsystem:load', -1, cfg.list)
end)


RegisterServerEvent('vrpdoorsystem:open')
AddEventHandler('vrpdoorsystem:open', function(id)
  local user = vRP.users_by_source[source]
  if user:hasPermission("!item."..cfg.list[id].key..".>0") or user:hasPermission(cfg.list[id].permission) then

    	SetTimeout(500, function()
      cfg.list[id].locked = not cfg.list[id].locked
      TriggerClientEvent('vrpdoorsystem:statusSend', (-1), id,cfg.list[id].locked)
      if cfg.list[id].pair ~= nil then
        local idsecond = cfg.list[id].pair
        cfg.list[idsecond].locked = cfg.list[id].locked
        TriggerClientEvent('vrpdoorsystem:statusSend', (-1), idsecond,cfg.list[id].locked)
      end
      if cfg.list[id].locked then
        vRP.EXT.Base.remote.notify(user.source, "Door Locked with " ..cfg.list[id].name.. " key.")
      else
        vRP.EXT.Base.remote.notify(user.source, "Door Unlocked with " ..cfg.list[id].name.. " key.")
      end
    end)
else
	vRP.EXT.Base.remote.notify(user.source, "Oops, You need the " ..cfg.list[id].name.. " key to lock/unlock the door")
  end
end)

Doors.event = {}


function Doors.event:playerSpawn(user, first_spawn)
  if first_spawn then
    TriggerClientEvent('vrpdoorsystem:load', user.source, cfg.list)
  end
end

vRP:registerExtension(Doors)
