{
  inputs,
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  #  imports = [
  #  <nixos-wsl/modules>
  #  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "red";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;
  };

  system.stateVersion = "22.05";
}
