{ pkgs, ... }:
{
  programs = {
    sway = {
      enable = false;
      wrapperFeatures.gtk = true;
    };
  };
}
