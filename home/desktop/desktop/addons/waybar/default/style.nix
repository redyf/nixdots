_:
''
  /* =============================================================================
   *
   * Waybar configuration
   *
   * Configuration reference: https://github.com/Alexays/Waybar/wiki/Configuration
   *
   * =========================================================================== */

  /* -----------------------------------------------------------------------------
   * Keyframes
   * -------------------------------------------------------------------------- */

  @import "machiatto.css";

  /*
     Polar Night
     nord0  #2e3440
     nord1  #3b4252
     nord2  #434c5e
     nord3  #4c566a
     Snow Storm
     nord4  #d8dee9
     nord5  #e5e9f0
     nord6  #eceff4
     Frost
     nord7  #8fbcbb
     nord8  #88c0d0
     nord9  #81a1c1
     nord10 #5e81ac
     Aurora
     nord11 #bf616a
     nord12 #d08770
     nord13 #ebcb8b
     nord14 #a3be8c
     nord15 #b48ead
   */

  /* -----------------------------------------------------------------------------
    * Base styles
    * -------------------------------------------------------------------------- */

  /* Reset all styles */

  * {
  color: @lavender;
  border: 0;
  padding: 0 0;
  font-family: UbuntuMono;
  /* font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; */
  /* font-family: "Hack Nerd Font"; */
  font-size: 14px;
  font-weight: bold;
  /* padding-bottom:4px;
       padding-top: 4px; */
  }

  window#waybar {
  border: 0px solid rgba(0, 0, 0, 0);
  /* border-radius: 10px; */
  /* background:#2d2a2e; */
  /* background-color: rgba(36, 39, 58, 0.85); */
  background-color: rgba(0, 0, 0, 0);
  /* background-color: shade(#1e1e2e, 0.95); */
  }

  #workspaces button {
  color: @base;
  border-radius: 50%;
  /* background-color: @base; */
  margin: 0px 0px;
  padding: 4 6 2 0;
  }

  #workspaces button:hover {
  color: @mauve;
  box-shadow: none;
  /* Remove predefined box-shadow */
  text-shadow: none;
  /* Remove predefined text-shadow */
  border: 0px;
  background: none;
  }

  #workspaces button:hover * {
  color: @mauve;
  background-color: @base;
  }

  #workspaces * {
  color: whitesmoke;
  }

  #workspaces {
  border-style: solid;
  background-color: @base;
  opacity: 1;
  border-radius: 10px;
  margin: 8px 0px 8px 8px;
  }

  #workspaces button.focused {
  color: @mauve;
  border-radius: 20px;
  padding: 10px;
  /* background-color: @flamingo; */
  }

  #workspaces button.focused * {
  color: @mauve;
  }

  #mode {
  color: #ebcb8b;
  }

  #clock,
  #custom-swap,
  #custom-cava-internal,
  #battery,
  #cpu,
  #memory,
  #idle_inhibitor,
  #temperature,
  #custom-keyboard-layout,
  #backlight,
  #network,
  #pulseaudio,
  #mode,
  #tray,
  #custom-power,
  #custom-pacman,
  #custom-launcher,
  #mpd {
  padding: 5px 8px;
  border-style: solid;
  background-color: shade(@base, 1);
  opacity: 1;
  margin: 8px 0;
  }

  /* -----------------------------------------------------------------------------
    * Module styles
    * -------------------------------------------------------------------------- */
  #mpd {
  border-radius: 10px;
  color: @mauve;
  margin-left: 5px;
  background-color: rgba(0, 0, 0, 0);
  }

  #mpd.2 {
  border-radius: 10px 0px 0px 10px;
  margin: 8px 0px 8px 6px;
  padding: 4px 12px 4px 10px;
  }

  #mpd.3 {
  border-radius: 0px 0px 0px 0px;
  margin: 8px 0px 8px 0px;
  padding: 4px;
  }

  #mpd.4 {
  border-radius: 0px 10px 10px 0px;
  margin: 8px 0px 8px 0px;
  padding: 4px 10px 4px 14px;
  }

  #mpd.2,
  #mpd.3,
  #mpd.4 {
  background-color: @base;
  font-size: 14px;
  }

  #mode {
  border-radius: 10px;
  color: @mauve;
  margin-right: 5px;
  }

  #custom-cava-internal {
  border-radius: 10px;
  color: @mauve;
  }

  #custom-swap {
  border-radius: 10px;
  color: @base;
  margin-left: 15px;
  background-color: @mauve;
  }

  #clock {
  /* background-color:#a3be8c; */
  color: @sky;
  border-radius: 10px;
  margin: 8px 10px;
  }

  #backlight {
  color: @yellow;
  /* border-bottom: 2px solid @yellow; */
  border-radius: 10px 0 0 10px;
  }

  #battery {
  color: #d8dee9;
  /* border-bottom: 2px solid #d8dee9; */
  border-radius: 0 10px 10px 0;
  margin-right: 10px;
  }

  #battery.charging {
  color: #81a1c1;
  /* border-bottom: 2px solid #81a1c1; */
  }

  @keyframes blink {
  to {
  color: @red;
  /* border-bottom: 2px solid @red; */
  }
  }

  #battery.critical:not(.charging) {
  color: #bf616a;
  /* border-bottom: 2px solid #bf616a; */
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
  }

  #cpu {
  color: @sky;
  /* border-bottom: 2px solid @sky; */
  }

  #cpu #cpu-icon {
  color: @sky;
  }

  #memory {
  color: @sky;
  border-radius: 0 10px 10px 0;
  margin-right: 5px;
  }

  #network.disabled {
  color: #bf616a;
  /* border-bottom: 2px solid #bf616a; */
  }

  #network {
  color: @green;
  /* border-bottom: 2px solid @green; */
  border-radius: 10px;
  margin-right: 5px;
  }

  #network.disconnected {
  color: #bf616a;
  /* border-bottom: 2px solid #bf616a; */
  }

  #pulseaudio {
  color: @flamingo;
  border-radius: 10px;
  margin-right: 5px;
  /* border-bottom: 2px solid @flamingo; */
  }

  #pulseaudio.muted {
  color: #3b4252;
  border-radius: 10px;
  margin-right: 5px;
  /* border-bottom: 2px solid #3b4252; */
  }

  #temperature {
  color: @teal;
  /* border-bottom: 2px solid @teal; */
  border-radius: 10px 0 0 10px;
  }

  #temperature.critical {
  color: @red;
  /* border-bottom: 2px solid @red; */
  }

  #idle_inhibitor {
  background-color: #ebcb8b;
  color: @base;
  }

  #tray {
  /* background-color: @base; */
  margin: 8px 10px;
  border-radius: 10px;
  }

  #custom-launcher,
  #custom-power {}

  #custom-launcher {
  background-color: @mauve;
  color: @base;
  border-radius: 10px;
  padding: 10px;
  margin-left: 15px;
  }

  #custom-power {
  color: @base;
  background-color: @red;
  border-radius: 10px;
  margin-left: 5px;
  margin-right: 15px;
  }

  #window {
  border-style: hidden;
  margin-left: 10px;
  /* margin-top:1px;  
       padding: 8px 1rem; */
  margin-right: 10px;
  color: #eceff4;
  }

  #custom-keyboard-layout {
  color: @peach;
  /* border-bottom: 2px solid @peach; */
  border-radius: 0 10px 10px 0;
  margin-right: 10px;
  }



  /* window#waybar {
     background: #2d2a2e;
     }
 
   * {
     color: #c8b9a9;
     font-family: Ubuntu Mono, sans-serif;
     font-size: 12px;
     }
 
     #workspaces button.focused {
     color: #f2e5bc;
     }
 
     #workspaces button {
     color: #c8b9a9;
     }
 
     .separator {
     background-color: #c8b9a9;
     }
 
     #mode {
     color: #ebcb8b;
     }
 
     #clock {
     color: #a3be8c;
     }
 
     #battery {
     color: #d8dee9;
     }
 
     #battery.charging {
     color: #b48ead;
     }
 
     #battery.critical:not(.charging) {
     color: #bf616a;
     }
 
     #cpu {
     color: #a3be8c;
     }
 
     #memory {
     color: #d3869b;
     }
 
     #network {
     color: #8fbcbb;
     }
 
     #network.disabled {
     color: #bf616a;
     }
 
     #network.disconnected {
     color: #bf616a;
     }
 
     #pulseaudio {
     color: #b48ead;
     }
 
     #pulseaudio.muted {
     color: #bf616a;
     }
 
     #temperature {
     color: #8fbcbb;
     }
 
     #temperature.critical {
     color: #bf616a;
   } */
''
