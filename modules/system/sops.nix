{
  config,
  lib,
  hostname,
  username,
  ...
}:

let
  cfg = config.myConfig.system.sops;
  hostSecretsFile = ../../hosts + "/${hostname}/secrets.yaml";
in
{
  options.myConfig.system.sops = {
    enable = lib.mkEnableOption "sops-nix secrets";
    keyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "/var/lib/sops-nix/key.txt";
      description = ''
        Path to the age key used to decrypt secrets on this host. Set to
        null to derive the age key from the SSH host key
        (/etc/ssh/ssh_host_ed25519_key) instead.
      '';
    };
    gitIdentity.enable = lib.mkEnableOption ''
      git/personal/* and git/work/* secrets rendered to
      /run/secrets/rendered/git-{personal,work} (used by the Home Manager
      git.sopsIdentity option)'';
  };

  config = lib.mkIf cfg.enable (
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
          age =
            if cfg.keyFile != null then
              {
                inherit (cfg) keyFile;
              }
            else
              { sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; };

          secrets."users/${username}/password".neededForUsers = true;
        };

        myConfig.users.hashedPasswordFile =
          lib.mkDefault
            config.sops.secrets."users/${username}/password".path;
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
