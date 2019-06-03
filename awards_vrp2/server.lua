

local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local cfg = module("awards_vrp2", "cfg/paycheck")

local paycheck = class("paycheck", vRP.Extension)


function paycheck:__construct()
  vRP.Extension.__construct(self)

  -- task: mission
  local function paycheck_giver()
    SetTimeout(1000*60*cfg.minutes_paycheck,paycheck_giver)
    self:paycheck_giver()
  end
  async(function()
    paycheck_giver()
  end)
  
  
  -- task: mission
  local function paycheck_prize()
    SetTimeout(1000*60*cfg.minutes_prize,paycheck_prize)
    self:paycheck_prize()
  end
  async(function()
    paycheck_prize()
  end)  

  -- task: mission
  local function aptitude_police()
    SetTimeout(1000*60*cfg.minutes_police,aptitude_police)
    self:aptitude_police()
  end
  async(function()
    aptitude_police()
  end)    


  -- task: mission
  local function aptitude_ems()
    SetTimeout(1000*60*cfg.minutes_ems,aptitude_ems)
    self:aptitude_ems()
  end
  async(function()
    aptitude_ems()
  end)  

  
end


function paycheck:aptitude_police(user)
  for k,v in pairs(cfg.police) do
    local users = vRP.EXT.Group:getUsersByPermission(k)
    for _,user in pairs(users) do
	  local paycheck = math.random(750,1500)
	  if user:hasPermission("police.key") then
		vRP.EXT.Base.remote._notifyPicture(user.source,"CHAR_FILMNOIR", 9, "AllCity Police", false, "Received XP and Paycheck: $"..paycheck)
		user:varyExp("emergency", "police", 1.0)
		user:giveBank(paycheck)
		
	  end
	end
  end
end

function paycheck:aptitude_ems(user)
  for k,v in pairs(cfg.ems) do
    local users = vRP.EXT.Group:getUsersByPermission(k)
    for _,user in pairs(users) do
	  local paycheck = math.random(900,1600)
	  if user:hasPermission("ems.whitelisted") then
		vRP.EXT.Base.remote._notifyPicture(user.source,"CHAR_FILMNOIR", 9, "AllCity EMS", false, "Received XP and Paycheck: $"..paycheck)
		user:varyExp("emergency", "paramedic", 1.0)
		user:giveBank(paycheck)
		
		end
	end
  end
end

function paycheck:paycheck_giver(user)
  for k,v in pairs(cfg.paycheck) do
    local users = vRP.EXT.Group:getUsersByPermission(k)
    for _,user in pairs(users) do
	local paycheck = math.random(200,1000)

	  if user:hasPermission("citizen.paycheck") then
		user:giveBank(paycheck)	
		vRP.EXT.Base.remote._notifyPicture(user.source,cfg.paycheck_picture, 9, cfg.paycheck_title_picture, false, cfg.message_paycheck..paycheck)
		end
	end
  end
end

function paycheck:paycheck_prize(user)
  for k,v in pairs(cfg.prize) do
    local users = vRP.EXT.Group:getUsersByPermission(k)
    for _,user in pairs(users) do
	  
	  local st = "strength.t"
	  local ammo = "wammo|WEAPON_COMBATPISTOL|50"
	  local ammo2 = "wammo|WEAPON_PISTOL|50"
	  local ammo3 = "wammo|WEAPON_PUMPSHOTGUN|50"
	  local drink = "edible|redgull"
	  local taco = "edible|tacos"


	  if user:hasPermission("citizen.paycheck") then
	  vRP.EXT.Base.remote._notifyPicture(user.source,cfg.bill_picture, 9, cfg.bill_title_picture, false, "Registered Citizen Item Bonus")
	  user:tryGiveItem(st,math.random(-15,20))
	  user:tryGiveItem(ammo,math.random(-30,2))
	  user:tryGiveItem(ammo2,math.random(-30,3))
	  user:tryGiveItem(ammo3,math.random(-30,1))
	  user:tryGiveItem(drink,math.random(1,1))
	  user:tryGiveItem(taco,math.random(1,1))
	  user:tryGiveItem("gem",math.random(-50,1))

	  end
	end
  end
end


vRP:registerExtension(paycheck)