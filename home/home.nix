{
  username,
  homeDirectory,
  ...
}:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };

  imports = [
    ./apps
    ./cli
    ./desktop
    ./shells
    ./system
  ];

  myHomeConfig = {
    apps = {
      enable = true;
      browsers.enable = true;
      development.enable = true;
      file-explorer.enable = true;
      gaming.enable = true;
      media.enable = true;
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
      ghostty.enable = true;
      gnome.enable = false;
      hyprland.enable = true;
      noctalia.enable = true;
      rofi.enable = false;
      sway.enable = false;
      swww.enable = false;
      theme.enable = true;
      waybar.enable = false;
      wezterm.enable = false;
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
      ];
    };
  };
}
