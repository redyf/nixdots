{
  lib,
  config,
  ...
}: {
  imports = [
    ./raspberry-hardware.nix
  ];
  options = {
    raspberry.enable = lib.mkEnableOption "Enable raspberry module";
  };

  config = lib.mkIf config.raspberry.enable {
    raspberry-hardware.enable = lib.mkDefault true;
  };
}
