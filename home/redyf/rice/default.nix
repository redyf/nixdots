{
  lib,
  config,
  ...
}: {
  imports = [
    ./btop
    ./cava
  ];

  options = {
    rice.enable = lib.mkEnableOption "Enable rice module";
  };
  config = lib.mkIf config.rice.enable {
    btop.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault false;
  };
}
