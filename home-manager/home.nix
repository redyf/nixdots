{ config, pkgs, ... }:

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

  # customNeovim = import ./config/nvim/nvim.nix;
  home.packages = with pkgs; [
  # Text Editors/Editing/Compiler 
    neovim 
    neovide
  	gcc
    python
  	cargo
  	lua
  	python3
    cmake
    gnupatch
    gnumake
    nodejs
    nodePackages.npm
    nodePackages.live-server
  
  # System Utils	
    fd
  	git
  	exa
  	wget
  	fuse
  	tree
  	ripgrep
  	appimage-run
  	unzip
  	polkit_gnome
  	flameshot
    jq

  # Terminal && prompt	
	  kitty
	  starship
	  pfetch
  	htop
    zsh
  	sl
    oh-my-zsh
    neofetch

  # Browser, vc, pdf
	  firefox	
	  discord
	  zathura
	
  # Rice
  	lxappearance
	  papirus-icon-theme
	  brightnessctl
  	xfce.thunar
  	dunst
  	nitrogen
  	cava
  	rofi
  	polybar
  	picom-next
    cmatrix
    sxhkd
    wofi
    waybar
    hyprpaper

  # Xdg

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
    (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" "Terminus" "CascadiaCode" "FiraCode" "JetBrainsMono" "Hack" "Iosevka" ]; })

  # Streaming/screenshot
    obs-studio
    grim # Screenshot tool for hyprland
    slurp # works with grim to screenshot on wayland

  # Others
  	steam
  	spotify
  	minecraft
  	notion-app-enhanced  
    pavucontrol
];

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
