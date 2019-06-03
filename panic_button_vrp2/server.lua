

local PanicAlert = class("PanicAlert", vRP.Extension)



function PanicAlert:__construct()
  vRP.Extension.__construct(self)


  
end


function PanicAlert:sendAlert(x,y,z, name, id)
    local targets = {}

    for _, user in pairs(vRP.users) do
        if user:isReady() and user:hasPermission("panic.alert") then
            table.insert(targets, user)
        end
    end


    for _, user in pairs(targets) do
		local panic = "https://www.myinstants.com/media/sounds/panic-button.mp3"
		
			vRP.EXT.Audio.remote._playAudioSource(-1, panic, 0.2,0,0,0,30, user.source)
			Wait(2500)
			local panic2 = "https://d1490khl9dq1ow.cloudfront.net/sfx/mp3preview/police-dispatch-radio-voice-clip-middle-age-female-officer-in-need-of-assis_GJFXxvEd.mp3"
            vRP.EXT.Audio.remote._playAudioSource(-1, panic2, 1,0,0,0,30, user.source)
            if user:request("Unit #"..id.." | " ..name.. "'s panic button was activated. Set GPS?", 30) then
            vRP.EXT.Map.remote._setGPS(user.source, x, y)
            vRP.EXT.Base.remote._notify(user.source, "~g~GPS set to Unit #"..id.." panic location.")

        end
    end
end


PanicAlert.event = {}

function PanicAlert.event:playerStateLoaded(user)
  self.remote._setStateReady(user.source, true) --only allow to activate when user state is ready
end

-- TUNNEL
PanicAlert.tunnel = {}

function PanicAlert.tunnel:alertPermissionCheck() --client permission tunnel
  local user = vRP.users_by_source[source]

  if user:hasPermission("police.market") then
  self.remote._blockUserClient(user.source, true)
  else
    self.remote._blockUserClient(user.source, false)
	end
end

function PanicAlert.tunnel:sendPanicAlert()
local user = vRP.users_by_source[source]
local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
local identity = vRP.EXT.Identity:getIdentity(user.cid)
local name = identity.name
local id = user.id
  if user:hasPermission("police.market") then
vRP.EXT.Base.remote._notify(user.source, "~b~Panic button triggered. All available units were notified.")
self:sendAlert(x,y,z, name, id)
  end
end

function PanicAlert.tunnel:noSend()
local user = vRP.users_by_source[source]
vRP.EXT.Base.remote._notify(user.source, "~r~Your panic button was already activated.")
end
  

vRP:registerExtension(PanicAlert)


