# Role: dev — development tooling and containers.
{ lib, pkgs, ... }:
{
  myConfig = {
    development = {
      enable = lib.mkDefault true;
      ansible.enable = lib.mkDefault false;
      aws.enable = lib.mkDefault true;
      k3s.enable = lib.mkDefault false;
      localstack.enable = lib.mkDefault false;
      nginx.enable = lib.mkDefault false;
      terraform.enable = lib.mkDefault false;
    };

    virtualization = {
      enable = lib.mkDefault true;
      docker.enable = lib.mkDefault true;
      virtmanager.enable = lib.mkDefault false;
      virtualbox.enable = lib.mkDefault false;
    };
  };

  environment.systemPackages = [ pkgs.docker-compose ];
}
