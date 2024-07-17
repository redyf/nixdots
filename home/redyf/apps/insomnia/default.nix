{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    insomnia.enable = lib.mkEnableOption "Enable insomnia module";
  };
  config = lib.mkIf config.insomnia.enable {
    home.packages = with pkgs; [
      (pkgs.callPackage ../../../../pkgs/insomnia.nix {
        src = insomnia; # pkg source is passed as a `specialArgs` and injected into this module.
      })
    ];
  };
}
