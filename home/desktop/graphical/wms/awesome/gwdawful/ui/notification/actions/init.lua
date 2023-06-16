--------------------------
-- Action notifications --
--------------------------

local beautiful = require('beautiful')

require('ui.notification.actions.volume')
require('ui.notification.actions.playerctl')
if beautiful.brightness_enabled then
    require('ui.notification.actions.brightness')
end
if beautiful.bluetooth_enabled then
    require('ui.notification.actions.bluetooth')
end
