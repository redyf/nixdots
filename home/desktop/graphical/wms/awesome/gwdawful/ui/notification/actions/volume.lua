local naughty   = require('naughty')
local bt        = require('beautiful')

local icon_dir  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/notification/"
local audio_on  = require('gears.color').recolor_image(icon_dir .. "audio-on.svg", bt.notification_accent)
local audio_off = require('gears.color').recolor_image(icon_dir .. "audio-off.svg", bt.notification_accent)

-- Sends a notification every time the content of the volume signal
-- is modified.
local timeout = 1.5
local first   = true
awesome.connect_signal('signal::volume', function(volume, muted)
    if first then
        first = false
    else
        local message
        if muted then
            message = "Muted"
        else
            message = tostring(volume) .. "%"
        end
        local notif = naughty.notification({
                title = "Audio", message = message, 
                icon = muted and audio_off or audio_on,
                timeout = timeout, app_name = "volume" 
            }, notif)
    end
end)
