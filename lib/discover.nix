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

  listNixFiles =
    path:
    let
      entries = builtins.readDir path;
    in
    map (lib.removeSuffix ".nix") (
      lib.attrNames (
        lib.filterAttrs (
          name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
        ) entries
      )
    );
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
        mkHost (
          {
            inherit hostname;
            inherit (meta) username;
          }
          // lib.optionalAttrs (meta ? system) { inherit (meta) system; }
          // lib.optionalAttrs (meta ? homeDirectory) { inherit (meta) homeDirectory; }
          // lib.optionalAttrs (meta ? modules) { inherit (meta) modules; }
        );
    in
    lib.genAttrs hostnames mkOne;

  # Reads home/users/*.nix and produces an attrset for `homeConfigurations`.
  # Per-user metadata can live in home/users/<name>.meta.nix or be inferred.
  discoverHomes =
    {
      homePath,
      mkHome,
      defaults ? { },
    }:
    let
      usersDir = homePath + "/users";
      usernames = listNixFiles usersDir;
      mkOne =
        username:
        let
          metaFile = usersDir + "/${username}.meta.nix";
          meta = if builtins.pathExists metaFile then import metaFile else { };
        in
        mkHome (defaults // { inherit username; } // meta);
    in
    lib.genAttrs usernames mkOne;
}
