--------------------------------
-- notification configuration --
--------------------------------

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local ruled     = require('ruled')
local naughty   = require('naughty')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local gfs       = gears.filesystem
local gc        = gears.color

local def_icon  = gc.recolor_image(
                    gfs.get_configuration_dir() .. "themes/assets/notification/def_notif.svg",
                    beautiful.notification_accent)

local helpers   = require('helpers')
local rubato    = require('modules.rubato')

local notif_size = beautiful.scaling * 10
local min_width  = notif_size * 2
local max_width  = notif_size * 3

local graph_size = notif_size * 0.75

-- Notifications
----------------
naughty.config.defaults.timeout = 5
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            ontop            = true,
            implicit_timeout = 6,
            border_width     = dpi(beautiful.border_width),
            position         = beautiful.notification_side
        }
    }
end)

naughty.connect_signal("request::icon", function(n, context, hints)
    if context ~= "app_icon" then
        return
    end
    local path = require('menubar').utils.lookup_icon(hints.app_icon) or
                 require('menubar').utils.lookup_icon(hints.app_icon:lower())
    if path then
        n.icon = path
    end
end)
naughty.connect_signal("request::action_icon", function(a, context, hints)
    a.icon = menubar.utils.lookup_icon(hints.id)
end)

naughty.connect_signal("request::display", function(n)
    
    local timeout = n.timeout
    n.timeout = 999999

    -- Basics
    local title = wibox.widget {
        widget        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.
                        waiting_nonlinear_back_and_forth,
        speed         = 100,
        rate          = 144,
        {
            markup = n.title:match('.') and "<b>" .. n.title .. "</b>"
                                         or "<b>Notification</b>",
            font   = beautiful.ui_font .. dpi(beautiful.subt_font_size),
            halign = "center",
            widget = wibox.widget.textbox
        }
    }
    local summary = wibox.widget {
        widget        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.
                        waiting_nonlinear_back_and_forth,
        speed         = 100,
        rate          = 144,
        {
            widget = wibox.widget.textbox,
            halign = "center",
            font   = beautiful.ui_font .. dpi(beautiful.base_font_size),
            text   = gears.string.xml_unescape(n.message)
        }
    }

    -- Fancy timeout image frame animation
    local image = wibox.widget {
        widget = wibox.widget.imagebox,
        image  = n.icon and helpers.crop_surface(1, gears.surface.load_uncached(n.icon))
                 or helpers.crop_surface(1, gears.surface.load_uncached(def_icon)),
        resize = true,
        align  = "center",
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        clip_shape            = helpers.mkroundedrect(),
        buttons = {
            awful.button({}, 1, function() n:destroy() end)
        }
	  }
    -- Animation stolen right off the certified animation lady.
    local timeout_graph = wibox.widget {
        widget    = wibox.container.arcchart,
        min_value = 0,
        max_value = 100,
        value     = 0,
        thickness = dpi(beautiful.ring_size),
        paddings  = dpi(beautiful.ring_size),
        rounded_edge = true,
        colors       = { beautiful.notification_accent },
        bg           = beautiful.lbg,
        forced_height = dpi(graph_size),
        forced_width  = dpi(graph_size),
        image
    }

    -- Action buttons
    local actions = wibox.widget {
        notification = n,
        base_layout  = wibox.widget {
            spacing  = dpi(beautiful.item_spacing),
            layout   = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id       = "text_role",
                        font     = beautiful.ui_font .. dpi(beautiful.item_padding),
                        widget   = wibox.widget.textbox
                    },
                    align  = "center",
                    widget = wibox.container.place
                },
                bottom = dpi(beautiful.item_spacing),
                top    = dpi(beautiful.item_spacing),
                left   = dpi(beautiful.item_padding),
                right  = dpi(beautiful.item_padding),
                widget = wibox.container.margin
            },
            bg     = beautiful.blk,
            widget = wibox.container.background
        },
        style  = {
            underline_normal    = false,
            underline_selected  = false,
            bg_normal           = beautiful.blk,
            bg_normal           = beautiful.gry
        },
        widget = naughty.list.actions
    }

    -- The actual notification
    local widget = naughty.layout.box { 
        notification = n, 
        cursor       = "hand2",
        shape        = helpers.mkroundedrect(),
        widget_template = {
            {
                {
                    timeout_graph,
                    margins = dpi(beautiful.scaling),
                    widget  = wibox.container.margin
                },
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            title,
                                            halign = "center",
                                            widget = wibox.container.place
                                        },
                                        {
                                            summary,
                                            halign = "center",
                                            widget = wibox.container.place
                                        },
                                        {
                                            {
                                                actions,
                                                shape  = helpers.mkroundedrect(),
                                                widget = wibox.container.background
                                            },
                                            left    = dpi(beautiful.item_spacing),
                                            right   = dpi(beautiful.item_spacing),
                                            top     = dpi(beautiful.item_spacing),
                                            widget  = wibox.container.margin,
                                            visible = n.actions and #n.actions > 0
                                        },
                                        spacing = dpi(beautiful.item_spacing),
                                        layout  = wibox.layout.fixed.vertical
                                    },
                                    align  = "center",
                                    widget = wibox.container.place
                                },
                                margins = {
                                    left   = dpi(beautiful.giga_padding),
                                    right  = dpi(beautiful.giga_padding),
                                    bottom = dpi(beautiful.subt_font_size),
                                    top    = dpi(beautiful.subt_font_size)
                                },
                                widget  = wibox.container.margin
                            },
                            bg     = beautiful.lbg,
                            shape  = helpers.mkroundedrect(),
                            widget = wibox.container.background
                        },
                        strategy = "min",
                        width    = dpi(min_width),
                        widget   = wibox.container.constraint
                    },
                    strategy = "max",
                    width    = dpi(max_width),
                    height   = dpi(max_width),
                    widget   = wibox.container.constraint
                },
                layout = wibox.layout.fixed.horizontal
            },
            id     = "background_role",
            bg     = beautiful.nbg,
            widget = naughty.container.background
        }
    }
    widget.buttons = {}
    local anim = rubato.timed {
        intro      = 0,
        duration   = timeout,
        subscribed = function(pos, time)
            timeout_graph.value = pos
            if time == timeout then
                n:destroy()
            end
        end
    }
    widget:connect_signal("mouse::enter", function()
        anim.pause = true
    end)

    widget:connect_signal("mouse::leave", function()
        anim.pause = false
    end)
    anim.target     = 100
end)
