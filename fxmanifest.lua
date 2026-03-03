--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██╗     ██╗███╗   ██╗██████╗ ███████╗ ██████╗ ██╗     ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██║     ██║████╗  ██║██╔══██╗██╔════╝██╔═══██╗██║     ██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██║     ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║██║     ██║  ██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██║     ██║██║╚██╗██║██║  ██║██╔══╝  ██║   ██║██║     ██║  ██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝███████╗██║██║ ╚████║██████╔╝██║     ╚██████╔╝███████╗██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝      ╚═════╝ ╚══════╝╚═════╝

    🐺 LXR Blindfold - Player Restraint System for RedM

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    Store:       https://theluxempire.tebex.io

    ═══════════════════════════════════════════════════════════════════════════════

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

fx_version 'cerulean'
game       'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name        'lxr-blindfold'
author      'iBoss21 / The Lux Empire'
description 'A blindfold / player-restraint script for RedM — LXR-Core, RSG-Core, VORP Core'
version     '2.1.0'

lua54 'yes'

server_script {
    'server/server.lua'
}

client_script {
    'client/utils.lua',
    'client/client.lua'
}

shared_script {
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/**/*'
}
