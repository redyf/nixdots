{
  pkgs,
  lib,
  ...
}: let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "0f2c393b11dd8174002803835ef7640635100ca3";
    hash = "sha256-iUnLLAQVMXFLyoB3wgYqUTx5SafLkvtOXK6C8EHK/nI=";
  };
  dark-matter = pkgs.fetchFromGitHub {
    owner = "DiscordStyles";
    repo = "DarkMatter";
    rev = "6678a3fb642c94a6f194202255f3fe73b2a829e9";
    hash = "sha256-RunuOehHyT+HlC+ggabv+B6WOaolN9l56Q8W8X3My7Q=";
  };
in {
  home.packages = with pkgs; [
    webcord-vencord # webcord with vencord extension installed
  ];

  # xdg.configFile = {
  # "WebCord/Themes/DarkMatter" = {
  #   source = "${dark-matter}/DarkMatter.theme.css";
  # };

  # xdg.configFile = {
  #  "WebCord/Themes/CatppuccinMocha" = {
  #    source = "${catppuccin-mocha}/themes/mocha.theme.css";
  #  };

  xdg.configFile."~/.config/WebCord/Themes/oxocarbondiscord.theme.css".text = ''
        /**
     * @name oxocarbon-discord
     * @description Allows you to customize Discord's native Color Scheme.
     * @author DevilBro
     * @version 1.0.0
     * @authorId 278543574059057154
     * @invite Jx3TjNS
     * @donate https://www.paypal.me/MircoWittrien
     * @patreon https://www.patreon.com/MircoWittrien
     * @website https://mwittrien.github.io/
     * @source https://github.com/mwittrien/BetterDiscordAddons/tree/master/Themes/DiscordRecolor/
     * @BDEditor DiscordRecolor
    */

    @import url('https://mwittrien.github.io/BetterDiscordAddons/Themes/DiscordRecolor/DiscordRecolor.css');

    :root {
      --accentcolor: 190,149,255;
      --accentcolor2: 255,126,182;
      --linkcolor: 61,219,217;
      --mentioncolor: 66,190,101;
      --textbrightest: 255,255,255;
      --textbrighter: 242,244,248;
      --textbright: 185,185,185;
      --textdark: 140,140,140;
      --textdarker: 115,115,115;
      --textdarkest: 80,80,80;
      --font: gg sans;
      --backgroundaccent: 38,38,38;
      --backgroundprimary: 22,22,22;
      --backgroundsecondary: 38,38,38;
      --backgroundsecondaryalt: 57,57,57;
      --backgroundtertiary: 22,22,22;
      --backgroundfloating: 82,82,82;
      --settingsicons: 1;
    }

    /* Any custom CSS below here */
  '';

  # # share my webcord configuration across devices
  # This shit doesnt work lulz
  # "WebCord/config.json".source = ./vencord.json;
  # };
}
