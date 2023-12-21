{pkgs, ...}: {
  home.packages = with pkgs; [kitty];
  xdg.configFile."kitty/kitty.conf".text = import ./kitty.nix;
  xdg.configFile."kitty/themes/challenger_deep.conf".text = import ./challenger-deep.nix;
  xdg.configFile."kitty/themes/dark-decay.conf".text = import ./dark-decay.nix;
  xdg.configFile."kitty/themes/decayce.conf".text = import ./decayce.nix;
  xdg.configFile."kitty/themes/lunar.conf".text = import ./lunar.nix;
  xdg.configFile."kitty/themes/mocha.conf".text = import ./mocha.nix;
  xdg.configFile."kitty/themes/macchiato.conf".text = import ./macchiato.nix;
  xdg.configFile."kitty/themes/tokyonight_night.conf".text = import ./tokyonight_night.nix;
}
