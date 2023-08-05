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
  # dark-matter = pkgs.fetchFromGitHub {
  #   owner = "DiscordStyles";
  #   repo = "DarkMatter";
  #   rev = "6678a3fb642c94a6f194202255f3fe73b2a829e9";
  #   hash = "sha256-RunuOehHyT+HlC+ggabv+B6WOaolN9l56Q8W8X3My7Q=";
  # };
in {
  home.packages = with pkgs; [
    webcord-vencord # webcord with vencord extension installed
  ];

  xdg.configFile = {
    "WebCord/Themes/DarkMatter" = {
      source = "${catppuccin-mocha}/themes/mocha.theme.css";
      # source = "${dark-matter}/DarkMatter.theme.css";
    };

    # # share my webcord configuration across devices
    # This shit doesnt work lulz
    # "WebCord/config.json".source = ./vencord.json;
  };
}
