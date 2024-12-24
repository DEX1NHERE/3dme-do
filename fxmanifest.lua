
fx_version 'bodacious'
game 'gta5'
author 'dex1n9'
description '/me /do'
version '2.1'
shared_script 'config.lua'
client_script 'client.lua'
server_scripts {
 '@mysql-async/lib/MySQL.lua',
 'server.lua'
 }
