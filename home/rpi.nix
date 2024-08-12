{ username, homeDirectory, ... }:
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
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
    ./virt
  ];

  apps.enable = false;
  cli.enable = true;
  desktop.enable = false;
  rice.enable = false;
  system.enable = false;
  tools.enable = true;
  virt.enable = false;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Add support for .local/bin
  home.sessionPath = [ "$HOME/.local/bin" ];
}
