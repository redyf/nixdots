{ inputs
, config
, pkgs
, ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "redyf";
  home.homeDirectory = "/home/redyf";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Overlays
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          };
        }
      );
    })
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
    # (import (builtins.fetchTarball {
    #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    # }))
    # (import ~/flake/overlays/firefox-overlay.nix)
    # (import ~/flake/pkgs/xwaylandvideobridge.nix)
  ];

  home.packages = with pkgs; [
    # Compilers/Development
    # go # Programming language
    gcc # GNU Compiler Collection
    lua
    jdk8
    dart
    cargo
    cmake
    rlwrap # Clojure dependency
    nodejs
    zprint # Clojure formatter
    clojure
    gnumake
    python3
    beautysh # Shell formatter
    gnupatch
    clj-kondo # Linter for Clojure
    elixir_1_14 # Elixir language

    # Clojure packages
    babashka # Native, fast starting Clojure interpreter for scripting
    leiningen # Project automation for Clojure
    clojure-lsp # Language server protocol for Clojure

    # Design
    figma-linux

    # Elixir packages
    elixir_ls

    # C/C++ Packages
    astyle # Source code indenter, formatter, and beautifier for C, C++, C# and Java
    cpplint # Static code checker for C/C++
    clang-tools # Standalone command line tools for C++ development
    # uncrustify # Source code beautifier for C, C++, C#, ObjectiveC, D, Java, Pawn and VALA

    # Nix Packages
    alejandra # Nix formatter written in Rust
    statix # Lints and suggestions for the nix programming language
    rnix-lsp # Nix LSP

    #Python/pip packages
    black # Python formatter
    python310Packages.pip
    python3Packages.tqdm
    python310Packages.debugpy
    python310Packages.flake8 # Python linter
    python310Packages.img2pdf
    python3Packages.ascii-magic
    python310Packages.pygobject3

    # NPM packages
    nodePackages.npm # Package manager
    nodePackages.live-server # Live server
    nodePackages_latest.eslint_d # JS linter
    nodePackages_latest.prettier # Formatter

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
    git
    exa
    zig
    fzf
    mpd
    mpv
    wget
    file
    fuse
    tree
    peek
    jp2a
    xclip
    # chafa # Transform images into colorful ascii (works with gifs too)
    unzip # Unzip files using the terminal
    lolcat
    figlet # Program for making large letters out of ordinary text
    img2pdf # Convert images to pdf
    lazygit # Amazing CLI git tool
    ripgrep
    findutils
    flameshot
    tree-sitter
    appimage-run # Run appimage files in the terminal
    polkit_gnome
    networkmanager
    nix-prefetch-git # Script used to obtain source hashes for fetchgit

    # Terminal && prompt
    sl
    zsh # Best Shell
    btop
    foot # Great terminal for wayland
    kitty # My favorite terminal
    nitch # Incredibly fast system fetch written in nim
    pfetch
    # hilbish # An interactive Unix-like shell written in Go
    starship # Customizable shell i use with zsh
    neofetch
    alacritty
    oh-my-zsh

    # Text Editors
    neovim
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
    google-chrome

    # Rice
    wofi
    swww # Cool wallpapers/gifs transitions
    cava
    rofi
    dunst # Notifications for your system
    sxhkd # BSPWM keybindings
    waybar # Best bar for wayland
    cmatrix
    polybar # Bar i use on X11
    nitrogen # Wallpaper utility for X11
    picom-next # Compositor for X11
    eww-wayland # Cool widgets for wayland
    xfce.thunar # File manager
    lxappearance # Gui software to change icons/themes
    brightnessctl
    # betterdiscordctl
    papirus-icon-theme
    xfce.thunar-archive-plugin # Plugin que habilita compressão e extração de arquivos no Thunar

    # Fonts
    go-font
    nerdfix # Helps you find/fix obsolete Nerd font icons
    nerdfonts
    noto-fonts
    dejavu_fonts
    font-awesome
    maple-mono-NF # Nerd fonts version
    liberation_ttf
    powerline-fonts
    cantarell-fonts
    source-code-pro
    fira-code-symbols
    powerline-symbols
    material-design-icons
    nur.repos.oluceps.san-francisco
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" "CascadiaCode" "UbuntuMono" "Terminus" "FiraCode" "JetBrainsMono" "Hack" "Iosevka" ]; })

    # Streaming/screenshot
    grim # Screenshot tool for hyprland
    slurp # Works with grim to screenshot on wayland
    ffmpeg_5 # A complete, cross-platform solution to record, convert and stream audio and video
    obs-studio # Livestreams
    wl-clipboard # Enables copy/paste on wayland
    davinci-resolve # Video editing

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

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    # integrates nur within Home-Manager
    nur =
      import
        (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
          sha256 = "0z3m4m499bxwpiq8dmn7myxrzifjkwg8jx18qk55w1fbxqds0j4j";
        })
        { inherit pkgs; };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: true;

  programs.git = {
    enable = true;
    userName = "Redyf";
    userEmail = "mateusalvespereira7@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
    };
    theme = {
      name = "whitesur-gtk-theme";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
    };
  };

  fonts.fontconfig.enable = true;

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
