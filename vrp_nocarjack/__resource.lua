
description "vrp_nocarjack"


dependency "vrp"
client_scripts{ 
  "@vrp/lib/utils.lua",
  "client_vrp.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server_vrp.lua"
}
files{
  "cfg/nocarjack.lua",
  "client.lua"
}