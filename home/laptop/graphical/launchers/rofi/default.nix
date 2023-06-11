{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    rofi-wayland
  ];

  xdg.configFile."rofi/colors.rasi".text = ''
    * {
        background:     #1E1D2FFF;
        background-alt: #282839FF;
        border:         #000B83FF;
        foreground:     #D9E0EEFF;
        selected:       #7AA2F7FF;
        active:         #ABE9B3FF;
        urgent:         #F28FADFF;
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration{
        modi: "run,drun,window,windowcd";
        lines: 5;
        font: "Sans Serif 16";
        show-icons: true;
        icon-theme: "Papirus-Dark";
        terminal: "st";
        drun-display-format: "{name}";
        location: 0;
        disable-history: false;
        hide-scrollbar: true;
        display-drun: " 󰵆  Apps ";
        display-run: " 󰆍  Run ";
        display-window: " 󱂬  Window";
        sidebar-mode: true;
    	kb-row-up: "Up,Control+k";
    	kb-row-down: "Down,Control+j";
    	kb-row-left: "Control+h";
    	kb-row-right: "Control+l";
    	kb-remove-char-back: "BackSpace,Shift+BackSpace";
    	kb-mode-complete: "";
    	kb-accept-entry: "Return,KP_Enter";
        kb-element-next: "";
    	kb-mode-next: "Tab";
    	kb-row-tab: "";
    	kb-remove-to-eol: "";
    }

    @theme "./colors.rasi"

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        height: 730px;
        width:1000px;
        border: 2px;
        border-color: @foreground;
        background-color: @background-alt;
        border-radius: 12;
    }

    mainbox {
        background-color: @background-alt;
        children: [ mode-switcher, inputbar, listview ];
    }

    inputbar {
        children: [prompt,entry];
        background-color: @background-alt;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @selected;
        padding: 6px;
        text-color: @background-alt;
        border-radius: 5px;
        margin: 20px 0px 0px 20px;
    }

    textbox-prompt-colon {
        expand: false;
        str: ":";
    }

    entry {
        padding: 6px;
        margin: 20px 0px 0px 10px;
        text-color: @foreground;
        background-color: @background-alt;
    }

    listview {
        border: 0px 0px 0px;
        padding: 10 10 0;
        margin: 10 10 0 10;
        columns: 4;
        spacing: 15;
        background-color: @background-alt;
    }

    element {
        padding: 5px;
        background-color: @background-alt;
        text-color: @foreground  ;
        orientation: vertical;
        spacing: 10;
    }

    element-icon {
        size: 80px;
        horizontal-align: 0.5;
    }

    element selected {
        background-color:  @foreground ;
        text-color: @background-alt  ;
        border-radius: 12px;
    }

    element-text {
        vertical-align: 0.5;
        horizontal-align: 0.5;
        expand: true;
        font: "Sofia Pro Bold 14";
      }

    mode-switcher {
        spacing: 0;
        margin: 5 10 5 10;
        padding: 10 50 5 50;
      }

    button {
        padding: 10px;
        background-color: @background-alt;
        text-color: @foreground;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color:  @active;
      text-color: @background-alt;
      border-radius: 10px;
    }
  '';
}
