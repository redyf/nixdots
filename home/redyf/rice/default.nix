{lib, ...}: {
  imports = [
    ./btop
    ./cava
  ];

  btop.enable = lib.mkDefault true;
  cava.enable = lib.mkDefault false;
}
