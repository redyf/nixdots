-----------------------------
-- gwdawful awesome config --
-----------------------------
-- Refer to 'userconf.lua' for proper customization configuration.
-- I've minimized interaction with this file to keep every separate
-- kind of configuration within its own dedicated directory/file.

-- Imports
----------
pcall(require, "luarocks.loader")

-- Error Handling
-----------------
-- Leaving this as the first in your config guarantees all errors will produce
-- a traceback notification.
local naughty = require("naughty")
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

-- Files
--------
-- Contains general user configuration.
-- I recommend checking this out FIRST.
require("userconf")
-- Loads the theming configuration.
require("beautiful").init(require("gears.filesystem").get_configuration_dir() .. "themes/init.lua")
-- Contains custom managed signals.
require("signals")
-- Contains the window manager configuration, like keybinds and rules.
require("config")
-- Contains the UI configuration.
require("ui")

-- Garbage Collection
---------------------
-- Utilize lua garbage cleanup, helps with resource usage.
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
