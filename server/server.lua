local RSGCore = exports['rsg-core']:GetCoreObject()

-- use goldpan
RSGCore.Functions.CreateUseableItem("goldpan", function(source, item)
    local src = source
    TriggerClientEvent("rsg-goldpanning:client:StartGoldPan", src, item.name)
end)

-- give reward
RegisterServerEvent('rsg-goldpanning:server:reward')
AddEventHandler('rsg-goldpanning:server:reward', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
	local foundgold = math.random(1,100)
	if foundgold < Config.GoldChance then
		local chance = math.random(1,100)
		if chance <= 50 then
			local item1 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			-- add items
			Player.Functions.AddItem(item1, Config.SmallRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
			TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.not_much_this_pan'), 'primary')
		elseif chance >= 50 and chance <= 80 then -- medium reward
			local item1 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			local item2 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			-- add items
			Player.Functions.AddItem(item1, Config.MediumRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
			Player.Functions.AddItem(item2, Config.MediumRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
			TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.looks_like_good_gold'), 'primary')
		elseif chance > 80 then -- large reward
			local item1 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			local item2 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			local item3 = Config.RewardItems[math.random(1, #Config.RewardItems)]
			-- add items
			Player.Functions.AddItem(item1, Config.LargeRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
			Player.Functions.AddItem(item2, Config.LargeRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
			Player.Functions.AddItem(item3, Config.LargeRewardAmount)
			TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item3], "add")
			TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.gold_fever_jackpot'), 'primary')
		end
	else
		TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.no_gold_this_time'), 'primary')
	end
end)
