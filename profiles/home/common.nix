# Shared Home Manager baseline for the personal users (selene, redyf).
# User files in home/users/ only keep what differs.
{ lib, ... }:
{
  imports = [
    ../../home/apps
    ../../home/cli
    ../../home/desktop
    ../../home/shells
    ../../home/system
  ];

  home = {
    pointerCursor.enable = lib.mkDefault true;
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  myHomeConfig = {
    apps = {
      enable = lib.mkDefault true;
      browsers.enable = lib.mkDefault true;
      development.enable = lib.mkDefault true;
      file-explorer.enable = lib.mkDefault true;
      # Only artix-game-launcher is on by default inside home/apps/gaming.
      gaming.enable = lib.mkDefault true;
      web.enable = lib.mkDefault true;
    };

    cli = {
      enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      neve.enable = lib.mkDefault false;
      tools.enable = lib.mkDefault true;
    };

    desktop = {
      enable = lib.mkDefault true;
      caelestia.enable = lib.mkDefault false;
      foot.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault true;
      gtk-theme.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      noctalia.enable = lib.mkDefault false;
      rofi.enable = lib.mkDefault false;
      serpantinum.enable = lib.mkDefault true;
      sway.enable = lib.mkDefault false;
      swww.enable = lib.mkDefault false;
      stylix-theme.enable = lib.mkDefault true;
      wezterm.enable = lib.mkDefault true;
      wofi.enable = lib.mkDefault true;
    };

    shells = {
      enable = lib.mkDefault true;
      nushell.enable = lib.mkDefault false;
      scripts.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    system = {
      enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      nixy.enable = lib.mkDefault true;
      utils.enable = lib.mkDefault true;
    };
  };
}
