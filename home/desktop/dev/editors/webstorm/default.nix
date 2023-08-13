{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    jetbrains.webstorm
  ];
}
