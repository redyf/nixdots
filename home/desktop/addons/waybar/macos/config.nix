{ pkgs, ... }:
let
  customDate = "${pkgs.writeShellScriptBin "custom_date" ''
    date '+%a %d %b'
  ''}/bin/custom_date";
in
{
  mainBar = {
    layer = "top";
    height = 35;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    spacing = 10;
    border-size = 0;
    padding = 10;

    modules-left = [
      "custom/launcher"
      "hyprland/window"
      "custom/texttwo"
      "custom/textthree"
      "custom/textfour"
      "custom/textfive"
    ];
    modules-right = [
      "tray"
      "image#ethernetart"
      "custom/date"
      "clock"
    ];

    "tray" = {
      icon-size = 13;
      spacing = 10;
    };

    clock = {
      format = "{:%H:%M %p}";
      tooltip-format = "{:%A, %B %d, %Y}";
    };

    "custom/date" = {
      exec = customDate;
      interval = 60;
      tooltip = false;
    };

    "hyprland/window" = {
      format = "{class}";
      max-length = 20;
      rewrite = {
        "^(?!.*\\S).*" = "Finder";
      };
    };

    "custom/launcher" = {
      "format" = "";
    };

    "custom/texttwo" = {
      exec = "echo 'File'";
      interval = 60;
      return-type = "plain";
      on-click = "Thunar";
    };

    "custom/textthree" = {
      exec = "echo 'Edit'";
      interval = 60;
      return-type = "plain";
      on-click = "krita";
    };

    "custom/textfour" = {
      exec = "echo 'View'";
      interval = 60;
      return-type = "plain";
    };

    "custom/textfive" = {
      exec = "echo 'Help'";
      interval = 60;
      return-type = "plain";
      on-click = "yad --title='Help' --text-info --width=600 --height=400 --filename=<(man hyprland | col -bx)";
    };

    "image#ethernetart" = {
      path = "/home/redyf/.config/waybar/icons/wifi-white.png";
      size = 13;
      interval = 60;
    };
  };

  home.file.".config/waybar/icons/wifi-white.png".source = ./wifi-white.png;
}
