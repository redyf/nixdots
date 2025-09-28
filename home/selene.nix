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

  apps.enable = false;
  cli.enable = true;
  desktop.enable = false;
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
