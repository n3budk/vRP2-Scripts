local LoadFreeze = class("LoadFreeze", vRP.Extension)



function LoadFreeze:__construct()
  vRP.Extension.__construct(self)
  end

  

LoadFreeze.event = {}




function LoadFreeze.event:playerStateLoaded(user)
if user and user:isReady() then
	self.remote._unFreeze(user.source, true)	
		end
end

	


vRP:registerExtension(LoadFreeze)
