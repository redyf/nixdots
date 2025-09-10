{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gnome.enable = lib.mkEnableOption "Enable gnome module";
  };
  config = lib.mkIf config.gnome.enable {
    programs = {
      gnome-shell = {
        enable = true;
        theme = {
          name = lib.mkForce "Orchis-Grey-Dark";
          package = pkgs.orchis-theme.override {
            tweaks = [
              "black"
              "solid"
            ];
          };
        };
      };
    };
    home.packages = with pkgs; [
      gnome-tweaks
      dconf2nix
      xdg-user-dirs-gtk
      dconf-editor
      libnotify
      gnomeExtensions.appindicator
      gnomeExtensions.forge
      gnomeExtensions.just-perfection
      gnomeExtensions.media-controls
      gnomeExtensions.open-bar
      gnomeExtensions.quick-settings-tweaker
      gnomeExtensions.rounded-window-corners-reborn
      gnomeExtensions.search-light
    ];
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/wm/preferences" = {
        resize-with-right-button = true;
        num-workspaces = 8;
      };
      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = [ ];
        close = [ "<Super>q" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        switch-to-workspace-left = [ "<Super>h" ];
        switch-to-workspace-right = [ "<Super>l" ];
        switch-input-source = [ ];
        switch-input-source-backward = [ ];
        unmaximize = [ ];
        toggle-maximized = [ "<Super>Up" ];
        maximize = [ ];
        minimize = [ "<Super>Down" ];
      };
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Super><Shift>s" ];
        toggle-quick-settings = [ "<Super>space" ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };
      "org/gnome/shell" = {
        disabled-extensions = [
          "vertical-workspaces@G-dH.github.com"
          "dynamic-panel@velhlkj.com"
          "compact-quick-settings@gnome-shell-extensions.mariospr.org"
        ];
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "forge@jmmaranan.com"
          "just-perfection-desktop@just-perfection"
          "mediacontrols@cliffniff.github.com"
          "openbar@neuromorph"
          "quick-settings-tweaks@qwreey"
          "rounded-window-corners@fxgn"
          "search-light@icedman.github.com"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>e";
        command = "thunar";
        name = "Thunar";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>Return";
        command = "ghostty";
        name = "Ghostty";
      };
      # extensions settings
      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = 0;
        icon-contrast = 0;
        icon-opacity = 255;
        icon-saturation = 1;
        icon-size = 0;
      };
      "org/gnome/shell/extensions/forge" = {
        focus-border-toggle = false;
        tabbed-tiling-mode-enabled = false;
        tiling-mode-enabled = true;
        window-gap-size = 7;
        window-gap-size-increment = 2;
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
        con-split-horizontal = [ ];
        con-split-layout-toggle = [ ];
        con-split-vertical = [ ];
        con-stacked-layout-toggle = [ ];
        con-tabbed-layout-toggle = [ ];
        con-tabbed-showtab-decoration-toggle = [ ];
        focus-border-toggle = [ ];
        prefs-tiling-toggle = [ "<Super>f" ];
        window-focus-down = [ ];
        window-focus-left = [ ];
        window-focus-right = [ ];
        window-focus-up = [ ];
        window-gap-size-decrease = [ ];
        window-gap-size-increase = [ ];
        window-move-down = [ ];
        window-move-left = [ ];
        window-move-right = [ ];
        window-move-up = [ ];
        window-resize-bottom-decrease = [ ];
        window-resize-bottom-increase = [ ];
        window-resize-right-decrease = [ ];
        window-resize-right-increase = [ ];
        window-resize-left-decrease = [ ];
        window-resize-left-increase = [ ];
        window-resize-top-decrease = [ ];
        window-resize-top-increase = [ ];
        window-snap-center = [ ];
        window-snap-one-third-left = [ ];
        window-snap-one-third-right = [ ];
        window-snap-two-third-left = [ ];
        window-snap-two-third-right = [ ];
        window-swap-down = [ ];
        window-swap-last-active = [ ];
        window-swap-left = [ ];
        window-swap-right = [ ];
        window-swap-up = [ ];
        window-toggle-always-float = [ ];
        window-toggle-float = [ ];
        workspace-active-tile-toggle = [ "<Super><Shift>f" ];
      };
      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = true;
        activites-button = true;
        clock-menu = true;
        clock-menu-positition = 1;
        clock-menu-position-offset = 5;
        dash = false;
        dash-app-running = false;
        dash-icon-size = 0;
        dash-separator = false;
        max-displayed-search-results = 0;
        panel = true;
        panel-in-overview = true;
        ripple-box = false;
        search = false;
        show-apps-button = false;
        startup-status = 0;
        support-notifier-showed-version = 34;
        support-notifier-type = 0;
        theme = false;
        top-panel-position = 0;
        window-demands-attentions-focus = false;
        window-picker-icon = false;
        window-preview-caption = false;
        window-preview-close-button = true;
        workspace = false;
        workspace-popup = false;
        workspaces-in-app-grid = false;
        workspace-switcher-size = 5;
        workspace-wrap-around = true;
      };
      "org/gnome/shell/extensions/mediacontrols" = {
        cache-art = false;
        colored-player-icon = false;
        extensions-index = 1;
        labels-order = [
          "ARTIST"
          "-"
          "TITLE"
        ];
        label-width = 220;
        mouse-action-left = "PREVIOUS_TRACK";
        mouse-action-middle = "PLAY_PAUSE";
        mouse-action-right = "NEXT_TRACK";
        scroll-labels = true;
        show-control-icons = false;
        show-player-icon = false;
        show-track-slider = false;
      };
      "org/gnome/shell/extensions/openbar" = {
        auto-bgalpha = false;
        autofg-bar = false;
        autofg-menu = false;
        autohg-bar = false;
        autotheme-font = false;
        bartype = "Mainland";
        bg-change = false;
        bgalpha = 0.9;
        bgalpha2 = 0.0;
        bgcolor = [
          "0.000"
          "0.000"
          "0.000"
        ];
        bgpalette = false;
        bguri = "";
        bradius = 0.0;
        bwidth = 0.0;
        candyalpha = 0.0;
        count1 = 493177;
        count10 = 281;
        count11 = 5;
        count12 = 2;
        count2 = 62325;
        count3 = 56112;
        count4 = 20103;
        count5 = 15526;
        count6 = 10417;
        count7 = 4137;
        count8 = 2542;
        count9 = 1373;
        dark-bgcolor = [
          "0.000"
          "0.000"
          "0.000"
        ];
        dark-bguri = "";
        dark-hcolor = [
          "0.125"
          "0.125"
          "0.125"
        ];
        dark-palette1 = [
          "17"
          "20"
          "20"
        ];
        dark-palette10 = [
          "141"
          "123"
          "112"
        ];
        dark-palette11 = [
          "124"
          "124"
          "132"
        ];
        dark-palette12 = [
          "124"
          "132"
          "128"
        ];
        dark-palette2 = [
          "58"
          "60"
          "58"
        ];
        dark-palette3 = [
          "38"
          "39"
          "38"
        ];
        dark-palette4 = [
          "81"
          "81"
          "76"
        ];
        dark-palette5 = [
          "27"
          "36"
          "34"
        ];
        dark-palette6 = [
          "43"
          "52"
          "50"
        ];
        dark-palette7 = [
          "67"
          "76"
          "72"
        ];
        dark-palette8 = [
          "43"
          "44"
          "52"
        ];
        dark-palette9 = [
          "67"
          "67"
          "76"
        ];
        default-font = "Sans 12";
        font = "CommitMono 10";
        hcolor = [
          "0.125"
          "0.125"
          "0.125"
        ];
        height = 37.0;
        import-export = false;
        light-bguri = "";
        light-palette1 = [
          "17"
          "20"
          "20"
        ];
        light-palette10 = [
          "141"
          "123"
          "112"
        ];
        light-palette11 = [
          "124"
          "124"
          "132"
        ];
        light-palette12 = [
          "124"
          "132"
          "128"
        ];
        light-palette2 = [
          "58"
          "60"
          "58"
        ];
        light-palette3 = [
          "38"
          "39"
          "38"
        ];
        light-palette4 = [
          "81"
          "81"
          "76"
        ];
        light-palette5 = [
          "27"
          "36"
          "34"
        ];
        light-palette6 = [
          "43"
          "52"
          "50"
        ];
        light-palette7 = [
          "67"
          "76"
          "72"
        ];
        light-palette8 = [
          "43"
          "44"
          "52"
        ];
        light-palette9 = [
          "67"
          "67"
          "76"
        ];
        margin = 0.0;
        margin-wmax = 0.0;
        menustyle = false;
        monitor-height = 1080;
        monitor-width = 1920;
        neon = false;
        palette1 = [
          "17"
          "20"
          "20"
        ];
        palette10 = [
          "141"
          "123"
          "112"
        ];
        palette11 = [
          "124"
          "124"
          "132"
        ];
        palette12 = [
          "124"
          "132"
          "128"
        ];
        palette2 = [
          "58"
          "60"
          "58"
        ];
        palette3 = [
          "38"
          "39"
          "38"
        ];
        palette4 = [
          "81"
          "81"
          "76"
        ];
        palette5 = [
          "27"
          "36"
          "34"
        ];
        palette6 = [
          "43"
          "52"
          "50"
        ];
        palette7 = [
          "67"
          "76"
          "72"
        ];
        palette8 = [
          "43"
          "44"
          "52"
        ];
        palette9 = [
          "67"
          "67"
          "76"
        ];
        pause-reload = false;
        reloadstyle = false;
        shadow = false;
        shalpha = 0.0;
        trigger-reload = false;
      };
      "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
        border-width = 0;
        settings-version = 7;
        skip-libadwaita-app = false;
      };
      "org/gnome/shell/extensions/search-light" = {
        animation-speed = 162.0;
        background-color = [
          0.0
          0.0
          0.0
          1.0
        ];
        blur-brightness = 0.6;
        blur-sigma = 30.0;
        border-radius = 1.1782178217821784;
        entry-font-size = 1;
        font-size = 1;
        monitor-count = 1;
        preferred-monitor = 0;
        scale-height = 0.1;
        scale-width = 0.0;
        shortcut-search = [ "<Alt>space" ];
      };
    };
  };
}
