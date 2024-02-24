_: let
  font = "RobotoMono Nerd Font";
  fontsize = "12";
  primary_accent = "cba6f7";
  secondary_accent = "89b4fa";
  tertiary_accent = "f5f5f5";
  background = "11111B";
  opacity = ".85";
  cursor = "Numix-Cursor";
in ''
  * {
      border: none;
      border-radius: 0px;
      font-family: ${font};
      font-size: 14px;
      min-height: 0;
  }

  window#waybar {
      /* background: rgba(16, 18, 19, 0.8); */
      background-color: rgba(0, 0, 0, 0.096);
  }

  #cava.left, #cava.right {
      background: #${background};
      margin: 5px;
      padding: 8px 16px;
      color: #${primary_accent};
  }
  #cava.left {
      border-radius: 24px 10px 24px 10px;
  }
  #cava.right {
      border-radius: 10px 24px 10px 24px;
  }
  #workspaces {
      background: #${background};
      margin: 5px 5px;
      padding: 8px 5px;
      border-radius: 16px;
      color: #${primary_accent}
  }
  #workspaces button {
      padding: 0px 5px;
      margin: 0px 3px;
      border-radius: 16px;
      color: transparent;
      background-color: #2f354a;
      transition: all 0.3s ease-in-out;
  }

  #workspaces button.active {
      background-color: #${secondary_accent};
      color: #${background};
      border-radius: 16px;
      min-width: 50px;
      background-size: 400% 400%;
      transition: all 0.3s ease-in-out;
  }

  #workspaces button:hover {
      background-color: #${tertiary_accent};
      color: #${background};
      border-radius: 16px;
      min-width: 50px;
      background-size: 400% 400%;
  }

  #custom-notification, #tray, #pulseaudio, #network, #battery,
  #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward{
      background: #${background};
      font-weight: bold;
      margin: 5px 0px;
  }
  #custom-notification, #tray, #pulseaudio, #network, #battery{
      color: #${primary_accent};
      border-radius: 10px 24px 10px 24px;
      padding: 0 20px;
      margin-left: 7px;
  }
  #clock {
      color: #${tertiary_accent};
      background-color: #${background};
      border-radius: 0px 0px 0px 40px;
      padding: 10px 10px 15px 25px;
      margin-left: 7px;
      font-weight: bold;
      font-size: 16px;
  }
  #custom-launcher {
      color: #${secondary_accent};
      background-color: #${background};
      border-radius: 0px 0px 40px 0px;
      margin: 0px;
      padding: 0px 35px 0px 15px;
      font-size: 28px;
  }

  #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
      background: #${background};
      font-size: 22px;
  }
  #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover{
      color: #${tertiary_accent};
  }
  #custom-playerctl.backward {
      color: #${primary_accent};
      border-radius: 24px 0px 0px 10px;
      padding-left: 16px;
      margin-left: 7px;
  }
  #custom-playerctl.play {
      color: #${secondary_accent};
      padding: 0 5px;
  }
  #custom-playerctl.foward {
      color: #${primary_accent};
      border-radius: 0px 10px 24px 0px;
      padding-right: 12px;
      margin-right: 7px
  }
  #custom-playerlabel {
      background: #${background};
      color: #${tertiary_accent};
      padding: 0 20px;
      border-radius: 24px 10px 24px 10px;
      margin: 5px 0;
      font-weight: bold;
  }
  #window{
      background: #${background};
      padding-left: 15px;
      padding-right: 15px;
      border-radius: 16px;
      margin-top: 5px;
      margin-bottom: 5px;
      font-weight: normal;
      font-style: normal;
  }
''
