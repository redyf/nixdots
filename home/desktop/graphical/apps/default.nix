{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    #./eww
  ];
  home.packages = with pkgs; [ slack ];
}
