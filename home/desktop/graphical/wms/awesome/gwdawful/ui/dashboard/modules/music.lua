-----------------------------
-- dashboard: music player --
-----------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local scratch   = require('config.scratchpad')
local playerctl = require('modules.bling').signal.playerctl.lib()

-- Widgets
----------
local album_art = wibox.widget {
    image       = helpers.crop_surface(1.5, gears.surface.load_uncached(beautiful.player_bg)),
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit",
    resize      = true,
    opacity     = 0.33,
    align       = "center",
    clip_shape  = helpers.mkroundedrect(),
    widget      = wibox.widget.imagebox
}

local function sng_info(size, color, placeholder)
    return wibox.widget {
        {
            id     = 'text_role',
            markup = placeholder,
            font   = beautiful.ui_font .. dpi(size),
            widget = wibox.widget.textbox
        },
        fg     = color,
        widget = wibox.container.background,
        set_markup = function(self, content)
            self:get_children_by_id('text_role')[1].markup = content
        end
    }
end
local sng_title  = sng_info(beautiful.title_font_size, beautiful.fg_normal, "<b>Nothing Playing</b>")
local sng_artist = sng_info(beautiful.subt_font_size,  beautiful.dfg,       "By Unknown")
local sng_album  = sng_info(beautiful.subt_font_size,  beautiful.dfg,       "On <i>Unknown</i>")

-- Progress Bar
local is_prog_hovered = false
local sng_progress = wibox.widget {
    bar_color        = beautiful.lbg,
    bar_active_color = beautiful.gry,
    handle_color     = beautiful.gry,
    handle_shape     = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    handle_width     = dpi(beautiful.base_font_size),
    forced_height    = dpi(beautiful.base_font_size),
    minimum          = 0,
    widget           = wibox.widget.slider,
}
sng_progress:connect_signal('mouse::enter', function()
    is_prog_hovered = true
    sng_progress.bar_active_color = beautiful.cya
    sng_progress.handle_color     = beautiful.cya
end)
sng_progress:connect_signal('mouse::leave', function()
    is_prog_hovered = false
    sng_progress.bar_active_color = beautiful.gry
    sng_progress.handle_color     = beautiful.gry
end)
sng_progress:connect_signal('property::value', function(_, value)
    if is_prog_hovered then
       playerctl:set_position(value)
    end
end)

