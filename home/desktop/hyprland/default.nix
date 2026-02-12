{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  hyprlandFlake = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  tokyonight_border = "rgba(7aa2f7ee) rgba(87aaf8ee) 45deg";
  tokyonight_background = "rgba(32344aaa)";
  catppuccin_macchiato_active_border = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
  catppuccin_macchiato_inactive_border = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(24273A) 45deg";
  opacity = "0.95";
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
      inputs.nvibrant.packages.${pkgs.stdenv.hostPlatform.system}.nvibrant

      (writeShellScriptBin "screenshot" ''
        grim -g "$(slurp)" - | wl-copy
      '')

      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')

      (writeShellScriptBin "autostart-swww" ''
        swww kill
        swww-daemon &
        swww restore
      '')

      (writeShellScriptBin "autostart-waybar" ''
        pkill waybar
        waybar -c $HOME/.config/waybar/config -s $HOME/.config/waybar/style.css &
      '')
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      systemd.variables = [ "--all" ];
      xwayland.enable = true;
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      ];
      settings = {
        "$mainMod" = "SUPER";
        monitor = [
          "DP-3,1920x1080@180,0x0,1"
          "HDMI-A-3,1920x1080@144,1920x0,1,transform,1"
        ];

        workspace = [
          "1, monitor:DP-3"
          "2, monitor:DP-3"
          "3, monitor:HDMI-A-3"
          "4, monitor:HDMI-A-3"
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
          sensitivity = -0.4;
          force_no_accel = false;
          touchpad = {
            natural_scroll = 1;
          };
        };

        plugin = {
          hyprscrolling = {
            column_width = 0.5;
            fullscreen_on_one_column = true;
            focus_fit_method = 1;
            follow_focus = true;
            follow_debounce_ms = 150;
          };
        };

        cursor = {
          enable_hyprcursor = true;
          no_hardware_cursors = false;
        };

        general = {
          gaps_in = 2;
          gaps_out = 0;
          border_size = 3;
          layout = "scrolling";
          allow_tearing = true;
          "col.active_border" = lib.mkDefault "${catppuccin_macchiato_active_border}";
          "col.inactive_border" = lib.mkDefault "${catppuccin_macchiato_inactive_border}";
        };

        render = {
          direct_scanout = 1;
        };

        decoration = {
          rounding = 0;
          shadow = {
            enabled = false;
            ignore_window = true;
            range = 20;
            render_power = 1;
          };
          blur = {
            enabled = false;
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
          animation = [
            "borderangle, 1, 100, linear, loop"
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
          vfr = false; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
          vrr = 1; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
          disable_hyprland_logo = true;
        };

        dwindle = {
          pseudotile = true;
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

        debug = {
          damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
        };

        exec-once = [
          "noctalia-shell"
          "[workspace 4 silent] obsidian"
          "nvidia-settings -a '[gpu:0]/GpuPowerMizerMode=1'"
          "nvibrant 0 512 700 0"
          # "gpu-screen-recorder -w portal -s 1920x1080 -f 59.94 -q high -r 45 -replay-storage ram -a default_output -c mp4 -o /home/redyf/Vídeos/clips"
        ];

        bind = [
          "SUPER,Q,killactive,"
          "SUPER SHIFT,M,exit,"
          "SUPER,S,togglefloating,"
          "SUPER,g,togglegroup"

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

          # "SUPER SHIFT, H, movewindow, l"
          # "SUPER SHIFT, L, movewindow, r"
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

          "SUPER, period, layoutmsg, move +col"
          "SUPER, comma, layoutmsg, move -col"
          "SUPER, equal, layoutmsg, colresize +0.2"
          "SUPER, minus, layoutmsg, colresize -0.2"

          "SUPER, P, layoutmsg, promote"
          "SUPER SHIFT, period, layoutmsg, swapcol r"
          "SUPER SHIFT, comma, layoutmsg, swapcol l"
          "SUPER SHIFT, H, layoutmsg, swapcol l"
          "SUPER SHIFT, L, layoutmsg, swapcol r"
          "SUPER, M, layoutmsg, togglefit"

          "SUPER,RETURN,exec,ghostty"
          "SUPER,e,exec,emacsclient -c -a 'emacs'"
          ",Print,exec,screenshot"
          "SUPER,Print,exec,screenshot-edit"
          "CTRL,Print,exec,grim -o DP-1 ~/Pictures/screenshot.png"
          "SUPER,o,exec,obsidian"
          "SUPER,space,exec,wofi --show drun -I"
          "SUPER CTRL, F10, exec, gpu-screen-recorder -w portal -s 1920x1080 -f 59.94 -q high -r 45 -replay-storage ram -a default_output -c mp4 -o /home/redyf/Vídeos/clips"
          "SUPER SHIFT, F10, exec, pkill -f gpu-screen-recorder"
          "SUPER, F10, exec, pkill -f -USR1 gpu-screen-recorder"
        ];

        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];

        windowrule = [
          # "float,class:^(pavucontrol)$"
          # "fullscreen,class:^(artix-games-launcher)$"
          # "float,class:^(file_progress)$"
          # "float,class:^(confirm)$"
          # "float,class:^(dialog)$"
          # "float,class:^(download)$"
          # "float,class:^(notification)$"
          # "float,class:^(error)$"
          # "float,class:^(confirmreset)$"
          # "float,title:^(Open File)$"
          # "float,title:^(branchdialog)$"
          # "float,title:^(Confirm to replace files)$"
          # "float,title:^(File Operation Progress)$"
          # "float,title:^(mpv)$"
          "match:class vesktop, workspace 3"
          # "opacity 1.0 1.0,class:^(wofi)$"
        ];

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
      };
    };
  };
}
