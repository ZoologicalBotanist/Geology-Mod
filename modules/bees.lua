function log(group, msg)
  api_log(group, msg)
end

function define_bee()
  -- Mineral Bee
  local mineral_bee_def = {
    id = "mineralbee",
    title = "Mineral",
    latin = "Apis Mineralis",
    hint = "These bees have been extinct in the wild for centuries, perhaps there is an ancient stone automaton that sells them...",
    desc = "This bee is the ancestor from which all other geological bees diverged.",
    lifespan = {"Normal"},
    productivity = {"Normal", "Fast"},
    fertility = {"Fecund", "Prolific"},
    stability = {"Normal", "Stable"},
    behaviour = {"Diurnal"},
    climate = {"Temperate"},
    rainlover = false,
    snowlover = false,
    grumpy = false,
    produce = "stone",
    calming = {"flower10", "flower11"},
    chance = 100,
    bid = "MI",
    requirement = "",
    shop_buy = 10
  }

  local res = api_define_bee(mineral_bee_def, 
    "sprites/mineral_bee_item.png", "sprites/mineral_bee_shiny.png", 
    "sprites/mineral_bee_hd.png",
    {r=180, g=180, b=180},
    "sprites/mineral_bee_mag.png",
    "Local Beekeeper Does It Again!",
    "Local APICO beekeeper restores the Mineral bee to its former glory!"
  )
  api_log("Mineral Bee defined", res)

  -- Magma Bee
  local magma_bee_def = {
    id = "magmabee",
    title = "Magma",
    latin = "Minerapis Magmus",
    hint = "The fiery cousin of mineral bees",
    desc = "Descended from mineral bees, these bees burn with the heat of molten rock. Even touching one can be painful without proper equipment.",
    lifespan = {"Rapid", "Short"},
    productivity = {"Normal", "Fast"},
    fertility = {"Fertile", "Fecund"},
    stability = {"Normal", "Unstable"},
    behaviour = {"Nocturnal"},
    climate = {"Any"},
    rainlover = true,
    snowlover = true,
    grumpy = true,
    produce = "geology_magcomb",
    calming = {"flower10"},
    chance = 100,
    bid = "IG",
    requirement = "",
    shop_buy = 15,
  }

  local res = api_define_bee(magma_bee_def, 
    "sprites/magma_bee_item.png", "sprites/magma_bee_shiny.png", 
    "sprites/magma_bee_hd.png",
    {r=238, g=70, b=25},
    "sprites/magma_bee_mag.png",
    "Magma Bees Bring The Heat!",
    "Things are starting to heat up around here! Thanks to a local APICO beekeeper, magma bees are erupting across the planet!"
  )
  api_log("Magma Bee defined", res)

  local res = api_define_bee_recipe("mineralbee", "fiery", "magmabee", "magma_bee_recipe")
  api_log("Magma Bee recipe defined", res)

  -- Sandstone Bee
  local sandstone_bee_def = {
    id = "sandstonebee",
    title = "Sandstone",
    latin = "Minerapis Sandpetris",
    hint = "Mineral bees laid to rest in water",
    desc = "Descended from mineral bees, these bees build their hives in sandstone outcroppings. One hive alone can produce an entire beach worth of sand.",
    lifespan = {"Long", "Ancient"},
    productivity = {"Slow", "Slowest"},
    fertility = {"Fecund", "Prolific"},
    stability = {"Normal", "Unstable"},
    behaviour = {"Crepuscular"},
    climate = {"Temperate"},
    rainlover = true,
    snowlover = false,
    grumpy = false,
    produce = "geology_sand",
    calming = {"flower10"},
    chance = 100,
    bid = "SA",
    requirement = "",
    shop_buy = 15
  }
  local res = api_define_bee(sandstone_bee_def, 
    "sprites/sandstone_bee_item.png", "sprites/sandstone_bee_shiny.png", 
    "sprites/sandstone_bee_hd.png",
    {r=212, g=154, b=89},
    "sprites/sandstone_bee_mag.png",
    "A Bucket Full Of Sand!",
    "Buckets of sand are everywhere now thanks to the sandstone bee, brought back at the hands of local APICO beekeeper!"
  )
  api_log("Sandstone Bee defined", res)

  local res = api_define_bee_recipe("mineralbee", "verge", "sandstonebee", "sandstone_bee_recipe")
  api_log("Sandstone Bee recipe defined", res)

-- Obsidian Bee
  local obsidian_bee_def = {
    id = "obsidianbee",
    title = "Obsidian",
    latin = "Minerapis Obsidainus",
    hint = "Sometimes, magma bees dunked in water will cool and become these bees.",
    desc = "Obsidian bees are the result of magma bees cooling in water. The magma they produce is no longer able to keep its temperature, and instead hardens into a stone.",
    lifespan = {"Long", "Ancient"},
    productivity = {"Normal", "Fast"},
    fertility = {"Fecund", "Prolific"},
    stability = {"Normal", "Stable"},
    behaviour = {"Crepiscular"},
    climate = {"Temperate"},
    rainlover = true,
    snowlover = false,
    grumpy = false,
    produce = "stone",
    calming = {"flower10", "flower11"},
    chance = 100,
    bid = "OB",
    requirement = "",
    shop_buy = 15}
  
  local res = api_define_bee(obsidian_bee_def, 
    "sprites/obsidian_bee_item.png", "sprites/obsidian_bee_shiny.png", 
    "sprites/obsidian_bee_hd.png",
    {r=56, g=15, b=82},
    "sprites/obsidian_bee_mag.png",
    "A Happy Accident!",
    "Local APICO beekeeper drops magma bee in water, discovers new species!"
  )
  api_log("Obsidian Bee defined", res)
end

function magma_bee_recipe()
  -- mineral-fiery 30% chance to mutate
  if (bee_a == "mineralbee" and bee_b == "fiery") or (bee_a == "fiery" and bee_b == "mineralbee") then
    chance = api_random(99) + 1
    if chance <= 30 then
      return true
    end
  end
  return false;
end

function sandstone_bee_recipe()
  -- mineral-verge 30% chance to mutate during the night at rain
  if (bee_a == "mineralbee" and bee_b == "verge") or (bee_a == "verge" and bee_b == "mineralbee") then
    time = api_get_time()
    weather = api_get_weather()
    chance = api_random(99) + 1
    if chance <= 30 and time <= "Night" and weather <= "Rain" then
      return true
    end
  end
  return false;
end

function obsidian_bee_recipe()
  -- mineral-verge 30% chance to mutate during the night at rain
  if (bee_a == "magmabee" and bee_b == "frosty") or (bee_a == "frosty" and bee_b == "magmabee") then
    chance = api_random(99) + 1
    if chance <= 30 then
      return true
    end
  end
  return false;
end