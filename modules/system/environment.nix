{ pkgs, ... }:
{
  environment = {
    variables = {
      EDITOR = "nvim";
      XDG_SESSION_TYPE = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GTK_THEME = "Catppuccin-Mocha-Compact-Blue-dark";
      # Add java to path
      JAVA_HOME = "${pkgs.jdk23_headless.home}/lib/openjdk";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox"; # Set default browser
    };
    plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      oxygen
      plasma-browser-integration
      kwallet
      kwallet-pam
      kwalletmanager
    ];
  };
}
