{ homeDirectory, ... }:
{
  imports = [ ../profiles/home/common.nix ];

  myHomeConfig = {
    apps.security = {
      enable = true;
      sshAgent.enable = true;
    };

    cli.tools.git = {
      work.enable = false;
      githubIdentityFile = "${homeDirectory}/.ssh/id_ed25519.pub";
      workIdentityFile = "${homeDirectory}/.ssh/id_ed25519_work.pub";
    };
  };
}
