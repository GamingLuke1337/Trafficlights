fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'TheStoicBear - Reworked by Gamingluke1337'
description 'Trafficlight script for FiveM'
version '1.1.0'

client_script 'client/main.lua'

server_scripts {
  'server/main.lua',
  'server/update.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}