# Role: laptop — battery and power management.
{ lib, ... }:
{
  myConfig.services = {
    tlp.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
  };
}
