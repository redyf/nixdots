{ lib, ... }:

{
  options.myConfig.services = {
    enable = lib.mkEnableOption "Enable Services configuration";
    autorandr = {
      enable = lib.mkEnableOption "Enable displayManager ";
    };
    displayManager = {
      enable = lib.mkEnableOption "Enable displayManager ";
    };
    flatpak = {
      enable = lib.mkEnableOption "Enable displayManager ";
    };
    fstrim = {
      enable = lib.mkEnableOption "Enable displayManager ";
    };
    input = {
      enable = lib.mkEnableOption "Enable displayManager ";
    };
  };

  imports = [
    ./autorandr.nix
    ./displayManager.nix
    ./flatpak.nix
    ./fstrim.nix
    ./input.nix
  ];
}
