{ pkgs, ... }: {
  home.packages = with pkgs; [
    neofetch
    imagemagick # Dependency for neofetch so it displays images
    libsixel # Dependency for neofetch so it displays images
    w3m
  ];
  # home.file.".config/neofetch/config.conf".text = import ./config.nix;
  # home.file.".config/neofetch/config.conf".text = import ./minimal.nix;
  home.file.".config/neofetch/config.conf".text = import ./clean.nix;
  # home.file.".config/neofetch/config.conf".text = import ./geometrical.nix;
}
