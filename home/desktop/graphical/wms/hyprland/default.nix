{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}: {
  home.file.".config/hypr/hyprland.conf".text = ''
          source=~/.config/hypr/mocha.conf
          monitor=,preferred,auto,1

          exec-once = $HOME/.config/hypr/autostart

          # The general config of a monitor looks like this:
          # monitor=name,resolution,position,scale

          # A common example:
          # monitor=DP-1,1920x1080@165,0x0,1
          monitor=,highrr,auto,1

          input {
              kb_layout=br
              kb_variant=
              kb_model=
              kb_options=
              kb_rules=

              follow_mouse = 1
              repeat_delay = 150
              repeat_rate = 25
              numlock_by_default = 1
              accel_profile = flat
              sensitivity = 0

              touchpad {
                  natural_scroll=no
              }
          }

          general {
              layout = master
              gaps_in=10
              gaps_out=10
              border_size=3
              #col.active_border = rgb(b2b2ff) rgb(f5c2e7) rgb(70a5eb) 270deg
              #bezier = linear, 0.0, 0.0, 1.0, 1.0
              #animation = borderangle, 1, 100, linear, loop

              #col.active_border=0xfff5c2e7   # pink
              #col.active_border=0xffb2b2ff   # purple
              #col.active_border=0xff8cc1ff   # decayce
              #col.active_border=0xffcdd6f4   # Catppuccin
              #col.active_border=0xffb4befe   # Catppuccin mocha
              #col.inactive_border=0xff1e1e2e
              col.group_border_active=0xfff9e2af
              col.group_border=0xff89dceb
              apply_sens_to_raw=1 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
          }

          decoration {
              multisample_edges = true
              active_opacity = 1
              inactive_opacity = 1
              fullscreen_opacity = 1.0
              drop_shadow = false
              shadow_range=6
              shadow_render_power=4
              shadow_ignore_window = true
              col.shadow=0x22000000 # 0xbbf5c2e7
              col.shadow_inactive=0x22000000
              rounding = 0
              dim_inactive = false
              dim_strength = 0.5
              dim_special = 0.0
              dim_around = 0.0
              blur = false
              blur_new_optimizations = true
              blur_size = 10
              blur_passes = 4
              blur_ignore_opacity = true
          }

          animations {

             # Selmer443 config
             bezier=pace,0.46, 1, 0.29, 0.99
             bezier=overshot,0.13,0.99,0.29,1.1
             bezier = md3_decel, 0.05, 0.7, 0.1, 1
             animation=windowsIn,1,6,md3_decel,slide
             animation=windowsOut,1,6,md3_decel,slide
             animation=windowsMove,1,6,md3_decel,slide
             animation=fade,1,10,md3_decel
             animation=workspaces,1,7,md3_decel,slide
             animation=specialWorkspace,1,8,md3_decel,slide
             animation=border,1,10,md3_decel

             #  PROxZima animations
             #  bezier = overshot, 0.13, 0.99, 0.29, 1.1
             #  animation = windows, 1, 4, overshot, slide
             #  animation = border, 1, 10, default
             #  animation = fade, 1, 10, default
             #  animation = workspaces, 1, 6, overshot, slidevert

             #  Caue's config
             # bezier = in, 0.5, 1.2, 0.4, 1
             # bezier = wss, 0.5, 1.15, 0.4, 1
             # bezier = fader, 0.33, 1, 0.68, 1
             # bezier = out, 0, 1, 0.6, 1
             # animation = windows, 1, 4, in
             # animation = border, 1, 10, default
             # animation = fade, 1, 7, fader
             # animation = workspaces, 1, 5, wss, slide

             #  Chris Titus config
             #  bezier = overshot, 0.05, 0.9, 0.1, 1.05
             #  bezier = smoothOut, 0.36, 0, 0.66, -0.56
             #  bezier = smoothIn, 0.25, 1, 0.5, 1
             #  animation = windows, 1, 5, overshot, slide
             #  animation = windowsOut, 1, 4, smoothOut, slide
             #  animation = windowsMove, 1, 4, default
             #  animation = border, 1, 10, default
             #  animation = fade, 1, 10, smoothIn
             #  animation = fadeDim, 1, 10, smoothIn
             #  animation = workspaces, 1, 6, default
          }

          misc {
          vfr = true # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
          vrr = 2 # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
          }

          dwindle {
            no_gaps_when_only = false
              pseudotile=0 # enable pseudotiling on dwindle
              special_scale_factor = 0.8
    split_width_multiplier = 1.0
    use_active_for_splits = true
              force_split=0
              preserve_split = true
              default_split_ratio = 1.0
          }

          master {
            orientation = right
            no_gaps_when_only=true
            special_scale_factor = 0.8
    new_is_master = true
    no_gaps_when_only = false
          }

          gestures {
          #    workspace_swipe=yes
          #    workspace_swipe_fingers=4
          }

          debug {
              damage_tracking = 2 # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
          }

          # Window rules
          windowrule=tile,title:^(kitty)$
          windowrule=float,title:^(fly_is_kitty)$
          windowrule = opacity 1.0 override 1.0 override,^(kitty)$ # Active/inactive opacity
          windowrule = tile,^(Spotify)$
          windowrule = tile,^(neovide)$
          windowrule = opacity 1.0 override 1.0 override,^(neovide)$ # Active/inactive opacity
          windowrulev2 = opacity 1.0 1.0,class:^(wofi)$

          windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
    windowrulev2 = noanim,class:^(xwaylandvideobridge)$
    windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
    windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

          # Animation override
          windowrule = animation move 60%, Rofi
          # blurls=waybar

          # Mouse binds
          bind=SUPER,mouse_down,workspace,e+1
          bind=SUPER,mouse_up,workspace,e-1
          bindm=SUPER,mouse:272,movewindow
          bindm=SUPER,mouse:273,resizewindow


          # Binds
          bind=SUPER,RETURN,exec,foot
          bind=ALT,RETURN,exec,kitty --single-instance
          bind=,Print,exec,~/.config/hypr/scripts/screenshot.sh
          bind=SUPER,Q,killactive,
          bind=SUPER,M,exit,
          bind=SUPER,S,togglefloating,
          bind=SUPER,space,exec,wofi --show drun -I -s ~/.config/wofi/style.css DP-3
          bind=SUPER,P,pseudo,
          bind=SUPER SHIFT,V,exec,~/.config/eww/fool_moon/bar/scripts/widgets toggle-clip
          bind=SUPER SHIFT,C,exec,~/.config/hypr/scripts/wallpaper_picker

          #bind=SUPER,h,movefocus,l
          #bind=SUPER,l,movefocus,r
          #bind=SUPER,k,movefocus,u
          #bind=SUPER,j,movefocus,d

          bind=SUPER,left,movefocus,l
          bind=SUPER,down,movefocus,r
          bind=SUPER,up,movefocus,u
          bind=SUPER,right,movefocus,d

          #bind=CTRL,1,workspace,1
          #bind=CTRL,2,workspace,2
          #bind=CTRL,3,workspace,3
          #bind=CTRL,4,workspace,4
          #bind=CTRL,5,workspace,5
          #bind=CTRL,6,workspace,6
          bind=SUPER,1,workspace,1
          bind=SUPER,2,workspace,2
          bind=SUPER,3,workspace,3
          bind=SUPER,4,workspace,4
          bind=SUPER,5,workspace,5
          bind=SUPER,6,workspace,6
          bind=SUPER,7,workspace,7
          bind=SUPER,8,workspace,8
          bind=SUPER,9,workspace,9
          bind=SUPER,0,workspace,10
          bind=SUPER,z,exec,waybar
          bind=SUPER,x,exec,"kill (pidof waybar)"



          ################################## Move ###########################################
          bind = SUPER SHIFT, H, movewindow, l
          bind = SUPER SHIFT, L, movewindow, r
          bind = SUPER SHIFT, K, movewindow, u
          bind = SUPER SHIFT, J, movewindow, d
          bind = SUPER SHIFT, left, movewindow, l
          bind = SUPER SHIFT, right, movewindow, r
          bind = SUPER SHIFT, up, movewindow, u
          bind = SUPER SHIFT, down, movewindow, d

          #---------------------------------------------------------------#
          # Move active window to a workspace with mainMod + ctrl + [0-9] #
          #---------------------------------------------------------------#
          bind = SUPER $mainMod CTRL, 1, movetoworkspace, 1
          bind = SUPER $mainMod CTRL, 2, movetoworkspace, 2
          bind = SUPER $mainMod CTRL, 3, movetoworkspace, 3
          bind = SUPER $mainMod CTRL, 4, movetoworkspace, 4
          bind = SUPER $mainMod CTRL, 5, movetoworkspace, 5
          bind = SUPER $mainMod CTRL, 6, movetoworkspace, 6
          bind = SUPER $mainMod CTRL, 7, movetoworkspace, 7
          bind = SUPER $mainMod CTRL, 8, movetoworkspace, 8
          bind = SUPER $mainMod CTRL, 9, movetoworkspace, 9
          bind = SUPER $mainMod CTRL, 0, movetoworkspace, 10
          bind = SUPER $mainMod CTRL, left, movetoworkspace, -1
          bind = SUPER $mainMod CTRL, right, movetoworkspace, +1
          # same as above, but doesnt switch to the workspace
          bind = SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1
          bind = SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2
          bind = SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3
          bind = SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4
          bind = SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5
          bind = SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6
          bind = SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7
          bind = SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8
          bind = SUPER $mainMod SHIFT, 9, movetoworkspacesilent, 9
          bind = SUPER $mainMod SHIFT, 0, movetoworkspacesilent, 10

          bind=SUPER,r,exec,kitty --hold "wf-recorder" "--audio" "--file=$(date).mp4"
          bind=SUPER,n,exec,~/.local/bin/lvimn
          bind=SUPER,e,exec,emacsclient -c -a 'emacs'

          bind=SUPER,g,togglegroup
          bind=SUPER,tab,changegroupactive
          bind=SUPER $mainMod SHIFT,B,exec, killall -3 eww & sleep 1 && ~/.config/hypr/themes/winter/eww/launch_bar

          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec_always {
              gsettings set $gnome-schema gtk-theme 'whitesur-gtk-theme'
              gsettings set $gnome-schema icon-theme 'Papirus-Dark'
              gsettings set $gnome-schema cursor-theme 'macOS-BigSur'
              gsettings set $gnome-schema font-name 'FiraCode Nerd Font'
          }
          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

          debug {
          damage_tracking = 2 # leave it on full unless you hate your GPU and want to make it suffer
          }

          # Themes
          #source=~/.config/hypr/themes/neon/theme.conf
          #source=~/.config/hypr/themes/cyber/theme.conf
          #source=~/.config/hypr/themes/garden/theme.conf
          source=~/.config/hypr/themes/catppuccin-macchiato.conf
  '';
}
