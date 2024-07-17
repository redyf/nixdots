{lib, ...}: {
  imports = [
    ./nix
    ./fonts
    ./shell
  ];

  nixy.enable = true;
  fonts.enable = true;
  shell.enable = true;
}
