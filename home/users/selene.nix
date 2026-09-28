{
  username,
  homeDirectory,
  ...
}:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
    pointerCursor.enable = true;
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  imports = [
    ../apps
    ../cli
    ../desktop
    ../shells
    ../system
  ];

  myHomeConfig = {
    apps = {
      enable = true;
      browsers.enable = true;
      development.enable = true;
      file-explorer.enable = true;
      gaming.enable = false;
      media.enable = false;
      security.enable = true;
      web.enable = true;
    };

    cli = {
      enable = true;
      neovim.enable = true;
      neve.enable = false;
      tools.enable = true;
    };

    desktop = {
      enable = true;
      caelestia.enable = false;
      foot.enable = false;
      ghostty.enable = true;
      gtk-theme.enable = true;
      hyprland.enable = true;
      noctalia.enable = false;
      rofi.enable = false;
      serpantinum.enable = true;
      sway.enable = false;
      swww.enable = false;
      stylix-theme.enable = true;
      wezterm.enable = true;
      wofi.enable = true;
    };

    shells = {
      enable = true;
      nushell.enable = false;
      scripts.enable = true;
      zsh.enable = true;
    };

    system = {
      enable = true;
      fonts.enable = true;
      nixy.enable = true;
      utils.enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "beekeeper-studio-5.3.4"
        "ventoy-1.1.07"
        "electron-40.10.5"
        "electron-39.8.10"
        "electron-41.10.6"
      ];
    };
  };
}
