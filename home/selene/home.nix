{
  inputs,
  pkgs,
  ...
}: {
  home = {
    username = "selene";
    homeDirectory = "/home/selene";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };

  imports = [
    ../redyf/apps
    ../redyf/cli
    ../redyf/desktop
    ../redyf/rice
    ../redyf/system
    ../redyf/tools
    ../redyf/virt
  ];

  apps.enable = false;
  cli.enable = false;
  desktop.enable = false;
  rice.enable = true;
  system.enable = false;
  tools.enable = false;
  virt.enable = false;

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
