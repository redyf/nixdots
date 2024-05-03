{pkgs, ...}: {
  home.packages = with pkgs; [
    mysql80
    postgresql
    beekeeper-studio
    # mysql-workbench
  ];
}
