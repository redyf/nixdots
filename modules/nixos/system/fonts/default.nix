{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ font-manager ];
      variables = {
        # Enable icons in tooling since we have nerdfonts.
        LOG_ICONS = "true";
      };
    };

    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [ "Times, Noto Serif" ];
          sansSerif = [ "Helvetica Neue LT Std, Helvetica, Noto Sans" ];
          monospace = [ "Courier Prime, Courier, Noto Sans Mono" ];
        };
      };
      packages = with pkgs;
        [
          sf-mono-liga-bin
          noto-fonts
          dejavu_fonts
          font-awesome
          fira-code-symbols
          powerline-symbols
          material-design-icons
          ubuntu_font_family
          (nerdfonts.override { fonts = [ "IBMPlexMono" "CascadiaCode" "FiraMono" "JetBrainsMono" ]; })
        ]
        ++ cfg.fonts;
    };
  };
}
