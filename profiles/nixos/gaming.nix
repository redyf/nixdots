# Role: gaming — Steam and friends.
{ lib, ... }:
{
  myConfig.gaming = {
    enable = lib.mkDefault true;
    steam.enable = lib.mkDefault true;
  };
}
