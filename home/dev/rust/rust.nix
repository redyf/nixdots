{pkgs, ...}: {
  home.packages = with pkgs; [
    rustc
    cargo
  ];
}
