{pkgs, ...}: {
  # Requires https://github.com/caarlos0/timer to be installed. spd-say should ship with your distro (Thanks Bashbunni!)
  home.packages = with pkgs; [
    # Anime/Manga
    ani-cli # A cli tool to browse and play anime
    # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Cloud
    awscli2

    # Gaming
    # gnutls
    # minecraft
    # grapejuice
    # libpulseaudio

    # Office + PDF readers
    wpsoffice # MS office alternative for linux

    # Notetaking
    obsidian

    # Rice
    # mako
    # dunst # Notifications for your system
    # cmatrix
    yazi # Best TUI file manager
    nitrogen # Wallpaper utility for X11
    nwg-look # Change GTK theme

    # Screenshot + extra utils
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    wl-clipboard # Enables copy/paste on wayland
    vlc

    # System Utils
    # mpd
    mpv
    # peek # Animated GIF screen recorder
    glib
    xclip
    unzip # Unzip files using the terminal
    # nerdfix # Fix obsolete nerd font icons
    tree-sitter # A parser generator tool and an incremental parsing library
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    dmenu
    spotify
  ];
}
