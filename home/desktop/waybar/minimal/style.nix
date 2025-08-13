{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  c = color: "#${color}";
in
''
  * {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 12px;
    font-weight: bold;
    min-height: 0;
  }

  window#waybar {
    background-color: ${c colors.base00};
    color: ${c colors.base05};
    border: none;
    padding: 0;
    margin: 0;
  }

  #workspaces {
    margin: 0;
  }

  #workspaces button {
    padding: 0 4px;
    background: transparent;
    border: none;
  }

  #workspaces button.active {
    color: ${c colors.base07};
    font-weight: bold;
  }

  #workspaces button.occupied {
    color: ${c colors.base05};
  }

  #workspaces button.empty {
    color: ${c colors.base03};
  }

  #clock {
    padding: 0 8px;
  }

  #keyboard-state, #pulseaudio, #battery, #network {
    padding: 0 8px;
  }

  #tray {
    padding: 0 8px;
  }

  #tray > .passive {
    opacity: 0.5;
  }

  #tray > .active {
    opacity: 1.0;
  }
''
