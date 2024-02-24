{pkgs, ...}: {
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/config.kdl".text = ''
        theme "catppuccin-macchiato"
        default_shell "zsh"
        simplified_ui false
        copy_command "wl-copy"
        ui {
        pane_frames {
            rounded_corners true
        }
    }
  '';
}
