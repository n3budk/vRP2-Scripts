local cfg = module("vgear_vrp2", "cfg/vgear")

local vGear = class("vGear", vRP.Extension)



local function menu_vgear(self)


	-- Police Drag
  local function m_loadout(menu)
    local user = menu.user

		self.remote._loadOutWeapons(user.source)

end

    vRP.EXT.GUI:registerMenuBuilder("loadout", function(menu)
      menu:addOption("Gear", m_loadout,"Apply twice to take effect.")
  end)
end  
  
  
function vGear:__construct()
    vRP.Extension.__construct(self)

	
  self.cfg = module("vgear_vrp2", "cfg/vgear")
  menu_vgear(self)	
	

end


-- EVENT
vGear.event = {}

function vGear.event:playerSpawn(user, first_spawn)
    if first_spawn then
        for k, v in pairs(self.cfg.vgear) do
            local gcfg = v._config

            if gcfg then
                local x = gcfg.x
                local y = gcfg.y
                local z = gcfg.z

                local function enter(user)
				if user:hasPermission("police.pc") then
                    menu = user:openMenu("loadout")
				end
			  end	
            local function leave(user)
                user:closeMenu()
            end

        local ment = clone(gcfg.map_entity)
        ment[2].title = "Police Gear"
        ment[2].pos = {x,y,z-1}
        vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
        user:setArea("vRP:cfg.vgear" .. k, x, y, z, 2, 1.5, enter, leave)

    	    end
		end
    end
end

vRP:registerExtension(vGear)
