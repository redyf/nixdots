{
  inputs,
  pkgs,
  ...
}: {
  home = {
    username = "redyf";
    homeDirectory = "/home/redyf";
    stateVersion = "22.11";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };

  # Imports
  imports = [
    ./apps
    ./cli
    ./desktop
    ./rice
    ./system
    ./tools
    ./virt
  ];

  apps.enable = true;
  cli.enable = true;
  desktop.enable = true;
  rice.enable = true;
  system.enable = true;
  tools.enable = true;
  virt.enable = true;

  # Allow unfree packages + use overlays
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
