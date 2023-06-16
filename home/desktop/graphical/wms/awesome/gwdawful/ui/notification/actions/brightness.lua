local naughty = require('naughty')
local bt        = require('beautiful')

local icon_dir  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/notification/"
local bri_high  = require('gears.color').recolor_image(icon_dir .. "brightness-hi.svg", bt.ylw)
local bri_low   = require('gears.color').recolor_image(icon_dir .. "brightness-lo.svg", bt.ylw)

-- Sends a notification every time the content of the bluetooth signal
-- is modified.
local timeout = 1.5
local first   = true
awesome.connect_signal('signal::brightness', function(brightness)
    if first then
        first = false
    else
        local message
        message = "Brightness set to " .. tostring(brightness) .. "%"
        local notif = naughty.notification({
                title = "Screen Brightness", message = message, 
                icon = brightness < 50 and bri_low or bri_high,
                timeout = timeout, app_name = "brightness" 
            }, notif)
    end
end)
