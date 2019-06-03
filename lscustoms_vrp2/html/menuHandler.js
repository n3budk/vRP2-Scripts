//ver 0.89
function ACMenu (num, name = "", parent = null) {
	this.parent = parent;
	this.name = name;
	this.ul = document.createElement("ul");

	var idx = num;
	var lItems = [];
	var curItem = null;

	this.getIdx = function() {return idx;}
	this.getCurItemNum = function() {return curItem;}
	this.getItem = function(n) {
		if (typeof(n) == "number" && n < lItems.length)
			return lItems[n];
		return null;
	}

	this.namesChain = function() {
		ret = [this.name];
		par = this.parent;
		while (par) {
			ret.splice(0, 0, par.name);
			par = par.parent;
		}
		return ret;
	}

	this.count = function() {
		return lItems.length;
	}

	this.addMenuItem = function(item) {
		lItems[lItems.length] = item;
		item.setParent(this);
	}

	this.removeMenuItem = function(number = null) {
		if (number == null) number = this.count()-1;
		if (curItem >= this.count()-1)
			curItem = this.count()-2;
		if (curItem < 1)
			curItem = null;
		if (lItems[number] != null) {
			this.ul.removeChild(lItems[number].li);
			lItems.splice(number,1);
		}
		this.setCurrentItem(curItem);
		this.setDocMaxHeight();
	}

	this.isOverflown = function() {
		return this.ul.clientHeight < this.ul.scrollHeight;
	}

	this.getCurItem = function() {
		if (curItem == null) return null;
		return lItems[curItem];
	}

	this.setCurrentItem = function(n) {
		if ((lItems.length <= n) || (lItems.length == 0) || !isFinite(n) || n == null) return false;
		if (curItem != null)
			if (lItems[curItem].li.getAttribute("class") == "current")
				lItems[curItem].li.removeAttribute("class");
		lItems[n].li.setAttribute("class", "current");
		curItem = n;
		lItems[n].preview();
		if (this.isCurItemOutOfScroll)
			lItems[curItem].li.scrollIntoView(false);
		return true;
	}

	this.setNextCurrentItem = function() {
		if (lItems.length == 0) return;
		if (curItem == null)
			curItem = -1
		else
			lItems[curItem].li.removeAttribute("class");
		if (curItem < lItems.length-1)
			curItem++
		else if (curItem > 0)
			curItem = 0;
		lItems[curItem].li.setAttribute("class", "current");
		lItems[curItem].preview();
		if (this.isCurItemOutOfScroll())
			lItems[curItem].li.scrollIntoView(false);
	}

	this.setPreviousCurrentItem = function() {
		if (lItems.length == 0) return;
		if (curItem == null)
			curItem = 0
		else
			lItems[curItem].li.removeAttribute("class");
		if (curItem > 0)
			curItem--
		else
			curItem = lItems.length-1;
		lItems[curItem].li.setAttribute("class", "current");
		lItems[curItem].preview();
		if (this.isCurItemOutOfScroll())
			lItems[curItem].li.scrollIntoView(true);
	}

	this.setDocMaxHeight = function() {
		var parentNode = this.ul.parentNode;
		if (!parentNode) return;
		this.ul.style.maxHeight = "100%";
		var crop = 5;
		var siblings = parentNode.children;
		for (var i = 0; i < siblings.length; i++)
			if (!siblings[i].isSameNode(this.ul))
				crop += siblings[i].clientHeight;
		if (this.ul.clientHeight > crop)
			this.ul.style.maxHeight = parentNode.clientHeight - crop + "px";
		if (this.isCurItemOutOfScroll())
			this.ul.getElementsByTagName('li')[curItem].scrollIntoView(false);
	}

	this.isCurItemOutOfScroll = function() {
		if (curItem == null) return false;
		var item = this.ul.getElementsByTagName('li')[curItem];
		var parentTop = item.parentNode.offsetTop + item.parentNode.scrollTop;
		var parentBottom = item.parentNode.offsetTop + item.parentNode.clientHeight + item.parentNode.scrollTop;
		return (item.offsetTop < parentTop) || (item.offsetTop + item.clientHeight > parentBottom);
	}
}

