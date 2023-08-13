{
  config,
  pkgs,
  lib,
  ...
}: {
  #imports = [./config.nix];
  home.packages = with pkgs; [
    droidcam
  ];
}
