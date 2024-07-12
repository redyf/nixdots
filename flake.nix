{
  description = "Redyf's Flake";

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
                extraSpecialArgs = {inherit inputs disko;};
                users.redyf = ./home/redyf/home.nix;
                backupFileExtension = "backup";
              };
            }
            stylix.nixosModules.stylix
            hyprland.nixosModules.default
            disko.nixosModules.disko
          ];
        };
      # nix build '.#nixosConfigurations.selene.config.system.build.sdImage' to build the image for the raspberry-pi
      selene = nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/selene/configuration.nix
          raspberry-pi-nix.nixosModules.raspberry-pi
        ];
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