function ACItem (n = "Main menu", a = 0, t = "folder", e = "", c = "folder", p = false) {
	this.prev = p;
	this.action = a;
	this.category = c;
	this.li = document.createElement("li");

	var name;
	var type;
	var extra;
	var parent = null;
	var feature = document.createElement("span");

	this.li.appendChild(document.createElement("span"));
	this.li.appendChild(feature);

	this.getName = function() {return name;}
	this.getType = function() {return type;}
	this.getExtra = function() {return extra;}
	this.getParent = function() {return parent;}

	this.select = function() {
		if (this.action == "repair") {
			$.post("http://lscustoms_vrp2/repair")
		} else if (this.action == "install") {
			$.post("http://lscustoms_vrp2/install")
		} else if (this.action == "getCustomColour") {
			var menuPar = 0
			if (parent && parent.parent) menuPar = parent.parent.getIdx();
			CPHandler.addMouseTracking();
			CPHandler.setPost("http://lscustoms_vrp2/preview", JSON.stringify({
				act: "RGB",
				mod: this.category,
				par: menuPar
			}));
			document.addEventListener("keydown", docKeyPressed);
			CP.style.visibility = "visible";
			$.post("http://lscustoms_vrp2/setNUIFocus")
		} else if (type == "folder" && typeof(this.action) == "number") {
			setActiveMenu(menus[this.action]);
			$.post("http://lscustoms_vrp2/selectItem", JSON.stringify({
				num: this.action,
				mod: this.category,
				type: type
			}));
			if (activeMenu && activeMenu.getCurItem())
				activeMenu.getCurItem().preview();

		} else if ((type == "price" || type == "info" || type == "owned" || type == "cart" || this.action === true || this.action === false)) {
			for (var i = 0; i < items.length; i++) {
				if (items[i].category == this.category && items[i] != this && items[i].getType() == "cart" && items[i].getType() != "owned") {
					if (isFinite(items[i].getExtra())) {
						items[i].setType("price")
					} else {
						items[i].setType("info");
					}
				}
			}

			if (type != "owned") {
				if (type == "discard" && this.action === true)
					this.setType("owned");
				else if (type == "cart" && this.action === false) {
					if (isFinite(extra)) 
						this.setType("price")
					else
						this.setType("info")
				} else
					this.setType("cart")
			} else if (this.action === false)
				this.setType("discard");

			var par = 0
			if (parent) par = parent.getIdx();
			$.post("http://lscustoms_vrp2/addToCart", JSON.stringify({
				act: this.action,
				mod: this.category,
				par: par
			}));
		}
			if (this.action === true || this.action === false)
				this.action = !this.action;
	}

	this.preview = function() {
		if (type == "folder" || this.prev == false) return;
		var menuPar = 0
		if (parent && parent.parent) menuPar = parent.parent.getIdx();
		$.post("http://lscustoms_vrp2/preview", JSON.stringify({
			act: this.action,
			mod: this.category,
			par: menuPar
		}));	
	}		

	this.setParent = function(p) {
		if (typeof(p) != "object") return;
		parent = p;
		p.ul.appendChild(this.li);
	}

	this.setType = function(_type) {
		if (typeof(_type) != "string") return;
		type = _type;
		feature.setAttribute("class", type);
	}

	this.setExtraText = function(text = "") {
		extra = text;
		feature.innerHTML = extra;
	}

	this.setExtra = function(_type, text="") {
		this.setType(_type);
		this.setExtraText(text);
	}

	this.setName = function(text = "") {
		name = text;
		this.li.firstChild.innerHTML = name;
	}

	this.setExtra(t, e);
	this.setName(n);
}

