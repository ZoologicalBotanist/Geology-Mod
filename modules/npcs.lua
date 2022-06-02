function log(group, msg)
  api_log(group, msg)
end

-- This is a placeholder file.
function define_npc()

  local npc_def = {
    id = 70,
    name = "Sanderson",
    pronouns = "It/Its",
    tooltip = "*Click*",
    shop = true,
    walking = false,
    stock = {"bee:mineralbee", "bee:magmabee", "bee:sandstonebee", "bee:obsidianbee"}, -- max 10
    specials = {"bee:mineralbee", "log", "log"}, -- must be 3
    dialogue = {
      "*Click?*",
      "*Click-click!*"
    },
    greeting = "*Click!*"
  }

  local res = api_define_npc(npc_def,
    "sprites/npc_standing.png",
    "sprites/npc_standing_h.png",
    "sprites/npc_walking.png",
    "sprites/npc_walking_h.png",
    "sprites/npc_head.png",
    "sprites/npc_bust.png",
    "sprites/npc_item.png",
    "sprites/npc_dialogue_menu.png",
    "sprites/npc_shop_menu.png"
  )
  api_log("NPC defined", res)

end