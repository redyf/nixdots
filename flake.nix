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
    # nur.url = "github:nix-community/NUR";

    # git+ssh://git@git.example.com/User/repo.git if you're using private repos
    # berkeley = {
    #   url = "git+ssh://git@github.com/redyf/berkeley.git";
    #   flake = false;
    # };

    # monolisa-script = {
    #   url = "git+ssh://git@github.com/redyf/test2.git";
    #   flake = false;
    # };
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
    basic-config = {
      pkgs,
      lib,
      ...
    }: {
      users.users.root.initialPassword = "root";
      networking = {
        hostName = "raspberry";
        firewall.enable = false;
        wireless = {
          enable = true;
        };
      };
      environment.systemPackages = with pkgs; [bluez bluez-tools neovim git];
      nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
      };
      time.timeZone = "America/Bahia";
      console = {keyMap = "br-abnt2";};
      i18n = {
        defaultLocale = "pt_BR.UTF-8";
      };
      hardware = {
        bluetooth.enable = true;
        raspberry-pi = {
          config = {
            all = {
              base-dt-params = {
                # enable autoprobing of bluetooth driver
                # https://github.com/raspberrypi/linux/blob/c8c99191e1419062ac8b668956d19e788865912a/arch/arm/boot/dts/overlays/README#L222-L224
                krnbt = {
                  enable = true;
                  value = "on";
                };
              };
            };
          };
        };
      };
    };
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
      # nix build '.#nixosConfigurations.selene.config.system.build.sdImage'
      selene = nixosSystem {
        system = "aarch64-linux";
        modules = [
	./hosts/selene/configuration.nix
	raspberry-pi-nix.nixosModules.raspberry-pi
	# basic-config
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