function ACCPHandler() {
	var RGB = [0,0,0];
	var H = 0;
	var V = 0;
	var S = 0;
	var BP = 1;
	var hSec = 255;
	var svRange = 1;
	var postCommand = "";
	var postParameters = "";
	
	var hue = document.getElementById("hue");
	var plt = document.getElementById("plt");
	var pltC = document.getElementById("pltC");
	var svSel = document.getElementById("svSel");
	var hueSel = document.getElementById("hueSel");

	this.getRGB = function() {return RGB}

	this.setPost = function(c, p) {postCommand = c; postParameters = p}

	this.setRGB = function(r = 0, g = 0, b = 0) {
		if (!isFinite(r) || !isFinite(g) || !isFinite(b))
			return;
		r = r < 0 ? 0 : r;
		g = g < 0 ? 0 : g;
		b = b < 0 ? 0 : b;
		r = r > 255 ? 255 : r;
		g = g > 255 ? 255 : g;
		b = b > 255 ? 255 : b;

		var rgb = [r/255, g/255, b/255];
		V = Math.max(rgb[0], rgb[1],rgb[2]);

		var d = V - Math.min(rgb[0], rgb[1], rgb[2]);
		S = V == 0 ? V : d / V;

		if (d == 0)
			H = 0
		else if (V == rgb[0])
			if (rgb[1] > rgb[2])
				H = hSec * ((rgb[1] - rgb[2]) / d % 6)
			else
				H =  hSec * 6 + hSec * ((rgb[1] - rgb[2]) / d % 6)
		else if (V == rgb[1])
			H = hSec * ((rgb[2] - rgb[0]) / d + 2)
		else if (V == rgb[2])
			H = hSec * ((rgb[0] - rgb[1]) / d + 4)

		var pH = svSel.offsetHeight / 4;
		var pW = svSel.offsetWidth / 2;
		var ll = plt.parentNode.clientWidth - svSel.clientWidth - pW/2;
		var tl = plt.parentNode.clientHeight - svSel.clientHeight - pH;
		var bl = (hue.parentNode.clientHeight - hueSel.clientHeight - hueSel.offsetHeight);
		var scale1 = hSec * 6 / bl;
		var xScale = svRange / ll;
		var yScale = svRange / (tl-pH);

		hueSel.style.top = Math.round(H / scale1) + "px";
		svSel.style.right = Math.round(S / xScale) + "px";
		svSel.style.bottom = Math.round(V / yScale + pH) + "px";

		calcRGB();
	}

	var hueHandler = function(cb) {
		var pH = hueSel.offsetHeight;
		var t = parseInt(hue.getBoundingClientRect().top);
		var y = cb.clientY-t-pH/2;
		var bl = (hue.parentNode.clientHeight - hueSel.clientHeight - pH);
		var range = hSec * 6;
		var scale = range / bl;

		y = y < 0 ? 0 : y;
		y = y > bl ? bl : y;
		H = y * scale; H = H > range ? range : H; H = H < 0 ? 0 : H;

		hueSel.style.top = y + "px";
		calcRGB();
	}

	var svHandler = function(cb) {
		var pH = svSel.offsetHeight / 4;
		var b = parseInt(plt.getBoundingClientRect().bottom);
		var y = b - cb.clientY - pH;
		var tl = plt.parentNode.clientHeight - svSel.clientHeight - pH;

		var pW = svSel.offsetWidth / 2;
		var r = parseInt(plt.getBoundingClientRect().right);
		var x = r - cb.clientX - pW;
		var ll = plt.parentNode.clientWidth - svSel.clientWidth - pW/2;

		y = y < pH ? pH : y;
		y = y > tl ? tl : y;
		x = x < 0 ? 0 : x;
		x = x > ll ? ll : x;

		var xScale = svRange / ll;
		var yScale = svRange / (tl-pH);
		V = (y-pH) * yScale; V = V > svRange ? svRange : V; V = V < 0 ? 0 : V;
		S = x * xScale; S = S > svRange ? svRange : S; S = S < 0 ? 0 : S;

		svSel.style.bottom = y + "px";
		svSel.style.right = x + "px";
		calcRGB();
	}

	var calcRGB = function() {
		BP = H / hSec % 2 - 1; BP = BP < 0 ? -BP : BP;

		var SV = S * V;
		var sub = V - SV;
		var c = Math.round((1 - BP) * 255);
		var c3 = Math.round(sub * 255);
		var c1 = Math.round((sub + SV) * 255);
		var c2 = Math.round((sub + (1 - BP) * SV) * 255);
		var s1 = hSec, s2 = hSec * 2, s3 = hSec * 3, s4 = hSec * 4, s5 = hSec * 5, s6 = hSec * 6;

		var rgb = [0,0,0];
		if 		(0 <= H && H < s1) 		{rgb[0] = 255; rgb[1] = c; rgb[2] = 0; 	RGB[0] = c1; RGB[1] = c2; RGB[2] = c3;}
		else if (s1 <= H && H < s2) 	{rgb[1] = 255; rgb[0] = c; rgb[2] = 0; 	RGB[1] = c1; RGB[0] = c2; RGB[2] = c3;}
		else if (s2 <= H && H < s3) 	{rgb[1] = 255; rgb[2] = c; rgb[0] = 0; 	RGB[1] = c1; RGB[2] = c2; RGB[0] = c3;}
		else if (s3 <= H && H < s4) 	{rgb[2] = 255; rgb[1] = c; rgb[0] = 0; 	RGB[2] = c1; RGB[1] = c2; RGB[0] = c3;}
		else if (s4 <= H && H < s5) 	{rgb[2] = 255; rgb[0] = c; rgb[1] = 0; 	RGB[2] = c1; RGB[0] = c2; RGB[1] = c3;}
		else if (s5 <= H && H <= s6) 	{rgb[0] = 255; rgb[2] = c; rgb[1] = 0; 	RGB[0] = c1; RGB[2] = c2; RGB[1] = c3;}

		pltC.style.fill = "rgb("+rgb[0]+","+rgb[1]+","+rgb[2]+")";
		svSel.style.backgroundColor = "rgb("+RGB[0]+","+RGB[1]+","+RGB[2]+")";
		$.post(postCommand, postParameters.replace('"RGB"', "["+RGB+"]"));
	}

	this.addMouseTracking = function () {
		plt.addEventListener("mousedown", svOnMouseDown)
		hue.addEventListener("mousedown", hueOnMouseDown)
		svSel.addEventListener("mousedown", svOnMouseDown)
		hueSel.addEventListener("mousedown", hueOnMouseDown)

		document.addEventListener("mouseup", function() {
			document.removeEventListener("mousemove", svHandler);
			document.removeEventListener("mousemove", hueHandler);
		})
	}

	this.removeMouseTracking = function() {
		plt.removeEventListener("mousedown", svOnMouseDown);
		hue.removeEventListener("mousedown", hueOnMouseDown);
		svSel.removeEventListener("mousedown", svOnMouseDown);
		hueSel.removeEventListener("mousedown", hueOnMouseDown);
	}

	var hueOnMouseDown = function(e) {
		if (e.which != 1) return;
		hueHandler(e);
		document.addEventListener("mousemove", hueHandler);
	}

	var svOnMouseDown = function(e) {
		if (e.which != 1) return;
		svHandler(e);
		document.addEventListener("mousemove", svHandler);
	}
}

