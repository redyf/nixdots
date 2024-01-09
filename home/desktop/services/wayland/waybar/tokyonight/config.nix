_: {
  mainBar = {
    margin-top = 6;
    margin-bottom = 2;
    margin-right = 8;
    margin-left = 8;
    modules-left = [ "custom/wmname" "custom/media" "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ ];
    modules-right = [
      "battery"
      "cpu"
      "memory"
      /*
      "backlight"
      */
      "pulseaudio"
      "clock"
      "network"
      "tray"
      "custom/powermenu"
    ];

    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "1" = [ "DP-3" ];
        "2" = [ "DP-3" ];
        "3" = [ "DP-3" ];
        "4" = [ "DP-3" ];
      };
      active-only = "false";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      disable-scroll = "false";
      all-outputs = "true";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = " ";
        "2" = "";
        "3" = " ";
        "4" = " ";
        "5" = " ";
        "6" = " ";
        "7" = " ";
        "8" = " ";
        "9" = " ";
        "10" = "󰊴 ";
      };
    };

    "custom/media" = {
      "format" = " {}";
      "max-lenght" = "40";
      "interval" = "1";
      "exec" = "playerctl metadata --format '{{ artist }} - {{ title }}'";
      "on-click" = "playerctl play-pause";
      "on-click-right" = "playerctl stop";
      "smooth-scrolling-threshold" = "4";
      "on-scroll-up" = "playerctl next";
      "on-scroll-down" = "playerctl previous";
    };

    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = " ";
        deactivated = " ";
      };
    };

    "tray" = {
      spacing = "10";
    };

    "clock" = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = " {:%H:%M}";
      format-alt = "󰃰 {:%A, %B %d, %Y}";
    };

    "cpu" = {
      format = " {usage}%";
      tooltip = "false";
    };

    "memory" = {
      format = " {}%";
      on-click = "foot -e btop";
    };

    "backlight" = {
      format = "{icon}{percent}%";
      format-icons = [ "󰃞 " "󰃟 " "󰃠 " ];
      on-scroll-up = "light -A 1";
      on-scroll-down = "light -U 1";
    };

    "battery" = {
      states = {
        warning = "30";
        critical = "15";
      };
      format = "{icon}{capacity}%";
      tooltip-format = "{timeTo} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = " ";
      format-alt = "{time} {icon}";
      format-icons = [ "  " "  " "  " "  " "  " ];
    };

    "network" = {
      format-wifi = "󰖩 {essid}";
      # format-ethernet = "{ifname}: {ipaddr}/{cidr} 󰈀 ";
      format-ethernet = "󰈀 {cidr}";
      format-linked = "{ifname} (No IP) 󰈀 ";
      format-disconnected = "󰖪  Disconnected";
      # on-click = "$HOME/.config/hypr/Scripts/wifi-menu";
      on-click = "foot -e nmtui";
      tooltip-format = "{essid} {signalStrength}%";
    };

    "pulseaudio" = {
      format = "{icon}{volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-bluetooth-muted = "   {volume}%";
      format-muted = "  {format_source}";
      format-icons = {
        headphone = " ";
        hands-free = "󰂑 ";
        headset = "󰂑 ";
        phone = " ";
        portable = " ";
        car = " ";
        default = [ " " " " " " ];
      };
      tooltip-format = "{desc} {volume}%";
      on-click = "pavucontrol";
    };

    "custom/wmname" = {
      format = " ";
      tooltip = "false";
      on-click = "$HOME/.config/rofi/launchers/type-1/launcher.sh";
      on-click-right = "$HOME/.config/hypr/Scripts/screenshot";
      on-click-middle = "$HOME/.config/hypr/Scripts/wallpaper-switch";
    };

    "custom/powermenu" = {
      format = " ";
      on-click = "$HOME/.config/rofi/powermenu/powermenu.sh";
    };
  };
}
