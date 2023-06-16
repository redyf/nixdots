------------------------
-- Client Decorations --
------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

local flip_dir  = (beautiful.titles_inverted     and beautiful.is_title_horizontal) and "south" or
                  (not beautiful.titles_inverted and beautiful.is_title_horizontal) and "north" or
                  (beautiful.titles_inverted and not beautiful.is_title_horizontal) and "west"  or
                  "east"

-- Buttons
----------
local mkbutton = function (width, onclick)
  return function(c)
    local button = wibox.widget {
      wibox.widget.textbox(),
      forced_width  = dpi(width),
      forced_height = dpi(beautiful.title_size),
      bg            = beautiful.titlebar_bg_normal,
      shape         = helpers.mkroundedrect(beautiful.border_radius),
      widget        = wibox.container.background
    }

    local color_transition = helpers.apply_transition {
      element   = button,
      prop      = 'bg',
      bg        = beautiful.titlebar_fg_focus,
      hbg       = beautiful.titlebar_fg_normal,
    }

    client.connect_signal("property::active", function()
      if c.active then
        color_transition.off()
      else
        color_transition.on()
      end
    end)

    button:add_button(awful.button({}, 1, function()
      if onclick then
        onclick(c)
      end
    end))

    return button
  end
end

local close = mkbutton(1.5 * beautiful.title_size, function(c)
    c:kill()
end)

local maximize = mkbutton(beautiful.title_size, function(c)
    c.maximized = not c.maximized
end)

local minimize = mkbutton(beautiful.title_size, function(c)
    gears.timer.delayed_call(function()
        c.minimized = not c.minimized
    end)
end)

local sticky = mkbutton(beautiful.title_size, function(c)
    c.sticky = not c.sticky
end)

-- Titlebars
------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

    if c.requests_no_titlebar then
        return
    end
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local n_titlebar = awful.titlebar(c, {
        size     = beautiful.title_size,
        position = beautiful.title_side,
    })
    n_titlebar.widget = {
        {
            {
                { -- Start
                    close(c),
                    maximize(c),
                    minimize(c),
                    spacing = dpi(beautiful.item_spacing),
                    layout  = wibox.layout.fixed.horizontal
                },
                { -- Middle
                    buttons = buttons,
                    layout  = wibox.layout.fixed.horizontal
                },
                { -- End
                    sticky(c),
                    spacing = dpi(beautiful.item_spacing),
                    layout  = wibox.layout.fixed.horizontal
                },
                spacing = dpi(beautiful.item_spacing),
                layout  = wibox.layout.align.horizontal
            },
            direction = flip_dir,
            widget    = wibox.container.rotate
        },
        margins = dpi(beautiful.scaling),
        widget  = wibox.container.margin
    }
end)
