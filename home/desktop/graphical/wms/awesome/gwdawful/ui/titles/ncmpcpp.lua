-----------------------
-- custom ncmpcpp ui --
-----------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local ruled     = require('ruled')
local gears     = require('gears')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local playerctl = require('modules.bling').signal.playerctl.lib()

local player_size = beautiful.title_size * 2

-- Widgets
----------
-- Draggable progressbar
local is_prog_hovered = false
local song_prog = wibox.widget {
    bar_color        = beautiful.titlebar_bg_focus,
    bar_active_color = beautiful.cya,
    handle_color     = beautiful.cya_d,
    handle_shape     = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    handle_width     = dpi(beautiful.item_spacing),
    forced_height    = dpi(beautiful.item_spacing),
    minimum          = 0,
    widget           = wibox.widget.slider,
}
-- This implementation makes it so that the current song progress 
-- will only be updated when the user hovers the progressbar.
song_prog:connect_signal('mouse::enter', function()
    is_prog_hovered = true
end)
song_prog:connect_signal('mouse::leave', function()
    is_prog_hovered = false
end)
song_prog:connect_signal('property::value', function(_, value)
    if is_prog_hovered then
        playerctl:set_position(value)
    end
end)

-- Album cover art
local cover_art = wibox.widget {
    image      = helpers.crop_surface(1, gears.surface.load_uncached(beautiful.player_bg)),
    clip_shape = helpers.mkroundedrect(),
    resize     = true,
    align      = "center",
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit",
    widget     = wibox.widget.imagebox
}

-- Song title and artist
local function infoline(default, size, color)
    return wibox.widget {
        {
            {
                id     = 'text_role',
                markup = default,
                font   = beautiful.ui_font .. dpi(size),
                widget = wibox.widget.textbox
            },
            fg       = color,
            widget   = wibox.container.background
        },
        step_function = wibox.container.scroll.step_functions
                        .waiting_nonlinear_back_and_forth,
        speed  = 100,
        layout = wibox.container.scroll.horizontal,
        set_markup = function(self, content)
            self:get_children_by_id('text_role')[1].markup = content
        end
    }
end
local song_title  = infoline("<b>Nothing Playing</b>", beautiful.tiny_font_size, beautiful.nfg)
local song_artist = infoline("Unknown",                beautiful.tiny_font_size, beautiful.dfg)

