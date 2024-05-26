{pkgs, ...}: {
  # Requires https://github.com/caarlos0/timer to be installed. spd-say should ship with your distro (Thanks Bashbunni!)
  home.packages = with pkgs; [
    # Anime/Manga
    # ani-cli # A cli tool to browse and play anime
    # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Cloud
    awscli2

    # Gaming
    # gnutls
    # minecraft
    # grapejuice
    # libpulseaudio

    # Notetaking
    obsidian

    # Other stuff
    gh
    ollama
    playerctl
    # spotify

    # Rice
    # mako
    bemenu
    # cmatrix
    nitrogen # Wallpaper utility for X11
    nwg-look # Change GTK theme

    # Screenshot + extra utils
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    wl-clipboard # Enables copy/paste on wayland
    vlc

    # System Utils
    mpv
    glib
    unzip # Unzip files using the terminal
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    tree-sitter # A parser generator tool and an incremental parsing library
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    cinnamon.nemo
  ];
}
