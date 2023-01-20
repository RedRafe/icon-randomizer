local shuffle = require("lib")

local seed = settings.startup["seed"].value
local shuffleTabs = settings.startup["random-tabs"].value

-- setting env seed is useless in datastage
-- math.randomseed(seed)

local itemGroups = {
  "ammo",
  "armor",
  "artillery-wagon",
  "capsule",
  "car",
  "cargo-wagon",
  "fluid",
  "fluid-wagon",
  "gun",
  "item",
  "locomotive",
  "module",
  "projectile",
  "repair-tool",
  "tool",
  "resource",
  "spider-vehicle",
  "spidertron-remote",
  "straight-rail",
  "item-entity"
}

local resourceGroup = {
  "iron-ore",
  "copper-ore",
  "uranium-ore",
  "stone",
  "coal"
}

local blacklist = {
  "heat-interface",
  "infinity-chest",
  "infinity-pipe",
  "blueprint",
  "blueprint-book",
  "coin",
  "linked-belt",
  "linked-chest",
  "linked-container",
  "loader",
  "express-loader",
  "fast-loader",
  "loader-1x1",
  "player-port",
  "electric-energy-interface",
  "selection-tool",
  "item-with-inventory",
  "item-with-label",
  "item-with-tags",
  "simple-entity-with-force",
  "simple-entity-with-owner",
  "burner-generator",
  "spidertron-rocket-launcher-1",
  "spidertron-rocket-launcher-2",
  "spidertron-rocket-launcher-3",
  "spidertron-rocket-launcher-4",
  "vehicle-machine-gun",
  "tank-machine-gun",
  "tank-cannon",
  "tank-flamethrower",
  "artillery-wagon-cannon",
  "cut-paste-tool",
  "copy-paste-tool",
  "deconstruction-planner",
  "upgrade-planner",
  "curved-rail"
}

--log("--- ITEMS ---")
shuffle.raw(itemGroups, blacklist, shuffleTabs, seed)
--log("--- TECHS ---")
shuffle.raw({"technology"}, blacklist, shuffleTabs, seed)
--log("--- RECIPES ---")
shuffle.raw({"recipe"}, blacklist, shuffleTabs, seed)
--log("--- RESOURCES ---")
shuffle.resource(resourceGroup, seed)


if shuffleTabs then
  -- create item sub-groups
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
  -- re-assign sub-groups
  shuffle.order(itemGroups, blacklist, seed)
  shuffle.order({"technology"}, blacklist, seed)
  shuffle.order({"recipe"}, blacklist, seed)
end