
 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if IsControlJustReleased(1, 243) then
				TriggerServerEvent('LockToggle:Lock')

        end
    end
end)

