dependency "vrp"
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"@vrp/lib/utils.lua",
	"client_vrp.lua"
}

server_scripts{
	"@vrp/lib/utils.lua",
	"server_vrp.lua"
}

files{
  "config.lua",
  "client.lua"
}
