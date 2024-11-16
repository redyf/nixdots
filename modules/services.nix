{ pkgs, ... }:
{
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
    mysql = {
      enable = false;
      package = with pkgs; mysql80;
    };
    postgresql = {
      enable = true;
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
        xfce.enable = false;
      };
      windowManager = {
        awesome = {
          enable = false;
        };
        i3 = {
          enable = true;
        };
      };
      xkb = {
        variant = "";
        layout = "br";
      };
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
