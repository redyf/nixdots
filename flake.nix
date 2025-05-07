{
  description = "Redyf's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    disko.url = "github:nix-community/disko";
    stylix.url = "github:danth/stylix";
    font-flake.url = "github:redyf/font-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    Neve.url = "github:redyf/Neve";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      hyprland,
      disko,
      stylix,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      # Helper function to generate packages for all supported systems
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported systems
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      # Function to create a NixOS configuration
      mkNixosConfig =
        {
          system,
          username,
          homeDirectory,
          hostname,
          modules ? [ ],
          homeModule ? null,
        }:
        let
          # Base modules for all NixOS configurations
          baseModules = [
            ./hosts/${username}/configuration.nix
            { networking.hostName = hostname; }
            stylix.nixosModules.stylix
          ];

          # Home Manager module, included only if homeModule is provided
          homeManagerModule = [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {
                  inherit
                    inputs
                    nixpkgs-stable
                    username
                    homeDirectory
                    ;
                };
                users.${username} = homeModule;
                backupFileExtension = "backup";
              };
            }
          ];

          # Combine modules: base modules, user-provided modules, and Home Manager (if enabled)
          allModules = baseModules ++ modules ++ (if homeModule != null then homeManagerModule else [ ]);
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              username
              homeDirectory
              hostname
              ;
          };
          modules = allModules;
        };

      # Function to create a standalone Home Manager configuration
      mkHomeConfig =
        {
          system,
          username,
          homeDirectory,
          stateVersion,
          homeModule,
          modules ? [ ],
        }:
        let
          # Base modules for Home Manager configuration
          baseHomeModules = [
            homeModule
            {
              home = {
                inherit username homeDirectory stateVersion;
              };
            }
          ];

          # Combine base modules with additional user-provided modules
          allHomeModules = baseHomeModules ++ modules;
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgsFor.${system};
          extraSpecialArgs = {
            inherit
              inputs
              username
              homeDirectory
              stateVersion
              ;
          };
          modules = allHomeModules;
        };
    in
    {
      nixosConfigurations = {
        desktop = mkNixosConfig {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          hostname = "desktop";
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
          ];
          homeModule = ./home/home.nix;
        };
      };

      homeConfigurations = {
        "redyf" = mkHomeConfig {
          system = "aarch64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          stateVersion = "22.11";
          homeModule = ./home/home.nix;
          modules = [ ]; # Add modules here, e.g., [ inputs.nixvim.homeManagerModules.nixvim ]
        };
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              nixfmt-rfc-style
              statix
            ];
          };
        }
      );

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
