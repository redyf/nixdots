{
  config,
  lib,
  inputs,
  hostname,
  ...
}:

let
  cfg = config.myConfig.system.sops;
  hostSecretsFile = ../../hosts + "/${hostname}/secrets.yaml";
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    sops = {
      defaultSopsFile = hostSecretsFile;
      defaultSopsFormat = "yaml";
      age = {
        inherit (cfg) keyFile;
        generateKey = false;
      };

      secrets."users/${config.myConfig.users.username}/password" = {
        neededForUsers = true;
      };
    };
  };
}
