{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  sys = osConfig.modules.system;
in {
  mainBar = {
    layer = "top"; # Original
    # position = "bottom"; # Original
    height = 32;
    # width = "1280";
    spacing = 8;
    margin-top = 6;
    margin-bottom = 2;
    margin-right = 8;
    margin-left = 8;
    fixed-center = false;
    modules-left = [
      "hyprland/workspaces"
      "custom/spotify"
    ];
    modules-center = [
      "hyprland/window"
    ];
    modules-right = [
      # "custom/colorpicker"
      "custom/notification"
      "custom/cava"
      "memory"
      # "disk"
      "pulseaudio"
      "network"
      "clock"
      "tray"
      "custom/power-menu"
    ];

    "wlr/workspaces" = {
      active-only = false;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace m+1";
      on-scroll-down = "hyprctl dispatch workspace m-1";
      format = "{name}";
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
        # "urgent" = "";
        # "active" = "";
        # "default" = "";
      };
    };

    "hyprland/window" = {
      format = "{}";
    };
    "tray" = {
      icon-size = 21;
      spacing = 5;
    };
    "clock" = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%a %b %d}";
      format = " {:%I:%M %p}";
      today-format = "<span color = '#ff6699'><b><u>{}</u></b></span>";
      format-calendar = "<span color='#ecc6d9'><b>{}</b></span>";
      format-calendar-weeks = "<span color='#99ffdd'><b>W{:%U}</b></span>";
      format-calendar-weekdays = "<span color='#ffcc66'><b>{}</b></span>";
      on-scroll = {
        calendar = 1;
      };
    };
    memory = {
      interval = 30;
      format = " {used:0.1f}G / {total:0.1f}G";
      on-click = "foot -e btop";
      tooltip = false;
    };
    disk = {
      format = "󰋊 {percentage_used}%";
      format-alt = "󰋊 {used}/{total} GiB";
      interval = 5;
      path = "/";
    };
    network = {
      # interface = "wlp2*"; # Optional
      format-wifi = "󰖩 {signalStrength}%";
      format-ethernet = "󰈀 {cidr}";
      tooltip-format = "{ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnect = "󰖪";
      on-click = "foot -e nmtui";
    };
    pulseaudio = {
      # scroll-step = 1; # %, can be a float
      format = "{icon} {volume}%";
      format-bluetooth = "{volume}%  {format_source}";
      format-bluetooth-muted = "󰖁 ";
      format-muted = "󰖁";
      # format-source = "{volume}% ";
      # format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "󰂑";
        headset = "󰂑";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "pavucontrol";
    };
    "custom/spotify" = {
      # exec = "python ~/.config/waybar/scripts/mediaplayer.py --player spotify";
      format = " {}";
      return-type = "json";
      on-click = "playerctl --player=spotify play-pause";
      on-scroll-down = "playerctl --player=spotify next";
      on-scroll-up = "playerctl --player=spotify previous";
      tooltip = false;
    };
    "custom/power-menu" = {
      format = "⏻";
      on-click = "~/.config/waybar/scripts/power-menu/powermenu.sh";
    };
    "custom/notification" = {
      # exec = "~/.config/waybar/scripts/notification.sh";
      exec = "~/flake/home/desktop/services/wayland/waybar/scripts/notification.sh";
      on-click = "dunstctl set-paused toggle";
      on-click-right = "notify-send -t 1 'swww' '1' & ~/flake/home/desktop/graphical/wms/hyprland/scripts/wall";
      return-type = "json";
      max-length = 50;
      format = "{}";
    };
    # "custom/colorpicker" = {
    #   format = "";
    #   on-click = "hyprpicker -a -f hex";
    #   on-click-right = "hyprpicker -a -f rgb";
    # };
  };
}
