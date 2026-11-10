{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.myConfig.virtualization.virtualbox;
in
{
  options.myConfig.virtualization.virtualbox.enable = lib.mkEnableOption "VirtualBox";

  config = lib.mkIf cfg.enable {
    virtualisation = {
      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
      };
    };

    users.extraGroups.vboxusers.members = [ username ];
  };
}
