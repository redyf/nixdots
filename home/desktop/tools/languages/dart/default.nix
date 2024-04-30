{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    android-studio
  ];
}
