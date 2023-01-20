local lib = {}

------------

function contains(tbl, element)
  for _, value in pairs(tbl) do
    if value == element then
      return true
    end
  end
  return false
end

local function shuffleTable(tbl, seed)
	local size = #tbl
		for i = size, 1, -1 do
			local rand = ((math.random(size) + seed) % size) + 1
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

local function shuffleTab(tbl, seed)
	-- 26 letters, random between 1 and N (both inclusive), so rnd(26) + 'a' - 1 = rand(25) + 'a'
	local order = string.char(math.random(25) + string.byte("a"))
	local subgroup = string.char(math.random(25) + string.byte("a"))
	if tbl.order ~= nil then tbl.order = order end
	if tbl.subgroup ~= nil then tbl.subgroup = subgroup end
end 

local function getInfo(tbl, group)
	return {
		source = group,
		name = tbl.name,
		icon = tbl.icon,
		icon_size = tbl.icon_size,
		icon_mipmaps = tbl.icon_mipmaps
	}
end

local function createTableFromKeys(groups, blacklist)
	local keys = {}
	for _, group in pairs(groups) do
		for k, v in pairs(data.raw[group]) do
			if (not contains(blacklist, v.name)) and iconIntegrity(v) then
				table.insert(keys, getInfo(v, group))
			end
		end
	end
	return keys
end

local function shuffleRaw(groups, blacklist, shuffleTabs, seed)
	local keys = createTableFromKeys(groups, blacklist)
	local shuffled = shuffleTable(table.deepcopy(keys), seed)
	for i, k in pairs(keys) do
		s = shuffled[i]
		elem = data.raw[k.source][k.name]
		elem.icon = s.icon
		elem.icon_size = s.icon_size
		elem.icon_mipmaps = s.icon_mipmaps
	end
end

local function shuffleOrder(groups, blacklist, seed)
	for _, group in pairs(groups) do
    for _, item in pairs(data.raw[group]) do
      if (not contains(blacklist, item.name)) then
				shuffleTab(item, seed)
			end
    end
  end
end

local function shuffleResource(resourceTable, seed)
	local pictureTable = {}
	-- save all ore variations
	for _, res in pairs(resourceTable) do
		table.insert(pictureTable, data.raw.item[res].pictures[1])
		table.insert(pictureTable, data.raw.item[res].pictures[2])
		table.insert(pictureTable, data.raw.item[res].pictures[3])
		table.insert(pictureTable, data.raw.item[res].pictures[4])
	end
	-- shuffle variations
	local shuffled = shuffleTable(table.deepcopy(pictureTable), seed)
	--log("size of table is " .. tostring(#shuffled))
	local i = 1
	-- assign variations
	for _, res in pairs(resourceTable) do
		data.raw.item[res].pictures = {
			shuffled[i],
			shuffled[i+1],
			shuffled[i+2],
			shuffled[i+3]
		}
		i = i + 4
	end
end

------------

--lib.shuffleIcons = shuffleIcons
--lib.shuffleTab = shuffleTab
lib.raw = shuffleRaw
lib.order = shuffleOrder
lib.resource = shuffleResource

------------

return lib