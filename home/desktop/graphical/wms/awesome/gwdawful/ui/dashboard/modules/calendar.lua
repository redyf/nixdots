-------------------------
-- dashboard: calendar --
-------------------------

-- Imports
----------
local beautiful = require('beautiful')
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Widgets
----------
local calendar_wdgt = wibox.widget {
    widget  = wibox.widget.calendar.month,
    date    = os.date("*t"),
    font    = beautiful.ui_font .. dpi(beautiful.base_font_size),
    flex_height = true,
    fn_embed = function(widget, flag, date) 
        local focus_widget = wibox.widget {
            text   = date.day,
            align  = "center",
            widget = wibox.widget.textbox,
        }
        local torender = flag == 'focus' and focus_widget or widget
        if flag == 'header' then
            torender.font = beautiful.ui_font .. 0
        end
        local colors = {
            header  = beautiful.blu,
            focus   = beautiful.ylw,
            normal  = beautiful.wht,
            weekday = beautiful.gry,
        }
        local color = colors[flag] or beautiful.fg_normal
        return wibox.widget {
            {
                {
                    torender,
                    align  = "center",
                    widget = wibox.container.place
                },
                margins = flag == 'focus' and dpi(beautiful.item_spacing) or 0, 
                widget  = wibox.container.margin
            },
            fg     = color,
            bg     = flag == 'focus' and beautiful.blk or beautiful.bg_normal,
            shape  = helpers.mkroundedrect(),
            forced_width = dpi(beautiful.dashboard_size * 0.315),
            widget = wibox.container.background
        }
    end
}

local clock = wibox.widget {
    {
        {
           {
               {
                    format = "<b>%M</b>",
                    font   = beautiful.mn_font .. dpi(beautiful.giga_padding),
                    widget = wibox.widget.textclock
                },
                fg     = beautiful.wht,
                widget = wibox.container.background
            },
            align  = "center",
            layout = wibox.container.place
        },
        left   = dpi(beautiful.title_font_size),
        top    = dpi(beautiful.subt_font_size),
        widget = wibox.container.margin
    },
    {
        {
           {
               {
                    format = "<b>%H</b>",
                    font   = beautiful.ui_font .. dpi(beautiful.giga_padding),
                    widget = wibox.widget.textclock
                },
                fg     = beautiful.blu,
                widget = wibox.container.background
            },
            align  = "center",
            layout = wibox.container.place
        },
        right  = dpi(beautiful.title_font_size),
        bottom = dpi(beautiful.subt_font_size),
        widget = wibox.container.margin
    },
    layout = wibox.layout.stack
}

-- Calendar
-----------
local function calendar() 
    return wibox.widget {
        {
            {
                calendar_wdgt,
                left    = dpi(beautiful.item_spacing),
                top     = dpi(-beautiful.item_padding),
                bottom  = dpi(beautiful.subt_font_size),
                right   = dpi(beautiful.subt_font_size),
                widget  = wibox.container.margin
            },
            {
                {
                    {
                        clock,
                        {
                            {
                                format = "%a %d\n",
                                align  = "center",
                                widget = wibox.widget.textclock
                            },
                            fg     = beautiful.gry,
                            widget = wibox.container.background
                        },
                        {
                            {
                                format = "<b>%b</b>\n%Y",
                                font   = beautiful.ui_font .. dpi(beautiful.title_font_size),
                                align  = "center",
                                widget = wibox.widget.textclock
                            },
                            fg     = beautiful.wht,
                            widget = wibox.container.background
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    align  = "center",
                    widget = wibox.container.place
                },
                bg     = beautiful.lbg,
                shape  = helpers.mkroundedrect(),
                forced_width = dpi(beautiful.dashboard_size * 0.1),
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        forced_height = dpi(beautiful.dashboard_size * 0.3),
        widget = wibox.container.background
    }
end

return calendar
