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
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = builtins.pathExists hostSecretsFile;
            message = "myConfig.system.sops is enabled but hosts/${hostname}/secrets.yaml does not exist. Create it with `sops hosts/${hostname}/secrets.yaml` (see docs/sops-setup.md).";
          }
        ];

        sops = {
          defaultSopsFile = hostSecretsFile;
          defaultSopsFormat = "yaml";
          age =
            if cfg.keyFile != null then
              {
                inherit (cfg) keyFile;
                generateKey = false;
              }
            else
              { sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; };

          secrets."users/${username}/password".neededForUsers = true;
        };
      }

      (lib.mkIf cfg.gitIdentity.enable {
        sops = {
          secrets = {
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
      })
    ]
  );
}
