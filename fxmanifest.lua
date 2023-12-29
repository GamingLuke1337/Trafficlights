fx_version "cerulean"
game "gta5"
lua54 "yes"

author "5M-CodeX | TheStoicBear"
description "codex-opticom"
version "2.0.0"

shared_scripts {
  "@ox_lib/init.lua",
  "config_shared.lua"
}

client_script "source/client/main.lua"

server_script "source/server/main.lua"
