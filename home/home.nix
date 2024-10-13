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
    ./rice
    ./system
    ./tools
  ];

  apps.enable = true;
  cli.enable = true;
  desktop.enable = true;
  rice.enable = true;
  system.enable = true;
  tools.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

}
