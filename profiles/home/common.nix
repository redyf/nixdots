# Shared Home Manager baseline for the personal users (selene, redyf).
# User files in users/ only keep what differs.
{ lib, ... }:
{
  home.pointerCursor.enable = lib.mkDefault true;

  myHomeConfig = {
    apps = {
      browsers.brave.enable = lib.mkDefault true;
      development = {
        database.enable = lib.mkDefault true;
        obsidian.enable = lib.mkDefault true;
        vscode.enable = lib.mkDefault true;
      };
      file-explorer.enable = lib.mkDefault true;
      gaming.artix-game-launcher.enable = lib.mkDefault true;
      web.enable = lib.mkDefault true;
    };

    cli = {
      neovim.enable = lib.mkDefault true;
      tools = {
        agents.enable = lib.mkDefault true;
        bat.enable = lib.mkDefault true;
        cymbal.enable = lib.mkDefault true;
        direnv.enable = lib.mkDefault true;
        eza.enable = lib.mkDefault true;
        fd.enable = lib.mkDefault true;
        fzf.enable = lib.mkDefault true;
        git.enable = lib.mkDefault true;
        http.enable = lib.mkDefault true;
        jq.enable = lib.mkDefault true;
        languages = {
          c.enable = lib.mkDefault true;
          javascript.enable = lib.mkDefault true;
          lua.enable = lib.mkDefault true;
          python.enable = lib.mkDefault true;
          rust.enable = lib.mkDefault true;
          yaml.enable = lib.mkDefault true;
        };
        ripgrep.enable = lib.mkDefault true;
        starship.enable = lib.mkDefault true;
        tmux.enable = lib.mkDefault true;
        zoxide.enable = lib.mkDefault true;
      };
    };

    desktop = {
      ghostty.enable = lib.mkDefault true;
      gtk-theme.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      serpantinum.enable = lib.mkDefault true;
      stylix-theme.enable = lib.mkDefault true;
      wezterm.enable = lib.mkDefault true;
      wofi.enable = lib.mkDefault true;
    };

    shells = {
      scripts.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    system = {
      fonts.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      utils.enable = lib.mkDefault true;
    };
  };
}
