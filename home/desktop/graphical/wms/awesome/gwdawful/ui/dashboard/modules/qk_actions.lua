------------------------------
-- dashboard: quick actions --
------------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Buttons
----------
-- Status icons
local function status_widget(icon, action, color)
    local status = wibox.widget {
        {
            {
                id     = "text_role",
                text   = icon,
                font   = beautiful.ic_font .. dpi(beautiful.giga_padding),
                align  = "center",
                widget = wibox.widget.textbox
            },
            margins = dpi(beautiful.ring_size),
            widget  = wibox.container.margin
        },
        bg     = beautiful.blk,
        widget = wibox.container.background,
        shape  = helpers.mkroundedrect(),
        buttons = {
            awful.button({}, 1, action)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    helpers.add_hover(status, beautiful.blk, color)
    return status
end

local dash_network   = status_widget("", function() awesome.emit_signal("network::toggle") end, beautiful.grn_d)
local dash_bluetooth = status_widget("", function() awesome.emit_signal("bluetooth::toggle") end, beautiful.blu_d)
local dash_scr_sel   = status_widget("", function() awesome.emit_signal("screenshot::selection") end, beautiful.cya_d)
local dash_scr_full  = status_widget("", function() awesome.emit_signal("screenshot::fullscreen") end, beautiful.mag_d)

-- Quick Actions
----------------
local function qk_actions()
    return wibox.widget {
        {
            {
                dash_network,
                beautiful.bluetooth_enabled and dash_bluetooth,
                dash_scr_sel,
                dash_scr_full,
                spacing = dpi(beautiful.item_padding),
                layout  = wibox.layout.flex.horizontal
            },
            margins = dpi(beautiful.base_font_size),
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(),
        forced_height = dpi(beautiful.dashboard_size * 0.115),
        widget = wibox.container.background
    }
end

-- Signal Connections
---------------------
awesome.connect_signal("signal::network", function(is_enabled)
    dash_network.text = is_enabled and "" or ""
end)
if beautiful.bluetooth_enabled then
    awesome.connect_signal("signal::bluetooth", function(is_enabled)
        dash_bluetooth.text = is_enabled and "" or ""
    end)
end

return qk_actions
