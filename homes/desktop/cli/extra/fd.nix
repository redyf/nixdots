{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
  ];
}
