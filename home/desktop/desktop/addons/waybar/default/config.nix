_: {
  mainBar = {
    layer = "top"; # Waybar at top layer
    position = "top"; # Waybar position (top|bottom|left|right)
    height = 30;
    margin = "0 0 0 0";
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "custom/swap"
      "tray"
      "hyprland/mode"
      "custom/cava-internal"
      "mpd#2"
      "mpd#3"
      "mpd#4"
      "mpd"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "pulseaudio"
      "temperature"
      "memory"
      "network"
      "custom/power"
    ];
    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      format-icons = {
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "5" = "";
        "6" = "";
        "7" = "";
        "8" = "";
        "9" = "";
        "10" = "";
      };
    };
    "mpd" = {
      tooltip = true;
      tooltip-format = "{artist} - {album} - {title} - Total Time : {totalTime:%M:%S}";
      format = " {elapsedTime:%M:%S}";
      format-disconnected = "⚠ Disconnected";
      format-stopped = " Not Playing";
      on-click = "mpc toggle";
      state-icons = {
        playing = "";
        paused = "";
      };
    };
    "mpd#2" = {
      format = "";
      format-disconnected = "";
      format-paused = "";
      format-stopped = "";
      on-click = "mpc -q pause && mpc -q prev && mpc -q start";
    };
    "mpd#3" = {
      interval = 1;
      format = "{stateIcon}";
      format-disconnected = "";
      format-paused = "{stateIcon}";
      format-stopped = "";
      state-icons = {
        paused = "";
        playing = "";
      };
    };
    "mpd#4" = {
      format = "";
      format-disconnected = "";
      format-paused = "";
      format-stopped = "";
      on-click = "mpc -q pause && mpc -q next && mpc -q start";
    };
    "custom/swap" = {
      on-click = "~/.config/waybar/scripts/swap.sh";
      tooltip = "Swap between waybar configs";
      format = "Bg  ";
    };
    "custom/mpd" = {
      format = " {title} - {artist}";
      interval = 5;
      exec = "mpc current --format='\"title\":\"%title%\",\"artist\":\"%artist%\"'";
    };
    "custom/cava-internal" = {
      exec = "sh ~/.config/waybar/scripts/Cava.sh";
      format = "{}";
      tooltip = false;
      on-click = "hyprlandmsg reload & pkill waybar & waybar";
      layer = "below";
      output = "all";
    };
    "hyprland/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };
    "hyprland/window" = {
      format = "~ {app_id}";
    };
    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    "tray" = {
      icon-size = 14;
      spacing = 5;
    };
    "clock" = {
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };
    # "actions": {
    # "on-click-right": "mode",
    # "on-click-forward": "tz_up",
    # "on-click-backward": "tz_down",
    # "on-scroll-up": "shift_up",
    # "on-scroll-down": "shift_down"
    # },
    # "format": "  {:%a %d %b  %I:%M %p}", //12 hour format
    # // "format": " {:%d %m %Y  %H:%M}",	//24 hour format
    # "format-alt": "  {:%d/%m/%Y  %H:%M:%S}",
    # // //"timezones": [ "Kolkata" ],
    # // //"max-length": 200
    # "interval": 1
    # },
    # // "clock": {
    # //     "format": "  {:%H:%M:%S}",
    # //     "format-alt": "  {:%A, %B %d, %Y (%R)}",
    # //     "tooltip-format": "<tt><small>{calendar}</small></tt>",
    # //     "calendar": {
    # //         "mode"          : "month",
    # //         "mode-mon-col"  : 3,
    # //         "weeks-pos"     : "right",
    # //         "on-scroll"     : 1,
    # //         "on-click-right": "mode",
    # //         "format": {
    # //             "months":     "<span color='#ffead3'><b>{}</b></span>",
    # //             "days":       "<span color='#ecc6d9'><b>{}</b></span>",
    # //             "weeks":      "<span color='#99ffdd'><b>W{}</b></span>",
    # //             "weekdays":   "<span color='#ffcc66'><b>{}</b></span>",
    # //             "today":      "<span color='#ff6699'><b><u>{}</u></b></span>"
    # //         }
    # //     },
    # //     "actions": {
    # //         "on-click-right": "mode",
    # //         "on-click-forward": "tz_up",
    # //         "on-click-backward": "tz_down",
    # //         "on-scroll-up": "shift_up",
    # //         "on-scroll-down": "shift_down"
    # //     },
    # //     "interval": 1
    # // },
    "cpu" = {
      format = "﬙ {usage: >3}%";
      on-click = "alacritty -e htop";
    };
    "memory" = {
      format = " {: >3}%";
      on-click = "alacritty -e htop";
    };
    "temperature" = {
      hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
      critical-threshold = 80;
      format = " {temperatureC}°C";
    };
    "backlight" = {
      format = "{icon} {percent: >3}%";
      format-icons = [ "" "" ];
      on-scroll-down = "light -A 5 && light -G | cut -d'.' -f1 > $hyprlandSOCK.wob";
      on-scroll-up = "light -U 5 && light -G | cut -d'.' -f1 > $hyprlandSOCK.wob";
    };
    "battery" = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity: >3}%";
      format-icons = [ "" "" "" "" "" ];
    };
    "network" = {
      format = "⚠ Disabled";
      format-wifi = " {essid}";
      format-ethernet = " Wired";
      format-disconnected = "⚠ Disconnected";
      on-click = "nm-connection-editor";
    };
    "pulseaudio" = {
      scroll-step = 1;
      format = "{icon} {volume: >3}%";
      format-bluetooth = "{icon} {volume: >3}%";
      format-muted = " muted";
      format-icons = {
        headphones = "";
        handsfree = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" ];
      };
      on-click = "pavucontrol";
      on-scroll-up = "pamixer -ui 2 && pamixer --get-volume > $hyprlandSOCK.wob";
      on-scroll-down = "pamixer -ud 2 && pamixer --get-volume > $hyprlandSOCK.wob";
    };
    "custom/power" = {
      format = "⏻";
      on-click = "nwgbar";
      tooltip = false;
    };
    "custom/launcher" = {
      format = " ";
      on-click = "exec nwg-drawer -c 7 -is 70 -spacing 23";
      tooltip = false;
    };
  };
}
