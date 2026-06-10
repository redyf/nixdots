# modules/users/groups.nix
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.users;
in
{
  options.myConfig.users = {
    enable = lib.mkEnableOption "Enable user configuration";

    username = lib.mkOption {
      type = lib.types.str;
      description = "Primary username for the system";
    };

    initialPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Initial password for the user (ignored if hashedPasswordFile is set).";
      default = null;
    };

    hashedPasswordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      description = "Path to a file containing the hashed password (e.g. provided by sops-nix).";
      default = null;
    };

    description = lib.mkOption {
      type = lib.types.str;
      description = "User description/full name";
      default = ""; # Will default to username if empty
    };

    isNormalUser = lib.mkOption {
      type = lib.types.bool;
      description = "Whether this is a normal user account";
      default = true;
    };

    shell = lib.mkOption {
      type = lib.types.package;
      description = "The user's shell";
      default = pkgs.zsh;
      example = "pkgs.bash";
    };

    groups = {
      base = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Base groups every user belongs to";
        default = [
          "networkmanager"
          "wheel"
        ];
      };

      development = lib.mkEnableOption "Enable development groups";
      virtualisation = lib.mkEnableOption "Enable virtualisation groups";
      media = lib.mkEnableOption "Enable media groups";
      input = lib.mkEnableOption "Enable input groups";

      additional = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Additional groups not covered by other options";
        default = [ ];
        example = [
          "wireshark"
          "cdrom"
        ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      extraGroups.xboxusers.members = [ cfg.username ];
      users.${cfg.username} = {
        inherit (cfg) isNormalUser shell hashedPasswordFile;
        initialPassword = lib.mkIf (cfg.hashedPasswordFile == null) cfg.initialPassword;
        description = if cfg.description != "" then cfg.description else cfg.username;
        extraGroups =
          cfg.groups.base
          ++ (lib.optionals cfg.groups.development [
            "dialout"
            "plugdev"
          ])
          ++ (lib.optionals cfg.groups.virtualisation [
            "docker"
            "kvm"
            "libvirtd"
            "gamemode"
          ])
          ++ (lib.optionals cfg.groups.media [
            "audio"
            "video"
          ])
          ++ (lib.optionals cfg.groups.input [ "input" ])
          ++ cfg.groups.additional;
      };
    };
  };
}
