local awful     = require('awful')
local naughty   = require('naughty')
local bt        = require('beautiful')

local icon_dir  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/notification/"
local blue_on   = require('gears.color').recolor_image(icon_dir .. "bluetooth-on.svg", bt.notification_accent)
local blue_off  = require('gears.color').recolor_image(icon_dir .. "bluetooth-off.svg", bt.notification_accent)

-- Sends a notification every time the content of the bluetooth signal
-- is modified.
local timeout = 2
local first   = true
awesome.connect_signal('signal::bluetooth', function(powered)
    if first then
        first = false
    else
        local message = powered and "Bluetooth ON!" or "Bluetooth OFF!"
        local notif = naughty.notification({
                title = "Connectivity", message = message, 
                icon = powered and blue_on or blue_off,
                timeout = timeout, app_name = "bluetooth" 
            }, notif)
    end
end)
