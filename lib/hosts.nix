# One attrset per hosts/<name>/meta.nix, with the defaults filled in.
{ lib }:
hostsPath:
lib.mapAttrs (
  hostname: _:
  let
    meta = import (hostsPath + "/${hostname}/meta.nix");
  in
  {
    inherit hostname;
    inherit (meta) username system roles;
    homeDirectory = "/home/${meta.username}";
    keyboard =
      meta.keyboard or {
        layout = "us";
        variant = "";
      };
  }
) (lib.filterAttrs (_: type: type == "directory") (builtins.readDir hostsPath))
