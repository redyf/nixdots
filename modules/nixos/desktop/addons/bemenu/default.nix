{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.bemenu;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in
{
  options.desktop.addons.bemenu = with types; {
    enable = mkBoolOpt false "Enable or disable the bemenu run launcher.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bemenu
    ];
  };
}
