resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "vRP2 boombox"

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server_vrp.lua"
}

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client_vrp.lua"
}

files{
  "lang/en.lua",
  "client.lua"
}

