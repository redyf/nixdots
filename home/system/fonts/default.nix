{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    fonts.enable = lib.mkEnableOption "Enable fonts module";
  };
  config = lib.mkIf config.fonts.enable {
    home = {
      packages = with pkgs; [
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.monolisa
        nerd-fonts.jetbrains-mono
        # (pkgs.stdenv.mkDerivation {
        #   pname = "BerkeleyFont";
        #   version = "1.0";
        #   src = /home/redyf/opensource/font-flake/Berkeley;
        #   installPhase = ''
        #     mkdir -p $out/share/fonts/truetype
        #     mv *.ttf $out/share/fonts/truetype/
        #   '';
        # })
        # (stdenvNoCC.mkDerivation {
        #   pname = "sf-mono-liga-bin";
        #   version = "dev";
        #   src = inputs.sf-mono-liga-src;
        #   dontConfigure = true;
        #   installPhase = ''
        #     mkdir -p $out/share/fonts/opentype
        #     cp -R $src/*.otf $out/share/fonts/opentype/
        #   '';
        # })
      ];
    };
    fonts.fontconfig = {
      enable = true;
      configFile."sfmono-hinting.conf" = {
        enable = true;
        text = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
          <fontconfig>
            <match target="font">
              <test name="family"><string>Liga SFMono Nerd Font</string></test>
              <edit name="autohint" mode="assign"><bool>true</bool></edit>
              <edit name="hinting" mode="assign"><bool>true</bool></edit>
              <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
            </match>
          </fontconfig>
        '';
      };
    };
  };
}
