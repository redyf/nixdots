{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    fortune
    ponysay
    pokemonsay
    pokemon-colorscripts-mac
    thefuck
  ];
  home.file.".config/fortunes" = {
    source = ./fortunes;
    recursive = true;
  };
}
