{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nixy.enable = lib.mkEnableOption "Enable nix module";
  };
  config = lib.mkIf config.nixy.enable {
    home = {
      packages = with pkgs; [
        nil
        statix
        alejandra
        nix-init
        nix-update
        nixpkgs-review
        cachix
      ];
    };
  nix = {
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://raspberry-pi-nix.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
      ];
    };
  };
    };
}
