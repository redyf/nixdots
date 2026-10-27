{ homeDirectory, ... }:
{
  imports = [ ../../profiles/home/common.nix ];

  myHomeConfig.apps = {
    media.enable = true;
    security.enable = true;
  };

  minecraft.enable = true;
  nuvio.enable = true;

  git = {
    sopsIdentity.enable = true;
    work.enable = true;
    maintenanceRepo = "${homeDirectory}/opensource/nixpkgs";
    safeDirectories = [ "${homeDirectory}/opensource/nixdots" ];
  };
}
