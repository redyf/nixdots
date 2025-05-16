{ lib, ... }:

{
  options.myConfig.hardware = {
    enable = lib.mkEnableOption "Enable hardware configuration";

    nvidia = {
      enable = lib.mkEnableOption "Enable NVIDIA drivers";
    };
  };

  imports = [
    ./nvidia.nix
  ];
}
