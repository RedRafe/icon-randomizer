local lib = require("lib")

local seed = settings.startup["seed"].value
local shuffleTabs = settings.startup["random-tabs"].value

-- set env seed
--math.randomseed(seed)
log(#data.raw.recipe)
lib.shuffleIcons(data.raw.recipe)
lib.shuffleIcons(data.raw.item)
lib.shuffleIcons(data.raw.technology)
lib.shuffleIcons(data.raw.ammo)
lib.shuffleIcons(data.raw.armor)
lib.shuffleIcons(data.raw.tool)
lib.shuffleIcons(data.raw.gun)
lib.shuffleIcons(data.raw.projectile)
lib.shuffleIcons(data.raw.fluid)
lib.shuffleIcons(data.raw.module)
lib.shuffleIcons(data.raw.capsule)

if shuffleTabs then
  -- A. create groups
  for i = 1, 25 do
    local letter = string.char(i + string.byte("a"))
    data:extend{(
      {
        type = "item-subgroup",
        name = letter,
        group = "logistics",
        order = letter
      }
    )}
  end
  -- B. remove other tabs
  --for i, group in pairs(data.raw["item-group"]) do
  --  if data.raw[i].name ~= "logistics" then data.raw[i] = nil end
  --end
  -- C. shuffle recipe/items meta
  for _, elem in pairs(data.raw.recipe) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.item) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.ammo) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.armor) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.tool) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.gun) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw['repair-tool']) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.projectile) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.fluid) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.module) do
    lib.shuffleTab(elem)
  end
  for _, elem in pairs(data.raw.capsule) do
    lib.shuffleTab(elem)
  end
end