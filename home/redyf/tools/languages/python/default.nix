{pkgs, ...}: {
  home.packages = with pkgs; [
    poetry
    python3
  ];
}
