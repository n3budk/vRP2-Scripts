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

timeLeft = 60
timer = true

function vGear:__construct()
    vRP.Extension.__construct(self)
	
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if not timer then
            timeLeft = timeLeft - 1

            if timeLeft < 1 then
                timeLeft = 60
                timer = true
            end
        end
    end
end)	
	
end



function vGear:loadOutWeapons()
	if timer then
	timer = false
	local ped = GetPlayerPed(-1)
    for k, w in pairs(spawnLoadoutList) do
        GiveWeaponToPed(ped, w[1], w[2], false, false)
    end		
    for k, c in pairs(spawnLoadoutExtrasList) do
        GiveWeaponComponentToPed(GetPlayerPed(-1), c[1], c[2])
    end
    for k, w in pairs(spawnLoadoutList) do
		local ped = GetPlayerPed(-1)
        GiveWeaponToPed(ped, w[1], w[2], false, false)
        ClearPedBloodDamage(ped)
        SetPedArmour(ped, 100)
        SetEntityHealth(ped, 200)
		vRP.EXT.Base:notify("Gear Applied")
    end	
	else 
		vRP.EXT.Base:notify("Gear was applied recently")
	end
end

vGear.tunnel = {}

vGear.tunnel.loadOutWeapons = vGear.loadOutWeapons


vRP:registerExtension(vGear)

