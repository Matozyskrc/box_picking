local Config = require('config')
local boxes = {}

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

local function getRandomPosition(center, radius)
    local angle = math.random() * 2 * math.pi
    local distance = math.random() * radius
    local offsetX = math.cos(angle) * distance
    local offsetY = math.sin(angle) * distance

    local initialZ = center.z + 100.0
    local foundGround, groundZ = GetGroundZFor_3dCoord(center.x + offsetX, center.y + offsetY, initialZ, false)
    return vec3(center.x + offsetX, center.y + offsetY, foundGround and groundZ or center.z)
end

local function getRandomLoot()
    local loot = Config.LootTable[math.random(#Config.LootTable)]
    loot.count = math.random(loot.count[1], loot.count[2]) 
    return loot
end


local function spawnBox()
    local position = getRandomPosition(Config.CenterCoords, Config.SpawnRadius)
    local boxLabel = 'Ieskoti detaliu'
    local boxID = #boxes + 1

    loadModel(Config.BoxModel)

    local boxProp = CreateObject(Config.BoxModel, position.x, position.y, position.z, false, true, false)
    SetEntityHeading(boxProp, math.random(0, 210))
    FreezeEntityPosition(boxProp, true)

    local zoneName = 'box_loot_' .. boxID
    boxes[boxID] = {position = position, prop = boxProp, zone = zoneName}

    exports.ox_target:addBoxZone({
        coords = position,
        size = vec3(3, 3, 3),
        rotation = 0,
        debug = false,
        options = {
            {
                name = zoneName,
                event = 'md_scrpt:pickupLoot',
                icon = 'fas fa-box',
                label = boxLabel,
                boxID = boxID,
                canInteract = function()
                    return true
                end,
            },
        },
    })

local function deleteBox(boxID)
    if boxes[boxID] then
        local prop = boxes[boxID].prop
        if DoesEntityExist(prop) then
            DeleteObject(prop)
        end
        boxes[boxID] = nil
    end
end


for i = 1, Config.BoxCount do
    spawnBox()
end

RegisterNetEvent('md_scrpt:pickupLoot', function(data)
    local boxID = data.boxID

    local progress = lib.progressBar({
        duration = 5000,
        label = 'Ieskote detaliu',
        useWhileDead = false,
        canCancel = true,
        disable = {move = true, car = true, combat = true},
        anim = {dict = 'amb@medic@standing@kneel@base', clip = 'base'},
    })

    if progress then
        local loot = getRandomLoot()
        TriggerServerEvent('md_scrpt:giveLoot', loot)
        TriggerEvent('ox_lib:notify', {type = 'success', description = 'Jus radote ' .. loot.count .. 'x ' .. loot.item})
        deleteBox(boxID)
        spawnBox()
    else
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Ieskojimas atsauktas!'})
    end
end)
