ESX = nil
local qtarget = exports.qtarget

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

qtarget:AddTargetModel(Config.PropATM, {
	options = {
		{
			icon = "fa-solid fa-money-bill",
			label = "Rapina ATM",
				
			-- end,
			event = "ak_illegal:qTarget",
			num = 1
		}
	},
	distance = 2
})

RegisterNetEvent('ak_dev:RapinaAtm',function()
	exports.rprogress:Custom({
		Async = false,
		canCancel = true,
		Duration = 3 * 1000,
		Label = 'Rapinando Atm...',
		onComplete = function()
		TriggerServerEvent('ak_dev:TogliItem')
		TriggerEvent('ultra-voltlab', 30, function(outcome ,reason)
			if outcome == 0 then
				FreezeEntityPosition(PlayerPedId(), false)
				ESX.ShowNotification('Hai fallito l\'hacking', false, false, 140)
				ExecuteCommand('e c')
			elseif outcome == 1 then
				TriggerEvent("Drilling:Start",function(success)
					if (success) then
					--   print("Drilling complete.")
					FreezeEntityPosition(PlayerPedId(), false)
					TriggerServerEvent('ak_dev:DaiSoldiATM')
					ExecuteCommand('e c')
					else
					end
				  end)
			elseif outcome == 2 then
				FreezeEntityPosition(PlayerPedId(), false)
				ESX.ShowNotification('Hai finito il tempo', false, false, 140)
				ExecuteCommand('e c')
			elseif outcome == -1 then
				ExecuteCommand('e c')
				FreezeEntityPosition(PlayerPedId(), false)
				ESX.ShowNotification('Non disponibile attualmente', false, false, 140)
			end
		end)
			end
	})
end)

RegisterNetEvent('ak_illegal:qTarget',function()
	ESX.TriggerServerCallback('ak_dev:CheckItem', function(DispositivoHack)
		if DispositivoHack >= 1 then
			FreezeEntityPosition(PlayerPedId(), true)
			ExecuteCommand('me Rapinando Atm')
			ExecuteCommand("e mechanic")
			TriggerEvent('ak_dev:RapinaAtm')
		else
			ESX.ShowNotification("Non hai gli strumenti giusti per rapinare questo ATM")
		end
	end)
end)
