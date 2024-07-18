{
  lib,
  config,
  ...
}: {
  imports = [
    ./btop
    ./cava
    ./fastfetch
  ];

  options = {
    rice.enable = lib.mkEnableOption "Enable rice module";
  };
  config = lib.mkIf config.rice.enable {
    btop.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault false;
    fastfetch.enable = lib.mkDefault false;
  };
}
