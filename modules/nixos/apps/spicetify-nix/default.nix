{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.spicetify;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  options.apps.spicetify = with types; {
    enable = mkBoolOpt false "Enable spicetify-nix";
  };

  config = mkIf cfg.enable {

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.text;
      # colorScheme = "mocha";

      # enabledExtensions = with spicePkgs.extensions; [
      #   fullAppDisplay
      #   shuffle # shuffle+ (special characters are sanitized out of ext names)
      #   hidePodcasts
      # ];
    };
  };
}
