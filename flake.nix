{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-wine10.url = "github:NixOS/nixpkgs?rev=5e80541a726e08ddbf5f6922d2389891a8c299db";

    musnix.url = "github:musnix/musnix";
    catppuccin.url = "github:catppuccin/nix";
    millenium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    concord.url = "github:chojs23/concord";
    hiresTi.url = "github:yelanxin/hiresTI";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      musnix,
      zen-browser,
      blender-bin,
      catppuccin,
      mcsr-nixos,
      aagl,
      ...
    }@inputs:
    let
      system = {
        arch = "x86_64-linux";
        hostname = "shinjuku";
      };
      settings = rec {
        username = "n0op3";
        homeDirectory = "/home/${username}";
      };
    in
    {
      nixosConfigurations.${system.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            system
            settings
            inputs
            mcsr-nixos
            ;
        };
        modules = [
          ./modules/options.nix
          ./cachix.nix
          ./configuration.nix
          ./modules/cleanup.nix
          ./modules/domains/system.nix
          ./modules/desktop/system.nix

          catppuccin.nixosModules.catppuccin

          {
            nixpkgs.overlays = with inputs; [
              mac-style-plymouth.overlays.default
              millenium.overlays.default
            ];
          }

          home-manager.nixosModules.home-manager
          (
            { config, ... }:
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  settings
                  mcsr-nixos
                  system
                  ;
                nihonConfig = config.nihonConfig;
              };
              home-manager.users.${settings.username} = {
                imports = [
                  ./home.nix
                  ./modules/domains/home.nix
                  ./modules/desktop/home.nix
                  ./modules/home-manager/opencode-workaround.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
          )
        ];
      };
    };
}
