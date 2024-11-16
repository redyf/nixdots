{
  description = "Redyf's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Overlays for rpi5
    raspberry-pi-nix.url = "github:tstat/raspberry-pi-nix";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    disko.url = "github:nix-community/disko";
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
    font-flake.url = "github:redyf/font-flake";
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    zen-browser.url = "github:omarcresp/zen-browser-flake";
    Neve.url = "github:redyf/Neve";
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # waybar-hyprland.url = "github:hyprwm/hyprland";
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
      raspberry-pi-nix,
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
            inherit inputs hyprland disko;
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
                        inherit inputs disko nixpkgs-stable;
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
            ++ [ stylix.nixosModules.stylix ]
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
          ];
        };
        rpi5 = createNixosConfiguration {
          system = "aarch64-linux";
          username = "sonja";
          homeDirectory = "/home/sonja";
          hostname = "rpi5";
          modules = [
            raspberry-pi-nix.nixosModules.raspberry-pi
            hyprland.nixosModules.default
          ];
        };
        minimal-rpi5 = createNixosConfiguration {
          system = "aarch64-linux";
          username = "minimal";
          homeDirectory = "/home/minimal";
          hostname = "minimal";
          includeHomeManager = false;
          modules = [ raspberry-pi-nix.nixosModules.raspberry-pi ];
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
              nixfmt-rfc-classic
              statix
            ];
          };
        }
      );
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-classic;
    };
}
