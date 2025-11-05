{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  c = color: "#${color}";
in
''
  * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
      color: #b4befe;
  }

  window#waybar {
      /*background-color: rgba(0, 0, 0, 1);*/
      background-color: #1e1e2e;
      background-color: transparent;
      color: #cdd6f4;
      transition-property: background-color;
      transition-duration: 0.5s;
      /*border: 1px solid rgba(211, 187, 255, 0.5);*/
      /*border-radius: 10;*/
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  #workspaces {
      /* margin: 4px 0px 4px 0px; */
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 10px 0 5px;
  }

  /*
  window#waybar.empty {
      background-color: transparent;
  }
  window#waybar.solo {
      background-color: #FFFFFF;
  }
  */

  window#waybar.termite {
      background-color: #3f3f3f;
  }

  window#waybar.chromium {
      background-color: #000000;
      border: none;
  }

  button {
      /* Use box-shadow instead of border so the text isn't offset */
      box-shadow: inset 0 -3px transparent;
      /* Avoid rounded borders under each button name */
      border: none;
      border-radius: 0;
  }

  /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
  button:hover {
      background: inherit;
  }

  #workspaces button {
      margin: 0 0px;
      padding: 0 0px;
      background-color: transparent;
      min-width: 20px;
  }

  #workspaces button:hover {
      /* background: rgba(38, 51, 85, 0.5); */
      background: transparent;
  }

  #workspaces button.active {
      font-weight: bold;
  }

  #workspaces button.urgent {
      color: #eb4d4b;
  }

  #mode {
      background-color: #64727d;
      border-bottom: 3px solid #ffffff;
  }

  /* #taskbar { */
  /*     margin: 2px 0px 2px 0px; */
  /*     background-color: #313244; */
  /*     border-radius: 15px; */
  /*     padding: 0 7px; */
  /*     color: #89b4fa; */
  /* } */

  #custom-notification.notification,
  #custom-notification.dnd-none,
  #custom-notification.dnd-notification {
      background-color: #1e1e2e;
      border: #89b4fa;
      /* margin: 3px; */
      border-radius: 15px;
      padding: 0px 9px 0px 9px;
  }

  #custom-notification {
      background-color: #1e1e2e;
      border: #89b4fa;
      /* margin: 3px; */
      border-radius: 15px;
      padding: 0px 4px 0px 9px;
  }

  #tray,
  #taskbar,
  #idle_inhibitor,
  #mpris,
  #clock,
  #battery,
  #cpu,
  #memory,
  #disk,
  #temperature,
  #backlight,
  #network,
  #pulseaudio,
  #wireplumber,
  #privacy,
  #custom-media,
  #mode,
  #scratchpad,
  #mpd {
      /* margin: 4px 0px 4px 0px; */
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 10px 0 10px;
  }

  #custom-vkeyboard {
      margin: 4px 0px 4px 0px;
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 10px 0 12px;

  }

  #window,

  /* If workspaces is the leftmost module, omit left margin */
  .modules-left>widget:first-child>#workspaces {
      margin-left: 0;
  }

  /* #taskbar { */
  /*     border: 1px solid #ffffff; */
  /* } */

  /* If workspaces is the rightmost module, omit right margin */
  .modules-right>widget:last-child>#workspaces {
      margin-right: 0;
  }


  #custom-notification:hover,
  #custom-vkeyboard:hover,
  #idle_inhibitor:hover,
  #custom-power:hover,
  #custom-launcher:hover,
  #mpris:hover,
  #workspaces:hover,
  #privacy:hover,
  #tray:hover,
  #battery:hover,
  #custom-clipboard:hover,
  #battery.charging:hover,
  #pulseaudio:hover,
  #backlight:hover,
  #clock:hover {
      transition: all 0.3s ease-in;
      text-shadow: 0 0 2px #c9cdff;
  }

  #battery.charging,
  #battery.plugged {
      /* color: #bac2de; */
      /* margin: 4px 0px 4px 0px; */
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 10px 0 10px;
  }

  @keyframes blink {
      to {
          color: #f53c3c;
      }
  }

  #battery.critical:not(.charging) {
      color: #b4befe;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      background-color: #1e1e2e;
  }

  #battery.warning:not(.charging) {
      color: orange;
      background-color: #1e1e2e;
  }

  label:focus {
      background-color: #000000;
  }

  #cpu {
      background-color: #2ecc71;
      color: #000000;
  }

  #memory {
      background-color: #9b59b6;
  }

  #disk {
      background-color: #964b00;
  }

  #network {
      padding: 7px;
  }

  #network.disconnected {
      color: #eb4d4b;
  }

  #pulseaudio.muted {
      color: #eb4d4b;
  }

  #wireplumber {
      background-color: #fff0f5;
      color: #000000;
  }

  #wireplumber.muted {
      background-color: #f53c3c;
  }

  #custom-firefox {
      margin-left: 20px;
      margin-right: 10px;
  }

  #custom-file {
      margin-right: 10px;
  }

  #custom-terminal {
      margin-right: 10px;
  }

  #custom-mail {
      margin-right: 10px;
  }

  #custom-code {
      margin-right: 20px;
  }

  #custom-power {
      /* margin: 4px 5px 4px 0px; */
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 15px 0 12px;
  }

  #custom-clipboard {
      font-family: "Font Awesome 6 Free";
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 10px 0 10px;
  }

  #custom-launcher {
      /* margin: 4px 0px 4px 5px; */
      background-color: #1e1e2e;
      border-radius: 15px;
      padding: 0 8px 0 11px;
  }

  #custom-media {
      background-color: #66cc99;
      color: #2a5c45;
      min-width: 100px;
  }

  #custom-media.custom-spotify {
      background-color: #66cc99;
  }

  #custom-media.custom-vlc {
      background-color: #ffa000;
  }

  #temperature {
      background-color: #f0932b;
  }

  #temperature.critical {
      background-color: #eb4d4b;
  }


  #tray>.passive {
      -gtk-icon-effect: dim;
  }

  #tray>.needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #eb4d4b;
  }

  /* #idle_inhibitor.activated { */
  /*     color: #26a65b; */
  /* } */

  #mpd {
      background-color: #66cc99;
      color: #2a5c45;
  }

  #mpd.disconnected {
      background-color: #f53c3c;
  }

  #mpd.stopped {
      background-color: #90b1b1;
  }

  #mpd.paused {
      background-color: #51a37a;
  }

  #language {
      background: #00b093;
      color: #740864;
      padding: 0 5px;
      margin: 0 5px;
      min-width: 16px;
  }

  #keyboard-state {
      background: #97e1ad;
      color: #000000;
      padding: 0 0px;
      margin: 0 5px;
      min-width: 16px;
  }

  #keyboard-state>label {
      padding: 0 5px;
  }

  #keyboard-state>label.locked {
      background: rgba(0, 0, 0, 0.2);
  }

  #scratchpad {
      background: rgba(0, 0, 0, 0.2);
  }

  #scratchpad.empty {
      background-color: transparent;
  }
''
