resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "files/gui/html/ui.html"


dependency "vrp"

files {
	"files/gui/html/ui.html",
	"files/gui/html/logo.png",
	"files/gui/html/dmv.png",
	"files/gui/html/cursor.png",
	"files/gui/html/styles.css",
	"files/gui/html/questions.js",
	"files/gui/html/scripts.js",
	"files/gui/html/debounce.min.js",
	"client.lua"	
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server_vrp.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"files/gui/GUI.lua",
	"client_vrp.lua"
}

files{
  "cfg/dmv.lua",
  "cfg/lang/en.lua",
  "client.lua"
}
