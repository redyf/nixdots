{ inputs
, lib
, pkgs
, config
, ...
}: with lib;
with lib.custom;
{
  imports = [
    <nixos/nixos/modules/virtualisation/virtualbox-image.nix>
  ];
  # suites = {
  #   development = enabled;
  # };
}
