{ lib, ... }:
{
  imports = import ../lib/modules-in.nix { inherit lib; } ./.;
}
