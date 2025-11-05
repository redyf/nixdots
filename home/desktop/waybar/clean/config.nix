{ config, ... }:
{
  mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "custom/sep"
      # "hyprland/layout"
      # "custom/sep"
      "hyprland/window"
    ];

    modules-right = [
      # "custom/sep"
      # "battery"
      "custom/sep"
      "network"
      "custom/sep"
      "cpu"
      "custom/sep"
      "memory"
      "custom/sep"
      "disk"
      "custom/sep"
      "clock"
      "custom/sep"
      "tray"
    ];

    clock = {
      format = "{:%H:%M}";
      format-alt = "{:%Y-%m-%d}";
    };

    cpu = {
      format = "CPU: {usage}%";
      tooltip = false;
    };

    memory = {
      format = "Mem: {used}GiB";
    };

    disk = {
      interval = 60;
      path = "/";
      format = "Disk: {free}";
    };

    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "Bat: {capacity}% {icon} {time}";
      format-plugged = "{capacity}% ";
      format-alt = "Bat {capacity}%";
      format-time = "{H}:{M}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
    };

    network = {
      format = "Online";
      format-disconnected = "Disconnected ⚠";
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      disable-scroll = true;
      all-outputs = true;
      on-click = "activate";
    };

    "hyprland/layout" = {
      format = "[{layout}]";
    };

    "hyprland/window" = {
      format = "{title}";
      max-length = 60;
    };

    "custom/sep" = {
      format = "|";
      interval = 0;
    };
  };
}
