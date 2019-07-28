Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
local cvRP = module("vrp", "client/vRP")
vRP = cvRP()

local LsCustoms = class("LsCustoms", vRP.Extension)
  
local cfg = module("lscustoms_vrp2", "cfg/lscustoms")


local veh = nil
local xenon = nil
local wheels = nil
local dash = false
local bpTyres = nil
local inter = false
local inUse = false
local curMenu = nil
local wheelsB = nil
local wColour = nil
local pColour = nil
local sColour = nil
local psColour = nil
local vehPrice = nil
local totalPrice = 0
local tyreSmoke = nil
local garageNumber = 0
local customTyres = nil
local blockExit = false
local customTyresB = nil
local enterAllowed = true
local menuIsHidden = false
local disablemenu = false
local confirmExit = false

local extras = {
	set = {1,1,1,1,1,1,1,1,1},
	cart = {1,1,1,1,1,1,1,1,1}
}
local wheelType = {set = -1, cart = -1}
local customColourP = {
	set = 	{use = false, RGB = {0,0,0}},
	cart = 	{use = false, RGB = {0,0,0}}
}
local customColourS = {
	set = 	{use = false, RGB = {0,0,0}},
	cart = 	{use = false, RGB = {0,0,0}}
}
local neon = {
	set = 	{left = false, right = false, front = false, back = false},
	cart = 	{left = false, right = false, front = false, back = false}
}

local fuel = 0

function LsCustoms:__construct()
    vRP.Extension.__construct(self)

Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(12)
		local ped = GetPlayerPed(-1)
		if inUse == false then
			if IsPedSittingInAnyVehicle(ped) then
				veh = GetVehiclePedIsUsing(ped)
				if DoesEntityExist(veh) and GetPedInVehicleSeat(veh, -1) == ped and not (IsThisModelAHeli(veh) or IsThisModelAPlane(veh)) then
					for i=0,#shops do
						local sh = shops[i]
						if GetDistanceBetweenCoords(sh.coords.x,sh.coords.y,sh.coords.z, GetEntityCoords(ped)) <= 8 then
							if IsControlJustPressed(1,201) then
								self.remote._ownedVhicleCheck() -- permission check for personal vehicle
								vehPrice = defaultVehPrice
								
								Citizen.Wait(5)
								if enterAllowed then
								vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
								fuel = GetVehicleFuelLevel(vehicle)
								self.remote._fuelAmount(fuel)
								self.remote.lockCar()
								self.remote._killVState() --disable vehicle state, if not people can wait 1 min then exit to apply mods
								self.remote._fuelUp()
								garageNumber = i
								buildMenu(sh.title)
								end
							else
								self.remote._fuelUp()
								SetTextCentre(1)
								SetTextDropShadow()
								SetTextEntry("STRING")
								SetTextProportional(0)
								SetTextScale(1.0, 0.7)
								SetTextColour(255,255,255,200)
								AddTextComponentString(inviteText..""..sh.title)
								DrawText(0.5, 0.85)
							end
						end
					end
				end
			end
		else
			if GetDistanceBetweenCoords(shops[garageNumber].coords.x,shops[garageNumber].coords.y,shops[garageNumber].coords.z, GetEntityCoords(ped)) < 10 then
				if IsControlJustPressed(1, controls.up) then
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if not confirmExit then
						SendNUIMessage({command = "prevACItem"})
					end
				end
				if IsControlJustPressed(1, controls.down) then
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if not confirmExit then
						SendNUIMessage({command = "nextACItem"})
					end
				end
				if IsControlJustPressed(1, controls.sel) then		
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if disablemenu then
						SendNUIMessage({command = "closeACMenu"})
					else
						SendNUIMessage({command = "selectACItem"})
						self.remote._fuelUp()
					end
				end
				if IsControlJustPressed(1, controls.back) then
					PlaySound(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					if curMenu == 0 then
					else
						SendNUIMessage({command = "goBackAC"})
					end
				end
			else
				_exit(false)
			end
		end
	end
end)



RegisterNUICallback("install", function()
	enterAllowed = false
	disablemenu = true
	SendNUIMessage({command = "closeACMenu"})
	self.remote.payGarage(totalPrice)
end)


RegisterNUICallback("repair", function()
self.remote.checkClean()
end)




function LsCustoms:installMods()
self.remote._fuelUp()
	self:installModsclient()
	local licencePlate = GetVehicleNumberPlateText(veh)
	local nl = {"off","off","off","off"}
	local tsc = {255,255,255}
	local inColour = 0
	local nc = {0,0,0}
	local dColour = 0
	local cCP = "off"
	local cCS = "off"
	local bpt = "off"
	local ctb = "off"
	local ct = "off"
	local mods = {}
	for i = 1,#menuInfo do
		if menuInfo[i].modID ~= nil and menuInfo[i].modID ~= 23 and menuInfo[i].modID ~= 24 then
			mods[menuInfo[i].modID] = menuInfo[i].set
		elseif menuInfo[i]._type == "tsc" then
			tsc = menuInfo[i].set
		elseif menuInfo[i]._type == "incol" then
			inColour = menuInfo[i].set
		elseif menuInfo[i]._type == "dcol" then
			dColour = menuInfo[i].set
		elseif menuInfo[i]._type == "nc" then
			nc = menuInfo[i].set
		end
	end

	if neon.set.left then nl[1] = "on" end
	if neon.set.back then nl[4] = "on" end
	if neon.set.right then nl[2] = "on" end
	if neon.set.front then nl[3] = "on" end
	if customColourP.set.use then cCP = "on" end
	if customColourS.set.use then cCS = "on" end
	if menuInfo[bpTyres].set then bpt = "on" end
	if menuInfo[customTyres].set then ct = "on" end
	if menuInfo[customTyresB].set then ctb = "on" end
	if mods[18] then mods[18] = "on" else mods[18] = "off" end
	if mods[20] then mods[20] = "on" else mods[20] = "off" end
	if mods[22] then mods[22] = "on" else mods[22] = "off" end

	mods[23] = menuInfo[wheels].set
	mods[24] = menuInfo[wheelsB].set
