----------------------
-- theming settings --
----------------------

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gc        = gears.color
local gfs       = gears.filesystem
local dpi       = beautiful.xresources.apply_dpi

local user      = require('userconf')

local clrs      = require('themes.palettes.' .. user.clr_palette)
local asst_dir  = gfs.get_configuration_dir() .. "themes/assets/"
local pltt_dir  = gfs.get_configuration_dir() .. "themes/palettes/" .. user.clr_palette .. "/"
local awes_dir  = gfs.get_themes_dir() .. "default/layouts/"

local theme     = {}

------------
-- Colors --
------------
theme.nbg   = clrs.nbg
theme.lbg   = clrs.lbg
theme.blk   = clrs.blk
theme.gry   = clrs.gry
theme.wht   = clrs.wht
theme.dfg   = clrs.dfg
theme.nfg   = clrs.nfg

theme.red   = clrs.red
theme.red_d = clrs.red_d
theme.grn   = clrs.grn
theme.grn_d = clrs.grn_d
theme.ylw   = clrs.ylw
theme.ylw_d = clrs.ylw_d
theme.blu   = clrs.blu
theme.blu_d = clrs.blu_d
theme.mag   = clrs.mag
theme.mag_d = clrs.mag_d
theme.cya   = clrs.cya
theme.cya_d = clrs.cya_d

-- General
theme.bg_normal = theme.nbg
theme.bg_focus  = theme.lbg
theme.bg_urgent = theme.blk
theme.fg_normal = theme.nfg
theme.fg_focus  = theme.nfg
theme.fg_urgent = theme.red

if user.dpi ~= nil then
    beautiful.xresources.set_dpi(user.dpi)
end

--------------
-- Settings --
--------------
-- Refactor
-----------
-- Bar position. The position of the rest of the UI is based on this.
theme.bar_side            = user.bar_pos ~= nil and user.bar_pos or "bottom"
theme.is_bar_horizontal   = (theme.bar_side == "top" or theme.bar_side == "bottom") and true 
                            or false
theme.align_direction     = theme.is_bar_horizontal and wibox.layout.align.horizontal
                                                    or wibox.layout.align.vertical
theme.fixed_direction     = theme.is_bar_horizontal and wibox.layout.fixed.horizontal
                                                    or wibox.layout.fixed.vertical

-- Set the title type to the opposite of the bar. If user changes sides,
-- use the other side of said type.
theme.is_title_horizontal = not theme.is_bar_horizontal
theme.change_title_side   = false
theme.title_side          = (theme.is_title_horizontal and theme.change_title_side)         and "bottom" or
                            (not theme.is_title_horizontal and not theme.change_title_side) and "right"  or
                            (not theme.is_title_horizontal and theme.change_title_side)     and "left"   or
                            "top"

-- Position of notifications on the screen. Based on bar and title position.
-- By far the ugliest of the bunch, since there are 8 possibilities.
theme.notification_side   = ((theme.bar_side == "top"    and theme.change_title_side)
                            or (theme.bar_side == "left" and not theme.change_title_side))  and "bottom_right" or
                            ((theme.bar_side == "top"    and not theme.change_title_side)
                            or (theme.bar_side == "right" and not theme.change_title_side)) and "bottom_left"  or
                            ((theme.bar_side == "bottom" and theme.change_title_side)     
                            or (theme.bar_side == "left" and theme.change_title_side))      and "top_right"    or
                            "top_left"

-- Numbers, which I'm hopefully doing better this time
------------------------------------------------------
-- Screen.
theme.scaling             = user.scaling ~= nil and user.scaling * 10.8    or 10.8
theme.aspect_ratio        = user.aspect_ratio ~= nil and user.aspect_ratio or 16/9
theme.full_height         = theme.scaling     * 100
theme.full_width          = theme.full_height * theme.aspect_ratio
-- Widget geometry.
theme.bar_size            = theme.scaling * 4.5
theme.title_size          = theme.scaling * 3
theme.dashboard_size      = theme.scaling * 75
-- This quite specific number will give **pretty** results
-- when dividing most `theme.scaling` values.
theme.item_spacing        = theme.scaling        / 1.8
theme.item_padding        = theme.item_spacing   * 1.333
theme.giga_padding        = theme.item_padding   * 2.5
theme.monster_padding     = theme.giga_padding   * 2
theme.ring_size           = theme.scaling        * 0.37
-- The `title` and `subt` don't refer to the window titles, but rather
-- the size's use in widgets.
theme.tiny_font_size      = theme.scaling        * 0.81
theme.base_font_size      = theme.tiny_font_size * 1.22
theme.subt_font_size      = theme.base_font_size * 1.2
theme.title_font_size     = theme.subt_font_size * 1.23

