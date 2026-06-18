{
  username,
  homeDirectory,
  ...
}:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
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
      gaming.enable = true;
      media.enable = true;
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
      foot.enable = false;
      ghostty.enable = true;
      gtk-theme.enable = true;
      hyprland.enable = true;
      noctalia.enable = true;
      rofi.enable = false;
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

  artix-game-launcher.enable = true;

  git = {
    sopsIdentity.enable = true;
    work.enable = true;
    maintenanceRepo = "${homeDirectory}/opensource/nixpkgs";
    safeDirectories = [ "${homeDirectory}/opensource/nixdots" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "beekeeper-studio-5.3.4"
        "ventoy-1.1.07"
        "electron-39.8.10"
      ];
    };
  };
}
