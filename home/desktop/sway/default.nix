{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sway.enable = lib.mkEnableOption "Enable sway home module";
  };
  config = lib.mkIf config.sway.enable {
    xdg.configFile."sway/config".text =
      let
        inherit (config.lib.stylix) colors;
      in
      ''
          # Variáveis
          set $mod Mod4

          # Monitores
          output DP-3 mode 1920x1080@180Hz position 0,0
          output HDMI-A-3 mode 1920x1080@144Hz position 1920,0 transform 270

          # Workspaces por monitor
          workspace 1 output DP-3
          workspace 2 output DP-3
          workspace 3 output HDMI-A-3
          workspace 4 output HDMI-A-3

          # Input
          input * {
              xkb_layout "br"
              repeat_delay 140
              repeat_rate 30
              accel_profile "flat"
              pointer_accel -0.4
          }

          input type:touchpad {
              natural_scroll enabled
          }

          gaps inner 2
          gaps outer 0
          default_border pixel 2

          exec noctalia-shell
          exec zen-twilight
          exec discord
          exec obsidian

          # Keybinds - Janelas
          bindsym $mod+q kill
          bindsym $mod+m exit
          bindsym $mod+s floating toggle

          # Foco (vim)
          bindsym $mod+h focus left
          bindsym $mod+j focus down
          bindsym $mod+k focus up
          bindsym $mod+l focus right

          # Foco (setas)
          bindsym $mod+Left focus left
          bindsym $mod+Down focus down
          bindsym $mod+Up focus up
          bindsym $mod+Right focus right

          # Mover janelas
          bindsym $mod+Shift+h move left
          bindsym $mod+Shift+j move down
          bindsym $mod+Shift+k move up
          bindsym $mod+Shift+l move right

          bindsym $mod+Shift+Left move left
          bindsym $mod+Shift+Down move down
          bindsym $mod+Shift+Up move up
          bindsym $mod+Shift+Right move right

          # Workspaces
          bindsym $mod+1 workspace number 1
          bindsym $mod+2 workspace number 2
          bindsym $mod+3 workspace number 3
          bindsym $mod+4 workspace number 4
          bindsym $mod+5 workspace number 5
          bindsym $mod+6 workspace number 6
          bindsym $mod+7 workspace number 7
          bindsym $mod+8 workspace number 8

          # Mover para workspace
          bindsym $mod+Shift+1 move container to workspace number 1
          bindsym $mod+Shift+2 move container to workspace number 2
          bindsym $mod+Shift+3 move container to workspace number 3
          bindsym $mod+Shift+4 move container to workspace number 4
          bindsym $mod+Shift+5 move container to workspace number 5
          bindsym $mod+Shift+6 move container to workspace number 6
          bindsym $mod+Shift+7 move container to workspace number 7
          bindsym $mod+Shift+8 move container to workspace number 8

          # Apps
          bindsym $mod+Return exec ghostty
          bindsym $mod+n exec kitty
          bindsym $mod+e exec emacsclient -c -a 'emacs'
          bindsym $mod+o exec obsidian
          bindsym $mod+i exec idea-ultimate
          bindsym $mod+space exec wofi --show drun -I -s ~/.config/wofi/style.css
          bindsym $mod+r exec rofi -show drun

          # Screenshots
          bindsym Print exec screenshot
          bindsym $mod+Print exec screenshot-edit
          bindsym Control+Print exec grim -o DP-1 ~/Pictures/screenshot.png

          # Outros
          bindsym $mod+z exec waybar

          # Mouse
          floating_modifier $mod normal

          # Window rules
          for_window [app_id="pavucontrol"] floating enable
          for_window [app_id="discord|Discord"] move to workspace 3
          for_window [title="^(Open File)$"] floating enable
          for_window [title="^(mpv)$"] floating enable

        #   bar {
        #     position top
        #     status_command while date +'%Y-%m-%d %H:%M'; do sleep 1; done
        #
        #     colors {
        #       background #${colors.base00}
        #       statusline #${colors.base05}
        #       focused_workspace #${colors.base0D} #${colors.base0D} #${colors.base00}
        #       active_workspace #${colors.base03} #${colors.base03} #${colors.base05}
        #       inactive_workspace #${colors.base00} #${colors.base00} #${colors.base05}
        #       urgent_workspace #${colors.base09} #${colors.base09} #${colors.base00}
        #     }
        # }
      '';
  };
}
