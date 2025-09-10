{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nixy.enable = lib.mkEnableOption "Enable nix module";
  };
  config = lib.mkIf config.nixy.enable {
    home = {
      packages = with pkgs; [
        nixd
        statix
        nixfmt-rfc-style
        nix-init
        nixpkgs-review
      ];
    };
  };
}
