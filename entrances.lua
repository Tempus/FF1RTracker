SavedEntrances = {
	Cardia1 = {},
	Coneria = {},
	Pravoka = {},
	Elfland = {},
	Melmond = {},
	CrescentLake = {},
	Gaia = {},
	Onrac = {},
	Lefein = {},
	ConeriaCastle1 = {},
	ElflandCastle = {},
	NorthwestCastle = {},
	CastleOrdeals1 = {},
	TempleOfFiends1 = {},
	EarthCave1 = {},
	GurguVolcano1 = {},
	IceCave1 = {},
	Cardia2 = {},
	BahamutCave1 = {},
	Waterfall = {},
	DwarfCave = {},
	MatoyasCave = {},
	SardasCave = {},
	MarshCave1 = {},
	MirageTower1 = {},
	TitansTunnelEast = {},
	TitansTunnelWest = {},
	Cardia4 = {},
	Cardia5 = {},
	Cardia6 = {}
}

last_EntranceID = 0;


function isEndDestination(cur_map)

	for i,finalMap in ipairs(FinalDestinations) do
		if DestinationMap[cur_map] == finalMap then
			return true
		end
	end

	return false
end


function saveOverworldOrigin()
	last_EntranceID = memory.getregister("a") + 1 -- Lua 1 indexing really sucks when working with binary
end

function markEntrances()
	cur_map = memory.readbyte(0x48) + 1
 
 	if isEndDestination(cur_map) then
		SavedEntrances[last_EntranceID][cur_map] = true
	end
end

memory.registerexec(0xC1EB, saveOverworldOrigin)
memory.registerexec(0xD12D, markEntrances)


function printEntrancesToMap()
	bank = memory.readbyte(0x57)
	if (bank ~= 0x9) then
		return
	end

	index = 1
	townIndex = 1

	for ow, inner in pairs(SavedEntrances) do
		if inner ~= {} then
			i = 0
			for endName,exists in pairs(inner) do
				if inner <= 8 then -- Town Endpoint, let's put it on the right side of the screen
					gui.text(128,8*townIndex+2, string.format("%-8s -> %8s", string.sub(OverworldLocations[ow],1,8), string.sub(DestinationMap[endName],1,8)))

					townIndex = townIndex + 1
				else
					if i == 0 then
						gui.text(1,8*index+2, string.format("%-8s -> %8s", string.sub(OverworldLocations[ow],1,8), string.sub(DestinationMap[endName],1,8)))
						i = i + 1
					else
						gui.text(1,8*index+2, string.format("%-8s -> %8s", " ", string.sub(DestinationMap[endName],1,8)))
					end
					index = index + 1
				end
			end
		end
	end
end

memory.registerexec(0xBCAB, printEntrancesToMap)


-- Info Tables

-- 0x2C40 + header
OverworldLocations = {
		"Cardia1",
		"Coneria",
		"Pravoka",
		"Elfland",
		"Melmond",
		"CrescentLake",
		"Gaia",
		"Onrac",
		"Lefein",
		"ConeriaCastle1",
		"ElflandCastle",
		"NorthwestCastle",
		"CastleOrdeals1",
		"TempleOfFiends1",
		"EarthCave1",
		"GurguVolcano1",
		"IceCave1",
		"Cardia2",
		"BahamutCave1",
		"Waterfall",
		"DwarfCave",
		"MatoyasCave",
		"SardasCave",
		"MarshCave1",
		"MirageTower1",
		"TitansTunnelEast",
		"TitansTunnelWest",
		"Cardia4",
		"Cardia5",
		"Cardia6" }

