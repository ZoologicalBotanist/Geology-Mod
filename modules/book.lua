function log(group, msg)
  api_log(group, msg)
end

function define_book()
  local book_def = {
    id = "geology_book_item",
    name = "Geology Guidebook",
    category = "Books",
    tooltip = "Right-click to open!",
    shop_key = true,
    shop_buy = 10,
    shop_sell = 0,
    singular = true
  }

  local res = api_define_item(book_def, "sprites/book_item.png")
  api_log("Book defined", res)


  local book_menu = {
    id = "geology_book",
    name = "Geology Guidebook",
    category = "Books",
    tooltip = "An ancient guidebook on geology, obtained from an equally ancient automaton.",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    center = true,
    invisible = true,
    layout = {},
    buttons = {"Move", "Close"},
    info = {},
    tools = {"mouse1", "hammer1"},
    placeable = true
  } 
  
  local res = api_define_menu_object(book_menu, "sprites/book_item.png", "sprites/book_menu.png", {
    define = "book_define", -- defined below as a function
    draw = "book_draw" -- defined below as a function
  })
  api_log("Book Menu defined", res)

  -- finally, this will add our book to the library bar on the bottom
  local res = api_library_add_book("geology_book", "book_open", "sprites/book_button.png")
  api_log("Book added to library", res)
end


-- function called when clicking the library book button
function book_open()
  api_toggle_menu(MY_BOOK_MENU, true)
end


-- define the book
function book_define(menu_id) 
  -- set the menu object to immortal so it's never deactivated
  obj_id = api_get_menus_obj(menu_id)
  immortal = api_set_immortal(obj_id, true)
  -- set to global for later
  MY_BOOK_MENU = menu_id
  MY_BOOK_OBJ = obj_id
end

function book_draw(menu_id)

  -- draw something on top!
  menu = api_get_inst(menu_id)
  cam = api_get_cam()
  mx = menu["x"] - cam["x"]
  my = menu["y"] - cam["y"]

  -- draw the menu
  api_draw_sprite(menu["sprite_index"], 0, mx, my)

  -- draw some text
  api_draw_text(mx + 6, my + 4, "This is a test geology \nbook! Eventually there \nwill be many pages \ndetailing minerals \ndiscovered via mineral \nbees.", false, "FONT_BOOK")

end