{ homeDirectory, ... }:
{
  imports = [ ../profiles/home/common.nix ];

  myHomeConfig = {
    apps = {
      media.enable = true;
      security.enable = true;
      gaming.minecraft.enable = false;
    };

    cli.tools.git = {
      sopsIdentity.enable = true;
      work.enable = true;
      maintenanceRepo = "${homeDirectory}/opensource/nixpkgs";
      safeDirectories = [ "${homeDirectory}/opensource/nixdots" ];
    };
  };
}
