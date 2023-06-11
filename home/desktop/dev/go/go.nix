{pkgs, ...}: {
  home.packages = with pkgs; [
    go # Go programming language
    gopls
  ];
}
# Programming language
