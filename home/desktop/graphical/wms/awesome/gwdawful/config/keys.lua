--------------
-- Keybinds --
--------------

-- Imports
----------
local gears     = require('gears')
local awful     = require('awful')
local beautiful = require('beautiful')

require('awful.autofocus') -- don't remove this, trust me

term_cmd        = terminal:match('wezterm') and " start " or " -e "
editor_cmd      = editor == "emacs" and editor 
                  or terminal .. term_cmd .. editor
files_cmd       = terminal .. term_cmd .. files_cli
tasks_cmd       = terminal .. term_cmd .. top

local modkey    = beautiful.modkey
local menu      = require('ui.menu')
local scratch   = require('config.scratchpad')
local launcher  = require('ui.app_launcher')
local playerctl = require('modules.bling').signal.playerctl.lib()
local tabbed    = require('modules.bling').module.tabbed

-- Behavior
-----------
-- Enable sloppy focus, so that focus follows mouse.
if beautiful.hover_focus then
    client.connect_signal("mouse::enter", function(c)
        c:activate { context = "mouse_enter", raise = false }
    end)
end

-- Root Window mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function() menu.mainmenu:toggle() end),
})

-- Global key/mouse bindings
----------------------------
awful.keyboard.append_global_keybindings({

    -- AwesomeWM
    ------------
    -- Reload Awesome
    awful.key({ modkey, "Control" }, "r",       awesome.restart,
              { description = "Reload AwesomeWM", group = "AwesomeWM" }),
    -- Awesome Menu
    awful.key({ modkey,           }, "w",       function() menu.mainmenu:toggle() end,
              { description = "Toggle Awesome Menu", group = "AwesomeWM" }),

    -- Applications
    ---------------
    -- Term
    awful.key({ modkey,           }, "Return",  function() awful.spawn(terminal) end,
              { description = "Open a terminal",  group = "Programs" }),
    -- Scratchpad terminal
    awful.key({ modkey, "Control" }, "Return",  function() scratch.terminal:toggle() end,
              { description = "Opens a terminal scratchpad", group = "Programs" }),
    -- Scratchpad music player
    awful.key({ modkey, "Control" }, "p",       function() scratch.music:toggle() end,
              { description = "Opens a music scratchpad", group = "Programs" }),
    -- Editor
    awful.key({ modkey, "Shift"   }, "Return",  function() awful.spawn(editor_cmd) end,
              { description = "Open an editor",   group = "Programs" }),
    -- File Browsers (term, gui)
    awful.key({ modkey,           }, "e",       function() awful.spawn(files_cmd) end,
              { description = "Open a TUI file manager", group = "Programs" }),
    awful.key({ modkey, "Shift"   }, "e",       function() awful.spawn(files_gui) end,
              { description = "Open a GUI file manager", group = "Programs" }),
    -- Task Manager
    awful.key({ modkey,           }, "Escape",  function() awful.spawn(tasks_cmd) end,
              { description = "Open a task manager", group = "Programs" }),
    -- Application launcher
    awful.key({ modkey            }, "p",       function() launcher:toggle() end,
              { description = "Open the application launcher", group = "Programs" }),

    -- Window Management
    --------------------
    -- switch focus (next, previous)
    awful.key({ modkey,           }, "j",       function() awful.client.focus.byidx( 1) end,
              { description = "Focus next client", group = "Window Management" }),
    awful.key({ modkey,           }, "k",       function() awful.client.focus.byidx(-1) end,
              { description = "Focus previous client", group = "Window Management" }),
    -- swap windows (next, previous)
    awful.key({ modkey, "Shift"   }, "j",       function() awful.client.swap.byidx(  1) end,
              { description = "Swap with next client", group = "Window Management" }),
    awful.key({ modkey, "Shift"   }, "k",       function() awful.client.swap.byidx( -1) end,
              { description = "Swap with previous client", group = "Window Management" }),
    -- add window to tabbed group (next, previous)
    awful.key({ modkey, "Control" }, "j",   function () tabbed.pick_by_direction("down") end,
              { description = "Add next window to tabbed group", group = "Window Management" }),
    awful.key({ modkey, "Control" }, "k",   function () tabbed.pick_by_direction("up") end,
              { description = "add previous window to tabbed group", group = "window management" }),
    -- switch focused monitor (next, previous)
    awful.key({ modkey,           }, "period",  function () awful.screen.focus_relative( 1) end,
              { description = "Focus next screen", group = "Window Management" }),
    awful.key({ modkey,           }, "comma",   function () awful.screen.focus_relative(-1) end,
              { description = "Focus previous screen", group = "Window Management" }),
    -- remove window from tabbed group
    awful.key({ modkey, "Control" }, "h",   function () tabbed.pop() end,
              { description = "Remove window from tabbed group", group = "Window Management" }),
    -- iterate through tabbed group members
    awful.key({ modkey, "Control" }, "l",   function () tabbed.iter() end,
              { description = "Cycle tabbed group members", group = "Window Management" }),
    -- switch focused monitor (next, previous)
    awful.key({ modkey,           }, "period",  function () awful.screen.focus_relative( 1) end,
              { description = "Focus next screen", group = "Window Management" }),
    awful.key({ modkey,           }, "comma",   function () awful.screen.focus_relative(-1) end,
              { description = "Focus previous screen", group = "Window Management" }),

    -- Layout Management
    --------------------
    -- master size (grow, shrink)
    awful.key({ modkey,           }, "l",       function() awful.tag.incmwfact( 0.05) end,
              { description = "Grow master client", group = "Layout Management" }),
    awful.key({ modkey,           }, "h",       function() awful.tag.incmwfact(-0.05) end,
              { description = "Shrink master client", group = "Layout Management" }),
    -- master amount (grow, shrink)
    awful.key({ modkey,           }, "equal",   function() awful.tag.incnmaster( 1, nil, true) end,
              { description = "Increase amount of master clients", group = "Layout Management" }),
    awful.key({ modkey,           }, "minus",   function() awful.tag.incnmaster(-1, nil, true) end,
              { description = "Decrease amount of master clients", group = "Layout Management" }),
    -- slaves size (grow, shrink)
    awful.key({ modkey, "Shift"   }, "l",       function() awful.client.incwfact( 0.05) end,
              { description = "Grow slave clients", group = "Layout Management" }),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.client.incwfact(-0.05) end,
              { description = "Shrink slave clients", group = "Layout Management" }),
    -- column amount (grow, shrink)
    awful.key({ modkey, "Shift"   }, "equal",   function() awful.tag.incncol( 1, nil, true) end,
              { description = "Increase amount of slave columns", group = "Layout Management" }),
    awful.key({ modkey, "Shift"   }, "minus",   function() awful.tag.incncol(-1, nil, true) end,
              { description = "Decrease amount of slave columns", group = "Layout Management" }),
    -- cycle layouts (next, previous)
    awful.key({ modkey,           }, "space",   function() awful.layout.inc( 1) end,
              { description = "Switch to next layout", group = "Layout Management" }),
    awful.key({ modkey, "Shift"   }, "space",   function() awful.layout.inc(-1) end,
              { description = "Switch to previous layout", group = "Layout Management" }),

    -- Media
    --------
    -- system volume (up, down, mute)
    awful.key({ nil,    }, "XF86AudioRaiseVolume",
        function() awesome.emit_signal("volume::change", 5) end,
        { description = "Increase system audio volume", group = "Media" }),
    awful.key({ nil,    }, "XF86AudioLowerVolume",
        function() awesome.emit_signal("volume::change", -5) end,
        { description = "Decrease system audio volume", group = "Media" }),
    awful.key({ nil,    }, "XF86AudioMute", 
        function() awesome.emit_signal("volume::mute") end,
        { description = "Mute system audio", group = "Media" }),
    -- song playback (play, prev, next)
    awful.key({ nil,    }, "XF86AudioPlay", 
        function() playerctl:play_pause() end,
        { description = "Play/pause media playback", group = "Media" }),
    awful.key({ nil,    }, "XF86AudioPrev", 
        function() playerctl:previous() end,
        { description = "Skip to next song/video", group = "Media" }),
    awful.key({ nil,    }, "XF86AudioNext", 
        function() playerctl:next() end,
        { description = "Rewind to previous song/video", group = "Media" }),
    -- brightness (up, down)
    awful.key({ nil,    }, "XF86MonBrightnessUp",
        function() awesome.emit_signal("brightness::change", 5) end,
        { description = "Increase screen brightness", group = "Media" }),
    awful.key({ nil,    }, "XF86MonBrightnessDown", 
        function() awesome.emit_signal("brightness::change", -5) end,
        { description = "Decrease screen brightness", group = "Media" }),
    -- language
    awful.key({ modkey, }, "u",
        function() awesome.emit_signal("signal::lang") end,
        { description = "Cycle keyboard layouts", group = "Media" }),
    -- screenshot (selection, screen)
    awful.key({           }, "Print",
        function() awesome.emit_signal("screenshot::selection") end),
    awful.key({ modkey    }, "Print",
        function() awesome.emit_signal("screenshot::fullscreen") end),

    -- UI
    -----
    -- toggle bar
    awful.key({ modkey,           }, "b", function() awesome.emit_signal("widget::bar")       end,
              { description = "Toggle bar visibility", group = "UI" }),
    -- toggle dashboard
    awful.key({ modkey,           }, "d", function() awesome.emit_signal("widget::dashboard") end,
              { description = "Toggle dashboard visibility", group = "UI" }),
})

