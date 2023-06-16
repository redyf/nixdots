--------------------------
-- unoriginal dashboard --
--------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

local user_panel = require('ui.dashboard.modules.user_panel')
local qk_actions = require('ui.dashboard.modules.qk_actions')
local music      = require('ui.dashboard.modules.music')
local sliders    = require('ui.dashboard.modules.sliders')
local calendar   = require('ui.dashboard.modules.calendar')

local Width      = beautiful.dashboard_size * 0.55 

-- Dashboard
------------
-- The settings for the dashboard itself
local dashboardBox = wibox {
    ontop   = true,
    visible = false,
    width   = dpi(Width),
    height  = dpi(beautiful.dashboard_size),
    shape   = helpers.mkroundedrect(),
    bg      = beautiful.bg_normal
}

local header = wibox.widget {
    {
        id     = 'text_role',
        markup = "<b>System Panel</b>",
        font   = beautiful.ui_font .. dpi(beautiful.subt_font_size),
        widget = wibox.widget.textbox
    },
    fg     = beautiful.gry,
    widget = wibox.container.background,
    set_markup = function(self, content)
        self:get_children_by_id('text_role')[1].markup = content
    end
}
awful.spawn.easy_async_with_shell(
    "uname -n", function(stdout)
        hostname      = stdout:match('(%w+)')
        header.markup = "<b>System Panel</b> • " .. hostname
    end
)

dashboardBox:setup {
    {
        {
            {
                header,
                user_panel(),
                music(),
                calendar(),
                qk_actions(),
                spacing = dpi(beautiful.scaling),
                layout  = wibox.layout.fixed.vertical
            },
            strategy = "exact",
            width    = dpi(beautiful.dashboard_size * 0.435),
            widget   = wibox.container.constraint
        },
        nil,
        {
            sliders(),
            strategy = "exact",
            width    = dpi(beautiful.dashboard_size * 0.05),
            widget   = wibox.container.constraint
        },
        layout = wibox.layout.align.horizontal
    },
    margins = dpi(beautiful.giga_padding),
    widget  = wibox.container.margin
}

-- Signal Connections
---------------------
awesome.connect_signal("widget::dashboard", function()
    dashboardBox.visible = not dashboardBox.visible
    awful.placement.next_to(
        dashboardBox,
        {
            preferred_positions = beautiful.bar_side == "left" and "right" or
                                  beautiful.bar_side == "right" and "left" or
                                  beautiful.bar_side == "top" and "bottom" or
                                  beautiful.bar_side == "bottom" and "top",
            preferred_anchors   = "front",
            margins             = dpi(beautiful.useless_gap * 2),
            geometry            = awful.screen.focused().mywibox
        }
    )
end)
