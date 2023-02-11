{
  description = "Redyf's nixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    waybar.url = "github:alexays/Waybar";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    
    # Games

    # Theming
    base16 = {
      url = "github:shaunsingh/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-oxocarbon = {
      url = "github:nyoom-engineering/base16-oxocarbon";
      flake = false;
    };

    # SFMono w/patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... }@inputs: {
    nixosConfigurations = {
      redyf = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs hyprland; };
        modules = [
          ./nixos/configuration.nix
          hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "redyf@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
