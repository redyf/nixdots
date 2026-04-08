{
  description = "Redyf's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Neve = {
      url = "github:redyf/Neve";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvibrant = {
      url = "github:mikaeladev/nix-nvibrant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
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
          ++ nixpkgs.lib.optionals (builtins.pathExists ./hosts/${hostname}/disko.nix) [
            inputs.disko.nixosModules.disko
            ./hosts/${hostname}/disko.nix
          ]
          ++ modules;
        };

      createHome =
        {
          system,
          username,
          homeDirectory,
          homeModule,
          stateVersion ? "25.05",
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit
              inputs
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
                inherit username stateVersion homeDirectory;
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
            inputs.hyprland.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.sops-nix.nixosModules.sops
          ];
        };
        selene = createNixosConfiguration {
          system = "x86_64-linux";
          username = "selene";
          hostname = "selene";
          modules = [
            inputs.hyprland.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.sops-nix.nixosModules.sops
          ];
        };
      };
      homeConfigurations = {
        "redyf" = createHome {
          system = "x86_64-linux";
          username = "redyf";
          homeDirectory = "/home/redyf";
          homeModule = ./home/home.nix;
          stateVersion = "25.05";
          modules = [ inputs.stylix.homeModules.stylix ];
        };
        "selene" = createHome {
          system = "x86_64-linux";
          username = "selene";
          homeDirectory = "/home/selene";
          homeModule = ./home/selene.nix;
          stateVersion = "25.05";
          modules = [ inputs.stylix.homeModules.stylix ];
        };
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
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
