----------------------
-- animated taglist --
----------------------

-- stolen from Alpha with love <3
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local rubato    = require('modules.rubato')

local line_long   = beautiful.bar_size * 0.8
local line_middle = beautiful.bar_size * 0.6
local line_short  = beautiful.bar_size * 0.4

local function gettaglist(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = helpers.mkroundedrect(),
        },
        layout = {
            spacing = dpi(beautiful.item_spacing),
            layout  = wibox.layout.fixed.vertical,
        },
        buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                markup = '',
                widget = wibox.widget.textbox,
            },
            id = 'background_role',
            forced_height = dpi(line_middle),
            widget = wibox.container.background,
            create_callback = function (self, tag)
                self.animate = rubato.timed {
                    duration = 0.15,
                    subscribed = function (h)
                        self:get_children_by_id('background_role')[1].forced_height = h
                    end
                }

                self.update = function ()
                    if tag.selected then
                        self.animate.target = (line_long)
                    elseif #tag:clients() > 0 then
                        self.animate.target = (line_middle)
                    else
                        self.animate.target = (line_short)
                    end
                end

                self.update()
            end,
            update_callback = function (self)
                self.update()
            end,
        }
    }
end

return gettaglist
