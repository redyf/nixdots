{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      jack.enable = false;
      pulse.enable = true;
      audio.enable = true;
    };

    fstrim.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };
    mysql = {
      enable = false;
      package = with pkgs; mysql80;
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        sessionCommands = ''
          xset r rate 150 25
          xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary
          nitrogen --restore
        '';
      };
      desktopManager = {
        xfce.enable = true;
      };
      windowManager = {
        awesome = {
          enable = false;
          luaModules = with pkgs.luaPackages; [
            luarocks
          ];
        };
      };
      xkb = {
        variant = "";
        layout = "br";
      };
      videoDrivers = ["nvidia"];
    };
    logmein-hamachi.enable = false;
    flatpak.enable = false;
    autorandr = {
      enable = true;
      profiles = {
        redyf = {
          config = {
            DP-0 = {
              enable = true;
              primary = true;
              mode = "1920x1080";
              rate = "165.00";
              position = "0x0";
            };
          };
        };
      };
    };
  };
}
