resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'Bradley / NS100 Chat'
version '1.0.0'

client_script 'client/NS_Bradley2.lua'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/sv_custom_chat.lua.lua'
}
