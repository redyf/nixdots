{ pkgs, ... }: {
  home.packages = with pkgs; [
    rm-improved
  ];
}
