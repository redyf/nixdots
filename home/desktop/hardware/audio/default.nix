{pkgs, ...}: {
  # sound.enable = true;
  # security.rtkit.enable = true;
  # programs.noisetorch.enable = true;
  home.packages = with pkgs; [
    easyeffects
    pavucontrol
    noisetorch
  ];
}