-- General
----------
theme.modkey                  = user.modkey ~= nil and user.modkey or "Mod4"

theme.caps_super              = false
if user.caps_super ~= nil then
   theme.caps_super = user.caps_super
end

theme.kb_layout1              = user.kb_layout1
theme.kb_layout2              = user.kb_layout2
if theme.caps_super and kb_layout1 ~= nil then
    awful.spawn.once('setxkbmap '.. theme.kb_layout1 ..' -option caps:super')
end

theme.hover_focus             = false
if user.hover_focus ~= nil then
   theme.hover_focus = user.hover_focus
end

-- Features
-----------
theme.battery_enabled         = false
if user.battery ~= nil then
   theme.battery_enabled = user.battery
end
theme.battery_name            = user.battery_name ~= nil    and user.battery_name    or "battery_BAT0"

theme.brightness_enabled      = false
if user.brightness ~= nil then
   theme.brightness_enabled = user.brightness
end
theme.brightness_name         = user.brightness_name ~= nil and user.brightness_name or "intel_backlight"

theme.bluetooth_enabled       = false
if user.bluetooth ~= nil then
   theme.bluetooth_enabled = user.bluetooth
end

-- Fonts 
--------
-- the space at the end is necessary
theme.ui_font                 = user.ui_font ~= nil and user.ui_font .. " " or "IBM Plex Sans "
theme.ic_font                 = user.ic_font ~= nil and user.ic_font .. " " or "Material Icons "
theme.mn_font                 = user.mn_font ~= nil and user.mn_font .. " " or "IBM Plex Mono "
-- default font
theme.font                    = theme.ui_font .. "Medium " .. dpi(theme.tiny_font_size)

-- Gaps
-------
theme.useless_gap             = user.inner_gaps ~= nil and dpi(user.inner_gaps * theme.scaling)
                                or dpi(theme.ring_size)
theme.outer_gaps              = user.outer_gaps ~= nil and user.outer_gaps * theme.scaling
                                or 3 * theme.useless_gap

-- Borders & Corners 
--------------------
theme.border_radius           = user.border_rad ~= nil and user.border_rad * theme.scaling
                                or theme.item_spacing

theme.rounded_clients         = false
if user.round_client ~= nil then
   theme.rounded_clients = user.round_client
end

theme.border_width            = user.border_size ~= nil and dpi(user.border_size * theme.scaling)
                                or dpi(0)
theme.border_width_maximized  = theme.border_width
theme.fullscreen_hide_border  = true
theme.border_color_active     = theme.blk
theme.border_color_normal     = theme.lbg
theme.border_color_urgent     = theme.red

-- Images
---------
-- wallpaper setting
theme.wallpaper               = user.wall ~= nil and user.wall
                                or pltt_dir .. "wall.png"
gears.wallpaper.maximized(theme.wallpaper)
-- others
theme.user_avatar             = user.avatar ~= nil and user.avatar
                                or asst_dir .. "user.png"
theme.player_bg               = user.player_bg ~= nil and user.player_bg
                                or pltt_dir .. "player.png"
theme.icon_theme              = user.icon_pack ~= nil and user.icon_pack or "Papirus"
theme.screenshot_dir          = user.scrnshot_dir == nil and os.getenv("HOME") .. "/Pictures/" or user.scrnshot_dir
-- Awesome icon
if user.awm_icon == nil then
    theme.awesome_icon = require('beautiful.theme_assets').awesome_icon(dpi(theme.scaling * 10), theme.fg_normal, theme.bg_normal)
elseif user.awm_icon == "arch" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/arch.svg", theme.cya)
elseif user.awm_icon == "debian" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/debian.svg", theme.red_d)
elseif user.awm_icon == "fedora" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/fedora.svg", theme.blu)
elseif user.awm_icon == "nix" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/nix.svg", theme.blu)
elseif user.awm_icon == "ubuntu" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/ubuntu.svg", theme.red)
elseif user.awm_icon == "void" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "distro/void.svg", theme.grn)
else
    theme.awesome_icon = user.awm_icon
end

-- Bar
------
theme.bar_enabled             = true
if user.bar_enabled ~= nil then
   theme.bar_enabled = user.bar_enabled
end

theme.wibar_bg                = theme.bg_normal
theme.wibar_fg                = theme.fg_normal
-- tasklist settings
theme.tasklist_plain_task_name   = true
theme.tasklist_disable_icon      = false
theme.tasklist_disable_task_name = true
theme.tasklist_align             = "center"
theme.tasklist_bg_normal         = theme.bg_normal
theme.tasklist_bg_focus          = theme.blk
theme.tasklist_bg_urgent         = theme.fg_urgent
-- taglist settings
theme.taglist_bg_focus           = theme.cya_d
theme.taglist_bg_occupied        = theme.wht
theme.taglist_bg_empty           = theme.gry
theme.taglist_bg_urgent          = theme.fg_urgent
-- systray
theme.systray_max_rows        = 1
theme.systray_icon_spacing    = dpi(theme.item_spacing)

