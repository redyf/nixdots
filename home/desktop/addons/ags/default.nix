{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];
  options = {
    ags.enable = lib.mkEnableOption "Enable ags module";
  };
  config = lib.mkIf config.ags.enable {
    home.packages = with pkgs; [
      dart-sass
      brightnessctl
      inputs.matugen.packages.${system}.default
      wf-recorder
      wayshot
      hyprpicker
      pavucontrol
      pamixer
    ];

    programs.ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      configDir = ./config;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
