{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.neofetch];
  # home.file.".config/neofetch/config.conf".text = import ./config.nix;
  # home.file.".config/neofetch/config.conf".text = import ./minimal.nix;
  home.file.".config/neofetch/config.conf".text = import ./clean.nix;
  # home.file.".config/neofetch/config.conf".text = import ./geometrical.nix;
}
