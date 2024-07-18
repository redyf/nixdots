{pkgs, ...}: {
  mainBar = {
    position = "top";
    layer = "top";
    height = 5;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = ["custom/launcher"];
    modules-center = ["hyprland/workspaces"];
    modules-right = ["cpu" "memory" "pulseaudio" "tray" "clock"];

    clock = {
      calendar = {
        format = {today = "<span color='#b4befe'><b>{}</b></span>";};
      };
      format = "  {:%H:%M}";
      tooltip = "true";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
      format-alt = " {:%d/%m}";
    };

    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
        sort-by-number = true;
      };
    };

    memory = {
      format = "  {}%";
      format-alt = " {used} GB";
      interval = 2;
    };

    cpu = {
      format = "  {usage}%";
      format-alt = "  {avg_frequency} GHz";
      interval = 2;
    };

    tray = {
      icon-size = 20;
      spacing = 8;
    };

    pulseaudio = {
      format = "{icon}  {volume}%";
      format-muted = "󰖁 ";
      format-icons = {default = [" "];};
      scroll-step = 5;
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
    };

    "custom/launcher" = {
      format = "";
      on-click = "pkill wofi || ${pkgs.wofi}/bin/rofi --show drun -I -s ~/.config/wofi/style.css DP-3";
      tooltip = "false";
    };
  };
}
