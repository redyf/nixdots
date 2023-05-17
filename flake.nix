{
  description = "Redyf's NixOS config for desktop and laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    hyprland.url = "github:hyprwm/Hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    waybar.url = "github:alexays/Waybar";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , hyprland
    , home-manager
    , utils
    , ...
    } @ inputs: {
      nixosConfigurations = {
        redyf = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs hyprland; };
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = { inherit inputs; };
                users.redyf = ./home-manager/home.nix;
              };
            }
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
          ];
        };
      };
    };
}
