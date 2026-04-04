_: {
  wayland.windowManager.hyprland = {
    settings = {

      bind = [
        "SUPER,Q,killactive,"
        "SUPER SHIFT,M,exit,"
        "SUPER,S,togglefloating,"
        "SUPER,g,togglegroup"

        "SUPER,h,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,k,movefocus,u"
        "SUPER,j,movefocus,d"

        "SUPER,left,movefocus,l"
        "SUPER,down,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,right,movefocus,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"

        # "SUPER SHIFT, H, movewindow, l"
        # "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        "SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8"

        "SUPER, period, layoutmsg, move +col"
        "SUPER, comma, layoutmsg, move -col"
        "SUPER, equal, layoutmsg, colresize +0.2"
        "SUPER, minus, layoutmsg, colresize -0.2"

        "SUPER, P, layoutmsg, promote"
        "SUPER SHIFT, period, layoutmsg, swapcol r"
        "SUPER SHIFT, comma, layoutmsg, swapcol l"
        "SUPER SHIFT, H, layoutmsg, swapcol l"
        "SUPER SHIFT, L, layoutmsg, swapcol r"
        "SUPER, M, layoutmsg, togglefit"

        "SUPER,RETURN,exec,wezterm"
        "SUPER,e,exec,emacsclient -c -a 'emacs'"
        ",Print,exec,screenshot"
        "SUPER,Print,exec,screenshot-edit"
        "CTRL,Print,exec,grim -o DP-1 ~/Pictures/screenshot.png"
        "SUPER,o,exec,obsidian"
        "SUPER,space,exec,wofi --show drun -I"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      windowrule = [
        # "float,class:^(pavucontrol)$"
        # "fullscreen,class:^(artix-games-launcher)$"
        # "float,class:^(file_progress)$"
        # "float,class:^(confirm)$"
        # "float,class:^(dialog)$"
        # "float,class:^(download)$"
        # "float,class:^(notification)$"
        # "float,class:^(error)$"
        # "float,class:^(confirmreset)$"
        # "float,title:^(Open File)$"
        # "float,title:^(branchdialog)$"
        # "float,title:^(Confirm to replace files)$"
        # "float,title:^(File Operation Progress)$"
        # "float,title:^(mpv)$"
        "match:class firefox, workspace 1"
        "match:class wezterm, workspace 2"
        "match:class vesktop, workspace 3"
        # "opacity 1.0 1.0,class:^(wofi)$"
      ];

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };
  };
}
