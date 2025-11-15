{ lib, ... }:

{
  options.myConfig.development = {
    enable = lib.mkEnableOption "Enable development configuration";

    ansible = {
      enable = lib.mkEnableOption "Enable Ansible";
    };

    aws = {
      enable = lib.mkEnableOption "Enable aws cli";
    };

    k3s = {
      enable = lib.mkEnableOption "Enable K3s";
    };

    k8s = {
      enable = lib.mkEnableOption "Enable K8s";
    };

    nginx = {
      enable = lib.mkEnableOption "Enable Nginx";
    };

    terraform = {
      enable = lib.mkEnableOption "Enable Terraform";
    };
  };

  imports = [
    ./ansible.nix
    ./aws.nix
    ./k3s.nix
    ./k8s.nix
    ./nginx.nix
    ./terraform.nix
  ];
}
