

local LoadFreeze = class("LoadFreeze", vRP.Extension)



function LoadFreeze:__construct()
  vRP.Extension.__construct(self)
  end

  

LoadFreeze.event = {}

function LoadFreeze.event:playerSpawn(user, first_spawn)
if first_spawn then
	SetTimeout(5000,function() 		
	local unfrozen = true
		self.remote._unFreeze(user.source, unfrozen)		
	    end)
	end
end
	


vRP:registerExtension(LoadFreeze)