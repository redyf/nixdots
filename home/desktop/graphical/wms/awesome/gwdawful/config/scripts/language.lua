-----------------------------
-- Layout Switching Script --
-----------------------------

-- Imports
----------
local awful     = require('awful')
local naughty   = require('naughty')
local bt        = require('beautiful')

local icon      = require('gears.filesystem').get_configuration_dir() .. "themes/assets/notification/language.svg"
local lang_icon = require('gears.color').recolor_image(icon, bt.notification_accent)

-- Language Switching
---------------------
local opts = bt.caps_super and "-option caps:super" or ""
awesome.connect_signal('signal::lang', function()
    awful.spawn.easy_async_with_shell(
        'setxkbmap -query | grep layout:', function(stdout)
            local content
            local content_old = bt.kb_layout1
            if stdout:match(bt.kb_layout2) then
                awful.spawn('setxkbmap ' .. bt.kb_layout1 .. ' ' .. opts)
                content = bt.kb_layout1
            else
                awful.spawn('setxkbmap ' .. bt.kb_layout2 .. ' ' .. opts)
                content = bt.kb_layout2
            end
            local notif = naughty.notify({
                    title   = "Keyboard Layout", 
                    icon    = lang_icon,
                    text    = "Changed to " .. content,
                    timeout = 3
            }, notif)
    end)
end)
