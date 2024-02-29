{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Utils
    mpd
    mpv
    tree
    peek # Animated GIF screen recorder
    xclip
    unzip # Unzip files using the terminal
    nerdfix # Fix obsolete nerd font icons
    traceroute # Tool to access the X clipboard from a console application
    tree-sitter # A parser generator tool and an incremental parsing library
    appimage-run # Run appimage files in the terminal
    polkit_gnome

    # Office + PDF readers
    wpsoffice # MS office alternative for linux
    zathura # PDF viewer

    # Anime/Manga
    # ani-cli # A cli tool to browse and play anime
    # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Rice
    dunst # Notifications for your system
    cmatrix
    onefetch
    xfce.thunar # Best GUI file manager
    # nitrogen # Wallpaper utility for X11

    # Screenshot + extra utils
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    wl-clipboard # Enables copy/paste on wayland
    davinci-resolve

    # Gaming
    # gnutls
    # minecraft
    # grapejuice
    # libpulseaudio
  ];
}
