{ inputs
, lib
, pkgs
, config
, modulesPath
, ...
}: with lib;
with lib.custom;
{
  #  imports = [
  #  <nixos-wsl/modules>
  #  ];

  suites = {
    wsl = enabled;
    development = enabled;
  };

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

