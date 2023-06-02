{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs = {
    foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "xterm-256color";
          # font = "JetBrainsMono Nerd Font:Bold:style=Extra Bold:size=16";
          # font = "CaskaydiaCove Nerd Font:Bold:style=Extra Bold:size=16";
          font = "BlexMono Nerd Font:Bold:style=Extra Bold:size=16";
          # font = "Maple Mono NF:Bold:style=Extra Bold:size=16";
          dpi-aware = "auto";
          pad = "2x2 center";
        };
        cursor = {
          # color = "a9b1d6 f5f5f5"; # Decay
          # color = "a9b1d6 f5f5f5"; # Dark-decay
          # color = "a5b6cf cbced3"; # Decayce
          # color = "c5c8cd 101419"; # Light-decay

          color = "1A1826 D9E0EE"; #Cattpuccin
          blink = false;
          style = "block";
          beam-thickness = "1.5";
        };

        colors = {
          # Dark-decay
          # alpha = "1.0";
          # foreground = "b6beca";
          # background = "101419";
          # regular0 = "1c252c";
          # regular1 = "e05f65";
          # regular2 = "78dba9";
          # regular3 = "f1cf8a";
          # regular4 = "70a5eb";
          # regular5 = "c68aee";
          # regular6 = "74bee9";
          # regular7 = "dee1e6";
          # bright0 = "384148";
          # bright1 = "fc7b81";
          # bright2 = "94f7c5";
          # bright3 = "ffeba6";
          # bright4 = "8cc1ff";
          # bright5 = "e2a6ff";
          # bright6 = "90daff";
          # bright7 = "fafdff";

          # Decay
          # alpha = "1.0";
          # foreground = "b6beca";
          # background = "171a1f";
          # regular0 = "1c252c";
          # regular1 = "e05f65";
          # regular2 = "78dba9";
          # regular3 = "f1cf8a";
          # regular4 = "70a5eb";
          # regular5 = "c68aee";
          # regular6 = "74bee9";
          # regular7 = "dee1e6";
          # bright0 = "384148";
          # bright1 = "fc7b81";
          # bright2 = "94f7c5";
          # bright3 = "ffeba6";
          # bright4 = "8cc1ff";
          # bright5 = "e2a6ff";
          # bright6 = "90daff";
          # bright7 = "fafdff";

          # Decayce
          # alpha = "1.0";
          # foreground = "a5b6cf";
          # background = "0d0f18";
          # regular0 = "151720";
          # regular1 = "dd6777";
          # regular2 = "90ceaa";
          # regular3 = "ecd3a0";
          # regular4 = "86aaec";
          # regular5 = "c296eb";
          # regular6 = "93cee9";
          # regular7 = "cbced3";
          # bright0 = "1c1e27";
          # bright1 = "e26c7c";
          # bright2 = "95d3af";
          # bright3 = "f1d8a5";
          # bright4 = "8baff1";
          # bright5 = "c79bf0";
          # bright6 = "98d3ee";
          # bright7 = "d0d3d8";

          # Light-decay
          # alpha = "1.0";
          # foreground = "101419";
          # background = "dee1e6 ";
          # regular0 = "c5c8cd";
          # regular1 = "bd3c42";
          # regular2 = "69b373";
          # regular3 = "ceac67";
          # regular4 = "4d82c8";
          # regular5 = "a367cb";
          # regular6 = "519bc6";
          # regular7 = "101419";
          # bright0 = "989ba0";
          # bright1 = "c24147";
          # bright2 = "6eb878";
          # bright3 = "d3b16c";
          # bright4 = "5287cd";
          # bright5 = "a86cd0";
          # bright6 = "56a0cb";
          # bright7 = "1f2328";

          # catppuccin mocha
          alpha = "0.4";
          foreground = "cdd6f4"; # Text
          background = "1E1D2F"; # Base
          regular0 = "45475a"; # Surface 1
          regular1 = "f38ba8"; # red
          regular2 = "a6e3a1"; # green
          regular3 = "f9e2af"; # yellow
          regular4 = "89b4fa"; # blue
          regular5 = "f5c2e7"; # pink
          regular6 = "94e2d5"; # teal
          regular7 = "bac2de"; # Subtext 1
          bright0 = "585b70"; # Surface 2
          bright1 = "f38ba8"; # red
          bright2 = "a6e3a1"; # green
          bright3 = "f9e2af"; # yellow
          bright4 = "89b4fa"; # blue
          bright5 = "f5c2e7"; # pink
          bright6 = "94e2d5"; # teal
          bright7 = "a6adc8"; # Subtext 0

          # catppuccin macchiato
          # alpha = "0.4";
          # foreground = "cad3f5"; # Text
          # background = "24273a"; # Base
          # regular0 = "494d64"; # Surface 1
          # regular1 = "ed8796"; # red
          # regular2 = "a6da95"; # green
          # regular3 = "eed49f"; # yellow
          # regular4 = "8aadf4"; # blue
          # regular5 = "f5bde6"; # pink
          # regular6 = "8bd5ca"; # teal
          # regular7 = "b8c0e0"; # Subtext 1
          # bright0 = "5b6078"; # Surface 2
          # bright1 = "ed8796"; # red
          # bright2 = "a6da95"; # green
          # bright3 = "eed49f"; # yellow
          # bright4 = "8aadf4"; # blue
          # bright5 = "f5bde6"; # pink
          # bright6 = "8bd5ca"; # teal
          # bright7 = "a5adcb"; # Subtext 0
        };
      };
    };
  };
}
