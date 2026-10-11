{
  imports = [ ../../profiles/home/common.nix ];

  myHomeConfig.apps = {
    media.enable = false;
    security.enable = true;
  };
}
