{
  inputs,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    catppuccin.enable = true;
    defaultEditor = true;
  };
}
