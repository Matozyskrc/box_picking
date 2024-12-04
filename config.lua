local Config = {}

-- Box Configuration
Config.BoxCount = 7 -- Number of boxes to spawn
Config.BoxModel = `prop_box_wood05a` -- box model

Config.CenterCoords = vec3(-1880.6063, 4640.4600, 57.0006) -- Box spawn location
Config.SpawnRadius = 30.0 -- Spawn radius

Config.LootTable = {
    {item = 'spyruokle', count = {1, 3}}, 
    {item = 'vamzdis', count = {1, 4}},
    {item = 'saugiklis', count = {1, 5}},
    {item = 'griebtuvas', count = {1, 5}},
    {item = 'guma', count = {1, 6}},
    {item = 'plienas', count = {1, 3}},
    {item = 'metalas', count = {1, 3}},
}

Config.Blip = {
    Enabled = true, -- Enable/Disable blip
    Sprite = 1, -- Blip icon
    Color = 2, -- Blip color
    Scale = 0.8, -- Blip size
    Name = "Box Location", -- Blip name
}

return Config
