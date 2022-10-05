trackerValues = {}
dirty = false

require("timer")
require("itemDrawer")
require("entrances")

function getItemStatus(name, address, activeValue)
	value = memory.readbyte(address)
	if value == activeValue then
		writeValue(name, value)
		return true
	else
		return false
	end
end

function getItemFlagStatus(name, address, activeBit, checkValue)
	value = memory.readbyte(address)
	if AND(value, activeBit) == checkValue then
		writeValue(name, value)
		return true
	else
		return false
	end
end

function writeValue(name, value)
	if not trackerValues[name] then
		if not dirty then
			file = io.open("tracker.txt", "w+")
		end
		dirty = true
	end

	trackerValues[name] = true

	if dirty then
		file:write(name, "\n")
	end
end

function checkItems()

	-- Key Items
    getItemStatus("lute", 0x6021, 1)
    getItemStatus("key", 0x6025, 1)
    getItemStatus("rod", 0x602A, 1)
    getItemStatus("chime", 0x602C, 1)
    getItemStatus("cube", 0x602E, 1)
    getItemStatus("oxyale", 0x6030, 1)

    -- Transport
    getItemStatus("ship", 0x6000, 1)
    getItemStatus("canoe", 0x6012 , 1)
    getItemStatus("bridge", 0x6008 , 1)

    getItemStatus("canal", 0x600C , 0)
    getItemStatus("floater", 0x602B , 1)
    getItemStatus("airship", 0x6004 , 1)


    -- Orbs
    getItemStatus("fireorb", 0x6032 , 1)
    getItemStatus("waterorb", 0x6033 , 1)
    getItemStatus("airorb", 0x6034 , 1)
    getItemStatus("earthorb", 0x6031 , 1)


    -- Fetch Items
    if not getItemFlagStatus("titan", 0x6214 , 1, 0) then
        getItemStatus("ruby", 0x6029 , 1)
    end

    if not getItemFlagStatus("lefein-slab", 0x620F , 2, 2) then
        if not getItemFlagStatus("unne-slab", 0x620B , 2, 2) then
    		getItemStatus("slab", 0x6028 , 1)
        end
    end


    if not getItemStatus("bahamut", 0x620E , 0) then 
    	getItemStatus("tail", 0x602D , 1)
    end
    
    if not getItemFlagStatus("bottlePopped", 0x6213 , 2, 2) then
        getItemStatus("bottle", 0x602F , 1)
    end

    if not getItemFlagStatus("astos", 0x6207 , 2, 2) then
        getItemStatus("crown", 0x6022 , 1)
    end

    if not getItemFlagStatus("smith", 0x6209 , 2, 2) then
        getItemStatus("adamant", 0x6027 , 1)
    end

    if not getItemFlagStatus("matoya", 0x620A , 2, 2) then
        getItemStatus("crystal", 0x6023 , 1)
    end

    if not getItemFlagStatus("elfPrince", 0x6205 , 2, 2) then
        getItemStatus("herb", 0x6024 , 1)
    end

    if not getItemFlagStatus("nerrick", 0x6208 , 2, 2) then
        getItemStatus("tnt", 0x6026 , 1)
    end
end


file = io.open("tracker.txt", "w+")	-- Guess we rewrite the entire file every frame, seems terrible. Really we should be check if there are differences and only writing then.
-- gdstr = gd.createFromPng("adamant.png"):gdStr()

while (true) do -- prevent script from exiting
	checkItems()
	drawItems()
	runTimer()

	-- Requires to run the game, lol
	FCEU.frameadvance()

	if dirty then 
		io.close(file)
		dirty = false
	end

end;