fx_version 'cerulean'
game 'gta5'

author 'matozyskrc'
description 'box_picking'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    "config.lua",
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_target',
    'ox_lib'
}
