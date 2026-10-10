{ lib }:
let
  readMeta =
    path: if builtins.pathExists (path + "/meta.nix") then import (path + "/meta.nix") else { };

  listSubdirs =
    path:
    let
      entries = builtins.readDir path;
    in
    lib.attrNames (lib.filterAttrs (_: type: type == "directory") entries);
in
{
  # Reads hosts/<name>/meta.nix for each subdirectory and produces an attrset suitable for `nixosConfigurations`.
  discoverHosts =
    {
      hostsPath,
      mkHost,
    }:
    let
      hostnames = listSubdirs hostsPath;
      mkOne =
        hostname:
        let
          meta = readMeta (hostsPath + "/${hostname}");
        in
        # meta.nix keys map 1:1 to mkHost arguments (username, system,
        # homeDirectory, roles, modules); unknown keys fail evaluation.
        mkHost ({ inherit hostname; } // meta);
    in
    lib.genAttrs hostnames mkOne;

  # One Home Manager configuration per host, keyed "<username>@<hostname>"
  # (the name `home-manager` and `nh home switch` try first). The user comes
  # from hosts/<name>/meta.nix and must have a home/users/<username>.nix.
  discoverHomes =
    {
      hostsPath,
      homePath,
      mkHome,
    }:
    let
      hosts =
        lib.filter
          ({ meta, ... }: meta ? username && builtins.pathExists (homePath + "/users/${meta.username}.nix"))
          (
            map (hostname: {
              inherit hostname;
              meta = readMeta (hostsPath + "/${hostname}");
            }) (listSubdirs hostsPath)
          );
      mkOne =
        { hostname, meta }:
        lib.nameValuePair "${meta.username}@${hostname}" (
          mkHome (
            {
              inherit hostname homePath;
              inherit (meta) username;
            }
            // lib.getAttrs (lib.filter (k: meta ? ${k}) [
              "system"
              "homeDirectory"
              "roles"
              "keyboard"
            ]) meta
          )
        );
    in
    lib.listToAttrs (map mkOne hosts);
}
