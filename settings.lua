data:extend(
{
	-- A
   {
      name = "seed",
      type = "int-setting",
      setting_type = "startup",
      default_value = 113,
      order = "a[modifier]-a[seed]",
      minimum_value = 1,
      maximum_value = 1000000
   },
	-- B
   {
      name = "random-tabs",
      type = "bool-setting",
      setting_type = "startup",
      default_value = true,
      order = "b[modifier]-b[random-tabs]"
   },
})
