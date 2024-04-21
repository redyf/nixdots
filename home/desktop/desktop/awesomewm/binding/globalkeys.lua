-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
	local globalkeys = gears.table.join(
		awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Tag browsing
		awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
		awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
		awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

		awful.key({ modkey }, "j", function()
			awful.client.focus.byidx(1)
		end, { description = "focus next by index", group = "client" }),
		awful.key({ modkey }, "k", function()
			awful.client.focus.byidx(-1)
		end, { description = "focus previous by index", group = "client" }),
		awful.key({ modkey }, "w", function()
			RC.mainmenu:show()
		end, { description = "show main menu", group = "awesome" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Layout manipulation
		awful.key({ modkey, "Shift" }, "j", function()
			awful.client.swap.byidx(1)
		end, { description = "swap with next client by index", group = "client" }),
		awful.key({ modkey, "Shift" }, "k", function()
			awful.client.swap.byidx(-1)
		end, { description = "swap with previous client by index", group = "client" }),
		awful.key({ modkey, "Control" }, "j", function()
			awful.screen.focus_relative(1)
		end, { description = "focus the next screen", group = "screen" }),
		awful.key({ modkey, "Control" }, "k", function()
			awful.screen.focus_relative(-1)
		end, { description = "focus the previous screen", group = "screen" }),
		awful.key(
			{ modkey },
			"u",
			awful.client.urgent.jumpto,
			{ description = "jump to urgent client", group = "client" }
		),
		awful.key({ modkey }, "Tab", function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end, { description = "go back", group = "client" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Standard program
		awful.key({ modkey }, "Return", function()
			awful.spawn(terminal)
		end, { description = "open a terminal", group = "launcher" }),
		awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
		awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Layout manipulation
		awful.key({ modkey }, "l", function()
			awful.tag.incmwfact(0.05)
		end, { description = "increase master width factor", group = "layout" }),
		awful.key({ modkey }, "h", function()
			awful.tag.incmwfact(-0.05)
		end, { description = "decrease master width factor", group = "layout" }),
		awful.key({ modkey, "Shift" }, "h", function()
			awful.tag.incnmaster(1, nil, true)
		end, { description = "increase the number of master clients", group = "layout" }),
		awful.key({ modkey, "Shift" }, "l", function()
			awful.tag.incnmaster(-1, nil, true)
		end, { description = "decrease the number of master clients", group = "layout" }),
		awful.key({ modkey, "Control" }, "h", function()
			awful.tag.incncol(1, nil, true)
		end, { description = "increase the number of columns", group = "layout" }),
		awful.key({ modkey, "Control" }, "l", function()
			awful.tag.incncol(-1, nil, true)
		end, { description = "decrease the number of columns", group = "layout" }),
		-- awful.key({ modkey }, "space", function()
		-- 	awful.layout.inc(1)
		-- end, { description = "select next", group = "layout" }),
		awful.key({ modkey }, "space", function()
			awful.spawn("rofi -show drun -I -s ~/.config/rofi/config.rasi DP-0")
		end, { description = "launch rofi", group = "launcher" }),

		awful.key({ modkey, "Shift" }, "space", function()
			awful.layout.inc(-1)
		end, { description = "select previous", group = "layout" }),

		awful.key({ modkey, "Control" }, "n", function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end, { description = "restore minimized", group = "client" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Prompt
		awful.key({ modkey }, "r", function()
			awful.screen.focused().mypromptbox:run()
		end, { description = "run prompt", group = "launcher" }),

		awful.key({ modkey }, "x", function()
			awful.prompt.run({
				prompt = "Run Lua code: ",
				textbox = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval",
			})
		end, { description = "lua execute prompt", group = "awesome" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Resize
		--awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize( 20,  20, -40, -40) end),
		--awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(-20, -20,  40,  40) end),
		awful.key({ modkey, "Control" }, "Down", function()
			awful.client.moveresize(0, 0, 0, -20)
		end),
		awful.key({ modkey, "Control" }, "Up", function()
			awful.client.moveresize(0, 0, 0, 20)
		end),
		awful.key({ modkey, "Control" }, "Left", function()
			awful.client.moveresize(0, 0, -20, 0)
		end),
		awful.key({ modkey, "Control" }, "Right", function()
			awful.client.moveresize(0, 0, 20, 0)
		end),

		-- Move
		awful.key({ modkey, "Shift" }, "Down", function()
			awful.client.moveresize(0, 20, 0, 0)
		end),
		awful.key({ modkey, "Shift" }, "Up", function()
			awful.client.moveresize(0, -20, 0, 0)
		end),
		awful.key({ modkey, "Shift" }, "Left", function()
			awful.client.moveresize(-20, 0, 0, 0)
		end),
		awful.key({ modkey, "Shift" }, "Right", function()
			awful.client.moveresize(20, 0, 0, 0)
		end),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Menubar
		awful.key({ modkey }, "p", function()
			menubar.show()
		end, { description = "show the menubar", group = "launcher" })
	)

	return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
	__call = function(_, ...)
		return _M.get(...)
	end,
})
