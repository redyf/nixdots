{ inputs, base16, config, nix-colors, pkgs, ... }:

{
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
  imports = [
    nix-colors.homeManagerModule
  ];

  #   colorScheme = {
  #   slug = "oxocarbon-dark";
  #   name = "Oxocarbon-Dark";
  #   author = "shaunsingh/IBM";
  #   colors = {
  #     base00 = "#161616";
  #     base01 = "#262626";
  #     base02 = "#393939";
  #     base03 = "#525252";
  #     base04 = "#dde1e6";
  #     base05 = "#f2f4f8";
  #     base06 = "#ffffff";
  #     base07 = "#08bdba";
  #     base08 = "#3ddbd9";
  #     base09 = "#78a9ff";
  #     base0A = "#ee5396";
  #     base0B = "#33b1ff";
  #     base0C = "#ff7eb6";
  #     base0D = "#42be65";
  #     base0E = "#be95ff"; 
  #     base0F = "#82cfff";
  #   };
  # };

  # programs = {
  #     kitty = {
  #       enable = true;
  #       settings = {
  #         foreground = "#${config.colorScheme.colors.base05}";
  #         background = "#${config.colorScheme.colors.base00}";
  #         # ...
  #       };

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
    (import ~/flake/overlays/firefox-overlay.nix)
  ];

  # customNeovim = import ./config/nvim/nvim.nix;
  home.packages = with pkgs; [
    # Text Editors
    neovim
    neovide
    vscode

    # Compilers
    gcc
    cargo
    lua
    python3
    cmake
    gnupatch
    gnumake
    nodejs

    # Design
    figma-linux

    #Python/pip packages
    python310Packages.pip
    python3Packages.tqdm
    python310Packages.debugpy

    # NPM packages
    nodePackages.npm
    nodePackages.live-server

    # System Utils	
    fd
    jq
    git
    exa
    zig
    fzf
    mpd
    wget
    fuse
    tree
    peek
    unzip
    lazygit
    ripgrep
    flameshot
    appimage-run
    polkit_gnome

    # Terminal && prompt	
    sl
    zsh
    htop
    kitty
    pfetch
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
    lxappearance
    papirus-icon-theme
    brightnessctl
    xfce.thunar
    xfce.thunar-archive-plugin # Plugin que habilita compressão e extração de arquivos no Thunar
    dunst
    nitrogen
    cava
    rofi
    polybar
    picom-next
    cmatrix
    sxhkd
    wofi
    hyprpaper
    waybar

    # Fonts
    dejavu_fonts
    go-font
    nerdfonts
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    jetbrains-mono
    font-awesome
    material-design-icons
    powerline-symbols
    nur.repos.oluceps.san-francisco
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" "CascadiaCode" "UbuntuMono" "Terminus" "FiraCode" "JetBrainsMono" "Hack" "Iosevka" ]; })

    # Streaming/screenshot
    obs-studio
    grim # Screenshot tool for hyprland
    slurp # works with grim to screenshot on wayland
    wl-clipboard # Enables copy/paste on wayland

    # Gaming
    wine
    grapejuice
    gnutls
    libpulseaudio
    minecraft
    steam

    # Others
    spotify
    obsidian
    notion-app-enhanced
    pavucontrol
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    # integrates nur within Home-Manager
    nur = import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        sha256 = "0c6vrlrid5vh759qly3jk6zwrd8c16hpql06qgj7f5iav1bwz4ms";
      })
      { inherit pkgs; };
  };


  nixpkgs.config.allowUnfreePredicate = (pkg: true);

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

  # Other themes: macOS-BigSur-White, macOS-BigSur, macOS-Monterey-White, macOS-Monterey

  fonts.fontconfig.enable = true;

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
