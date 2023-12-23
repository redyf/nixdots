{
  inputs,
  pkgs,
  ...
}: let
  hyprland_flake = inputs.hyprland.packages.${pkgs.system}.hyprland;
  fontsize = "12";
  oxocarbon_pink = "ff7eb6";
  oxocarbon_border = "393939";
  oxocarbon_background = "161616";
  background = "rgba(11111B00)";
  tokyonight_blue = "rgba(7aa2f7ee) rgba(87aaf8ee) 45deg";
  tokyonight_background = "rgba(32344aaa)";
  opacity = ".85";
  cursor = "Numix-Cursor";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
    };
    settings = {
      "$mainMod" = "SUPER";
      monitor = [
        ",highrr,auto,1"
        # "DP-3,1920x1080@165,0x0,auto"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        repeat_delay = 140;
        repeat_rate = 30;
        numlock_by_default = 1;
        accel_profile = "flat";
        sensitivity = 0;
        force_no_accel = 1;
        touchpad = {
          natural_scroll = 1;
        };
      };

      general = {
        gaps_in = 1;
        gaps_out = 2;
        border_size = 3;
        "col.active_border" = "${tokyonight_blue}";
        "col.inactive_border" = "${tokyonight_background}";
        layout = "dwindle";
        apply_sens_to_raw = 1; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      };

      decoration = {
        rounding = 12;
        shadow_ignore_window = true;
        drop_shadow = false;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgb(${oxocarbon_background})";
        "col.shadow_inactive" = "${background}";
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = 0.0117;
          contrast = 1.5;
          brightness = 1;
          xray = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "pace,0.46, 1, 0.29, 0.99"
          "overshot,0.13,0.99,0.29,1.1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
        ];
        animation = [
          "windowsIn,1,6,md3_decel,slide"
          "windowsOut,1,6,md3_decel,slide"
          "windowsMove,1,6,md3_decel,slide"
          "fade,1,10,md3_decel"
          "workspaces,1,9,md3_decel,slide"
          "workspaces, 1, 6, default"
          "specialWorkspace,1,8,md3_decel,slide"
          "border,1,10,md3_decel"
        ];
      };

      misc = {
        vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
        vrr = false; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
      };

      dwindle = {
        pseudotile = true; # enable pseudotiling on dwindle
        force_split = 0;
        preserve_split = true;
        default_split_ratio = 1.0;
        no_gaps_when_only = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
      };

      master = {
        mfact = 0.5;
        orientation = "right";
        special_scale_factor = 0.8;
        new_is_master = true;
        no_gaps_when_only = false;
      };

      gestures = {
        workspace_swipe = false;
      };

      debug = {
        damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
      };

      exec-once = [
        "easyeffects --gapplication-service" # Starts easyeffects in the background
        "$HOME/.config/hypr/autostart"
        "exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      bind = [
        "SUPER,Q,killactive,"
        "SUPER,M,exit,"
        "SUPER,S,togglefloating,"
        "SUPER,g,togglegroup"
        # "SUPER,tab,changegroupactive"
        # "SUPER,P,pseudo,"

        # Vim binds
        "SUPER,h,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,k,movefocus,u"
        "SUPER,j,movefocus,d"

        "SUPER,left,movefocus,l"
        "SUPER,down,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,right,movefocus,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        # "SUPER,9,workspace,9"
        # "SUPER,0,workspace,10"

        #CTRL,1,workspace,1
        #CTRL,2,workspace,2
        #CTRL,3,workspace,3
        #CTRL,4,workspace,4
        #CTRL,5,workspace,5
        #CTRL,6,workspace,6

        ################################## Move ###########################################
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        #---------------------------------------------------------------#
        # Move active window to a workspace with mainMod + ctrl + [0-9] #
        #---------------------------------------------------------------#
        # "SUPER $mainMod CTRL, 1, movetoworkspace, 1"
        # "SUPER $mainMod CTRL, 2, movetoworkspace, 2"
        # "SUPER $mainMod CTRL, 3, movetoworkspace, 3"
        # "SUPER $mainMod CTRL, 4, movetoworkspace, 4"
        # "SUPER $mainMod CTRL, 5, movetoworkspace, 5"
        # "SUPER $mainMod CTRL, 6, movetoworkspace, 6"
        # "SUPER $mainMod CTRL, 7, movetoworkspace, 7"
        # "SUPER $mainMod CTRL, 8, movetoworkspace, 8"
        # "SUPER $mainMod CTRL, 9, movetoworkspace, 9"
        # "SUPER $mainMod CTRL, 0, movetoworkspace, 10"
        # "SUPER $mainMod CTRL, left, movetoworkspace, -1"
        # "SUPER $mainMod CTRL, right, movetoworkspace, +1"
        # same as above, but doesnt switch to the workspace
        "SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8"
        # "SUPER $mainMod SHIFT, 9, movetoworkspacesilent, 9"
        # "SUPER $mainMod SHIFT, 0, movetoworkspacesilent, 10"

        "SUPER,RETURN,exec,kitty"
        "ALT,RETURN,exec,foot"
        "SUPER,n,exec,neovide"
        "SUPER,e,exec,emacsclient -c -a 'emacs'"
        "SUPER,o,exec,anytype --use-gl=desktop"
        ",Print,exec,~/.config/hypr/scripts/screenshot.sh"
        "SUPER,space,exec,bemenu-run"
        # "SUPER,z,exec,waybar"
        # "SUPER,space,exec, tofi-drun --drun-launch=true"
        # SUPER,space,exec,wofi --show drun -I -s ~/.config/wofi/style.css DP-3
        # "SUPER SHIFT,V,exec,~/.config/eww/fool_moon/bar/scripts/widgets toggle-clip"
        # "SUPER SHIFT,C,exec,~/.config/hypr/scripts/wallpaper_picker"
        # "SUPER $mainMod SHIFT,B,exec, killall -3 eww & sleep 1 && ~/.config/hypr/themes/winter/eww/launch_bar"
      ];

      bindm = [
        # Mouse binds
        # "SUPER,mouse_down,workspace,e+1"
        # "SUPER,mouse_up,workspace,e-1"
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      # bindle = [
      #     # Backlight Keys
      #     ",XF86MonBrightnessUp,exec,light -A 5"
      #     ",XF86MonBrightnessDown,exec,light -U 5"
      #     # Volume Keys
      #     ",XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%  "
      #     ",XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%  "
      # ];
      # bindl = [
      #     ",switch:on:Lid Switch, exec, swaylock -f -i ~/photos/wallpapers/wallpaper.png"
      #     ",switch:off:Lid Switch, exec, swaylock -f -i ~/photos/wallpapers/wallpaper.png"
      # ];

      windowrule = [
        # Window rules
        "tile,title:^(kitty)$"
        "float,title:^(fly_is_kitty)$"
        "tile,^(Spotify)$"
        "tile,^(neovide)$"
        "tile,^(wps)$"
        "opacity 1.0 override 1.0 override,^(neovide)$"
      ];

      windowrulev2 = [
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        # "opacity ${custom.opacity} ${custom.opacity},class:^(WebCord)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(mpv)$"
        "opacity 1.0 1.0,class:^(wofi)$"
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];
    };

    # Submaps
    extraConfig = ''
           # source = ~/.config/hypr/themes/catppuccin-macchiato.conf
           # source = ~/.config/hypr/themes/oxocarbon.conf
           env = LIBVA_DRIVER_NAME,nvidia
           env = XDG_SESSION_TYPE,wayland
           env = GBM_BACKEND,nvidia-drm
           env = __GLX_VENDOR_LIBRARY_NAME,nvidia
           env = WLR_NO_HARDWARE_CURSORS,1
      #     # will switch to a submap called resize
      #     bind=$mainMod,R,submap,resize
      #
      #     # will start a submap called "resize"
      #     submap=resize
      #
      #     # sets repeatable binds for resizing the active window
      #     binde=,L,resizeactive,15 0
      #     binde=,H,resizeactive,-15 0
      #     binde=,K,resizeactive,0 -15
      #     binde=,J,resizeactive,0 15
      #
      #     # use reset to go back to the global submap
      #     bind=,escape,submap,reset
      #     bind=$mainMod,R,submap,reset
      #
      #     # will reset the submap, meaning end the current one and return to the global one
      #     submap=reset
    '';
  };
}
