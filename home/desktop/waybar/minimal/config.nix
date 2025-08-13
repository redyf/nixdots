{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  c = color: "#${color}";
in
{
  mainBar = {
    layer = "top";
    height = 24;
    spacing = 0;
    margin = "0px 0px 0px 0px";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [
      "tray"
      "keyboard-state"
      "pulseaudio"
      "battery"
      "network"
    ];
    clock = {
      format = "{:%I:%M %p}";
      tooltip = false;
    };
    tray = {
      icon-size = 13;
      spacing = 10;
      show-passive-items = true;
    };
    "keyboard-state" = {
      "numlock" = true;
      "capslock" = true;
      "format" = "{name} {icon}";
      "format-icons" = {
        "locked" = "";
        "unlocked" = "";
      };
    };
    pulseaudio = {
      format = "<span color='${c colors.base0B}'>vol</span> {volume}%";
      format-bluetooth = "<span color='${c colors.base0B}'>vol</span> {volume}%  {format_source}";
      format-bluetooth-muted = "<span color='${c colors.base0B}'>󰖁</span>";
      format-muted = "<span color='${c colors.base0B}'>󰖁</span>";
      format-icons = {
        headphone = "";
        hands-free = "󰂑";
        headset = "󰂑";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
      on-click = "pavucontrol";
    };
    battery = {
      format = "<span color='${c colors.base09}'>bat</span> {capacity}%";
      format-charging = "<span color='${c colors.base09}'>bat</span> {capacity}%";
      format-full = "<span color='${c colors.base09}'>bat</span> {capacity}%";
      tooltip = false;
    };
    network = {
      format-wifi = "<span color='${c colors.base0C}'>net</span> {essid}";
      format-ethernet = "<span color='${c colors.base0C}'>eth</span> {ipaddr}";
      format-disconnected = "<span color='${c colors.base0C}'>net</span> down";
      tooltip = false;
    };
    "hyprland/workspaces" = {
      format = "{name}";
      all-outputs = true;
      sort-by-number = true;
      active-only = false;
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
        "6" = [ ];
        "7" = [ ];
        "8" = [ ];
      };
      on-click = "activate";
    };
  };
}
