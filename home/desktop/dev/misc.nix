{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: Convert all packages to nix modules

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
    networkmanager

    # Office + PDF readers
    wpsoffice # MS office alternative for linux
    zathura # PDF viewer

    # Browsers
    firefox

    # Anime/Manga
    ani-cli # A cli tool to browse and play anime
    # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Rice
    swww # Cool wallpapers/gifs transitions
    dunst # Notifications for your system
    bemenu # Dmenu for wayland
    xfce.thunar # Best GUI file manager
    cmatrix
    onefetch
    nitrogen # Wallpaper utility for X11

    # Screenshot + extra utils
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    wl-clipboard # Enables copy/paste on wayland

    # Gaming
    # gnutls
    minecraft
    # grapejuice
    # libpulseaudio

    # Audio/Music
    easyeffects
    pavucontrol
  ];
}
