{ homeDirectory, ... }:
{
  imports = [ ../../profiles/home/common.nix ];

  myHomeConfig.apps = {
    gaming.enable = true;
    media.enable = true;
    security.enable = false;
  };

  git = {
    sopsIdentity.enable = true;
    work.enable = true;
    maintenanceRepo = "${homeDirectory}/opensource/nixpkgs";
    safeDirectories = [ "${homeDirectory}/opensource/nixdots" ];
  };
}
