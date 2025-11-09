{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  c = color: "#${color}";
in
''
  @define-color background #1e1e2e;
  @define-color foreground #cdd6f4;
  @define-color select     #585b70;

  @define-color pink       #f5c2e7;
  @define-color purple     #cba6f7;
  @define-color red        #f38ba8;
  @define-color orange     #fab387;
  @define-color yellow     #f9e2af;
  @define-color green      #a6e3a1;
  @define-color blue       #89b4fa;
  @define-color gray       #45475a;

  * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 13px;
      font-weight: bold;
      background-color: transparent;
      border-radius: 5px;
      min-height: 0;
  }

  window,
  tooltip {
      background-color: @background;
  }

  #waybar {
      background: alpha(@background, 0.6);
      border-radius: 0;
  }

  #workspaces {
      margin: 1px 0;
  }

  #workspaces button {
      color: @foreground;
      border: none;
      padding: 0 5px;
  }
  #workspaces button:hover {
      color: @pink;
      transition: none;
      border-bottom: 1px solid @pink;
      padding: 0 8px;
  }

  #workspaces button.active {
      color: @pink;
      border: 2px solid @pink;
      padding: 0 8px;
      margin: 0 2px;
  }

  #workspaces button.urgent {
      background-color: @red;
      padding: 0 8px;
  }

  #custom-power,
  #tray,
  #bluetooth,
  #network,
  #battery,
  #pulseaudio,
  #clock {
      color: @foreground;
      margin: 1px 0;
      padding: 0 10px;
  }

  #custom-power:hover,
  #bluetooth:hover,
  #network:hover,
  #battery:hover,
  #pulseaudio:hover,
  #clock:hover {
      background-color: alpha(@select, 0.6);
  }

  #bluetooth {
      color: @yellow;
  }

  #network {
      color: @green;
  }

  #battery {
      color: @purple;
  }

  #pulseaudio {
      color: @orange;
  }

  #clock {
      margin-right: 10px;
      color: @blue;
  }

  #custom-power {
      margin-left: 10px;
      padding: 0px 10px 0 15px;
  }
''
