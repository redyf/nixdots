{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  mainBar = {
    # position = "top";
    layer = "top";
    height = 16;
    margin-top = 0;
    margin-bottom = 0;
    margin-right = 0;
    margin-left = 0;
    modules-left = ["custom/launcher" "custom/playerctl" "custom/playerlabel"];
    modules-center = [
      "wlr/workspaces"
      # "cpu"
    ];
    modules-right = [
      "custom/notification"
      "memory"
      "disk"
      "tray"
      "network"
      "pulseaudio"
      "clock"
      "custom/power-menu"
    ];
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

    "wlr/workspaces" = {
      active-only = false;
      all-outputs = true;
      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
        sort-by-number = true;
      };
    };

    "custom/playerctl" = {
      format = "{icon}";
      return-type = "json";
      max-length = 64;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-scroll-down = "playerctl previous";
      on-click = "playerctl play-pause";
      on-scroll-up = "playerctl next";
      format-icons = {
        Playing = "<span foreground='#6791eb'>󰐌 </span>";
        Paused = "<span foreground='#cdd6f4'>󰏥 </span>";
      };
    };

    "custom/playerlabel" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 48;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      format-icons = {
        Playing = "<span foreground='#6791eb'>󰐌 </span>";
        Paused = "<span foreground='#cdd6f4'>󰏥 </span>";
      };
    };

    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon}  {capacity}%";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{icon} {time}";
      # "format-good"= "", // An empty format will hide the module
      # "format-full"= "";
      format-icons = ["" "" "" "" ""];
    };

    memory = {
      interval = 30;
      format = " {used:0.1f}G / {total:0.1f}G";
      on-click = "foot -e btop";
      tooltip = false;
    };

    cpu = {
      format = "󰻠 {usage}%";
      format-alt = "󰻠 {avg_frequency} GHz";
      interval = 5;
    };

    disk = {
      format = "󰋊 {}%";
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

    tray = {
      icon-size = 16;
      spacing = 5;
    };

    backlight = {
      # "device"= "acpi_video1";
      format = "{icon} {percent}%";
      format-icons = ["" "" "" "" "" "" "" "" ""];
      #	"on-scroll-up"=;
      #	"on-scroll-down"=;
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{volume}%  {format_source}";
      format-bluetooth-muted = "󰖁 ";
      format-muted = "󰖁";
      format-icons = {
        headphone = "";
        hands-free = "󰂑";
        headset = "󰂑";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      # on-click-right = "bash ~/.scripts/volume mute";
      # on-scroll-up = "bash ~/.scripts/volume up";
      # on-scroll-down = "bash ~/.scripts/volume down";
      scroll-step = 5;
      on-click = "pavucontrol";
    };
    "custom/power-menu" = {
      format = "⏻";
      on-click = "~/.config/waybar/scripts/power-menu/powermenu.sh";
    };

    "custom/notification" = {
      exec = "~/.config/waybar/scripts/notification.sh";
      on-click = "dunstctl set-paused toggle";
      on-click-right = "notify-send -t 1 'swww' '1' & ~/flake/home/desktop/graphical/wms/hyprland/scripts/wall";
      return-type = "json";
      max-length = 50;
      format = "{}";
    };
    "custom/launcher" = {
      format = "";
      on-click = "bemenu-run";
      on-click-right = "bash $HOME/.config/rofi/run.sh";
      tooltip = "false";
    };

    "custom/wf-recorder" = {
      format = "{}";
      interval = "once";
      exec = "echo ''";
      tooltip = "false";
      exec-if = "pgrep 'wf-recorder'";
      on-click = "exec ./scripts/wlrecord.sh";
      signal = 8;
    };

    "custom/hyprpicker" = {
      format = "󰈋";
      on-click = "hyprpicker -a -f hex";
      on-click-right = "hyprpicker -a -f rgb";
    };
  };
}
