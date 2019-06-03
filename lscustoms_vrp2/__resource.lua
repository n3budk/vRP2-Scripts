resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'



dependency "vrp"
dependency "addons_vrp2"

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