{ username, homeDirectory, ... }:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
    # Add support for .local/bin
    sessionPath = [ "$HOME/.local/bin" ];
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

  apps.enable = false;
  cli.enable = true;
  desktop.enable = false;
  rice.enable = false;
  system.enable = false;
  tools.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
