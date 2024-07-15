{pkgs, ...}: {
  home.packages = with pkgs; [
    postgresql
    # beekeeper-studio
    # mysql-workbench
  ];
}
