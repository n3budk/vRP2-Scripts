local vGear = class("vGear", vRP.Extension)



-- https://wiki.fivem.net/wiki/Weapons
-- {weaponHash, amountOfAmmoToGive} Too much ammo might crash the game, be careful!
local spawnLoadoutList = {  

    {0x8BB05FD7, 1},    -- Flashlight
    {0x678B81B1, 1},    -- Nightstick
    {0x3656C8C1, 1},    -- Stun Gun
    {0xBFE256D4, 200},  -- Pistol MK2
	{0x555AF99A, 200}, -- pimp shotgun MK2

}

-- https://wiki.fivem.net/wiki/Weapon_Components
-- {weaponHashToApplyComponentTo, weaponComponentHash} Any extras/components that need to be attached to certain weapons? Enter them below
local spawnLoadoutExtrasList = {   
    {0xBFE256D4, 0x43FD595B},   -- Combat Pistol Flashlight
    {0xBFE256D4, 0x4F37DF2A},   -- Combat Pistol Fullk metal Jacket
    {0xBFE256D4, 0xE4E00B70},   -- Combat Pistol Cammo
    {0xBFE256D4, 0x21E34793},   -- Combat Pistol Compasator	
    {0xBFE256D4, 0x8ED4BB70},   -- Combat Pistol Scope
	
	
	
	
	
	
	
	
    {0x555AF99A, 0x7BC4CDDC},   -- pimp shotgun MK2 Flashlight
    {0x555AF99A, 0x4E65B425},   -- pimp shotgun MK2 Buck Shots
    {0x555AF99A, 0xE3BD9E44},   -- pimp shotgun MK2 Cammo	
    {0x555AF99A, 0x5F7DCE4D},   -- pimp shotgun MK2 Muzzle
    {0x555AF99A, 0x3F3C8181},   -- pimp shotgun MK2 Muzzle	
	
		
	

}



function vGear:loadOutWeapons()
    local ped = GetPlayerPed(-1)
    for k, w in pairs(spawnLoadoutList) do
        GiveWeaponToPed(GetPlayerPed(-1), w[1], w[2], false, false)
    end
    for k, c in pairs(spawnLoadoutExtrasList) do
        GiveWeaponComponentToPed(ped, c[1], c[2])
    end
    TriggerEvent('chatMessage', '', {255,255,255}, "Weapons Equipped")
end


----------------------------------------------------------------------------
function vGear:__construct()
    vRP.Extension.__construct(self)

end

vGear.tunnel = {}
vGear.tunnel.loadOutWeapons = vGear.loadOutWeapons


vRP:registerExtension(vGear)