-- Playback Controls
local function mk_ctrl(icon, run)
    local ctrl_button = wibox.widget {
        {
            {
                id     = "text_role",
                text   = icon,
                font   = beautiful.ic_font .. dpi(beautiful.giga_padding),
                widget = wibox.widget.textbox
            },
            margins = dpi(beautiful.ring_size),
            widget  = wibox.container.margin
        },
        fg      = beautiful.nfg,
        bg      = beautiful.lbg,
        shape   = helpers.mkroundedrect(),
        widget  = wibox.container.background,
        buttons = {
            awful.button({}, 1, run)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    helpers.add_hover(ctrl_button, beautiful.lbg, beautiful.blk)
    return ctrl_button
end
local ctrl_prev = mk_ctrl("", function() playerctl:previous()          end)
local ctrl_play = mk_ctrl("", function() playerctl:play_pause()        end)
local ctrl_next = mk_ctrl("", function() playerctl:next()              end)
local ctrl_shff = mk_ctrl("", function() playerctl:cycle_shuffle()     end)
local ctrl_loop = mk_ctrl("", function() playerctl:cycle_loop_status() end)
local my_player = mk_ctrl("", function()
                                 scratch.music:toggle()
                                 awesome.emit_signal("widget::dashboard")
                               end)

-- Volume control
local is_vol_hovered = false
local vol_bar = wibox.widget {
    {
        {
            {
                id                  = 'slider_role',
                bar_shape           = helpers.mkroundedrect(),
                bar_color           = beautiful.blk,
                bar_active_color    = beautiful.wht,
                handle_color        = beautiful.wht,
                handle_shape        = helpers.mkroundedrect(),
                minimum             = 0,
                maximum             = 100,
                handle_width        = dpi(beautiful.base_font_size),
                bar_height          = dpi(beautiful.item_spacing),
                forced_height       = dpi(beautiful.base_font_size),
                widget              = wibox.widget.slider
            },
            direction = "east",
            widget    = wibox.container.rotate
        },
        margins = dpi(beautiful.base_font_size),
        widget  = wibox.container.margin
    },
    bg      = beautiful.lbg,
    shape   = helpers.mkroundedrect(),
    widget  = wibox.container.background,
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
    vol_bar.slider.bar_active_color = beautiful.grn
    vol_bar.slider.handle_color     = beautiful.grn
end)
vol_bar:connect_signal('mouse::leave', function()
    is_vol_hovered = false
    vol_bar.slider.bar_active_color = beautiful.wht
    vol_bar.slider.handle_color     = beautiful.wht
end)

-- Signals
----------
playerctl:connect_signal("metadata",
    function(_, title, artist, album_path, album, new, player_name)
        album_art.image   = album_path:match("/") and 
                            helpers.crop_surface(1.5, gears.surface.load_uncached(album_path)) or 
                            helpers.crop_surface(1.5, gears.surface.load_uncached(beautiful.player_bg))
        sng_title.markup  = title:match("%w")  and "<b>" .. title .. "</b>"    or "<b>Nothing Playing</b>"
        sng_artist.markup = artist:match("%w") and "by " .. artist             or "by Unknown"
        sng_album.markup  = album:match("%w")  and "on <i>" .. album .. "</i>" or "on <i>Unknown</i>"
end)
playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if interval_sec > 0 then
        sng_progress.maximum = length_sec
        sng_progress.value   = interval_sec
    end
end)
playerctl:connect_signal("playback_status", function(_, playing, player_name)
        ctrl_play.text = playing and "" or ""
end)
playerctl:connect_signal("shuffle", function(_, shuffle)
        ctrl_shff.fg = shuffle and beautiful.ylw or beautiful.fg_normal
end)
playerctl:connect_signal("loop_status", function(_, loop_status)
    if loop_status:match('none') then
        ctrl_loop.fg    = beautiful.fg_normal
        ctrl_loop.text  = ""
    elseif loop_status:match('track') then
        ctrl_loop.fg    = beautiful.ylw
        ctrl_loop.text  = ""
    else
        ctrl_loop.fg    = beautiful.grn
        ctrl_loop.text  = ""
    end
end)
playerctl:connect_signal("volume", function(_, volume, player_name)
    vol_bar.value  = not is_vol_hovered and volume
end)

-- Music Player
---------------
local function music()
    return wibox.widget {
        {
            vol_bar,
            {
                album_art,
                {
                    {
                        {
                            {
                               nil,
                               nil,
                               my_player,
                               layout = wibox.layout.align.horizontal
                            },
                            {
                                {
                                    sng_title,
                                    step_function = wibox.container.scroll.step_functions.
                                                    waiting_nonlinear_back_and_forth,
                                    speed         = 100,
                                    rate          = 144,
                                    layout = wibox.container.scroll.horizontal
                                },
                                {
                                    sng_artist,
                                    step_function = wibox.container.scroll.step_functions.
                                                    waiting_nonlinear_back_and_forth,
                                    speed         = 100,
                                    rate          = 144,
                                    layout = wibox.container.scroll.horizontal
                                },
                                {
                                    sng_album,
                                    step_function = wibox.container.scroll.step_functions.
                                                    waiting_nonlinear_back_and_forth,
                                    speed         = 100,
                                    rate          = 144,
                                    layout = wibox.container.scroll.horizontal
                                },
                                layout = wibox.layout.fixed.vertical
                            },
                            {
                                {
                                    {
                                        ctrl_prev,
                                        ctrl_play,
                                        ctrl_next,
                                        spacing = dpi(beautiful.item_padding),
                                        layout  = wibox.layout.fixed.horizontal
                                    },
                                    nil,
                                    {
                                        ctrl_shff,
                                        ctrl_loop,
                                        spacing = dpi(beautiful.item_padding),
                                        layout  = wibox.layout.fixed.horizontal
                                    },
                                    layout  = wibox.layout.align.horizontal
                                },
                                top    = dpi(beautiful.base_font_size),
                                widget = wibox.container.margin
                            },
                            spacing = dpi(beautiful.item_spacing),
                            layout  = wibox.layout.fixed.vertical
                        },
                        margins = dpi(beautiful.title_font_size),
                        widget  = wibox.container.margin
                    },
                    {
                        sng_progress,
                        valign = "bottom",
                        layout = wibox.container.place
                    },
                    layout = wibox.layout.align.vertical
                },
                layout = wibox.layout.stack
            },
            spacing = dpi(beautiful.base_font_size),
            layout  = wibox.layout.fixed.horizontal
        },
        forced_height = dpi(beautiful.dashboard_size * 0.26),
        widget        = wibox.container.background
    }
end
return music