-- Control buttons
local function ctrlbtn(icon, run)
    local ctrl_button = wibox.widget {
        {
            {
                id     = "text_role",
                text   = icon,
                font   = beautiful.ic_font .. dpi(beautiful.subt_font_size),
                widget = wibox.widget.textbox
            },
            margins = dpi(beautiful.item_spacing),
            widget  = wibox.container.margin
        },
        fg      = beautiful.nfg,
        bg      = beautiful.titlebar_bg_focus,
        shape   = helpers.mkroundedrect(),
        widget  = wibox.container.background,
        buttons = {
            awful.button({}, 1, run)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    helpers.add_hover(ctrl_button, beautiful.titlebar_bg_focus, beautiful.titlebar_fg_focus)
    return ctrl_button
end
local prev_btn = ctrlbtn("", function() playerctl:previous()          end)
local play_btn = ctrlbtn("", function() playerctl:play_pause()        end)
local next_btn = ctrlbtn("", function() playerctl:next()              end)
local shff_btn = ctrlbtn("", function() playerctl:cycle_shuffle()     end)
local loop_btn = ctrlbtn("", function() playerctl:cycle_loop_status() end)

-- Volume control
local is_vol_hovered = false
local vol_bar = wibox.widget {
    {
       {
           {
               text   = "",
               align  = "center",
               font   = beautiful.ic_font .. dpi(beautiful.subt_font_size),
               widget = wibox.widget.textbox
           },
           fg     = beautiful.grn,
           widget = wibox.container.background
       },
       {
           {
               id                  = 'slider_role',
               bar_shape           = helpers.mkroundedrect(),
               bar_color           = beautiful.gry,
               bar_active_color    = beautiful.grn,
               handle_color        = beautiful.grn,
               handle_shape        = helpers.mkroundedrect(),
               minimum             = 0,
               maximum             = 100,
               handle_width        = dpi(beautiful.item_spacing),
               bar_height          = dpi(beautiful.item_spacing),
               forced_height       = dpi(beautiful.base_font_size),
               forced_width        = dpi(beautiful.giga_padding * 3),
               widget              = wibox.widget.slider
           },
           top    = dpi(beautiful.item_padding),
           bottom = dpi(beautiful.item_padding),
           widget = wibox.container.margin
       },
       spacing = dpi(beautiful.tiny_font_size),
       layout  = wibox.layout.fixed.horizontal
    },
    left   = dpi(beautiful.title_font_size),
    right  = dpi(beautiful.title_font_size),
    widget = wibox.container.margin,
    get_slider = function(self)
        return self:get_children_by_id('slider_role')[1]
    end,
    set_value  = function(self, val)
        self.slider.value = val * 100
    end
}
vol_bar.slider:connect_signal('property::value', function(_, value)
    playerctl:set_volume(value / 100)
end)
vol_bar:connect_signal('mouse::enter', function()
    is_vol_hovered = true
end)
vol_bar:connect_signal('mouse::leave', function()
    is_vol_hovered = false
end)

-- Decorations
--------------
local bottom = function(c)
    awful.titlebar(c, { position = "bottom", 
                        size     = dpi(player_size), 
                        bg       = beautiful.titlebar_bg_normal }):setup {
        song_prog,
        {
            {
                {
                    cover_art,
                    {
                        {
                            song_title,
                            song_artist,
                            layout = wibox.layout.fixed.vertical
                        },
                        valign = "center",
                        widget = wibox.container.place
                    },
                    spacing = dpi(beautiful.base_font_size),
                    layout  = wibox.layout.fixed.horizontal
                },
                {
                    {
                        prev_btn,
                        play_btn,
                        next_btn,
                        spacing = dpi(beautiful.item_spacing),
                        layout  = wibox.layout.fixed.horizontal
                    },
                    margins = dpi(beautiful.ring_size),
                    widget  = wibox.container.margin
                },
                {
                    {
                        vol_bar,
                        loop_btn,
                        shff_btn,
                        spacing = dpi(beautiful.item_spacing),
                        layout  = wibox.layout.fixed.horizontal
                    },
                    margins = dpi(beautiful.ring_size),
                    widget  = wibox.container.margin
                },
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(beautiful.base_font_size),
            widget  = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }
end

-- Signals
----------
-- Song progress.
playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if player_name == "mpd" and interval_sec > 0 then
        song_prog.maximum = length_sec
        song_prog.value   = interval_sec
    end
end)
-- Song cover, title and artist.
playerctl:connect_signal("metadata", function(_, title, artist, album_path, _, _, player_name)
    if player_name == "mpd" then
        song_title.markup  = title:match('%w')  and "<b>" .. title .. "</b>" or "<b>Nothing Playing</b>"
        song_artist.markup = artist:match('%w') and artist                   or "Unknown"
        cover_art.image    = album_path:match('/') and 
                             helpers.crop_surface(1, gears.surface.load_uncached(album_path))
                             or helpers.crop_surface(1, gears.surface.load_uncached(beautiful.player_bg))
    end
end)
-- Playback status
playerctl:connect_signal("playback_status", function(_, playing, player_name)
    if player_name == "mpd" then
        play_btn.text = playing and "" or ""
    end
end)
-- Shuffle and Loop status colors
playerctl:connect_signal("shuffle", function(_, shuffle)
        shff_btn.fg = shuffle and beautiful.ylw or beautiful.fg_normal
end)
playerctl:connect_signal("loop_status", function(_, loop_status)
    if loop_status:match('none') then
        loop_btn.fg = beautiful.nfg
    elseif loop_status:match('track') then
        loop_btn.fg = beautiful.ylw
    else
        loop_btn.fg = beautiful.grn
    end
end)
-- Volume level
playerctl:connect_signal("volume", function(_, volume, player_name)
    if player_name == "mpd" then
        vol_bar.value  = not is_vol_hovered and volume
    end
end)

-- Apply
--------
local ncmpcpp_ui = function(c)
    -- Bind custom titlebars
    bottom(c)

    -- Unbind default titlebar
    if beautiful.is_title_horizontal then
        awful.titlebar.hide(c, beautiful.title_side)
        awful.titlebar.show(c, "top")
    -- elseif (beautiful.title_side == "right") then
        -- sidebar(c)
    end

end

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule({
        id       = "music",
        rule     = terminal == "tym" and { role  = "ncmpcpp" } 
                   or { class = "ncmpcpp" }, 
        callback = ncmpcpp_ui
    })
end)
