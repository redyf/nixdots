------------------
-- signal files --
------------------

require('signals.volume')
require('signals.network')

local beautiful = require('beautiful')

-- If the user has enabled bluetooth, then
-- emit a status signal.
if beautiful.bluetooth_enabled then
    require('signals.bluetooth')
end

-- If the user has enabled brightness metrics,
-- then emit brightness signal.
if beautiful.brightness_enabled then
    require('signals.brightness')
end

-- If the user has enabled battery metrics,
-- then emit battery signal.
if beautiful.battery_enabled then
    require('signals.battery')
end
