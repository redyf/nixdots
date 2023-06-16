-----------------------------
-- playerctl notifications --
-----------------------------

-- Imports
----------
local naughty   = require('naughty')
local beautiful = require('beautiful')
local bling     = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

-- Notifications
----------------
-- The notification to be sent.
local function notif(title, artist, album_path)
    local previous = naughty.action { name = "PRV" }
    previous:connect_signal('invoked', function()
        playerctl:previous()
    end)
    local pause = naughty.action { name = "PS" }
    pause:connect_signal('invoked', function()
        playerctl:play_pause()
    end)
    local next = naughty.action { name = "NXT" }
    next:connect_signal('invoked', function()
        playerctl:next()
    end)

    naughty.notify {
        title   = title, 
        text    = "by " .. artist:match('.+') or "Unknown", 
        image   = album_path:match('/') and album_path or beautiful.player_bg,
        actions = { previous, pause, next },
        timeout = 2
    }
end

-- Sends a notification every time the playerctl song changes.
local info_first = true
playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, _, _, _)
    if info_first then
        info_first = false
    else
       notif(title, artist, album_path)
    end
end)
