{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  c = color: "#${color}";
in
''
  @define-color bg    #1a1b26; 
  @define-color fg    #a9b1d6; 
  @define-color blk   #32344a; 
  @define-color red   #f7768e; 
  @define-color grn   #9ece6a; 
  @define-color ylw   #e0af68; 
  @define-color blu   #7aa2f7; 
  @define-color mag   #ad8ee6; 
  @define-color cyn   #0db9d7; 
  @define-color brblk #444b6a; 
  @define-color white #ffffff; 

  * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 16px;
      font-weight: bold;
  }

  window#waybar {
      background-color: @bg;
      color: @fg;
  }

  #workspaces button {
      padding: 0 6px;
      color: @cyn;
      background: transparent;
      border-bottom: 3px solid @bg;
  }
  #workspaces button.active {
      color: @cyn;
      border-bottom: 3px solid @mag;
  }
  #workspaces button.hidden {
      color: @white;
  }
  #workspaces button.hidden.active {
      color: @cyn;
      border-bottom: 3px solid @mag;
  }

  #workspaces button.urgent {
      background-color: @red;
  }

  button:hover {
      background: inherit;
      box-shadow: inset 0 -3px #ffffff;
  }

  #clock,
  #custom-sep,
  #battery,
  #cpu,
  #memory,
  #disk,
  #network,
  #tray {
      padding: 0 8px;
      color: @white;
  }

  #custom-sep {
      color: @brblk;
  }

  #clock {
      color: @cyn;
      border-bottom: 4px solid @cyn;
  }

  #battery {
      color: @blu;
      border-bottom: 4px solid @blu;
  }

  #disk {
      color: @ylw;
      border-bottom: 4px solid @ylw;
  }

  #memory {
      color: @mag;
      border-bottom: 4px solid @mag;
  }

  #cpu {
      color: @grn;
      border-bottom: 4px solid @grn;
  }

  #network {
      color: @red;
      border-bottom: 4px solid @red;
  }

  #network.disconnected {
      background-color: @red;
  }

  #tray {
      background-color: #2980b9;
  }

''
