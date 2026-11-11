{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.myConfig.users;
in
{
  options.myConfig.users = {
    initialPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Initial password for the user (ignored if hashedPasswordFile is set).";
      default = null;
    };

    hashedPasswordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      description = "Path to a file containing the hashed password (set by the sops module when it is enabled).";
      default = null;
    };

    description = lib.mkOption {
      type = lib.types.str;
      description = "User description/full name";
      default = username;
    };

    shell = lib.mkOption {
      type = lib.types.package;
      description = "The user's shell";
      default = pkgs.zsh;
    };

    groups = {
      virtualisation = lib.mkEnableOption "docker, kvm and libvirtd group membership";
      input = lib.mkEnableOption "input group membership";
    };
  };

  config.users.users.${username} = {
    isNormalUser = true;
    inherit (cfg) shell hashedPasswordFile description;
    initialPassword = lib.mkIf (cfg.hashedPasswordFile == null) cfg.initialPassword;
    extraGroups = [
      "networkmanager"
      "wheel"
    ]
    ++ lib.optionals cfg.groups.virtualisation [
      "docker"
      "kvm"
      "libvirtd"
    ]
    ++ lib.optionals cfg.groups.input [ "input" ];
  };
}