InnerMapLocations = {
		"ConeriaCastle2",
		"TempleOfFiends2",
		"MarshCaveTop",
		"MarshCave3",
		"MarshCaveBottom",
		"EarthCave2",
		"EarthCaveVampire",
		"EarthCave4",
		"EarthCaveLich",
		"GurguVolcano2",
		"GurguVolcano3",
		"GurguVolcano4",
		"GurguVolcano5",
		"GurguVolcano6",
		"GurguVolcanoKary",
		"IceCave2",
		"IceCave3",
		"IceCavePitRoom",
		"IceCave4",
		"IceCave5",
		"IceCave6",
		"IceCave7",
		"CastleOrdealsMaze",
		"CastleOrdealsTop",
		"CastleOrdealsBack",
		"BahamutsRoom",
		"CastleOrdeals4",
		"CastleOrdeals5",
		"CastleOrdeals6",
		"CastleOrdeals7",
		"CastleOrdeals8",
		"CastleOrdeals9",
		"SeaShrine1",
		"SeaShrine2",
		"SeaShrineMermaids",
		"SeaShrine4",
		"SeaShrine5",
		"SeaShrine6",
		"SeaShrine7",
		"SeaShrine8",
		"SeaShrineKraken",
		"MirageTower2",
		"MirageTower3",
		"SkyPalace1",
		"SkyPalace2",
		"SkyPalace3",
		"SkyPalaceMaze",
		"SkyPalaceTiamat",
		"TempleOfFiends3",
		"TempleOfFiends4",
		"TempleOfFiends5",
		"TempleOfFiends6",
		"TempleOfFiends7",
		"TempleOfFiends8",
		"TempleOfFiends9",
		"TempleOfFiends10",
		"TempleOfFiends11",
		"TempleOfFiends12",
		"CastleOrdeals10",
		"CastleOrdeals11",
		"CastleOrdeals12",
		"CastleOrdeals13",
		"ConeriaCastleBack",
		"RescuePrincess",
		"Overworld" }

-- 0x3F200 + header
DestinationMap = {
		"ConeriaTown",
		"Pravoka",
		"Elfland",
		"Melmond",
		"CrescentLake",
		"Gaia",
		"Onrac",
		"Lefein",
		"ConeriaCastle1F",
		"ElflandCastle",
		"NorthwestCastle",
		"CastleOrdeals1F",
		"TempleOfFiends",
		"EarthCaveB1",
		"GurguVolcanoB1",
		"IceCaveB1",
		"Cardia",
		"BahamutCaveB1",
		"Waterfall",
		"DwarfCave",
		"MatoyasCave",
		"SardasCave",
		"MarshCaveB1",
		"MirageTower1F",
		"ConeriaCastle2F",
		"CastleOrdeals2F",
		"CastleOrdeals3F",
		"MarshCaveB2",
		"MarshCaveB3",
		"EarthCaveB2",
		"EarthCaveB3",
		"EarthCaveB4",
		"EarthCaveB5",
		"GurguVolcanoB2",
		"GurguVolcanoB3",
		"GurguVolcanoB4",
		"GurguVolcanoB5",
		"IceCaveB2",
		"IceCaveB3",
		"BahamutCaveB2",
		"MirageTower2F",
		"MirageTower3F",
		"SeaShrineB5",
		"SeaShrineB4",
		"SeaShrineB3",
		"SeaShrineB2",
		"SeaShrineB1",
		"SkyPalace1F",
		"SkyPalace2F",
		"SkyPalace3F",
		"SkyPalace4F",
		"SkyPalace5F",
		"TempleOfFiends1F",
		"TempleOfFiends2F",
		"TempleOfFiends3F",
		"TempleOfFiendsEarth",
		"TempleOfFiendsFire",
		"TempleOfFiendsWater",
		"TempleOfFiendsAir",
		"TempleOfFiendsChaos",
		"TitansTunnel" }


FinalDestinations = {
		"ConeriaTown",
		"Pravoka",
		"Elfland",
		"Melmond",
		"CrescentLake",
		"Gaia",
		"Onrac",
		"Lefein",
		"ConeriaCastle1F",
		"ElflandCastle",
		"NorthwestCastle",
		"CastleOrdeals1F",
		"TempleOfFiends",
		"Cardia",
		"Waterfall",
		"DwarfCave",
		"MatoyasCave",
		"SardasCave",
		"MarshCaveB2",
		"MarshCaveB3",
		"EarthCaveB5",
		"GurguVolcanoB5",
		"IceCaveB2",
		"BahamutCaveB2",
		"MirageTower3F",
		"SeaShrineB1",
		"SkyPalace5F",
		"TitansTunnel" }


printTopLevelEntrances()