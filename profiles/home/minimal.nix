{ lib, ... }:
{
  myHomeConfig = {
    apps = {
      enable = lib.mkDefault true;
      browsers.enable = lib.mkDefault false;
      development.enable = lib.mkDefault false;
      file-explorer.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault false;
      media.enable = lib.mkDefault false;
      security.enable = lib.mkDefault false;
      web.enable = lib.mkDefault false;
    };

    cli = {
      enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      neve.enable = lib.mkDefault false;
      tools.enable = lib.mkDefault false;
    };

    desktop = {
      enable = lib.mkDefault false;
      foot.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault false;
      gtk-theme.enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault false;
      noctalia.enable = lib.mkDefault false;
      rofi.enable = lib.mkDefault false;
      sway.enable = lib.mkDefault false;
      swww.enable = lib.mkDefault false;
      stylix-theme.enable = lib.mkDefault false;
      wezterm.enable = lib.mkDefault false;
      wofi.enable = lib.mkDefault false;
    };

    shells = {
      enable = lib.mkDefault true;
      nushell.enable = lib.mkDefault false;
      scripts.enable = lib.mkDefault false;
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
