---------------------------
-- dashboard: user panel --
---------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- User profile
---------------
local greeter = wibox.widget {
    markup = "Welcome, <b>user!</b>",
    font   = beautiful.ui_font .. dpi(beautiful.title_font_size),
    widget = wibox.widget.textbox
}
awful.spawn.easy_async_with_shell(
    "whoami", function(stdout)
        name           = stdout:match('(%w+)')
        greeter.markup = "<b>Hi,</b> " .. name
    end
)

local uptime = wibox.widget {
    text   = "Uptime unknown...",
    font   = beautiful.ui_font .. dpi(beautiful.base_font_size),
    widget = wibox.widget.textbox
}
local function get_uptime()
    awful.spawn.easy_async_with_shell(
        "uptime -p", function(stdout)
            uptime.text = stdout
        end)
end
gears.timer {
    timeout   = 60,
    call_now  = true,
    autostart = true,
    callback  = get_uptime
}

-- Battery
----------
local avatar = wibox.widget {
   {
      widget        = wibox.widget.imagebox,
      image         = helpers.crop_surface(1, gears.surface.load_uncached(beautiful.user_avatar)),
      clip_shape    = gears.shape.circle,
      resize        = true,
      horizontal_fit_policy = "fit",
      vertical_fit_policy   = "fit"
   },
   paddings     = dpi(beautiful.ring_size),
   thickness    = dpi(beautiful.ring_size * 0.75),
   max_value    = 100,
   value        = 100,
   rounded_edge = beautiful.border_radius > 0,
   colors       = {
      {
         type  = "linear",
         from  = { 0, 0 },
         to    = { dpi(beautiful.giga_padding), dpi(beautiful.giga_padding) },
         stops = { { 0, beautiful.grn }, { 1, beautiful.grn_d } }
      }
   },
   bg           = beautiful.blk,
   start_angle  = 3 * math.pi / 2,
   widget       = wibox.container.arcchart
}

local bat_bar = wibox.widget {
   {
      {
         {
            id      = 'icon_role',
            font    = beautiful.ic_font .. dpi(beautiful.subt_font_size),
            halign  = "left",
            valign  = "center",
            widget  = wibox.widget.textbox
         },
         fg     = beautiful.wht,
         widget = wibox.container.background
      },
      {
         {
            id      = 'text_role',
            font    = beautiful.ui_font .. dpi(beautiful.base_font_size), 
            widget  = wibox.widget.textbox
         },
         fg     = beautiful.wht,
         widget = wibox.container.background
      },
      spacing = dpi(beautiful.item_spacing),
      layout  = wibox.layout.fixed.horizontal
   },
   left   = dpi(beautiful.item_spacing),
   widget = wibox.container.margin,
   set_icon   = function(self, new_icon)
       self:get_children_by_id('icon_role')[1].text = new_icon
   end,
   set_text   = function(self, new_text)
       self:get_children_by_id('text_role')[1].text = new_text
   end
}

if beautiful.battery_enabled then
    awesome.connect_signal("signal::battery", function(level, state, discharge_t, charge_t, type)
        avatar.value = level
        if state ~= 2 then
            bat_bar.icon = ""
            if state ~= 1 then
                bat_bar.text     = "Fully Charged"
            else
                bat_bar.text = charge_t .. " mins to full charge"
            end
        else
            bat_bar.icon = ""
            bat_bar.text = discharge_t .. " mins remaining"
        end
    end)
end

-- Power Buttons
----------------
local function txtbtn(icon, action)
    return wibox.widget {
        {
            text   = icon,
            font   = beautiful.ic_font .. dpi(beautiful.giga_padding),
            align  = "center",
            widget = wibox.widget.textbox
        },
        fg     = beautiful.red,
        widget = wibox.container.background,
        buttons = {
            awful.button({}, 1, action)
        }
    } 
end
local shutdown = txtbtn("", function() awful.spawn("systemctl poweroff") end);
local reboot   = txtbtn("", function() awful.spawn("systemctl reboot") end);
local logoff   = txtbtn("", function() awesome.quit() end);

local function user_profile()
    return wibox.widget {
    {
        {
            {
                {
                    {
                        avatar,
                        valign = "center",
                        layout = wibox.container.place
                    },
                    strategy = "exact",
                    height   = dpi(beautiful.dashboard_size * 0.11),
                    widget   = wibox.container.constraint
                },
                {
                    {
                        {
                            greeter, 
                            {
                                uptime,
                                fg     = beautiful.wht,
                                widget = wibox.container.background
                            },
                            layout  = wibox.layout.fixed.vertical
                        },
                        valign = "center",
                        widget = wibox.container.place
                    },
                    left   = dpi(beautiful.title_font_size),
                    right  = dpi(beautiful.subt_font_size),
                    top    = dpi(beautiful.subt_font_size),
                    widget = wibox.container.margin
                },
                layout  = wibox.layout.fixed.horizontal
            },
            margins = dpi(beautiful.title_font_size),
            widget  = wibox.container.margin
        },
        nil,
        {
            {
                {
                    {
                        bat_bar,
                        margins = dpi(beautiful.ring_size),
                        visible = beautiful.battery_enabled,
                        widget  = wibox.container.margin
                    },
                    nil,
                    {
                        helpers.mkbtn(logoff,   beautiful.lbg, beautiful.gry),
                        helpers.mkbtn(reboot,   beautiful.lbg, beautiful.gry),
                        helpers.mkbtn(shutdown, beautiful.lbg, beautiful.gry),
                        spacing = dpi(beautiful.ring_size),
                        layout  = wibox.layout.fixed.horizontal
                    },
                    layout = wibox.layout.align.horizontal
                },
                margins = dpi(beautiful.ring_size),
                widget  = wibox.container.margin
            },
            bg     = beautiful.blk,
            widget = wibox.container.background
        },
        layout = wibox.layout.align.vertical
    },
    shape  = helpers.mkroundedrect(),
    bg     = beautiful.lbg,
    forced_height = dpi(beautiful.dashboard_size * 0.2),
    widget = wibox.container.background
}
end

return user_profile
