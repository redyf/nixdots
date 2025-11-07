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
    # font-flake.url = "github:redyf/font-flake";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    nix-topology.url = "github:oddlama/nix-topology";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
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
      nix-topology,
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
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ nix-topology.overlays.default ];
        }
      );

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
          homeManagerConfig ? ./home/home.nix,
        }:
        nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              hyprland
              disko
              nix-topology
              ;
            inherit username homeDirectory hostname;
          };
          modules = [
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
                    users."${username}" = import homeManagerConfig {
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
          ]
          ++ modules;
        };
    in
    {
      nixosConfigurations = {
        desktop = createNixosConfiguration {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          hostname = "desktop";
          homeManagerConfig = ./home/home.nix;
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            nix-topology.nixosModules.default
            stylix.nixosModules.stylix
          ];
        };
        selene = createNixosConfiguration {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          hostname = "selene";
          homeManagerConfig = ./home/selene.nix;
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
            stylix.nixosModules.stylix
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

      topology.x86_64-linux = import nix-topology {
        pkgs = nixpkgsFor.x86_64-linux;
        modules = [
          ./topology-example.nix

          # Informações das suas configurações NixOS existentes
          {
            inherit (self) nixosConfigurations;
          }
        ];
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
