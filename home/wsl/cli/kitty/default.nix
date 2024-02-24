{pkgs, ...}: {
  home.packages = with pkgs; [kitty];
  xdg.configFile."kitty/kitty.conf".text = import ./kitty.nix;
  xdg.configFile."kitty/themes/lunar.conf".text = import ./lunar.nix;
}
