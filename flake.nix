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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Neve.url = "github:redyf/Neve";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      hyprland,
      home-manager,
      disko,
      stylix,
      lanzaboote,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      # Stable Nixpkgs instantiated for supported system types.
      nixpkgsStableFor = forAllSystems (system: import nixpkgs-stable { inherit system; });

      # Function to create a nixosConfiguration with a dynamic username
      createNixosConfiguration =
        {
          system,
          username,
          homeDirectory,
          hostname ? null,
          modules ? [ ],
          includeHomeManager ? true,
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
          modules =
            [
              ./hosts/${username}/configuration.nix
              { networking.hostName = hostname; }
            ]
            ++ (
              if includeHomeManager then
                [
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useUserPackages = true;
                      useGlobalPkgs = false;
                      extraSpecialArgs = {
                        inherit
                          inputs
                          disko
                          nixpkgs-stable
                          ;
                      };
                      users."${username}" = import ./home/home.nix {
                        inputs = inputs;
                        pkgs = nixpkgsFor."${system}";
                        inherit username homeDirectory;
                      };
                      backupFileExtension = "backup";
                    };
                  }
                ]
              else
                [ ]
            )
            ++ [
              stylix.nixosModules.stylix
            ]
            ++ modules;
        };

      createHomeManagerConfiguration =
        {
          system,
          username,
          homeDirectory,
          stateVersion ? "22.11",
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs hyprland;
            inherit username homeDirectory stateVersion;
          };
          pkgs = nixpkgsFor."${system}";
          modules = [
            ./home/rpi.nix
            {
              home = {
                username = username;
                homeDirectory = homeDirectory;
                stateVersion = stateVersion;
              };
            }
          ] ++ modules;
        };
    in
    {
      nixosConfigurations = {
        desktop = createNixosConfiguration {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          hostname = "desktop";
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };

      homeConfigurations = {
        "redyf" = createHomeManagerConfiguration {
          system = "aarch64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          stateVersion = "22.11";
          modules = [ ];
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
