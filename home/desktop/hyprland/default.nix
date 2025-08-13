{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  hyprlandFlake = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      grim # Screenshot tool for hyprland
      slurp # Works with grim to screenshot on wayland
      swappy # Wayland native snapshot editing tool, inspired by Snappy on macOS
      wl-clipboard # Enables copy/paste on wayland

      (writeShellScriptBin "screenshot" ''
        grim -g "$(slurp)" - | wl-copy
      '')

      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')

      (writeShellScriptBin "autostart" ''
        # Variables
        config=$HOME/.config/hypr
        scripts=$config/scripts

        # Waybar (if enabled)
        pkill waybar
        $scripts/launch_waybar &
        $scripts/tools/dynamic &

        # Wallpaper
        swww kill
        swww-daemon
        swww restore

        # Others
        # /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
        # dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
      '')
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd.variables = [ "--all" ];
      xwayland = {
        enable = true;
      };
      settings = {
        "$mainMod" = "SUPER";
        monitor = [
          "DP-3,1920x1080@165,0x0,1"
          # "Unknown-1,disable"
          # ",highrr,auto,auto"
        ];
        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
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
          mouse_refocus = false;
          repeat_delay = 140;
          repeat_rate = 30;
          numlock_by_default = 1;
          accel_profile = "flat";
          sensitivity = -0.6;
          force_no_accel = false;
          touchpad = {
            natural_scroll = 1;
          };
        };

        cursor = {
          enable_hyprcursor = true;
          no_hardware_cursors = true;
        };

        general = {
          gaps_in = 2;
          gaps_out = 0;
          border_size = 0;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          shadow = {
            enabled = false;
            ignore_window = true;
            range = 20;
            render_power = 3;
          };
          blur = {
            enabled = true;
            size = 4;
            passes = 2;
            new_optimizations = true;
            ignore_opacity = true;
            noise = 1.17e-2;
            contrast = 1.3;
            brightness = 1;
            xray = true;
          };
        };

        animations = {
          enabled = true;
          # Original
          # bezier = [
          #   "pace,0.46, 1, 0.29, 0.99"
          #   "overshot,0.13,0.99,0.29,1.1"
          #   "md3_decel, 0.05, 0.7, 0.1, 1"
          # ];
          # animation = [
          #   "windowsIn,1,6,md3_decel,slide"
          #   "windowsOut,1,6,md3_decel,slide"
          #   "windowsMove,1,6,md3_decel,slide"
          #   "fade,1,10,md3_decel"
          #   "workspaces,1,9,md3_decel,slide"
          #   "workspaces, 1, 6, default"
          #   "specialWorkspace,1,8,md3_decel,slide"
          #   "border,1,10,md3_decel"
          # ];
          # Jonkero's
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
        };

        misc = {
          vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
          vrr = 0; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
          disable_hyprland_logo = true;
        };

        dwindle = {
          pseudotile = true; # enable pseudotiling on dwindle
          force_split = 0;
          preserve_split = true;
          default_split_ratio = 1.0;
          special_scale_factor = 0.8;
          split_width_multiplier = 1.0;
          use_active_for_splits = true;
        };

        master = {
          mfact = 0.5;
          orientation = "right";
          special_scale_factor = 0.8;
          new_status = "slave";
        };

        gestures = {
          workspace_swipe = false;
        };

        debug = {
          damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
        };

        exec-once = [
          "autostart"
          "obsidian"
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

          ################################## Move ###########################################
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, J, movewindow, d"
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"

          "SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8"

          "SUPER,RETURN,exec,ghostty"
          "SUPER,n,exec,kitty"
          "SUPER,e,exec,emacsclient -c -a 'emacs'"
          ",Print,exec,screenshot"
          "SUPER,Print,exec,screenshot-edit"
          "SUPER,o,exec,obsidian"
          "SUPER,i,exec,idea-ultimate"
          "SUPER SHIFT,C,exec,wallpaper"
          "SUPER,z,exec,waybar"
          "SUPER,space,exec,wofi --show drun -I -s ~/.config/wofi/style.css DP-3"
        ];

        bindm = [
          # Mouse binds
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];

        windowrulev2 = [
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
        ];

        ecosystem = {
          no_update_news = true;
        };
      };
    };

    # Hyprland configuration files
    xdg.configFile = {
      "hypr/scripts/launch_waybar".source = ./scripts/launch_waybar;
      "hypr/scripts/tools/dynamic".source = ./scripts/tools/dynamic;
    };
  };
}
