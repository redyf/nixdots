# Safe public baseline: no GUI, no personal apps.
{ lib, ... }:
{
  myHomeConfig = {
    apps.file-explorer.enable = lib.mkDefault true;
    cli.neovim.enable = lib.mkDefault true;
    shells.zsh.enable = lib.mkDefault true;

    system = {
      fonts.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      utils.enable = lib.mkDefault true;
    };
  };
}
