{
  pkgs,
  lib,
  config,
  ...
}:
let
  catppuccin-prismlauncher = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "prismlauncher";
    rev = "main"; # Or pin to a specific commit hash for reproducibility
    sha256 = "0z4z4qq7b7q5f4vwsphyiszdm410kmy4zkzsylcnnzzdki4sn8gv"; # You'll need to update this with the actual hash
  };
in
{
  options = {
    minecraft.enable = lib.mkEnableOption "Enable minecraft module";
  };
  config = lib.mkIf config.minecraft.enable {
    home = {
      packages = with pkgs; [
        prismlauncher
      ];
      file = {
        ".local/share/PrismLauncher/themes/Catppuccin-Mocha" = {
          source = "${catppuccin-prismlauncher}/themes/Mocha";
          recursive = true;
        };
      };
    };
  };
}
