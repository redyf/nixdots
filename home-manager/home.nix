{ inputs, config, nix-colors, pkgs, ... }:

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

  # Overlays

  nixpkgs.overlays = [ 
  	(self: super: {
		discord = super.discord.overrideAttrs (
			_: { src = builtins.fetchTarball {
			url = "https://discord.com/api/download?platform=linux&format=tar.gz";
			}; }
		);
	})
  (import ~/flake/overlays/firefox-overlay.nix)
];

  
  # customNeovim = import ./config/nvim/nvim.nix;
  home.packages = with pkgs; [
  # Text Editors
    neovim 
    neovide

  # Compiler
  	gcc
    #python
  	cargo
  	lua
  	#python3
    cmake
    gnupatch
    gnumake
    nodejs

  # NPM packages
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
    zig
    fzf
    mpd

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
    latest.firefox-nightly-bin
	  discord
	  zathura
	
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
    (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" "Terminus" "FiraCode" "JetBrainsMono" "Hack" "Iosevka" ]; })

  # Streaming/screenshot
    obs-studio
    grim # Screenshot tool for hyprland
    slurp # works with grim to screenshot on wayland
    wl-clipboard # Enables copy/paste on wayland

  # Others
  	steam
  	spotify
  	minecraft
  	notion-app-enhanced  
    pavucontrol
];

  nixpkgs.config.packageOverrides = pkgs: {
  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0chga5llgczr04varsa5x6fsw319sswjpnfsrijcbwly6rgpzym4";
  }) { inherit pkgs; };
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
