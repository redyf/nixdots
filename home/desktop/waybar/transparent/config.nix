{ config, ... }:
{
  mainBar = {
    modules-left = [
      "custom/power"
      "hyprland/workspaces"
    ];
    # modules-center = [ ];
    modules-right = [
      "tray"
      "bluetooth"
      "network"
      "battery"
      "pulseaudio"
      "clock"
    ];

    "custom/power" = {
      format = "⭘ ";
      tooltip = false;
      on-click = "wlogout -b 5";
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      warp-on-scroll = false;
      format = "{name}";
      cursor = true;
    };

    tray = {
      icon-size = 20;
      spacing = 10;
      cursor = true;
    };

    bluetooth = {
      format = " 󰂯 ";
      format-disabled = " 󰂲 ";
      format-connected = " 󰂱 ";
      on-click = "blueman-manager";
    };

    network = {
      format-wifi = "  {essid}";
      format-ethernet = "  Ethernet";
      format-linked = "  Linked (No IP)";
      format-disconnected = "  Disconnected";
      tooltip = false;
    };

    battery = {
      states = {
        good = 85;
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-full = "{icon} {capacity}%";
      format-plugged = " {capacity}%";
      format-charging = " {capacity}%";
      format-alt = "{icon} {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      tooltip-format = "{time}";
      cursor = false;
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "  {volume}%";
      format-bluetooth = " {volume}%";
      format-bluetooth-muted = "  {volume}%";
      format-icons = {
        headphone = " ";
        headset = " ";
        default = [ " " ];
      };
      on-click = "pavucontrol";
    };

    clock = {
      format = "{:%a %d/%m/%Y ~ %H:%M}";
      tooltip-format = "<span size='15000'><tt>{calendar}</tt></span>";
      calendar = {
        mode = "month";
        format = {
          months = "<span color='#F5C2E7'><b>{}</b></span>";
          weekdays = "<span color='#89B4FA'><b>{}</b></span>";
          days = "<span color='#CDD6F4'><b>{}</b></span>";
          today = "<span color='#F9E2AF'><b>{}</b></span>";
        };
      };
      on-click = "swaync-client -t -sw";
    };
  };
}
