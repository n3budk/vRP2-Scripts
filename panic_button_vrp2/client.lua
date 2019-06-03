local PanicAlert = class("PanicAlert", vRP.Extension)



function PanicAlert:__construct()
  vRP.Extension.__construct(self)
  
  self.state_ready = false
  self.panic = true
  self.userAllowed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if self.state_ready then

                if (IsDisabledControlPressed(1, 340) and IsDisabledControlJustPressed(1, 167)) then
				       self.remote._alertPermissionCheck()
					   Wait(5)
                        if self.userAllowed then
						if not self.panic then
                        self.remote._noSend()
						else
                            self.panic = false
                            self.remote._sendPanicAlert()

                            SetTimeout(60000, function()
                                self.panic = true
                            end)
                        end
						
                end
            end
        end
    end
end)
		

end

function PanicAlert:blockUserClient(state) 
  self.userAllowed = state
end

-- TUNNEL
PanicAlert.tunnel = {}


function PanicAlert.tunnel:setStateReady(state)
  self.state_ready = state
end

PanicAlert.tunnel.blockUserClient = PanicAlert.blockUserClient


vRP:registerExtension(PanicAlert)
