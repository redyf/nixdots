# Every module under `dir`, for a default.nix that is only `{ imports = ...; }`.
# A directory holding a default.nix is one module (its other files belong to
# it); any other .nix file is a module on its own.
{ lib }:
dir:
let
  walk =
    path:
    lib.concatLists (
      lib.mapAttrsToList (
        name: type:
        let
          entry = path + "/${name}";
        in
        if type == "directory" then
          if builtins.pathExists (entry + "/default.nix") then [ entry ] else walk entry
        else
          lib.optional (lib.hasSuffix ".nix" name && name != "default.nix") entry
      ) (builtins.readDir path)
    );
in
walk dir