var CP;
var infTxt;
var menuDoc;
var menus = [];
var items = [];
var CPHandler = {};
var activeMenu = null;

function setActiveMenu(m) {
	if (!m) return false;
	if (m.constructor.name != "ACMenu") return false;
	if (activeMenu != null) {
		activeMenu.ul.setAttribute("style", "display:none");
		activeMenu.ul.removeAttribute("id");
	}
	if (!m.ul) return false;
	activeMenu = m;
	activeMenu.ul.removeAttribute("style");
	menuDoc.appendChild(activeMenu.ul);
	updateBreadcrumbs();
	activeMenu.setDocMaxHeight();
	return true;
}

function updateBreadcrumbs() {
	if (!activeMenu) return;
	var node = document.getElementById("bcs");
	var crumbs = activeMenu.namesChain();
	if (crumbs != null) {
		node.innerHTML = crumbs[0];
		for (var i = 1; i < crumbs.length; i++) {
			var crumb = document.createElement("span");
			crumb.setAttribute("class", "breadcrumb");
			crumb.innerHTML = crumbs[i];
			node.appendChild(crumb);
		}
	}
	var counter = document.createElement("span");
	counter.setAttribute("id", "counter"); counter.setAttribute("class", "info");
	node.appendChild(counter);
	updateCounter();
}

function updateCounter() {
	var cur = (activeMenu.getCurItemNum() == null) ? 0 : (activeMenu.getCurItemNum() + 1);
	document.getElementById("counter").innerHTML = "("+cur+"/"+activeMenu.count()+")";
}

function openACMenu(name) {
	var header = document.createElement("h1");
	var breadcrumbs = document.createElement("div");
	
	header.setAttribute("id", "mhdr");
	breadcrumbs.setAttribute("id", "bcs");
	breadcrumbs.setAttribute("class", "breadcrumbs");

	CPHandler = new ACCPHandler();
	if (typeof(name) == "string")
		header.innerHTML = name;
	breadcrumbs.innerHTML = "Main";
	menuDoc.appendChild(header);
	menuDoc.appendChild(breadcrumbs);
	menuDoc.style.display = "block";
}

function closeACMenu() {
	menus = [];
	items = [];
	CPHandler = {};
	activeMenu = null;
	menuDoc.innerHTML =  "";
	menuDoc.style.display = "none";
	CP.style.visibility = "hidden";
}

function createACMenu(name = "Main", parent = null) {
	menus[menus.length] = new ACMenu(menus.length, name, parent);
	if (typeof(parent) == "number")
		menus[menus.length-1].parent = menus[parent];
}

