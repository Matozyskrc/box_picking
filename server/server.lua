local ox_inventory = exports.ox_inventory

RegisterNetEvent('md_scrpt:giveLoot', function(loot)
    local xPlayer = source
    ox_inventory:AddItem(xPlayer, loot.item, loot.count)
end)
