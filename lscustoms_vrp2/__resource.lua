resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "vrp"
dependency "AddonsV"

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server_vrp.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

files {
	"cfg/lscustoms.lua",
	"html/menu.html",
	"html/menuHandler.js",
	"html/style/menu.css",
	"html/style/colourPicker.css"
}

ui_page "html/menu.html"