------------------------
-- menu configuration --
------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local gfs       = gears.filesystem
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Awesome Menu
---------------
-- Create a main menu
local menu = {}

menu.mainmenu = awful.menu({ 
        items = { 
            { "Terminal", terminal      },
            { "Files",    files_gui     },
            { "Browser",  browser       },
            { 
                "Awesome", 
                {
                    { "Config",  editor_cmd .. " " .. gfs.get_configuration_dir() },
                    { "Restart", awesome.restart },
                }
            },
            {
                "Power",
                {
                    { "Log Out",  function() awesome.quit() end                    },
                    { "Restart",  function() awful.spawn("systemctl reboot") end   },
                    { "Shutdown", function() awful.spawn("systemctl poweroff") end }
                }
            }
        }
})

-- apply rounded corners to submenus,                         by u/signalsourcesexy
-- also applies antialiasing,                                 by AlphaTechnolog
menu.mainmenu.wibox.shape = helpers.mkroundedrect()
menu.mainmenu.wibox.bg    = beautiful.bg_normal .. '00'
menu.mainmenu.wibox:set_widget(wibox.widget({
    {
        {
            menu.mainmenu.wibox.widget,
            shape  = helpers.mkroundedrect(),
            widget = wibox.container.background,
        },
        margins = dpi(beautiful.scaling),
        widget = wibox.container.margin
    },
    bg     = beautiful.bg_normal,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background,
}))

awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
    local ret       = awful.menu.original_new(...)
    ret.wibox.shape = helpers.mkroundedrect()
    ret.wibox.bg    = beautiful.bg_normal .. '00'
    ret.wibox:set_widget(
        wibox.widget {
            {
                {
                    ret.wibox.widget,
                    shape  = helpers.mkroundedrect(),
                    widget = wibox.container.background,
                },
                margins = dpi(beautiful.scaling),
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            bg     = beautiful.bg_normal,
            shape  = helpers.mkroundedrect(),
        }
    )
    return ret
end

return menu
