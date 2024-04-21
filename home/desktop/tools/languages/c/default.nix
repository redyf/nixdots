{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    cmake
    gnumake
    gnupatch
    # astyle
    # cpplint
    clang-tools
  ];
}
