{
  inputs,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    # package = inputs.helix.packages.${pkgs.system}.helix;
  };
}
