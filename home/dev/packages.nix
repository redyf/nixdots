{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Compilers/Development

    # go # Programming language
    gcc # GNU Compiler Collection
    lua
    deno
    jdk8
    dart
    cargo
    cmake
    nodejs
    gnumake
    beautysh # Shell formatter
    gnupatch

    # Clojure packages
    clojure # Clojure programming language
    babashka # Native, fast starting Clojure interpreter for scripting
    leiningen # Project automation for Clojure
    clojure-lsp # Language server protocol for Clojure
    clj-kondo # Linter for Clojure
    rlwrap # Clojure dependency
    zprint # Clojure formatter

    # Design
    figma-linux

    # Elixir packages
    elixir_1_14 # Elixir language
    elixir_ls

    # C/C++ Packages
    astyle # Source code indenter, formatter, and beautifier for C, C++, C# and Java
    cpplint # Static code checker for C/C++
    clang-tools # Standalone command line tools for C++ development
    # uncrustify # Source code beautifier for C, C++, C#, ObjectiveC, D, Java, Pawn and VALA

    # Nix Packages
    alejandra # Nix formatter written in Rust
    statix # Lints and suggestions for the nix programming language
    nil # Nix LSP
    nix-init # Command line tool to generate Nix packages from URLs
    nix-prefetch-git # Script used to obtain source hashes for fetchgit

    # NPM packages
    node2nix
    nodePackages.npm # Package manager
    nodePackages.live-server # Live server
    nodePackages_latest.eslint_d # JS linter
    nodePackages_latest.prettier # Formatter
    nodePackages_latest.tailwindcss

    # Lua packages
    stylua # Lua formatter
    selene # Lua linter written in rust
    luaformatter # Lua formatter (currently using this one)
    lua-language-server # Lua LSP
    luajitPackages.luacheck # Lua linter
    luajitPackages.luarocks-nix # Package manager for Lua on Nix

    # Go packages
    # gopls

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
    betterdiscordctl
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
    # betterdiscordctl
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
