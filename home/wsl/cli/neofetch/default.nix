{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.neofetch];
  # home.file.".config/neofetch/config.conf".text = import ./config.nix;
  # home.file.".config/neofetch/config.conf".text = import ./minimal.nix;
  home.file.".config/neofetch/config.conf".text = import ./clean.nix;
  # home.file.".config/neofetch/config.conf".text = import ./geometrical.nix;

  # xdg = {
  #   configFile = {
  # ".config/neofetch/ascii/logoo.txt".text = import ./ascii/logoo.txt;
  # ".config/neofetch/ascii/lambda.txt".text = import ./ascii/lambda.txt;
  #     ".config/neofetch/images/sakurafetch.png".text = import ./images/sakurafetch.png;
  #   };
  # };
}
