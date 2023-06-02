{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Design
    figma-linux

    # System Utils
    fd
    jq
    exa
    zig
    fzf
    mpd
    mpv
    glib # C library of programming buildings blocks
    wget
    file
    fuse
    tree
    peek
    jp2a
    xclip
    chafa # Transform images into colorful ascii (works with gifs too)
    unzip # Unzip files using the terminal
    lolcat
    figlet # Program for making large letters out of ordinary text
    img2pdf # Convert images to pdf
    lazygit # Amazing CLI git tool
    ripgrep
    findutils
    flameshot
    playerctl
    tree-sitter
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    networkmanager
    gobject-introspection # A middleware layer between C libraries and language bindings
    inputs.xwaylandvideobridge.packages.${pkgs.system}.xwaylandvideobridge # Make screensharing work on wayland

    # Terminal && prompt
    sl
    btop
    kitty # My favorite terminal

    # Text Editors
    neovide # Gui neovim editor with cool animations

    # Neovim plugins
    # vimPlugins.null-ls-nvim
    # vimPlugins.neogit # Git tool for neovim
    vimPlugins.presence-nvim

    # Other packages for nvim
    shellcheck # Shell script analysis tool

    # Browser, vc, pdf
    # latest.firefox-nightly-bin
    firefox
    discord
    zathura

    # Rice
    swww # Cool wallpapers/gifs transitions
    dunst # Notifications for your system
    sxhkd # BSPWM keybindings
    cmatrix
    polybar # Bar i use on X11
    nitrogen # Wallpaper utility for X11
    picom-next # Compositor for X11
    eww-wayland # Cool widgets for wayland
    xfce.thunar # File manager
    lxappearance # Gui software to change icons/themes
    brightnessctl
    xfce.thunar-archive-plugin # Plugin que habilita compressão e extração de arquivos no Thunar

    # Streaming/screenshot
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_5 # A complete, cross-platform solution to record, convert and stream audio and video
    obs-studio # Livestreams
    hyprpicker # Color picker for wayland
    wl-clipboard # Enables copy/paste on wayland

    # Gaming
    grapejuice
    gnutls
    libpulseaudio
    minecraft
    logmein-hamachi # A hosted VPN service that lets you securely extend LAN-like networks to distributed teams
    steam

    # Others
    spotify
    obsidian
    pavucontrol
  ];
}
