# Role: dev — development tooling and containers.
{ lib, pkgs, ... }:
{
  myConfig = {
    development.aws.enable = lib.mkDefault true;
    virtualization.docker.enable = lib.mkDefault true;
  };

  environment.systemPackages = [ pkgs.docker-compose ];
}
