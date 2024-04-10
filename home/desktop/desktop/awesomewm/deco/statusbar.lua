-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom widgets
-- local battery_widget = require("battery-widget")
-- local audio_widget = require("awesome-pulseaudio-widget")
-- local connman = require("connman_widget")

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist = require("deco.taglist"),
	tasklist = require("deco.tasklist"),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Configure widgets
-- battery_widget {
--     ac = "AC",
--     adapter = "BAT0",
--     ac_prefix = "AC: ",
--     battery_prefix = "Bat: ",
--     percent_colors = {
--         { 25, "red"   },
--         { 50, "orange"},
--         {999, "green" },
--     },
--     listen = true,
--     timeout = 10,
--     widget_text = "${AC_BAT}${color_on}${percent}%${color_off}",
--     widget_font = "Deja Vu Sans Mono 16",
--     tooltip_text = "Battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
--     alert_threshold = 20,
--     alert_timeout = 0,
--     alert_title = "Low battery !",
--     alert_text = "${AC_BAT}${time_est}",
-- }
-- connman.gui_client = "nm-applet"

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mytextclock.format = "%Y-%m-%d %H:%M"

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			RC.launcher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mykeyboardlayout,
			wibox.widget.systray(),
			-- audio_widget(),
			-- connman,
			-- battery_widget,
			mytextclock,
			s.mylayoutbox,
		},
	})
end)
-- }}}
