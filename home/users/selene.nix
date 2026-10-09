{
  imports = [ ../../profiles/home/common.nix ];

  myHomeConfig.apps = {
    gaming.enable = false;
    media.enable = false;
    security.enable = true;
  };
}
