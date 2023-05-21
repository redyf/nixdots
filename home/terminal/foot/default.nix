{ config
, inputs
, pkgs
, ...
}: {
  programs = {
    foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:Bold:style=Extra Bold:size=14";
          dpi-aware = "auto";
          pad = "8x4 center";
        };
        cursor = {
          color = "1A1826 D9E0EE";
          blink = true;
          style = "block";
          beam-thickness = "1.5";
        };
        colors = {
          # catppuccin
          alpha = "0.80";
          foreground = "D9E0EE";
          background = "1E1D2F";
          regular0 = "6E6C7E"; # black
          regular1 = "F28FAD"; # red
          regular2 = "ABE9B3"; # green
          regular3 = "FAE3B0"; # yellow
          regular4 = "96CDFB"; # blue
          regular5 = "F5C2E7"; # magenta
          regular6 = "89DCEB"; # cyan
          regular7 = "D9E0EE"; # white
          bright0 = "988BA2"; # bright black
          bright1 = "F28FAD"; # bright red
          bright2 = "ABE9B3"; # bright green
          bright3 = "FAE3B0"; # bright yellow
          bright4 = "96CDFB"; # bright blue
          bright5 = "F5C2E7"; # bright magenta
          bright6 = "89DCEB"; # bright cyan
          bright7 = "D9E0EE"; # bright white
        };
      };
    };
  };
}