-- Tag Keybinds
---------------
awful.keyboard.append_global_keybindings({
    -- Switch to tag
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "Switch to tag",
        group       = "Tags",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    -- Show tag
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "Toggle shown tag",
        group       = "Tags",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    -- Send to tag
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "Send client to tag",
        group       = "Tags",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    -- Show focused on tag
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "Show client on tag",
        group       = "Tags",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})

-- Client binds
---------------
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({        }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- toggle state (fullscreen, maximized, floating, sticky)
        awful.key({ modkey,         }, "f", function(c) c.fullscreen = not c.fullscreen c:raise() end,
                  { description = "Toggle fullscreen client", group = "Window Management" }),
        awful.key({ modkey,         }, "m", function(c) c.maximized = not c.maximized c:raise() end,
                  { description = "Toggle maximized client", group = "Window Management" }),
        awful.key({ modkey,         }, "s", awful.client.floating.toggle,
                  { description = "Toggle floating client", group = "Window Management" }),
        awful.key({ modkey, "Shift" }, "s", function(c) c.sticky = not c.sticky end,
                  { description = "Toggle sticky client", group = "Window Management" }),
        -- default close window behaviour
        awful.key({ modkey,         }, "q", function(c) c:kill() end,
                  { description = "Close client", group = "Window Management" }),
        -- send to master
        awful.key({ modkey,         }, "Tab", function(c) c:swap(awful.client.getmaster()) end,
                  { description = "Swap client with master", group = "Window Management" }),
    })
end)
