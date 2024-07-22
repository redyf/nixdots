{
  description = "Redyf's Flake";

  nixConfig = {
    extra-substituters = ["https://raspberry-pi-nix.cachix.org"];
    extra-trusted-public-keys = [
      "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    raspberry-pi-nix.url = "github:tstat/raspberry-pi-nix";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    disko.url = "github:nix-community/disko";
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    font-flake.url = "github:redyf/font-flake";
    # waybar-hyprland.url = "github:hyprwm/hyprland";
    # Neve.url = "github:redyf/Neve";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    disko,
    stylix,
    font-flake,
    raspberry-pi-nix,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) nixosSystem;
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});

    # Function to create a nixosConfiguration with a dynamic username
    createNixosConfiguration = {
      system,
      username,
      homeDirectory,
      hostname ? null,
    }:
      nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            inputs
            hyprland
            disko
            ;
          inherit username homeDirectory hostname;
        };
        modules = [
          ./hosts/${username}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = false;
              extraSpecialArgs = {inherit inputs disko;};
              users."${username}" = import ./home/home.nix {
                inputs = inputs;
                pkgs = nixpkgsFor."${system}";
                inherit username homeDirectory;
              }; # Use the username dynamically
              backupFileExtension = "backup";
            };
          }
          stylix.nixosModules.stylix
          hyprland.nixosModules.default
          disko.nixosModules.disko
          {networking.hostName = hostname;}
        ];
      };

    createHomeManagerConfiguration = {
      system,
      username,
      homeDirectory,
      stateVersion ? "22.11",
    }:
      home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit
            inputs
            hyprland
            ;
          inherit username homeDirectory stateVersion;
        };
        pkgs = nixpkgsFor."${system}";
        modules = [
          ./home/home.nix
          {
            home = {
              username = username;
              homeDirectory = homeDirectory;
              stateVersion = stateVersion;
            };
          }
          stylix.homeManagerModules.stylix
          hyprland.homeManagerModules.default
        ];
      };
  in {
    nixosConfigurations = {
      desktop = createNixosConfiguration {
        system = "x86_64-linux";
        username = "redyf";
        homeDirectory = "/home/redyf";
        hostname = "desktop";
      };
      rpi5 = createNixosConfiguration {
        system = "aarch64-linux";
        username = "sonja";
        homeDirectory = "/home/sonja";
        hostname = "rpi5";
      };
    };

    homeConfigurations = {
      "selene" = createHomeManagerConfiguration {
        system = "aarch64-linux";
        username = "selene";
        homeDirectory = "/home/selene";
        stateVersion = "22.11";
      };
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
