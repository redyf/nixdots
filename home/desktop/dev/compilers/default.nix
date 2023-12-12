{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc # GNU Compiler Collection
    beautysh # Shell formatter
    gnupatch
  ];
}
