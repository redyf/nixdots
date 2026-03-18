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
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
      (writeShellScriptBin "screenshot" ''
        grim -g "$(slurp)" - | wl-copy
      '')

      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')
    ];
    xdg.configFile."sway/config".text =
      let
        inherit (config.lib.stylix) colors;
      in
      ''
        # Variáveis
        set $mod Mod4

        output eDP-1 mode 1920x1200@60Hz position 0 0 scale 1 scale_filter smart

        input * {
            xkb_layout "br"
            repeat_delay 140
            repeat_rate 30
            accel_profile "flat"
            pointer_accel -0.4
        }

        input type:touchpad {
          tap enabled
          tap_button_map lrm
          natural_scroll enabled
        }

        gaps inner 2
        gaps outer 0
        default_border pixel 2

        exec noctalia-shell
        exec obsidian

        # Keybinds - Janelas
        bindsym $mod+q kill
        bindsym $mod+Shift+m exit
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
        bindsym $mod+Return exec wezterm
        bindsym $mod+e exec emacsclient -c -a 'emacs'
        bindsym $mod+o exec obsidian
        bindsym $mod+i exec idea-ultimate
        bindsym $mod+space exec wofi --show drun -I -s ~/.config/wofi/style.css
        bindsym $mod+r exec rofi -show drun

        # Screenshots
        bindsym Print exec screenshot
        bindsym $mod+Print exec screenshot-edit
        bindsym Control+Print exec grim -o DP-1 ~/Pictures/screenshot.png

        # Mouse
        floating_modifier $mod normal

        assign [app_id="firefox"] workspace number 1
        assign [class="Firefox"] workspace number 1
        assign [app_id="org.wezfurlong.wezterm"] workspace number 2
        assign [class="org.wezfurlong.Wezterm"] workspace number 2
        assign [app_id="vesktop"] workspace number 3
        assign [class="Vesktop"] workspace number 3
        assign [app_id="obsidian"] workspace number 3
        assign [class="Obsidian"] workspace number 3
        assign [app_id="slack"] workspace number 4
        assign [class="Slack"] workspace number 4
      '';
  };
}
