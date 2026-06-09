{
  config,
  lib,
  hostname,
  ...
}:

let
  cfg = config.myConfig.system.sops;
  username = config.myConfig.users.username;
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

      secrets = {
        "users/${username}/password" = {
          neededForUsers = true;
        };

        "git/personal/name".owner = username;
        "git/personal/email".owner = username;
        "git/work/name".owner = username;
        "git/work/email".owner = username;
      };

      templates = {
        "git-personal" = {
          owner = username;
          mode = "0400";
          content = ''
            [user]
              name = ${config.sops.placeholder."git/personal/name"}
              email = ${config.sops.placeholder."git/personal/email"}
          '';
        };

        "git-work" = {
          owner = username;
          mode = "0400";
          content = ''
            [user]
              name = ${config.sops.placeholder."git/work/name"}
              email = ${config.sops.placeholder."git/work/email"}
          '';
        };
      };
    };
  };
}
