# `nix flake check` evaluates nixosConfigurations but not homeConfigurations.
# This check forces evaluation of every Home Manager configuration for the
# system of `pkgs` without building it: only the .drv paths are written to
# the output.
{ pkgs, homeConfigurations }:
let
  inherit (pkgs) lib;
  inherit (pkgs.stdenv.hostPlatform) system;
  homes = lib.filterAttrs (_: home: home.activationPackage.system == system) homeConfigurations;
  drvPaths = lib.mapAttrsToList (
    name: home: "${name} ${builtins.unsafeDiscardStringContext home.activationPackage.drvPath}"
  ) homes;
in
pkgs.writeText "home-configurations-eval" (lib.concatLines drvPaths)
