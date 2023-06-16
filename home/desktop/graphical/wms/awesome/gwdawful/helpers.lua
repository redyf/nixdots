----------------------
-- helper functions --
----------------------
-- fun fact: not a single one of these is mine.

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = require('beautiful').xresources.apply_dpi

local color     = require('modules.color')
local rubato    = require('modules.rubato')
local cairo     = require("lgi").cairo

-- Helpers
----------
local helpers = {}
-- create a transition animation function
function helpers.apply_transition(opts)
    opts = opts or {}
    local bg      = opts.bg  or beautiful.lbg
    local hbg     = opts.hbg or beautiful.blk
    local element = opts.element
    local prop    = opts.prop
    local background       = color.color { hex = bg }
    local hover_background = color.color { hex = hbg }
    local transition       = color.transition(background, hover_background, color.transition.RGB)
    local fading = rubato.timed {
        duration = 0.30,
    }
    fading:subscribe(function(pos)
        element[prop] = transition(pos / 100).hex
    end)
    return {
        on  = function()
            fading.target = 100
        end,
        off = function()
            fading.target = 0
        end
    }
end

-- add hover support to wibox.container.background-based elements
function helpers.add_hover(element, bg, hbg)
    local transition = helpers.apply_transition {
        element = element,
        prop    = 'bg',
        bg      = bg,
        hbg     = hbg,
    }
    element:connect_signal('mouse::enter', transition.on)
    element:connect_signal('mouse::leave', transition.off)
end

-- create a rounded rect using a custom radius
function helpers.mkroundedrect(radius)
    radius = radius or beautiful.border_radius
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, dpi(radius))
    end
end

-- create a simple rounded-like button with hover support
function helpers.mkbtn(template, bg, hbg, radius)
    local button = wibox.widget {
        {
            template,
            margins = dpi(beautiful.ring_size),
            widget  = wibox.container.margin,
        },
        bg     = bg,
        widget = wibox.container.background,
        shape  = helpers.mkroundedrect(radius),
    }
    if bg and hbg then
        helpers.add_hover(button, bg, hbg)
    end
    return button
end
-- Send key
function helpers.send_key(c, key)
	awful.spawn.with_shell("xdotool key --window " .. tostring(c.window) .. " " .. key)
end

-- Blyaticon's surface cropping function.
-- Takes the aspect ratio of the image and a gears.surface. Also returns a surface.
function helpers.crop_surface(ratio, surf)
    local old_w, old_h = gears.surface.get_size(surf)
    local old_ratio    = old_w/old_h
    if old_ratio == ratio then return surf end

    local new_h = old_h
    local new_w = old_w
    local offset_h, offset_w = 0, 0
    -- quick mafs
    if (old_ratio < ratio) then
       new_h    = math.ceil(old_w * (1/ratio))
       offset_h = math.ceil((old_h - new_h)/2)
    else
       new_w    = math.ceil(old_h * ratio)
       offset_w = math.ceil((old_w - new_w)/2)
    end

    local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
    local cr       = cairo.Context(out_surf)
    cr:set_source_surface(surf, -offset_w, -offset_h)
    cr.operator    = cairo.Operator.SOURCE
    cr:paint()

    return out_surf
end

return helpers
