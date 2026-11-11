{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.system.nix.enable = lib.mkEnableOption "nix";
  config = lib.mkIf config.myHomeConfig.system.nix.enable {
    home = {
      packages = with pkgs; [
        nixd
        statix
        nixfmt
      ];
    };
  };
}
