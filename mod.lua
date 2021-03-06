
MOD_NAME = "geology"

MY_BOOK_MENU = nil
MY_BOOK_OBJ = nil

function register()

  return {
    name = MOD_NAME,
    hooks = {"ready", "click", "gui"},
    modules = {"items", "bees", "npcs", "book"}
  }
end

function init() 

  api_set_devmode(true)
  log("init", "Hello World!")

  local res = define_item()
  api_log("Items defined", res)

  local res = define_bee()
  api_log("Bees defined", res)

  local res = define_book()
  api_log("Book defined", res)

  local res = define_npc()
  api_log("NPCs defined", res)

  return "Success"

end

function ready()

  -- if we haven't already spawned our new npc, spawn them
  friend = api_get_menu_objects(nil, "npc70")
  if #friend == 0 then
    player = api_get_player_position()
    api_create_obj("npc70", player["x"] + 16, player["y"] - 32)
  end

  existing = api_get_menu_objects(nil, "geology_geology_book")
  if #existing == 0 then
    api_create_obj("geology_geology_book", -32, -32)
  end

  fake_rock_number = api_get_menu_objects(nil, "geology_fake_rock")
  if #fake_rock_number == 0 then
    player = api_get_player_position()
    center = api_get_inst_in_circle("tree", player["x"], player["y"], 40)
    random = api_choose(center)
    ground = api_get_ground(random["x"], random["y"])
    if ground == "grass1" or ground == "grass2" or ground == "grass3" or ground == "grass4" then
      api_create_obj("geology_fake_rock", random["x"], random["y"])
    end
  end
  
  -- play a sound to celebrate our mod loading! :D
  api_play_sound("confetti")


end

function data(ev, data)

  if (ev == "LOAD" and data ~= nil) then
    name = api_gp(api_get_player_instance(), "name")
    if data["players"][name] == nil then
      api_log("data", "First time!")
      data["players"][name] = true
      api_set_data(data)
    else
      api_log("data", "Loaded before.")
    end

  end

  if (ev == "SAVE" and data ~= nil) then
    return
  end

end

function gui()

  -- draw book if open
  if api_gp(MY_BOOK_OBJ, "open") == true then
    -- get screen pos
    game = api_get_game_size()
    cam = api_get_cam()
    -- draw black rectangle at 0.9 alpha over entire screen
    api_draw_rectangle(0, 0, game["width"], game["height"], "BLACK", false, 0.9)
    -- redraw menu on gui layer
    book_draw(MY_BOOK_MENU)
  end

end


-- click is called whenever the player clicks
-- https://wiki.apico.buzz/wiki/Modding_API#click()
function click(button, click_type)

  if button == "LEFT" and click_type == "PRESSED" then
    api_log("debug", "clicked")
    highlighted = api_get_highlighted("obj")
      if highlighted ~= nil then
       api_log("debug", "clicked on highlighted")
      inst = api_get_inst(highlighted)
        if inst["oid"] == "stone" then
          api_log("debug", "highlighted is a stone, starting timer")
              api_create_timer("giver", 0.1)
        else
          api_log("debug", "clicked on something that isn't a stone. nothing happens")
        end
        else
          api_log("debug", "clicked on nothing. nothing happens")
        end
      end
    end



  function giver()
    tree_checker = api_get_highlighted("obj")
    api_log("debug", "timer finished, checking for destroyed stone")
    if tree_checker == nil then
      api_log("debug", "nothing highlighted. testing your luck")
        chance = api_random(1)
        if chance == 0 then
          api_log("debug", "lucky. have a bee")
          mouse_pos = api_get_mouse_position()
          stats = api_create_bee_stats("mineralbee", false)
          api_create_item("bee", 1, mouse_pos["x"], mouse_pos["y"], stats)
        else
          api_log("debug", "unlucky. nothing happens")
    end
  else
    api_log("debug", "you still have something highlighted. nothing happens")
  end
  
  -- check if we right click out book item to open the book
  if button == "RIGHT" and click_type == "PRESSED" then

    -- fake opening a book by opening our fake menu object when the book is right clicked in a slot
    highlighted = api_get_highlighted("slot")
    if highlighted ~= nil then
      slot = api_get_slot_inst(highlighted)
      if slot["item"] == "geology_geology_book_item" then
        api_toggle_menu(MY_BOOK_MENU, true)
      end
    end
  end

end
