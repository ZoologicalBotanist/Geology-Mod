function log(group, msg)
  api_log(group, msg)
end


-- Defines items
function define_item()
  -- Beekeeping Produce
  local magcomb_def = {
    id = "magcomb",
    name = "Magma Comb Fragment",
    category = "Beekeeping",
    tooltip = "A fragment of magma-filled honeycomb. It is not recommended that you eat it. Perhaps it can be used to craft things...",
    shop_buy = 10,
    shop_sell = 3,
  }
  local res = api_define_item(magcomb_def, "sprites/magcomb.png")
  api_log("Magma Comb Fragment define", res)

  local sand_def = {
    id = "sand",
    name = "Sand",
    category = "Resource",
    tooltip = "The sand left behind by the excavating of sandstone bees.",
    shop_buy = 5,
    shop_sell = 1,
  }
  local res = api_define_item(sand_def, "sprites/sand.png")
  api_log("Sand define", res)

  local obsidian_def = {
    id = "obsidian",
    name = "Obsidian",
    category = "Resource",
    tooltip = "The shards of cooled magma produced by obsidian bees.",
    shop_buy = 5,
    shop_sell = 1,
  }
  local res = api_define_item(obsidian_def, "sprites/obsidian.png")
  api_log("Obsidian define", res)

  local fake_rock_def = {
    id = "fake_rock",
    name = "Fake Rock",
    category = "Construction",
    tooltip = "A fake rock",
    placeable = true,
    obj = "fake_rock"
  }
  local res = api_define_item(fake_rock_def, "sprites/fakerock.png")
  api_log("Fake Rock define", res)

  local glass_def = {
    id = "glass",
    name = "Glass",
    category = "Resource",
    tooltip = "The result of cooled molten sand. Can be used to craft things.",
    shop_buy = 5,
    shop_sell = 1,
  }
  
  local recipe = {
    { item = "geology_sand", amount = 3 },
    { item = "geology_magcomb", amount = 1 }
  }

  local res = api_define_item(glass_def, "sprites/glass.png")
  api_log("Glass define", res)
  res = api_define_recipe("crafting", MOD_NAME .. "_glass", recipe, 1)
  api_log("Glass recipe define", res)

  -- Obsidian Tool Set 
  api_define_item({
    id = "obsidian_axe",
    name = "Cool Axe",
    category = "Decoration",
    tooltip = "This is a cool axe!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    durability = 50,
    singular = true
  }, "sprites/obsidian_axe.png")
  -- add the item to the workbench as a recipe
  recipe = {
    { item = "log", amount = 10 },
    { item = "waterproof", amount = 20 },
    { item = "glue", amount = 5 }
  }
  res = api_define_recipe("tools", MOD_NAME .. "_obsidian_axe", recipe, 1)

end