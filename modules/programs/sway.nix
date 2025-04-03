{ pkgs, ... }:
{
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = false;
    };
  };
}
