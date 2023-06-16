------------------------
-- dashboard: sliders --
------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Widgets
----------
local function makeslider(base_icon, color, input, min)
    local widget = wibox.widget {
        {
            {
                {
                    {
                        id      = 'icon_role',
                        text    = base_icon,
                        font    = beautiful.ic_font .. dpi(beautiful.giga_padding),
                        align   = "center",
                        widget  = wibox.widget.textbox
                    },
                    id      = 'fg_role',
                    fg      = beautiful.wht,
                    widget  = wibox.container.background,
                    buttons = {
                        awful.button({}, 1, input)
                    }
                },
                {
                    {
                        {
                            id                  = 'slider_role',
                            bar_shape           = helpers.mkroundedrect(),
                            bar_height          = dpi(beautiful.item_spacing),
                            bar_color           = beautiful.blk,
                            bar_active_color    = beautiful.wht,
                            handle_color        = beautiful.wht,
                            handle_shape        = helpers.mkroundedrect(),
                            handle_width        = dpi(beautiful.subt_font_size),
                            minimum             = min,
                            maximum             = 100,
                            widget              = wibox.widget.slider
                        },
                        top    = dpi(beautiful.item_padding),
                        bottom = dpi(beautiful.item_padding),
                        widget = wibox.container.margin
                    },
                    direction = "east",
                    widget    = wibox.container.rotate
                },
                spacing = dpi(beautiful.base_font_size),
                layout  = wibox.layout.fixed.vertical
            },
            top     = dpi(beautiful.subt_font_size),
            bottom  = dpi(beautiful.subt_font_size),
            left    = dpi(beautiful.item_spacing),
            right   = dpi(beautiful.item_spacing),
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(),
        widget = wibox.container.background,
        get_slider = function(self)
            return self:get_children_by_id('slider_role')[1]
        end,
        get_stt_ic = function(self)
            return self:get_children_by_id('fg_role')[1]
        end,
        set_value  = function(self, val)
            self.slider.value = val
        end,
        set_icon   = function(self, new_icon)
            self:get_children_by_id('icon_role')[1].text = new_icon
        end
    }
    widget:connect_signal("mouse::enter", function()
        widget.slider.bar_active_color = color
        widget.slider.handle_color     = color
        widget.stt_ic.fg               = color
    end)
    widget:connect_signal("mouse::leave", function()
        widget.slider.bar_active_color = beautiful.wht
        widget.slider.handle_color     = beautiful.wht
        widget.stt_ic.fg               = beautiful.wht
    end)
    return widget
end

-- Volume
---------
local volumebar = makeslider("", beautiful.blu, function() awesome.emit_signal("volume::mute") end, 0)
awesome.connect_signal("signal::volume", function(volume, muted)
    volumebar.value = volume
    volumebar.icon  = muted and "" or ""
end)
volumebar.slider:connect_signal('property::value', function(_, value)
    awesome.emit_signal("volume::set", tonumber(value))
end)

-- Microphone
-------------
local mic        = makeslider("", beautiful.mag, function() awesome.emit_signal("microphone::mute") end, 0)
awesome.connect_signal("signal::microphone", function(mic_level, mic_muted)
    mic.value = mic_level
    mic.icon = mic_muted and "" or ""
end)
mic.slider:connect_signal('property::value', function(_, value)
    awesome.emit_signal("microphone::set", tonumber(value))
end)

-- Brightness
-------------
local brightbar = makeslider("", beautiful.ylw, nil, 5)
if beautiful.brightness_enabled then
    awesome.connect_signal("signal::brightness", function(brightness)
        brightbar.value = brightness
        if brightness <= 33 then 
            brightbar.icon  = ""
        elseif brightness <= 66 then
            brightbar.icon  = ""
        else
            brightbar.icon  = ""
        end
    end)
end
brightbar.slider:connect_signal('property::value', function(_, value)
    awesome.emit_signal("brightness::set", value)
end)

-- Sliders
----------
local function sliderbox()
    return wibox.widget {
        volumebar,
        mic,
        beautiful.brightness_enabled and brightbar,
        spacing = dpi(beautiful.base_font_size),
        layout  = wibox.layout.flex.vertical
    }
end

return sliderbox
