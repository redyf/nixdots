-------------
-- Layouts --
-------------

-- Imports
----------
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local delayed_call  = require("gears.timer").delayed_call
local dpi           = beautiful.xresources.apply_dpi

local bling         = require('modules.bling')
local helpers       = require('helpers')

-- Layouts
----------
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
        -- bling.layout.mstab,
        bling.layout.centered,
        bling.layout.vertical,
        awful.layout.suit.tile.bottom,
        -- bling.layout.horizontal,
        -- bling.layout.equalarea,
        -- bling.layout.deck,
        awful.layout.suit.floating
    })
end)

-- External Padding
-------------------
-- This is added ON TOP of the 'beautiful.useless_gap' value
local screen_padding = beautiful.outer_gaps - beautiful.useless_gap 
awful.screen.connect_for_each_screen(function(s)
    s.padding = {
        left   = dpi(screen_padding), 
        right  = dpi(screen_padding), 
        top    = dpi(screen_padding), 
        bottom = dpi(screen_padding)
    }
end)

-- Rounded Corners
------------------
if beautiful.rounded_clients then
    client.connect_signal("request::manage", function(c)
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end
    end)
end
