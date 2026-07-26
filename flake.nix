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
      ...
    }@inputs:
    let
      settings = {
        hostname = "shinjuku";
        username = "n0op3";
      };
    in
    {
      nixosConfigurations.${settings.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs settings;
        };
        modules = [
          ./modules/options.nix
          ./configuration.nix

          home-manager.nixosModules.home-manager
          (
            { config, ... }:
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs settings;
                nihonConfig = config.nihonConfig;
              };
              home-manager.users.${settings.username} = ./home.nix;
            }
          )
        ];
      };
    };
}
