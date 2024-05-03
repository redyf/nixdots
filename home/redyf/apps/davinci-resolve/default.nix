{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
  ];
}
