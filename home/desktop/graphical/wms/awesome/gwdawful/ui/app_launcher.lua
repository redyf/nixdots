--------------------------
-- application launcher --
--------------------------

-- Imports
----------
local awful         = require('awful')
local beautiful     = require('beautiful')
local dpi           = beautiful.xresources.apply_dpi

local helpers       = require('helpers')
local bling         = require('modules.bling')

local item_height   = beautiful.scaling * 6
local item_width    = item_height * 4

-- Launcher
-----------
local app_launcher  = bling.widget.app_launcher({

    -- Settings
    terminal            = terminal,
    select_before_spawn = true,
    save_history        = false,
    app_show_name       = true,
    app_show_icon       = false,
    skip_empty_icons    = false,

    -- Fonts
    prompt_icon         = "",
    prompt_icon_font    = ic_font,
    prompt_font         = ui_font,
    prompt_text         = "",
    app_name_halign     = "left",
    app_name_font       = ui_font,

    -- Geometry
    apps_per_row        = 6,
    apps_per_column     = 2,
    apps_spacing        = dpi(beautiful.item_spacing),
    app_width           = dpi(item_width),
    app_height          = dpi(item_height),
    app_content_padding = dpi(beautiful.giga_padding),
    prompt_height       = dpi(item_height),
    prompt_paddings     = dpi(beautiful.giga_padding),
    border_width        = beautiful.border_width,
    shape               = helpers.mkroundedrect(),
    prompt_shape        = helpers.mkroundedrect(),
    app_shape           = helpers.mkroundedrect(),
    
    -- Colors
    background               = beautiful.nbg,
    border_color             = beautiful.border_color_active,
    prompt_color             = beautiful.lbg,
    prompt_icon_color        = beautiful.wht,
    prompt_text_color        = beautiful.wht,
    prompt_cursor_color      = beautiful.wht,
    app_normal_color         = beautiful.nbg,
    app_normal_hover_color   = beautiful.lbg,
    app_selected_color       = beautiful.lbg,
    app_selected_hover_color = beautiful.blk,
    app_name_normal_color    = beautiful.dfg,
    app_name_selected_color  = beautiful.nfg
})

return app_launcher
