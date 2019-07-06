local PanicAlert = class("PanicAlert", vRP.Extension)



function PanicAlert:__construct()
  vRP.Extension.__construct(self)
  
  self.state_ready = false
  self.panic = false
  self.userAllowed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if self.state_ready then
                if (IsDisabledControlPressed(1, 36) and IsDisabledControlJustPressed(1, 167)) then
                        if self.userAllowed then
						if not self.panic then
                            self.panic = true
                            self.remote._sendPanicAlert()
                            SetTimeout(300000, function()
                            self.panic = false
                            end)
							else 
							vRP.EXT.Base:notify("~r~You already activated your panic button recently")
                    end	
                end
            end
        end
    end
end)
		

end


-- TUNNEL
PanicAlert.tunnel = {}

function PanicAlert.tunnel:checkPermission(state) 
  self.userAllowed = state
end

function PanicAlert.tunnel:setStateReady(state)
  self.state_ready = state
end


vRP:registerExtension(PanicAlert)
