{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    figma.enable = lib.mkEnableOption "Enable figma module";
  };
  config = lib.mkIf config.figma.enable {
    home.packages = with pkgs; [
      figma-linux
    ];
  };
}
