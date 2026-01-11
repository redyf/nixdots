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
      browsers.enable = false;
      development.enable = false;
      file-explorer.enable = true;
      gaming.enable = false;
      media.enable = false;
      web.enable = false;
    };

    cli = {
      enable = true;
      neovim.enable = true;
      neve.enable = false;
      tools.enable = true;
    };

    desktop = {
      enable = true;
      foot.enable = true;
      ghostty.enable = false;
      hyprland.enable = false;
      noctalia.enable = false;
      rofi.enable = false;
      sway.enable = true;
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
