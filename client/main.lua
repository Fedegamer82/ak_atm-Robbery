ESX = nil
local ox_target = exports.ox_target
local models = { `prop_atm_01`, `prop_atm_02` }

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


ox_target:addModel(models, {
	{
		name = "RapinaATM",
		icon = "fa-solid fa-money-bill",
		label = 'Rapina ATM',
		onSelect = function()
			ESX.TriggerServerCallback('ak_dev:CheckItem', function(DispositivoHack)
                if DispositivoHack >= 1 then
					FreezeEntityPosition(PlayerPedId(), true)
					TriggerEvent('ak_dev:RapinaAtm')
				else
					ESX.ShowNotification("Non hai gli strumenti giusti per rapinare questo ATM")
				end
			end)
		end,
	},
})

RegisterNetEvent('ak_dev:RapinaAtm',function(morte)
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
			elseif outcome == 1 then
				FreezeEntityPosition(PlayerPedId(), false)
				TriggerServerEvent('ak_dev:DaiSoldiATM')
			elseif outcome == 2 then
				FreezeEntityPosition(PlayerPedId(), false)
				ESX.ShowNotification('Hai finito il tempo', false, false, 140)
			elseif outcome == -1 then
				FreezeEntityPosition(PlayerPedId(), false)
				ESX.ShowNotification('Non disponibile attualmente', false, false, 140)
			end
		end)
			end
	})
end)