function addACItem(parent = 0, lText = "Main menu", act = 0, _class = "folder", rText = "", cat = "folder", prev = false) {
	if (typeof(parent) != "number") return;
	items[items.length] = new ACItem(lText, act, _class, rText, cat, prev);
	menus[parent].addMenuItem(items[items.length-1]);
}

function docKeyPressed(cb) {
	if (cb.keyCode == 13) {
		$.post("http://lscustoms_vrp2/removeNUIFocus");
		var RGB = CPHandler.getRGB();
		CPHandler.removeMouseTracking();
		CP.style.visibility = "hidden";
		if (activeMenu && activeMenu.getCurItem()) {
			activeMenu.getCurItem().action = RGB;
			activeMenu.getCurItem().select();
			activeMenu.getCurItem().action = "getCustomColour";
		}
	} else if (cb.keyCode == 8) {
		$.post("http://lscustoms_vrp2/removeNUIFocus");
		CPHandler.removeMouseTracking();
		CP.style.visibility = "hidden";		
	}
}

function showInfoText(text) {
	infTxt.innerHTML = text;
	infTxt.style.bottom = "";
	infTxt.style.opacity = 1;	
}

function hideInfoText() {
	infTxt.style.opacity = 0;	
	infTxt.style.bottom = "-100%";
}

window.addEventListener("load", function() {
	infTxt = document.getElementById("infTxt");
	menuDoc = document.getElementById("menu");
	CP = document.getElementById("CP");

	CP.style.visibility = "hidden";
	menuDoc.style.display = "none";
	infTxt.style.bottom = "-100%";
	infTxt.style.opacity = 0;

	window.addEventListener("message", function(e) {
		if (e.data.command == "createACMenu" && e.data.name) {
			createACMenu(e.data.name, e.data.parent);
		}
		else if (e.data.command == "setActiveACMenu" && typeof(e.data.num) == "number") {
			setActiveMenu(menus[e.data.num]);
		}
		else if (e.data.command == "removeACItem") {
			if (!menus[e.data.par]) return
			var i = menus[e.data.par].count()-1;
			for (; (i > 0) && (menus[e.data.par].getItem(i).action != e.data.num); i--);
			menus[e.data.par].removeMenuItem(i);
		}
		else if (e.data.command == "openACMenu") {
			openACMenu(e.data.name);
		}
		else if (e.data.command == "addACItem" && e.data.params) {
			var p = e.data.params;
			addACItem(p.par, p.lText, p.act, p._class, p.rText, p.cat, p.prev);
		}
		else if (e.data.command == "setTotalPrice") {
			for (var i = 0; i < items.length; i++)
				if (items[i].action == "install") {
					items[i].setExtra(	typeof(e.data.price) == "number" ? "price" : "info",
										e.data.price
					);}
		}
		else if (e.data.command == "hideACMenu") {
			menuDoc.style.display = "none";
		}
		else if (e.data.command == "showACMenu") {
			menuDoc.style.display = "block";
		}
		else if (e.data.command == "showInfoText") {
			showInfoText(e.data.text);
		}
		else if (e.data.command == "hideInfoText") {
			hideInfoText();
		}
		else if (activeMenu){
			if (e.data.command == "nextACItem") {
				activeMenu.setNextCurrentItem();
			}
			else if (e.data.command == "prevACItem") {
				activeMenu.setPreviousCurrentItem();
			}
			else if (e.data.command == "selectACItem") {
				if (activeMenu && activeMenu.getCurItem())
					activeMenu.getCurItem().select();
			}
			else if (e.data.command == "removeCurACItem") {
				activeMenu.removeMenuItem(activeMenu.getCurItemNum());
			}
			else if (e.data.command == "setRGB") {
				CPHandler.setRGB(e.data.R, e.data.G, e.data.B)
			}
			else if (e.data.command == "goBackAC") {
				if (activeMenu.parent) {
					setActiveMenu(activeMenu.parent);
					var i = menus.length-1;
					for (; (i > 0) && (activeMenu != menus[i]); i--);
					$.post("http://lscustoms_vrp2/goBack", JSON.stringify({
						num: i,
						command: "back",
					}));
				} else {
					$.post("http://lscustoms_vrp2/goBack", JSON.stringify({
						command: "exit",
					}));
				}
			}
			else if (e.data.command == "closeACMenu") {
				closeACMenu();
			}
		}
		updateBreadcrumbs();
	})
})
