_: {
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
      windowManager = {
        awesome.enable = true;
      };
      displayManager = {
        sessionCommands = ''
          xset r rate 140 30
          xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary
          nitrogen --restore
        '';
      };
      xkb = {
        variant = "";
        layout = "br";
      };
    };
  };
}
