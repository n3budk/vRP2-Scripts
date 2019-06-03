local LegacyFuel = class("LegacyFuel", vRP.Extension)

function LegacyFuel:__construct()
  vRP.Extension.__construct(self)
end

Vehicles = {
	{ plate = '87OJP476', model = 'Zentorno', fuel = 50}
}

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

LegacyFuel.tunnel = {}

function LegacyFuel.tunnel:PayFuel(price)
	local user = vRP.users_by_source[source]
	local amount  = round(price, 0)
	user:tryPayment(amount)
	vRP.EXT.Base.remote._notify(user.source,"You paid ~g~$"..amount)
end



function LegacyFuel.tunnel:UpdateServerFuelTable(plate, model, fuel)
	local found = false

	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate and Vehicles[i].model == model then 
			found = true
			
			if fuel ~= Vehicles[i].fuel then
				table.remove(Vehicles, i)
				table.insert(Vehicles, {plate = plate, model = model, fuel = fuel})
			end
			break 
		end
	end

	if not found then
		table.insert(Vehicles, {plate = plate, model = model, fuel = fuel})
	end
end



function LegacyFuel.tunnel:CheckServerFuelTable (plate, model)
	local user = vRP.users_by_source[source]
	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate and Vehicles[i].model == model then
			local vehInfo = {plate = Vehicles[i].plate, model = Vehicles[i].model ,fuel = Vehicles[i].fuel}
			self.remote._ReturnFuelFromServerTable(user.source, vehInfo)
			break
		end
	end
end

function LegacyFuel.tunnel:CheckCashOnHand()
	local user = vRP.users_by_source[source]
	local cb = user:getWallet()
	self.remote._RecieveCashOnHand(user.source, cb)
end



vRP:registerExtension(LegacyFuel)