end


end


function LsCustoms:closeAC()
SendNUIMessage({command = "closeAC"})
inUse = false
end

function LsCustoms:goBack()
inUse = false
enterAllowed = true
disablemenu = false
SendNUIMessage({command = "goBackAC"})
end

function LsCustoms:revertMods()
_exit(false)
inUse = false
disablemenu = false

end

function buildMenu(title)
	inUse = true
	SendNUIMessage({command = "openACMenu"})
	SendNUIMessage({command = "createACMenu", name = mainMenuText})
	local isBike = IsThisModelABike(GetEntityModel(veh)) or string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))) == "chimera"
	
	curMenu = 0

	neon.set.left = IsVehicleNeonLightEnabled(veh, 0)
	neon.set.back = IsVehicleNeonLightEnabled(veh, 3)
	neon.set.right = IsVehicleNeonLightEnabled(veh, 1)
	neon.set.front = IsVehicleNeonLightEnabled(veh, 2)
	neon.cart.left = neon.set.left
	neon.cart.back = neon.set.back
	neon.cart.right = neon.set.right
	neon.cart.front = neon.set.front

	customColourP.set.use = GetIsVehiclePrimaryColourCustom(veh)
	customColourS.set.use = GetIsVehicleSecondaryColourCustom(veh)
	customColourP.set.RGB = table.pack(GetVehicleCustomPrimaryColour(veh))
	customColourS.set.RGB = table.pack(GetVehicleCustomSecondaryColour(veh))
	customColourP.cart.use = customColourP.set.use
	customColourS.cart.use = customColourS.set.use
	customColourP.cart.RGB = customColourP.set.RGB
	customColourS.cart.RGB = customColourS.set.RGB

	SetVehicleModKit(veh, 0)
	for i = 1,#menuInfo do
		local iType = menuInfo[i]._type
		if (iType == "wtype") then
			wheels = i
			wheelType.set = GetVehicleWheelType(veh)
			wheelType.cart = wheelType.set
		elseif (iType == "wheel" or iType == "bwheel") and menuInfo[i].modID == 23 and wheelType.set == i - wheels - 1 then
			menuInfo[wheels].set = GetVehicleMod(veh, menuInfo[i].modID)
			menuInfo[wheels].cart = menuInfo[wheels].set
		elseif iType == "dcol" then
			menuInfo[i].set = GetVehicleDashboardColour(veh)
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "incol" then
			menuInfo[i].set = GetVehicleInteriorColour(veh)
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "ct" then
			menuInfo[i].set = not not GetVehicleModVariation(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
			customTyres = i
		elseif iType == "ctb" then
			menuInfo[i].set = not not GetVehicleModVariation(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
			customTyresB = i
		elseif iType == "bt" then
			menuInfo[i].set = not GetVehicleTyresCanBurst(veh)
			menuInfo[i].cart = menuInfo[i].set
			bpTyres = i
		elseif iType == "n" then
			menuInfo[i].set = neon.set.left or neon.set.right or neon.set.front or neon.set.back
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "nc" then
			menuInfo[i].set = table.pack(GetVehicleNeonLightsColour(veh))
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "tsc" then
			menuInfo[i].set = table.pack(GetVehicleTyreSmokeColor(veh))
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "wtint" then
			menuInfo[i].set = GetVehicleWindowTint(veh)
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "lp" then
			menuInfo[i].set = GetVehicleNumberPlateTextIndex(veh)
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "xl" then
			menuInfo[i].set = not not IsToggleModOn(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
			xenon = i
		elseif iType == "ts" then
			menuInfo[i].set = not not IsToggleModOn(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
			tyreSmoke = i
		elseif iType == "turbo" then
			menuInfo[i].set = not not IsToggleModOn(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
		elseif iType == "wheel" and menuInfo[i].modID == 24 then
			wheelsB = i
		elseif iType == "pcol" then
			pColour = i
		elseif iType == "scol" then
			sColour = i
		elseif iType == "pscol" then
			psColour = i
		elseif iType == "wcol" then
			wColour = i
		end
	end
	
	local bodyCol = table.pack(GetVehicleColours(veh))
	local extraCol = table.pack(GetVehicleExtraColours(veh))
	menuInfo[pColour].set = bodyCol[1]
	menuInfo[sColour].set = bodyCol[2]
	menuInfo[pColour].cart = bodyCol[1]
	menuInfo[sColour].cart = bodyCol[2]
	menuInfo[wColour].set = extraCol[2]
	menuInfo[wColour].cart = extraCol[2]
	menuInfo[psColour].set = extraCol[1]
	menuInfo[psColour].cart = extraCol[1]

	for i = 1,#menuInfo do
		local fName
		local iType = menuInfo[i]._type
		if isBike then
			fName = menuInfo[i].nameBike
		else
			fName = menuInfo[i].nameCar
		end
		SendNUIMessage({command = "createACMenu", name = fName, parent = menuInfo[i].parent})
		if menuInfo[i].parent > 0 then menuInfo[menuInfo[i].parent].children = menuInfo[menuInfo[i].parent].children + 1 end
		SendNUIMessage({command = "addACItem", params = {par = menuInfo[i].parent, act = i, lText = fName, _class = "folder", rText = "", cat = "folder", prev = false}})
		if (iType == "wheel" or iType == "bwheel") then
			if menuInfo[i].modID == 24 then
				SetVehicleWheelType(veh, 6)
			elseif not isBike then
				SetVehicleWheelType(veh, i - wheels - 1)
			end
		end

		local children = 0
		if iType == "get" or iType == "unlstd" or (iType == "wheel" or iType == "bwheel") and (wheelType.set == i - wheels - 1 or menuInfo[i].modID == 24) then
			menuInfo[i].set = GetVehicleMod(veh, menuInfo[i].modID)
			menuInfo[i].cart = menuInfo[i].set
		end

		local count = GetNumVehicleMods(veh, menuInfo[i].modID)
		if iType == "get" or (iType == "wheel" or iType == "bwheel") then
			if count ~= nil and count > 0 and count ~= false then
				count = count - 1
				if menuInfo[i].modID == 29 or menuInfo[i].modID == 30 then dash = true end
				if menuInfo[i].modID == 31 or menuInfo[i].modID == 32 then inter = true end
				local extra = getExtra(i, -1, menuInfo[i].set == -1)
				SendNUIMessage({command = "addACItem", params = {par = i, act = -1, lText = stockText, _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
				for j = 0,count do
					local label = GetModTextLabel(veh, menuInfo[i].modID, j)
					extra = getExtra(i, j, menuInfo[i].set == j)
					if label ~= nil then
						local name = tostring(GetLabelText(label))
						if name == "NULL" then
							name = fName.." "..tostring(j+1)
						end 
						if not (string.match(label, "WTD_V") or string.match(label, "WT_V")) or allowGuns then
							SendNUIMessage({command = "addACItem", params = {par = i, act = j, lText = name, _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
							children = children + 1
						end
					end
				end
			end

			if (iType == "wheel" or iType == "bwheel") then
				SetVehicleWheelType(veh, wheelType.set)
				if menuInfo[i].modID == 23 then
					SetVehicleMod(veh, menuInfo[i].modID, menuInfo[wheels].set, menuInfo[customTyres].set)
				elseif menuInfo[i].modID == 24 and customTyresB ~= nil then
					SetVehicleMod(veh, menuInfo[i].modID, menuInfo[wheelsB].set, menuInfo[customTyresB].set)
				end
			end

		elseif iType == "wtint" or iType == "lp" then
			for j = 1,#unlisted[menuInfo[i].modID] do
				if unlisted[menuInfo[i].modID][j] ~= "und" then
					local extra = getExtra(i, j, menuInfo[i].set == j-1)
					SendNUIMessage({command = "addACItem", params = {par = i, act = j-1, lText = unlisted[menuInfo[i].modID][j], _class = extra.class, rText = extra.text, cat = iType, prev = true}})
					children = children + 1
				end
			end
		elseif iType == "unlstd" then
			local extra = getExtra(i, -1, menuInfo[i].set == -1)
			SendNUIMessage({command = "addACItem", params = {par = i, act = -1, lText = stockText, _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
			for j = 1,#unlisted[menuInfo[i].modID] do
				local available = true;
				if (menuInfo[i].set ~= j) then
					SetVehicleMod(veh, menuInfo[i].modID, j-1)
					available = GetVehicleMod(veh, menuInfo[i].modID) == j-1
					SetVehicleMod(veh, menuInfo[i].modID, menuInfo[i].set)
				end
				if available and unlisted[menuInfo[i].modID][j] ~= "und" then
					extra = getExtra(i, j, menuInfo[i].set == j-1)
					SendNUIMessage({command = "addACItem", params = {par = i, act = j-1, lText = unlisted[menuInfo[i].modID][j], _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
					children = children + 1
				end
			end
		elseif iType == "turbo" then
			local available = true
			if not menuInfo[i].set then
				ToggleVehicleMod(veh, menuInfo[i].modID, true)
				available = IsToggleModOn(veh, menuInfo[i].modID)
				ToggleVehicleMod(veh, menuInfo[i].modID, menuInfo[i].set)
			end
			if available then
				local extra = getExtra(i, 0, menuInfo[i].set)
				SendNUIMessage({command = "addACItem", params = {par = i, act = not menuInfo[i].set, lText = unlisted[menuInfo[i].modID][1], _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
				children = children + 1
			end
		elseif (iType == "pcol" or iType == "scol") --[[ and garageNumber == 0]] then
			local extra = getExtra(i, 0, menuInfo[i].modID == 66 and customColourP.set.use or menuInfo[i].modID == 67 and customColourS.set.use);
			--SendNUIMessage({command = "addACItem", params = {par = i, act = "getCustomColour", lText = customColourText, _class = extra.class, rText = extra.text, cat = menuInfo[i].modID, prev = true}})
		elseif iType == "pscol" or iType == "wcol" or iType == "mtlc" or iType == "incol" and (inter or menuInfo[i].set ~= 0) or iType == "dcol" and (dash or menuInfo[i].set ~= 0) then
			for j = 1,#colInd.metallic do
				local extra
				if iType == "mtlc" then
					extra = getExtra(i, 0, menuInfo[menuInfo[i].parent].set == colInd.metallic[j])
				else
					extra = getExtra(i, 0, menuInfo[i].set == colInd.metallic[j])
				end
				local cat = iType
				if iType == "mtlc" then
					cat = menuInfo[menuInfo[i].parent].modID
				end
				if not (iType == "incol" or iType == "dcol") or (iType == "incol" or iType == "dcol") and colInd.metallic[j] ~= 0 then
					SendNUIMessage({command = "addACItem", params = {par = i, act = colInd.metallic[j], lText = colNames[colInd.metallic[j]+1], _class = extra.class, rText = extra.text, cat = cat, prev = true}})
				end
				children = children + 1
			end
		elseif iType == "util" then
			for j = 1,#colInd.util do
				local extra = getExtra(i, 0, menuInfo[menuInfo[i].parent].set == colInd.util[j])
				SendNUIMessage({command = "addACItem", params = {par = i, act = colInd.util[j], lText = colNames[colInd.util[j]+1], _class = extra.class, rText = extra.text, cat = menuInfo[menuInfo[i].parent].modID, prev = true}})
				children = children + 1
			end
		elseif iType == "matte" then
			for j = 1,#colInd.matte do
				local extra = getExtra(i, 0, menuInfo[menuInfo[i].parent].set == colInd.matte[j])
				SendNUIMessage({command = "addACItem", params = {par = i, act = colInd.matte[j], lText = colNames[colInd.matte[j]+1], _class = extra.class, rText = extra.text, cat = menuInfo[menuInfo[i].parent].modID, prev = true}})
				children = children + 1
			end
		elseif iType == "worn" then
			for j = 1,#colInd.worn do
				local extra = getExtra(i, 0, menuInfo[menuInfo[i].parent].set == colInd.worn[j])
				SendNUIMessage({command = "addACItem", params = {par = i, act = colInd.worn[j], lText = colNames[colInd.worn[j]+1], _class = extra.class, rText = extra.text, cat = menuInfo[menuInfo[i].parent].modID, prev = true}})
				children = children + 1
			end
		elseif iType == "metal" then
			for j = 1,#colInd.metal do
				local extra = getExtra(i, 0, menuInfo[menuInfo[i].parent].set == colInd.metal[j])
				SendNUIMessage({command = "addACItem", params = {par = i, act = colInd.metal[j], lText = colNames[colInd.metal[j]+1], _class = extra.class, rText = extra.text, cat = menuInfo[menuInfo[i].parent].modID, prev = true}})
				children = children + 1
			end
		elseif iType == "ct" or iType == "xl" or iType == "ts" or (iType == "bt" and allowBPTyres) or (iType == "ctb" and isBike) then
			local extra = getExtra(i, 0, menuInfo[i].set)

			SendNUIMessage({command = "addACItem", params = {par = menuInfo[i].parent, act = not menuInfo[i].set, lText = fName, _class = extra.class, rText = extra.text, cat = iType, prev = false}})
			if menuInfo[i].parent > 0 then
				menuInfo[menuInfo[i].parent].children = menuInfo[menuInfo[i].parent].children + 1
			end
		elseif iType == "n" and not isBike then
			local extra = getExtra(i, 0, neon.set.left or neon.set.right)
			local available = true
			if not (neon.set.left or neon.set.right) then
				SetVehicleNeonLightEnabled(veh, 0, true)
				SetVehicleNeonLightEnabled(veh, 1, true)
				available = IsVehicleNeonLightEnabled(veh, 0) or IsVehicleNeonLightEnabled(veh, 1)
				SetVehicleNeonLightEnabled(veh, 0, neon.set.left)
				SetVehicleNeonLightEnabled(veh, 1, neon.set.right)
			end
			if available then
				SendNUIMessage({command = "addACItem", params = {par = i, act = not (neon.set.left or neon.set.right), lText = neonLayouts[1], _class = extra.class, rText = extra.text, cat = "n1", prev = false}})
				children = children + 1
			end
			available = true
			if not neon.set.front then
				SetVehicleNeonLightEnabled(veh, 2, true)
				available = IsVehicleNeonLightEnabled(veh, 2)
				SetVehicleNeonLightEnabled(veh, 2, neon.set.front)
			end
			if available then
				extra = getExtra(i, 1, neon.set.front)
				SendNUIMessage({command = "addACItem", params = {par = i, act = not neon.set.front, lText = neonLayouts[2], _class = extra.class, rText = extra.text, cat = "n2", prev = false}})
				children = children + 1
			end
			available = true
			if not neon.set.back then
				SetVehicleNeonLightEnabled(veh, 3, true)
				available = IsVehicleNeonLightEnabled(veh, 3)
				SetVehicleNeonLightEnabled(veh, 3, neon.set.back)
			end
			if available then
				extra = getExtra(i, 1, neon.set.back)
				SendNUIMessage({command = "addACItem", params = {par = i, act = not neon.set.back, lText = neonLayouts[3], _class = extra.class, rText = extra.text, cat = "n3", prev = false}})
				children = children + 1
			end
		elseif iType == "tsc" or iType == "nc" and not isBike then
			local extra
			local custom = true
			for j = 1,#colours do
				if menuInfo[i].set[1] == colours[j].colour[1] and menuInfo[i].set[2] == colours[j].colour[2] and menuInfo[i].set[3] == colours[j].colour[3] then
					custom = false
				end
				extra = getExtra(i, 0, menuInfo[i].set[1] == colours[j].colour[1] and menuInfo[i].set[2] == colours[j].colour[2] and menuInfo[i].set[3] == colours[j].colour[3])
				SendNUIMessage({command = "addACItem", params = {par = i, act = colours[j].colour, lText = colours[j].name, _class = extra.class, rText = extra.text, cat = iType, prev = true}})
				children = children + 1
			end
			--if garageNumber == 0 then
				extra = getExtra(i, 0, custom)
				--SendNUIMessage({command = "addACItem", params = {par = i, act = "getCustomColour", lText = customColourText, _class = extra.class, rText = extra.text, cat = iType, prev = true}})
			--end
		elseif iType == "extra" then
			for j = 1,#extras.set do
				local available = true
				extras.set[j] = (not IsVehicleExtraTurnedOn(veh, j)) and 1 or 0
				extras.cart[j] = extras.set[j]
				if extras.set[j] == 1 then
					SetVehicleExtra(veh, j, 0)
					available = IsVehicleExtraTurnedOn(veh, j)
					SetVehicleExtra(veh, j, 1)
				end
				if available then
					local extra = getExtra(i, j, extras.set[j] == 0)
					SendNUIMessage({command = "addACItem", params = {par = i, act = extras.set[j] == 1, lText = extraText.." "..tostring(j), _class = extra.class, rText = extra.text, cat = iType..tostring(j), prev = false}})
					children = children + 1
				end
			end
		elseif iType == "rep" then
			SendNUIMessage({command = "addACItem", params = {par = menuInfo[i].parent, act = "repair", lText = fName, _class = "repair", rText = cleanfix, cat = "repair", prev = false}})
		elseif iType == "inst" then
			SendNUIMessage({command = "addACItem", params = {par = menuInfo[i].parent, act = "install", lText = fName, _class = "info", rText = "", cat = "install", prev = false}})
		end

		menuInfo[i].children = children
	end

	for i = #menuInfo,1,-1 do
		if menuInfo[i].children < 1 or
				not isBike and menuInfo[i].modID == 23 and i - wheels == 7 or
				isBike and menuInfo[i].parent == wheels and menuInfo[i].modID ~= 24 and i - wheels ~= 7
				--[[or (menuInfo[i]._type == "bs" or menuInfo[i]._type == "bwheel") and garageNumber ~= 0]] then
			SendNUIMessage({command = "removeACItem", num = i, par = menuInfo[i].parent})
			if menuInfo[i].parent > 0 then
				menuInfo[menuInfo[i].parent].children = menuInfo[menuInfo[i].parent].children - 1
			end
		end
	end
	SendNUIMessage({command = "setActiveACMenu", num = 0})
end


function _exit(restart)
	--if blockExit then return end
	SetNuiFocus(false, false)
	for i = 1,#menuInfo do
	setMod(i, true)
	end
	SendNUIMessage({command = "closeACMenu"})
	xenon = nil
	wheels = nil
	dash = false
	inter = false
	curMenu = nil
	wheelsB = nil
	wColour = nil
	pColour = nil
	sColour = nil
	psColour = nil
	totalPrice = 0
	tyreSmoke = nil
	customTyres = nil
	customTyresB = nil
	menuIsHidden = false
	extras = {
		set = {1,1,1,1,1,1,1,1,1},
		cart = {1,1,1,1,1,1,1,1,1}
	}
	wheelType = {set = -1, cart = -1}
	customColourP = {
		set = 	{use = false, RGB = {0,0,0}},
		cart = 	{use = false, RGB = {0,0,0}}
	}
	customColourS = {
		set = 	{use = false, RGB = {0,0,0}},
		cart = 	{use = false, RGB = {0,0,0}}
	}
	neon = {
		set = 	{left = false, right = false, front = false, back = false},
		cart = 	{left = false, right = false, front = false, back = false}
	}
	for i = 1,#menuInfo do
		menuInfo[i].set = -1
		menuInfo[i].cart = -1
		menuInfo[i].children = 0
	end
	if restart then
		--buildMenu(shops[garageNumber].title)
	else
		inUse = false
		veh = nil
		vehPrice = nil
		garageNumber = 0
	end
end

function getExtra(num, mult, cond)
	local extra = {text = "", class = "info"}
	if cond then
		extra.text = ""
		extra.class = "owned"
	else
		extra.text = calcPrice(menuInfo[num].price + menuInfo[num].prog * mult)
		extra.class = "price"
		if extra.text == 0 or mult < 0 then
			extra.text = freeText
			extra.class = "info"
		end
	end
	return extra
end


function setMod(num, perm)
	local modID = menuInfo[num].modID
	local choice = menuInfo[num].cart
	local iType = menuInfo[num]._type
	if perm then choice = menuInfo[num].set end
	if modID ~= nil then
		if (menuInfo[num]._type == "wheel" or menuInfo[num]._type == "bwheel") and (menuInfo[num].modID == 23 or menuInfo[num].modID == 24) then
			if perm then
				choice = menuInfo[wheels].set
				SetVehicleWheelType(veh, wheelType.set)
				SetVehicleMod(veh, menuInfo[customTyres].modID, menuInfo[wheels].set, menuInfo[customTyres].set)
				if customTyresB ~= nil then
					SetVehicleMod(veh, menuInfo[customTyresB].modID, menuInfo[wheelsB].set, menuInfo[customTyresB].set)
				end
			else
				choice = menuInfo[wheels].cart
				SetVehicleWheelType(veh, wheelType.cart)
				SetVehicleMod(veh, menuInfo[customTyres].modID, menuInfo[wheels].cart, menuInfo[customTyres].cart)
				if customTyresB ~= nil then
					SetVehicleMod(veh, menuInfo[customTyresB].modID, menuInfo[wheelsB].cart, menuInfo[customTyresB].cart)
				end
			end
		elseif iType == "mtlc" or iType == "matte" or iType == "util" or iType == "worn" or iType == "metal" or iType == "pcol" or iType == "scol" then
			if perm then
				if customColourP.set.use then
					SetVehicleCustomPrimaryColour(veh, customColourP.set.RGB[1], customColourP.set.RGB[2], customColourP.set.RGB[3])
				else
					ClearVehicleCustomPrimaryColour(veh)
				end
				if customColourS.set.use then
					SetVehicleCustomSecondaryColour(veh, customColourS.set.RGB[1], customColourS.set.RGB[2], customColourS.set.RGB[3])
				else
					ClearVehicleCustomSecondaryColour(veh)
				end
				SetVehicleColours(veh, menuInfo[pColour].set, menuInfo[sColour].set)
			else
				if customColourP.cart.use then
					SetVehicleCustomPrimaryColour(veh, customColourP.cart.RGB[1], customColourP.cart.RGB[2], customColourP.cart.RGB[3])
				else
					ClearVehicleCustomPrimaryColour(veh)
				end
				if customColourS.cart.use then
					SetVehicleCustomSecondaryColour(veh, customColourS.cart.RGB[1], customColourS.cart.RGB[2], customColourS.cart.RGB[3])
				else
					ClearVehicleCustomSecondaryColour(veh)
				end
				SetVehicleColours(veh, menuInfo[pColour].cart, menuInfo[sColour].cart)
			end
		elseif menuInfo[num]._type == "wtint" then
			SetVehicleWindowTint(veh, choice)
		elseif menuInfo[num]._type == "lp" then
			SetVehicleNumberPlateTextIndex(veh, choice)
		elseif menuInfo[num]._type == "turbo" then
			ToggleVehicleMod(veh, modID, choice)
		elseif menuInfo[num]._type ~= "ct" and menuInfo[num]._type ~= "xl" and menuInfo[num]._type ~= "bt" and menuInfo[num]._type ~= "ts"and menuInfo[num]._type ~= "ctb" then
			SetVehicleMod(veh, modID, choice)
		end
	elseif iType == "pscol" or iType == "wcol" then
		if perm then
			SetVehicleExtraColours(veh, menuInfo[psColour].set, menuInfo[wColour].set)
		else
			SetVehicleExtraColours(veh, menuInfo[psColour].cart, menuInfo[wColour].cart)
		end
	elseif menuInfo[num]._type == "tyres" then
		if perm then
			SetVehicleTyresCanBurst(veh, not menuInfo[bpTyres].set)
			ToggleVehicleMod(veh, menuInfo[tyreSmoke].modID, menuInfo[tyreSmoke].set)
			SetVehicleMod(veh, menuInfo[customTyres].modID, menuInfo[wheels].set, menuInfo[customTyres].set)
			if customTyresB ~= nil then
				SetVehicleMod(veh, menuInfo[customTyresB].modID, menuInfo[wheelsB].set, menuInfo[customTyresB].set)
			end
		else
			SetVehicleTyresCanBurst(veh, not menuInfo[bpTyres].cart)
			ToggleVehicleMod(veh, menuInfo[tyreSmoke].modID, menuInfo[tyreSmoke].cart)
			SetVehicleMod(veh, menuInfo[customTyres].modID, menuInfo[wheels].cart, menuInfo[customTyres].cart)
			if customTyresB ~= nil then
				SetVehicleMod(veh, menuInfo[customTyresB].modID, menuInfo[wheelsB].cart, menuInfo[customTyresB].cart)
			end
		end
	elseif menuInfo[num]._type == "n" then
		if perm then
			SetVehicleNeonLightEnabled(veh, 0, neon.set.left)
			SetVehicleNeonLightEnabled(veh, 1, neon.set.right)
			SetVehicleNeonLightEnabled(veh, 2, neon.set.front)
			SetVehicleNeonLightEnabled(veh, 3, neon.set.back)
		else
			SetVehicleNeonLightEnabled(veh, 0, neon.cart.left)
			SetVehicleNeonLightEnabled(veh, 1, neon.cart.right)
			SetVehicleNeonLightEnabled(veh, 2, neon.cart.front)
			SetVehicleNeonLightEnabled(veh, 3, neon.cart.back)
		end
	elseif menuInfo[num]._type == "nc" then
		if perm then
			SetVehicleNeonLightsColour(veh, menuInfo[num].set[1], menuInfo[num].set[2], menuInfo[num].set[3])
		else
			SetVehicleNeonLightsColour(veh, menuInfo[num].cart[1], menuInfo[num].cart[2], menuInfo[num].cart[3])
		end
	elseif menuInfo[num]._type == "tsc" then
		if perm then
			SetVehicleTyreSmokeColor(veh, menuInfo[num].set[1], menuInfo[num].set[2], menuInfo[num].set[3])
		else
			SetVehicleTyreSmokeColor(veh, menuInfo[num].cart[1], menuInfo[num].cart[2], menuInfo[num].cart[3])
		end
	elseif menuInfo[num]._type == "lights" then
		if perm then
			ToggleVehicleMod(veh, 22, menuInfo[xenon].set)
		else
			ToggleVehicleMod(veh, 22, menuInfo[xenon].cart)
		end
	elseif iType == "incol" then
		SetVehicleInteriorColour(veh, choice)
	elseif iType == "dcol" then
		SetVehicleDashboardColour(veh, choice)
	elseif iType == "extra" then
		if perm then
			for j = 1,#extras.set do
				SetVehicleExtra(veh, j, extras.set[j])
			end
		else
			for j = 1,#extras.cart do
				SetVehicleExtra(veh, j, extras.cart[j])
			end
		end
	end
end

function calcPrice(price)
	local vp = vehPrice
	if vp == nil then vp = defaultVehPrice end
	return math.floor(vp / 100 * price)
end

function LsCustoms:installModsclient()

	for i = 1,#menuInfo do
		menuInfo[i].set = menuInfo[i].cart
	end
	wheelType.set = wheelType.cart
	neon.set.left = neon.cart.left
	neon.set.back = neon.cart.back
	neon.set.right = neon.cart.right
	neon.set.front = neon.cart.front

	customColourP.set.use = customColourP.cart.use
	customColourS.set.use = customColourS.cart.use
	customColourP.set.RGB = customColourP.cart.RGB
	customColourS.set.RGB = customColourS.cart.RGB

	for j = 1,#extras.set do extras.set[j] = extras.cart[j] end

	_exit(true)
end

function LsCustoms:applyClean()
	SetVehicleFixed(veh)
	SetVehicleDirtLevel(veh, 0.0)
	self.remote._fuelUp()
end	

RegisterNUICallback("preview", function(data)
	if data.act == "getCustomColour" then
		local RGB
		if menuInfo[curMenu]._type == "nc" or menuInfo[curMenu]._type == "ts" then
			RGB = menuInfo[curMenu].cart
		elseif data.mod == 66 then
			RGB = table.pack(GetVehicleCustomPrimaryColour(veh))
		elseif data.mod == 67 then
			RGB = table.pack(GetVehicleCustomSecondaryColour(veh))
		end
		if RGB ~= nil then
			SendNUIMessage({command = "setRGB", R = RGB[1], G = RGB[2], B = RGB[3]})
		end
	elseif data.mod == "pscol" then
		SetVehicleExtraColours(veh, data.act, menuInfo[wColour].cart)
	elseif data.mod == 66 and data.act ~= nil then
		if menuInfo[curMenu]._type == "pcol" then
			SetVehicleCustomPrimaryColour(veh, data.act[1], data.act[2], data.act[3])
		else
			SetVehicleColours(veh, data.act, menuInfo[sColour].cart)
		end
	elseif data.mod == 67 and data.act ~= nil then
		if menuInfo[curMenu]._type == "scol" then
			SetVehicleCustomSecondaryColour(veh, data.act[1], data.act[2], data.act[3])
		else
			SetVehicleColours(veh, menuInfo[pColour].cart, data.act)	
		end
	elseif data.mod == "wtint" then
		SetVehicleWindowTint(veh, data.act)
	elseif data.mod == "lp" then
		SetVehicleNumberPlateTextIndex(veh, data.act)
	elseif data.mod == "wcol" then
		SetVehicleExtraColours(veh, menuInfo[psColour].cart, data.act)
	elseif data.mod == "incol" then
		SetVehicleInteriorColour(veh, data.act)
	elseif data.mod == "dcol" then
		SetVehicleDashboardColour(veh, data.act)
	elseif data.mod == "ct" then
		SetVehicleMod(veh, menuInfo[customTyres].modID, menuInfo[wheels].cart, data.act)
	elseif data.mod == "ctb" then
		SetVehicleMod(veh, menuInfo[customTyresB].modID, menuInfo[wheelsB].cart, data.act)
	elseif data.mod == "xl" then
		ToggleVehicleMod(veh, menuInfo[xenon].modID, data.act)
	elseif data.mod == "ts" then
		ToggleVehicleMod(veh, menuInfo[tyreSmoke].modID, data.act)
	elseif data.mod == "turbo" then
		ToggleVehicleMod(veh, data.act)
	elseif data.mod == "n1" then
		SetVehicleNeonLightEnabled(veh, 0, data.act)
		SetVehicleNeonLightEnabled(veh, 1, data.act)
	elseif data.mod == "n2" then
		SetVehicleNeonLightEnabled(veh, 2, data.act)
	elseif data.mod == "n3" then
		SetVehicleNeonLightEnabled(veh, 3, data.act)
	elseif data.mod == "nc" then
		SetVehicleNeonLightsColour(veh, data.act[1], data.act[2], data.act[3])
	elseif data.mod == "tsc" then
		SetVehicleTyreSmokeColor(veh, data.act[1], data.act[2], data.act[3])
	elseif data.mod == "bt" then
		SetVehicleTyresCanBurst(veh, not data.act)
	elseif string.match(data.mod, "extra") then
		SetVehicleExtra(veh, tonumber(string.sub(data.mod, 6)), (not data.act) and 1 or 0)
	else	
		SetVehicleMod(veh, data.mod, data.act)
	end
end)

RegisterNUICallback("addToCart", function(data)	
	if curMenu > 0 then		
		if data.mod == "ct" then
			menuInfo[customTyres].cart = data.act
			SetVehicleMod(veh, 23, menuInfo[wheels].cart, data.act)
		elseif data.mod == "xl" then
			menuInfo[xenon].cart = data.act
			ToggleVehicleMod(veh, menuInfo[xenon].modID, data.act)
		elseif data.mod == "bt" then
			menuInfo[bpTyres].cart = data.act
			SetVehicleTyresCanBurst(veh, menuInfo[bpTyres].cart)
		elseif data.mod == "ts" then
			menuInfo[tyreSmoke].cart = data.act
			ToggleVehicleMod(veh, menuInfo[tyreSmoke].modID, data.act)
		elseif data.mod == "ctb" then
			menuInfo[customTyresB].cart = data.act
			SetVehicleMod(veh, 24, menuInfo[wheelsB].cart, data.act)
		elseif data.mod == "n1" then
			neon.cart.left = data.act
			neon.cart.right = data.act
			SetVehicleNeonLightEnabled(veh, 0, data.act)
			SetVehicleNeonLightEnabled(veh, 1, data.act)
			menuInfo[curMenu].cart = neon.cart.left or neon.cart.right or neon.cart.front or neon.cart.back
		elseif data.mod == "n2" then
			neon.cart.front = data.act
			SetVehicleNeonLightEnabled(veh, 2, data.act)
			menuInfo[curMenu].cart = neon.cart.left or neon.cart.right or neon.cart.front or neon.cart.back
		elseif data.mod == "n3" then
			neon.cart.back = data.act
			SetVehicleNeonLightEnabled(veh, 3, data.act)
			menuInfo[curMenu].cart = neon.cart.left or neon.cart.right or neon.cart.front or neon.cart.back
		elseif data.mod == "nc" then
			menuInfo[curMenu].cart = data.act
			SetVehicleNeonLightsColour(veh, data.act[1], data.act[2], data.act[3])
		elseif data.mod == "tsc" then
			menuInfo[curMenu].cart = data.act
			SetVehicleTyreSmokeColor(veh, data.act[1], data.act[2], data.act[3])
		elseif menuInfo[curMenu]._type == "wheel" or menuInfo[curMenu]._type == "bwheel" then
			for i = 1,#menuInfo do
				if menuInfo[i]._type == "wheel" or menuInfo[i]._type == "bwheel" then
					if menuInfo[i].modID == data.mod then menuInfo[i].cart = -1 end
				end
			end
			menuInfo[curMenu].cart = data.act
		elseif data.mod == 66 then
			if menuInfo[curMenu]._type == "pcol" then
				customColourP.cart.use = true
				customColourP.cart.RGB = data.act
				SetVehicleCustomPrimaryColour(veh, data.act[1], data.act[2], data.act[3])
			else
				customColourP.cart.use = false
				menuInfo[curMenu].cart = data.act
				menuInfo[pColour].cart = data.act
				ClearVehicleCustomPrimaryColour(veh)
			end
			SetVehicleColours(veh, menuInfo[pColour].cart, menuInfo[sColour].cart)
		elseif data.mod == 67 then
			if menuInfo[curMenu]._type == "scol" then
				customColourS.cart.use = true
				customColourS.cart.RGB = data.act
				SetVehicleCustomSecondaryColour(veh, data.act[1], data.act[2], data.act[3])
			else
				customColourS.cart.use = false
				menuInfo[curMenu].cart = data.act
				menuInfo[sColour].cart = data.act
				ClearVehicleCustomSecondaryColour(veh)
			end
			SetVehicleColours(veh, menuInfo[pColour].cart, menuInfo[sColour].cart)
		elseif string.match(data.mod, "extra") then
			local j = tonumber(string.sub(data.mod, 6))
			extras.cart[j] = (not data.act) and 1 or 0
			SetVehicleExtra(veh, j, extras.cart[j])
		else
			menuInfo[curMenu].cart = data.act
		end
	end

	if menuInfo[curMenu].parent == wheels then
		wheelType.cart = GetVehicleWheelType(veh)
		if menuInfo[curMenu].modID == 23 then
			menuInfo[wheels].cart = data.act
		elseif menuInfo[curMenu].modID == 24 then
			menuInfo[wheelsB].cart = data.act
		end
	elseif menuInfo[curMenu].parent == pColour or menuInfo[curMenu].parent == sColour then
		menuInfo[menuInfo[curMenu].parent].cart = data.act
	end

	if 	menuInfo[curMenu].modID ~= nil and menuInfo[curMenu]._type ~= "ct" and menuInfo[curMenu]._type ~= "xl" and menuInfo[curMenu]._type ~= "bt" and
		menuInfo[curMenu]._type ~= "ctb" and menuInfo[curMenu]._type ~= "turbo" and menuInfo[curMenu]._type ~= "pcol" and menuInfo[curMenu]._type ~= "scol" then
		SetVehicleMod(veh, data.mod, data.act)
	elseif menuInfo[curMenu]._type == "turbo" then
		ToggleVehicleMod(veh, data.mod, data.act)
	end
end)

RegisterNUICallback("selectItem", function(data)	
	if data.type == "folder" then
		if curMenu == wheels then
			if menuInfo[data.num].modID == 24 then
				SetVehicleWheelType(veh, 6)
			else
				SetVehicleWheelType(veh, data.num - wheels - 1)
			end
		elseif curMenu == pColour then
			ClearVehicleCustomPrimaryColour(veh)
		elseif curMenu == sColour then
			ClearVehicleCustomSecondaryColour(veh)
		end
		if menuInfo[data.num].modID ~= nil then
			if menuInfo[data.num].modID == 31 then
				SetVehicleDoorOpen(veh, 0, 0, 0)
				SetVehicleDoorOpen(veh, 1, 0, 0)
			elseif menuInfo[data.num].modID >= 36 and menuInfo[data.num].modID <= 38 then
				SetVehicleDoorOpen(veh, 5, 0, 0)
			elseif menuInfo[data.num].modID >= 39 and menuInfo[data.num].modID <= 41 then
				SetVehicleDoorOpen(veh, 4, 0, 0)
			end
		end
		curMenu = data.num
	end
end)

RegisterNUICallback("goBack", function(data)	
	if data.command == "back" then
		setMod(curMenu, false)
		if menuInfo[curMenu].modID ~= nil then
			if menuInfo[curMenu].modID == 31 then
				SetVehicleDoorShut(veh, 0, 0)
				SetVehicleDoorShut(veh, 1, 0)
			elseif menuInfo[curMenu].modID >= 36 and menuInfo[curMenu].modID <= 38 then
				SetVehicleDoorShut(veh, 5, 0)
			elseif menuInfo[curMenu].modID >= 39 and menuInfo[curMenu].modID <= 41 then
				SetVehicleDoorShut(veh, 4, 0)
			end
		end
		curMenu = data.num
		if curMenu == 0 then
			totalPrice = 0
			
			for i = 1,#menuInfo do
				if menuInfo[i].set ~= menuInfo[i].cart then
					local mult = 0
					if tonumber(menuInfo[i].cart) ~= nil then mult = tonumber(menuInfo[i].cart) end
					local prog = menuInfo[i].prog * (mult + 1)
					if prog < 0 then prog = 0 end
					local inc = menuInfo[i].price + prog
					if mult < 0 then inc = 0 end
					if menuInfo[i]._type == "pcol" and not customColourP.cart.use or menuInfo[i]._type == "scol" and not customColourS.cart.use then
						inc = 0
					end
					if menuInfo[menuInfo[i].parent]._type == "pcol" and not customColourP.cart.use or menuInfo[menuInfo[i].parent]._type == "scol" and not customColourS.cart.use then
						if menuInfo[menuInfo[i].parent].cart ~= menuInfo[i].cart then
							inc = 0
						end
					end
					totalPrice = totalPrice + calcPrice(inc)
				end
			end
			if totalPrice == 0 then totalPrice = "" end
			SendNUIMessage({command = "setTotalPrice", price = totalPrice})
		end
	else
		_exit(false)
	end
end)

RegisterNUICallback("setNUIFocus", function(data)
	SetNuiFocus(true, true)
end)

RegisterNUICallback("removeNUIFocus", function(data)
	SetNuiFocus(false, false)
end)



function LsCustoms:blockEnter(blockEnter)
	enterAllowed = not blockEnter
end


function LsCustoms:applyFuel(value)
local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
if vehicle then
SetVehicleFuelLevel(vehicle, value)
   end
	
end
	



LsCustoms.tunnel = {}

LsCustoms.tunnel.applyFuel = LsCustoms.applyFuel
LsCustoms.tunnel.revertMods = LsCustoms.revertMods
LsCustoms.tunnel.closeAC = LsCustoms.closeAC
LsCustoms.tunnel.applyClean = LsCustoms.applyClean
LsCustoms.tunnel.goBack = LsCustoms.goBack
LsCustoms.tunnel.blockEnter = LsCustoms.blockEnter
LsCustoms.tunnel.installMods = LsCustoms.installMods

vRP:registerExtension(LsCustoms)