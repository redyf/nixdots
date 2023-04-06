{
  inputs,
  base16,
  config,
  nix-colors,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "redyf";
  home.homeDirectory = "/home/redyf";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Imports

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
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
    (import ~/flake/overlays/firefox-overlay.nix)
  ];

  home.packages = with pkgs; [
    # Text Editors
    neovim
    neovide

    # Neovim packages/plugins
    vimPlugins.presence-nvim

    # Compilers/Development
    gcc # GNU Compiler Collection
    lua
    jdk8
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

    # C/C++ Packages
    astyle # Source code indenter, formatter, and beautifier for C, C++, C# and Java
    cpplint # Static code checker for C/C++
    clang-tools # Standalone command line tools for C++ development
    # uncrustify # Source code beautifier for C, C++, C#, ObjectiveC, D, Java, Pawn and VALA

    # Nix Packages
    alejandra # Nix formatter written in Rust
    statix # Lints and suggestions for the nix programming language
    rnix-lsp # Nix LSP

    # Design
    figma-linux

    #Python/pip packages
    black # Python formatter
    python310Packages.pip
    python3Packages.tqdm
    python3Packages.debugpy
    python310Packages.flake8 # Python linter
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

    # Clojure packages
    babashka # Native, fast starting Clojure interpreter for scripting
    leiningen # Project automation for Clojure
    clojure-lsp # Language server protocol for Clojure

    # Elixir packages
    elixir_ls

    # Other packages for nvim
    shellcheck # Shell script analysis tool

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
    # chafa # Transform images into colorful ascii (works with gifs too)
    unzip
    lazygit # Amazing CLI git tool
    ripgrep
    findutils
    flameshot
    tree-sitter
    appimage-run
    polkit_gnome
    nix-prefetch-git # Script used to obtain source hashes for fetchgit

    # Terminal && prompt
    sl
    zsh
    btop
    kitty
    nitch # Incredibly fast system fetch written in nim
    # pfetch
    # hilbish # An interactive Unix-like shell written in Go
    # wezterm
    starship
    neofetch
    oh-my-zsh

    # Browser, vc, pdf
    # latest.firefox-nightly-bin
    firefox
    discord
    zathura
    google-chrome

    # Rice
    wofi
    swww
    cava
    rofi
    dunst
    sxhkd
    waybar
    cmatrix
    polybar
    nitrogen
    mpvpaper
    hyprpaper
    picom-next
    xfce.thunar
    lxappearance
    brightnessctl
    # betterdiscordctl
    papirus-icon-theme
    xfce.thunar-archive-plugin # Plugin que habilita compressão e extração de arquivos no Thunar

    # Fonts
    dejavu_fonts
    go-font
    nerdfonts
    font-awesome
    noto-fonts
    liberation_ttf
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    font-awesome
    material-design-icons
    powerline-symbols
    powerline-fonts
    cantarell-fonts
    source-code-pro
    nur.repos.oluceps.san-francisco
    (pkgs.nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "UbuntuMono" "Terminus" "FiraCode" "JetBrainsMono" "Hack" "Iosevka"];})

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
    notion-app-enhanced
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
        sha256 = "1gvks0qglmanxn8b84wrf31iihjslf9ic0qqsnd4knwiz5h5w1kz";
      })
      {inherit pkgs;};
  };

  nixpkgs.config.allowUnfreePredicate = pkg: true;

  programs.git = {
    enable = true;
    userName = "Redyf";
    userEmail = "mateusalvespereira7@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
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

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
