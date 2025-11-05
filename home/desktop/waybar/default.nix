{
  lib,
  config,
  pkgs,
  ...
}:
let
  minimalConfig = import ./minimal/config.nix {
    inherit config lib;
  };
  minimalStyle = import ./minimal/style.nix {
    inherit config lib;
  };
  cleanConfig = import ./clean/config.nix {
    inherit config;
  };
  cleanStyle = import ./clean/style.nix {
    inherit config;
  };
  transparentConfig = import ./transparent/config.nix {
    inherit config;
  };
  transparentStyle = import ./transparent/style.nix {
    inherit config;
  };
  niriPuccinConfig = import ./nirippuccin/config.nix {
    inherit config;
  };
  niriPuccinStyle = import ./nirippuccin/style.nix {
    inherit config;
  };
in
{
  options = {
    waybar.enable = lib.mkEnableOption "Enable waybar module";
  };
  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = transparentConfig;
      style = transparentStyle;
    };
  };
}
