{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode
    gnome.gnome-keyring
  ];
}
