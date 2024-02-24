{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    custom.insomnia
  ];
}
