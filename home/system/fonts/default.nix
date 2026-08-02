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
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.tx02
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.berkeley-mono
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.sf-mono
        nerd-fonts.jetbrains-mono
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
