opacity = 1
images = {}

function drawKeyItems() 
	keyItems = { "lute", "key", "rod", "oxyale", "chime", "cube" }

	goMode = true
	for i,name in ipairs(keyItems) do
		-- print (trackerValues[name] == nil)
		if trackerValues[name] == nil or trackerValues[name] == false then
			goMode = false
		end
	end

	if goMode then
		drawGo()
		return
	end

	for i,name in ipairs(keyItems) do
		if trackerValues[name] then
			gui.gdoverlay(14*i-8, 0, images["images/"..name..".gd"], opacity) 
		end
	end
end

function drawFetchItems() 
	keyItems = { {"ruby", "titan"}, {"crystal", "matoya"}, {"tail", "bahamut"}, {"bottle","bottlePopped"}, {"crown","astos"}, {"adamant","smith"}, {"tnt","nerrick"}, {"herb","eflPrince"}, {"slab","lefeien"}}

	y = 0
	for i,v in ipairs(keyItems) do
		if trackerValues[v[1]] and not trackerValues[v[2]] then 
			gui.gdoverlay(1, 240-14-8-14*y, images["images/"..v[1]..".gd"], opacity) 
			y = y+1
		end
	end	
end

function drawOrbs() 
	-- Or shards if we're sharding
	gui.box(2, 15, 5, 18, "grey", "grey")
	gui.box(2, 20, 5, 23, "grey", "grey")
	gui.box(2, 25, 5, 28, "grey", "grey")
	gui.box(2, 30, 5, 33, "grey", "grey")

	if trackerValues["earthorb"] then
		gui.box(2, 15, 5, 18, "green", "green")
	elseif trackerValues["fireorb"] then
		gui.box(2, 20, 5, 23, "red", "red")
	elseif trackerValues["waterorb"] then
		gui.box(2, 25, 5, 28, "blue", "blue")
	elseif trackerValues["airorb"] then
		gui.box(2, 30, 5, 33, "cyan", "cyan")
	end
end

function drawTransportation() 
	-- Just one icon... or two?
end


function drawItems() 
	gui.box(0, 0, 256, 8, "black", "black")

	drawKeyItems()
	drawFetchItems()
	drawOrbs()
	-- drawTransportation()
end


GoFile = io.open("images/Go.gd", "r")
GoImg = GoFile:read("*all")
io.close(GoFile)

frame = 1
speed = 4

function drawGo()
	currentframe = math.floor(frame / speed)

	gui.gdoverlay(1, 1, GoImg, currentframe%4*32, math.floor(currentframe/4)*32, 32, 32) 

	frame = frame + 1
	if (frame / speed > 12) then
		frame = 0
	end
end



function loadImages()
	local p = io.popen('find "'.. "images" ..'" -type f')  --Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all files.     
	for file in p:lines() do                         --Loop through all files
		img = io.open(file, "r")
		images[file] = img:read("*all")
		io.close(img)
	end
end

loadImages()