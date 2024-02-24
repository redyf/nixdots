{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Dev
    poetry
    # httpie
    # postman
    # openssl
    # postgresql
    # beekeeper-studio
    # mysql-workbench
    # logisim

    # Design
    # figma-linux

    # Modeling
    # dia

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
    ffmpeg
    # img2pdf # Convert images to pdf
    findutils
    # flameshot
    traceroute
    tree-sitter # A parser generator tool and an incremental parsing library
    # appimage-run # Run appimage files in the terminal
    polkit_gnome
    networkmanager
    cinnamon.nemo

    # Terminal && prompt
    nerdfix # Helps you find/fix obsolete Nerd font icons
    lazygit # Amazing CLI git tool

    # Text Editors/IDEs
    # vscode
    # neovide # Gui neovim editor with cool animations

    # Anime/Manga
    ani-cli # A cli tool to browse and play anime
    mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats
  ];
}
