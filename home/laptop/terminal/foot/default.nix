_: {
  programs = {
    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          # font = "JetBrainsMono Nerd Font:Bold:style=Extra Bold:size=11";
          # font = "CaskaydiaCove Nerd Font:Bold:style=Extra Bold:size=11";
          # font = "BlexMono Nerd Font:Bold:style=Extra Bold:size=11";
          font = "Liga SFMono Nerd Font:Bold:style=Bold:size=14";
          # font = "Maple Mono NF:Bold:style=Extra Bold:size=11";
          dpi-aware = "auto";
          pad = "2x2 center";
        };
        cursor = {
          # color = "1A1826 D9E0EE"; # Cattpuccin
          # color = "a9b1d6 f5f5f5"; # Decay
          # color = "a9b1d6 f5f5f5"; # Dark-decay
          # color = "a5b6cf cbced3"; # Decayce
          # color = "c5c8cd 101419"; # Light-decay
          # color = "1a1b26 c0caf5"; # Lunar
          # color = "192330 cdcecf"; # Nightfox
          # color = "161616 f2f4f8"; # Carbonfox
          # color = "11121d a0a8cd"; # Tokyodark
          color = "161616 ffffff"; # Oxocarbon
          blink = false;
          style = "block";
          beam-thickness = "1.5";
        };
        colors = {
          # Cattpuccin mocha
          # alpha = "0.8";
          # foreground = "cdd6f4"; # Text
          # background = "1E1D2F"; # Base
          # regular0 = "45475a"; # Surface 1
          # regular1 = "f38ba8"; # red
          # regular2 = "a6e3a1"; # green
          # regular3 = "f9e2af"; # yellow
          # regular4 = "89b4fa"; # blue
          # regular5 = "f5c2e7"; # pink
          # regular6 = "94e2d5"; # teal
          # regular7 = "bac2de"; # Subtext 1
          # bright0 = "585b70"; # Surface 2
          # bright1 = "f38ba8"; # red
          # bright2 = "a6e3a1"; # green
          # bright3 = "f9e2af"; # yellow
          # bright4 = "89b4fa"; # blue
          # bright5 = "f5c2e7"; # pink
          # bright6 = "94e2d5"; # teal
          # bright7 = "a6adc8"; # Subtext 0

          # Cattpuccin macchiato
          # alpha = "0.8";
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

          # Lunar
          # alpha = "1.0";
          # foreground = "a9b1d6";
          # background = "1a1b26";
          # regular0 = "414868";
          # regular1 = "f7768e";
          # regular2 = "73daca";
          # regular3 = "e0af68";
          # regular4 = "7aa2f7";
          # regular5 = "bb9af7";
          # regular6 = "7dcfff";
          # regular7 = "c0caf5";
          # bright0 = "414868";
          # bright1 = "f7768e";
          # bright2 = "73daca";
          # bright3 = "e0af68";
          # bright4 = "7aa2f7";
          # bright5 = "bb9af7";
          # bright6 = "7dcfff";
          # bright7 = "c0caf5";

          # carbonfox
          # alpha = "1.0";
          # foreground = "f2f4f8";
          # background = "161616";
          # regular0 = "282828";
          # regular1 = "ee5396";
          # regular2 = "25be6a";
          # regular3 = "08bdba";
          # regular4 = "78a9ff";
          # regular5 = "be95ff";
          # regular6 = "33b1ff";
          # regular7 = "dfdfe0";
          # bright0 = "484848";
          # bright1 = "f16da6";
          # bright2 = "46c880";
          # bright3 = "2dc7c4";
          # bright4 = "8cb6ff";
          # bright5 = "c8a5ff";
          # bright6 = "52bdff";
          # bright7 = "e4e4e5";

          # nightfox
          # alpha = "1.0";
          # foreground = "cdcecf";
          # background = "192330";
          # regular0 = "393b44";
          # regular1 = "c94f6d";
          # regular2 = "81b29a";
          # regular3 = "dbc074";
          # regular4 = "719cd6";
          # regular5 = "9d79d6";
          # regular6 = "63cdcf";
          # regular7 = "dfdfe0";
          # bright0 = "575860";
          # bright1 = "d16983";
          # bright2 = "8ebaa4";
          # bright3 = "e0c989";
          # bright4 = "86abdc";
          # bright5 = "baa1e2";
          # bright6 = "7ad5d6";
          # bright7 = "e4e4e5";

          # tokyodark
          # alpha = "1.0";
          # foreground = "a0a8cd";
          # background = "11121d";
          # regular0 = "06080a";
          # regular1 = "ee6d85";
          # regular2 = "95c561";
          # regular3 = "d7a65f";
          # regular4 = "7199ee";
          # regular5 = "a485dd";
          # regular6 = "38a89d";
          # regular7 = "a0a8cd";
          # bright0 = "212234";
          # bright1 = "ee6d85";
          # bright2 = "95c561";
          # bright3 = "d7a65f";
          # bright4 = "7199ee";
          # bright5 = "a485dd";
          # bright6 = "38a89d";
          # bright7 = "a0a8cd";

          # oxocarbon
          alpha = "1.0";
          foreground = "f2f4f8";
          background = "161616";
          regular0 = "262626";
          regular1 = "ee5396";
          regular2 = "42be65";
          regular3 = "ffe97b";
          regular4 = "33b1ff";
          regular5 = "ff7eb6";
          regular6 = "3ddbd9";
          regular7 = "dde1e6";
          bright0 = "393939";
          bright1 = "ee5396";
          bright2 = "42be65";
          bright3 = "ffe97b";
          bright4 = "33b1ff";
          bright5 = "ff7eb6";
          bright6 = "3ddbd9";
          bright7 = "ffffff";
        };
      };
    };
  };
}
