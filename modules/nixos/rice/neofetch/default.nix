{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.rice.neofetch;
in
{
  options.rice.neofetch = with types; {
    enable = mkBoolOpt false "Enable or disable neofetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
      imagemagick # Dependency for neofetch so it displays images
      libsixel # Dependency for neofetch so it displays images
      w3m
    ];
    # home.file.".config/neofetch/config.conf".text = import ./config.nix;
    # home.file.".config/neofetch/config.conf".text = import ./minimal.nix;
    home.file.".config/neofetch/config.conf".text = import ./clean.nix;
    # home.file.".config/neofetch/config.conf".text = import ./geometrical.nix;
  };
}
