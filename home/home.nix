{
  username,
  homeDirectory,
  ...
}:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
    # Add support for .local/bin
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

  apps.enable = true;
  cli.enable = true;
  desktop.enable = true;
  shells.enable = true;
  system.enable = true;

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
