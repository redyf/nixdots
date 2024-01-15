{ pkgs, ... }: {
  home.packages = with pkgs; [ kitty ];
  xdg = {
    configFile = {
      "kitty/kitty.conf".text = import ./kitty.nix;
      "kitty/themes/challenger_deep.conf".text = import ./challenger-deep.nix;
      "kitty/themes/dark-decay.conf".text = import ./dark-decay.nix;
      "kitty/themes/decayce.conf".text = import ./decayce.nix;
      "kitty/themes/lunar.conf".text = import ./lunar.nix;
      "kitty/themes/mocha.conf".text = import ./mocha.nix;
      "kitty/themes/macchiato.conf".text = import ./macchiato.nix;
      "kitty/themes/tokyonight_night.conf".text = import ./tokyonight_night.nix;
      "kitty/themes/rose-pine.conf".text = import ./rose-pine.nix;
    };
  };
}