-- Titles
---------
theme.titles_enabled          = true
if user.title_enable ~= nil then
   theme.titles_enabled = user.title_enable
end

theme.titles_inverted         = false
if user.title_invert ~= nil then
   theme.titles_inverted = user.title_invert
end

theme.titlebar_font           = theme.ui_font .. "Bold " .. dpi(theme.scaling)
theme.titlebar_bg_focus       = theme.blk
theme.titlebar_fg_focus       = theme.lbg
theme.titlebar_bg_normal      = theme.lbg
theme.titlebar_fg_normal      = theme.nbg
theme.titlebar_bg_urgent      = theme.fg_urgent
theme.titlebar_fg_urgent      = theme.red_d
-- tabbar
theme.tabbar_bg_normal        = theme.titlebar_bg_normal
theme.tabbar_fg_normal        = theme.titlebar_fg_normal
theme.tabbar_bg_focus         = theme.titlebar_bg_focus
theme.tabbar_fg_focus         = theme.titlebar_fg_focus
theme.tabbar_size             = dpi(theme.title_size)
theme.tabbar_position         = theme.title_side
theme.mstab_bar_padding       = theme.rounded_clients and dpi(theme.useless_gap) or 0
theme.mstab_border_radius     = theme.rounded_clients and dpi(theme.border_radius) or 0

-- Notifications
----------------
theme.notification_padding    = dpi(theme.title_font_size)
theme.notification_spacing    = dpi(theme.notification_padding / 2)
theme.notification_accent     = theme.grn

-- Scratchpad
-------------
theme.scratchpad_width        = user.scratch_high ~= nil and user.scratch_wide * theme.full_width
                                or 0.40 * theme.full_width
theme.scratchpad_height       = user.scratch_high ~= nil and user.scratch_high * theme.full_height
                                or 0.66 * theme.full_height

-- Layouts
----------
theme.gap_single_client       = true
theme.master_width_factor     = 0.56
theme.layout_tile             = gc.recolor_image(awes_dir .. "tilew.png",       theme.fg_normal)
theme.layout_tileleft         = gc.recolor_image(awes_dir .. "tileleftw.png",   theme.fg_normal)
theme.layout_tilebottom       = gc.recolor_image(awes_dir .. "tilebottomw.png", theme.fg_normal)
theme.layout_tiletop          = gc.recolor_image(awes_dir .. "tiletopw.png",    theme.fg_normal)
theme.layout_fairv            = gc.recolor_image(awes_dir .. "fairvw.png",      theme.fg_normal)
theme.layout_floating         = gc.recolor_image(awes_dir .. "floating.png",    theme.fg_normal)
theme.layout_fairh            = gc.recolor_image(awes_dir .. "fairhw.png",      theme.fg_normal)
theme.layout_cornernw         = gc.recolor_image(awes_dir .. "cornernww.png",   theme.fg_normal)
theme.layout_cornerne         = gc.recolor_image(awes_dir .. "cornernew.png",   theme.fg_normal)
theme.layout_cornersw         = gc.recolor_image(awes_dir .. "cornersww.png",   theme.fg_normal)
theme.layout_cornerse         = gc.recolor_image(awes_dir .. "cornersew.png",   theme.fg_normal)

-- Menu
-------
theme.menu_font               = theme.ui_font .. "Bold " .. dpi(theme.scaling)
theme.menu_height             = dpi(theme.monster_padding)
theme.menu_width              = dpi(theme.menu_height * 5)
theme.menu_fg_focus           = theme.fg_focus
theme.menu_bg_focus           = theme.bg_focus
theme.menu_fg_normal          = theme.fg_normal
theme.menu_bg_normal          = theme.bg_normal
theme.menu_border_color       = theme.bg_focus
theme.menu_border_width       = theme.border_width
theme.menu_submenu_icon       = gc.recolor_image(asst_dir .. "menu_expand.svg", theme.fg_focus)

-- Tooltip
----------
theme.tooltip_bg              = theme.bg_focus
theme.tooltip_fg              = theme.fg_normal
theme.tooltip_font            = theme.font
theme.tooltip_shape           = gears.shape.rounded_rect

-- Snap
-------
theme.snap_bg                 = theme.taglist_bg_focus
theme.snap_border_width       = dpi(theme.giga_padding)
theme.snap_shape              = gears.shape.rectangle

return theme
