{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    cmake
    gnumake
    gnupatch
    clang-tools
  ];
}
