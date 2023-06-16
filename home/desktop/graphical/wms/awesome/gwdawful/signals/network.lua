--------------------
-- network signal --
--------------------
-- Reports status, and can toggle it.

-- Imports
----------
local awful = require('awful')
local gears = require('gears')

-- Network Fetching and Signal Emitting
---------------------------------------
-- Emit a network status signal
local status_old = -1
local function emit_network_status()
    awful.spawn.easy_async_with_shell(
        "bash -c 'nmcli networking connectivity check'", function(stdout)  
            local status    = stdout:match("full") -- boolean
            local status_id = status and 1 or 0    -- integer
            if status_id ~= status_old then
                awesome.emit_signal('signal::network', status)
                status_old = status_id
            end
        end)
end

-- Change network status
awesome.connect_signal('network::toggle', function()
    if status_old == 0 then
        awful.spawn("nmcli networking on")
    else
        awful.spawn("nmcli networking off")
    end
end)

-- Refreshing
-------------
gears.timer {
    timeout     = 5,
    call_now    = true,
    autostart   = true,
    callback    = function() 
        emit_network_status()
    end
}
