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
    rev = "1ef0e745286ce32750abc3bc5d3ca8073a623b60";
    hash = "sha256-RN1VM29OH75GHSHgpu3HW8YSonIEnX7MZzCObJ6BwtQ=";
  };
in
{
  options = {
    minecraft.enable = lib.mkEnableOption "Enable minecraft module";
  };
  config = lib.mkIf config.minecraft.enable {
    home = {
      packages = with pkgs; [
        prismlauncher-unwrapped
        (modrinth-app.overrideAttrs (oldAttrs: {
          buildCommand = ''
            					gappsWrapperArgs+=(
            						--set GDK_BACKEND x11
            						--set WEBKIT_DISABLE_DMABUF_RENDERER 1
            					)
            				''
          + oldAttrs.buildCommand;
        }))
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
