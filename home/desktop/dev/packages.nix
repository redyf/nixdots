{pkgs, ...}: {
  home.packages = with pkgs; [
    # Dev
    poetry
    httpie
    # postman
    openssl
    postgresql
    beekeeper-studio
    # mysql-workbench

    # Design
    # figma-linux

    # Modeling
    dia

    # Useful utils
    fd # A simple, fast and user-friendly alternative to find
    jq # A lightweight and flexible command-line JSON processor
    eza # Replacement for ls in rust (removed due to unmaintained upstream).
    fzf # Fuzzy finder
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    rm-improved # Replacement for rm with focus on safety, ergonomics and performance

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
    # gobject-introspection # A middleware layer between C libraries and language bindings

    # Terminal && prompt
    nerdfix # Helps you find/fix obsolete Nerd font icons
    lazygit # Amazing CLI git tool

    # Text Editors/IDEs
    vscode
    neovide # Gui neovim editor with cool animations

    # Office + PDF readers
    wpsoffice # MS office alternative for linux
    zathura # PDF viewer

    # Browsers
    brave
    firefox
    # google-chrome

    # Socials
    discord

    # Note taking
    anytype
    obsidian

    # Anime/Manga
    ani-cli # A cli tool to browse and play anime
    mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

    # Rice
    # st # Suckless terminal
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

    # Video editing/Streaming
    # davinci-resolve
    # xwaylandvideobridge

    # Screenshot + extra utils
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
    wl-clipboard # Enables copy/paste on wayland
    # hyprpicker # Color picker for hyprland

    # Gaming
    # gnutls
    minecraft
    # libpulseaudio

    # Audio/Music
    spotify
    easyeffects
    pavucontrol
  ];
}
