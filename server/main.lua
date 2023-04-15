ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function RandomNumber()
	return math.random(1000,12000)
end

RegisterServerEvent('ak_dev:DaiSoldiATM')
AddEventHandler('ak_dev:DaiSoldiATM', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(item)
        xPlayer.addAccountMoney('black_money',  RandomNumber())
end)

RegisterServerEvent('ak_dev:TogliItem')
AddEventHandler('ak_dev:TogliItem', function(itemremove, source)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- local xItem = xPlayer.getInventoryItem(Config.DispositivoHack)
        xPlayer.removeInventoryItem(Config.DispositivoHack, 1)
end)

ESX.RegisterServerCallback('ak_dev:CheckItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local DispositivoHack = xPlayer.getInventoryItem(Config.DispositivoHack).count
	cb(DispositivoHack)
end)
