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
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvibrant = {
      url = "github:mikaeladev/nix-nvibrant";
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

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      nixpkgsStableFor = forAllSystems (system: import nixpkgs-stable { inherit system; });

      createNixosConfiguration =
        {
          system,
          username,
          homeDirectory ? "/home/${username}",
          hostname ? null,
          modules ? [ ],
        }:
        nixosSystem {
          specialArgs = {
            inherit
              inputs
              hyprland
              disko
              username
              homeDirectory
              hostname
              ;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/${hostname}/configuration.nix
            { networking.hostName = hostname; }
          ]
          ++ modules;
        };

      createHome =
        {
          system,
          username,
          homeDirectory,
          homeModule,
          stateVersion ? "22.11",
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit
              inputs
              hyprland
              username
              homeDirectory
              stateVersion
              ;
          };
          pkgs = nixpkgsFor."${system}";
          modules = [
            homeModule
            {
              home = {
                inherit username stateVersion;
                homeDirectory = "/home/${username}";
              };
              programs.home-manager.enable = true;
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
          hostname = "desktop";
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
            stylix.nixosModules.stylix
          ];
        };
        selene = createNixosConfiguration {
          system = "x86_64-linux";
          username = "selene";
          hostname = "selene";
          modules = [
            disko.nixosModules.disko
            hyprland.nixosModules.default
            stylix.nixosModules.stylix
          ];
        };
      };
      homeConfigurations = {
        "redyf" = createHome {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          homeModule = ./home/home.nix;
          stateVersion = "22.11";
          modules = [ stylix.homeModules.stylix ];
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
              nixfmt
              statix
            ];
          };
        }
      );
      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt);
    };
}
