{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zen-specific.enable = lib.mkEnableOption "Enable zen module";
  };
  config = lib.mkIf config.zen-specific.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".specific
    ];
  };
}
