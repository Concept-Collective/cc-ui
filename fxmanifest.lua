version '1.0.0'
author 'Concept Collective'
description ''

lua54 'yes'

ui_page 'nui/index.html'
files {
    'nui/index.html',
    'nui/**.js',
    'nui/**.css'
}

server_scripts {
    'example/server.lua'
}

client_scripts{
    'components/**.lua',
    'example/client.lua'
}


game 'common'
fx_version 'adamant'
