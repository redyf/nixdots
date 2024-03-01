{
  description = "Redyf's Flake";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-wsl = {
    #   url = "github:nix-community/nixos-wsl";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    manix = {
      url = "github:nix-community/manix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Neve.url = "github:redyf/Neve";
    disko.url = "github:nix-community/disko";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";

    nix-ld-rs.url = "github:nix-community/nix-ld-rs";

    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    Monolisa = {
      url = "github:lauer3912/Monolisa";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    # nixos-wsl,
    spicetify-nix,
    disko,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    nixosConfigurations = {
      redyf =
        nixpkgs.lib.nixosSystem
        {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hyprland
              spicetify-nix
              disko
              ;
          };
          modules = [
            ./hosts/redyf/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {inherit inputs spicetify-nix disko;};
                users.redyf = ./home/desktop/home.nix;
              };
            }
            hyprland.nixosModules.default
            {programs.hyprland.enable = true;}
            disko.nixosModules.disko
          ];
        };
      # wsl = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     {nix.registry.nixpkgs.flake = nixpkgs;}
      #     ./hosts/wsl/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager = {
      #         useUserPackages = true;
      #         useGlobalPkgs = false;
      #         users.red = ./home/wsl/home.nix;
      #       };
      #     }
      #     nixos-wsl.nixosModules.wsl
      #   ];
      # };
      # testing = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/testing/configuration.nix
      #     home-manager.nixosModules.home-manager
      #   ];
      # };
      # vm = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/vm/configuration.nix
      #     home-manager.nixosModules.home-manager
      #   ];
      # };
    };
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          alejandra
          statix
        ];
      };
    });
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
