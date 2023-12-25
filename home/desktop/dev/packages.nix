{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: Convert all packages to nix modules

    # Design
    # figma-linux

    # Modeling
    # dia

    # System Utils
    mpd
    mpv
    w3m
    libsixel # Dependency for neofetch so it displays images
    imagemagick # Dependency for neofetch so it displays images
    file
    fuse
    tree
    peek
    timer # CLI sleep progress app
    light # GNU/Linux application to control backlights
    xclip
    chafa # Transform images into colorful ascii (works with gifs too)
    unzip # Unzip files using the terminal
    lolcat
    speechd
    libnotify
    # img2pdf # Convert images to pdf
    findutils
    # flameshot
    traceroute
    tree-sitter # A parser generator tool and an incremental parsing library
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    networkmanager

    # Office + PDF readers
    wpsoffice # MS office alternative for linux
    zathura # PDF viewer

    # Browsers
    brave
    firefox

    # Notes
    # anytype
    # obsidian

    # Anime/Manga
    ani-cli # A cli tool to browse and play anime
    mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Rice
    swww # Cool wallpapers/gifs transitions
    dunst # Notifications for your system
    # sxhkd # BSPWM keybindings
    bemenu # Dmenu for wayland
    pcmanfm # Best GUI file manager
    cmatrix
    # polybar # Bar i use on X11
    onefetch
    nitrogen # Wallpaper utility for X11
    # picom-next # Compositor for X11
    # eww-wayland # Cool widgets for wayland
    # lxappearance # Gui software to change icons/themes
    # brightnessctl

    # Screenshot + extra utils
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    wl-clipboard # Enables copy/paste on wayland

    # Gaming
    # gnutls
    minecraft
    # grapejuice
    # libpulseaudio

    # Audio/Music
    # spotify
    easyeffects
    pavucontrol
  ];
}
