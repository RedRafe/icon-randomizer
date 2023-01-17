local lib = {}

------------

local function shuffleTable(tbl)
	local size = #tbl
		for i = size, 1, -1 do
			local rand = math.random(size)
			tbl[i], tbl[rand] = tbl[rand], tbl[i]
		end
	return tbl
end

local function iconIntegrity(tbl)
	return ((tbl.icon ~= nil) and (tbl.icon_size ~= nil) and (tbl.icon_mipmaps ~= nil))
end

local function shuffleIcons(tbl)
	-- Save keys
	local keys = {}
	for i, _ in pairs(tbl) do
		table.insert(keys, i)
	end
	-- shuffle
	local size = #keys
	for i = size, 1, -1 do
		local r = math.random(size)
		local a = keys[i]
		local b = keys[r]

		if iconIntegrity(tbl[a]) and iconIntegrity(tbl[b]) then
			keys[i], keys[r] = keys[r], keys[i]
			tbl[a].icon, tbl[b].icon = tbl[b].icon, tbl[a].icon
			tbl[a].icon_size, tbl[b].icon_size = tbl[b].icon_size, tbl[a].icon_size
			tbl[a].icon_mipmaps, tbl[b].icon_mipmaps = tbl[b].icon_mipmaps, tbl[a].icon_mipmaps
		else
			log("Icon integrity not guaranteed for " .. tbl[a].name .. " and " .. tbl[b].name)
		end
	end
end

local function shuffleTab(tbl)
	-- 26 letters, random between 1 and N (both inclusive), so rnd(26) + 'a' - 1 = rand(25) + 'a'
	local order = string.char(math.random(25) + string.byte("a"))
	local subgroup = string.char(math.random(25) + string.byte("a"))
	if tbl.order ~= nil then tbl.order = order end
	if tbl.subgroup ~= nil then tbl.subgroup = subgroup end
end 

------------

lib.shuffleIcons = shuffleIcons
lib.shuffleTab = shuffleTab

return lib