# Role: laptop — battery and power management.
{ lib, ... }:
{
  myConfig.services = {
    enable = lib.mkDefault true;
    tlp.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
  };
}
