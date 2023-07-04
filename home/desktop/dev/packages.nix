{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Design
    figma-linux

    # Game dev
    # unityhub

    # System Utils
    fd
    jq
    exa
    zig
    fzf
    mpd
    mpv
    # glib # C library of programming buildings blocks
    # glibc
    file
    fuse
    tree
    peek
    jp2a
    light # GNU/Linux application to control backlights
    xclip
    chafa # Transform images into colorful ascii (works with gifs too)
    unzip # Unzip files using the terminal
    img2pdf # Convert images to pdf
    # lazygit # Amazing CLI git tool
    ripgrep
    findutils
    # flameshot
    tree-sitter # A parser generator tool and an incremental parsing library
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    networkmanager
    # gobject-introspection # A middleware layer between C libraries and language bindings

    # Terminal && prompt
    nerdfix # Helps you find/fix obsolete Nerd font icons

    # Text Editors
    emacs
    neovide # Gui neovim editor with cool animations

    # Browser, vc, pdf
    # google-chrome
    discord
    zathura

    # Rice
    swww # Cool wallpapers/gifs transitions
    dunst # Notifications for your system
    # sxhkd # BSPWM keybindings
    bemenu # Dmenu for wayland
    cmatrix
    # polybar # Bar i use on X11
    nitrogen # Wallpaper utility for X11
    picom-next # Compositor for X11
    # eww-wayland # Cool widgets for wayland
    xfce.thunar # File manager
    lxappearance # Gui software to change icons/themes
    # brightnessctl
    xfce.thunar-archive-plugin # Plugin que habilita compressão e extração de arquivos no Thunar

    # Streaming/screenshot
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_5 # A complete, cross-platform solution to record, convert and stream audio and video
    obs-studio # Livestreams
    wl-clipboard # Enables copy/paste on wayland

    # Gaming
    # grapejuice
    # gnutls
    # libpulseaudio
    minecraft
    # logmein-hamachi # A hosted VPN service that lets you securely extend LAN-like networks to distributed teams
    steam

    # Others
    spotify
    obsidian
    pavucontrol
  ];
}
