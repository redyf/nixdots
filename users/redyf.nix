{ homeDirectory, ... }:
{
  imports = [ ../profiles/home/common.nix ];

  myHomeConfig = {
    apps = {
      media.enable = true;
      security = {
        enable = true;
        sshAgent.enable = true;
      };
      gaming.minecraft.enable = false;
    };

    cli.tools.git = {
      sopsIdentity.enable = true;
      work.enable = true;
      githubIdentityFile = "${homeDirectory}/.ssh/id_ed25519.pub";
      workIdentityFile = "${homeDirectory}/.ssh/id_ed25519_work.pub";
      maintenanceRepo = "${homeDirectory}/opensource/nixpkgs";
      safeDirectories = [ "${homeDirectory}/opensource/nixdots" ];
    };
  };
}
