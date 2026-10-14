{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom flakes
    kawaru = {
      url = "github:n0op3/kawaru";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland

    hyprland.url = "github:hyprwm/Hyprland";

    hyprquickframe = {
      url = "github:n0op3/HyprQuickFrame";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # END Hyprland

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millenium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    concord = {
      url = "github:chojs23/concord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    themecord = {
      url = "github:danihek/themecord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hiresTi = {
      url = "github:yelanxin/hiresTI";
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
      url = "github:ezKEa/aagl-gtk-on-nix/main";
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
      system = "x86_64-linux";
      settings = {
        hostname = "shinjuku";
        username = "n0op3";
      };
    in
    {
      nixosConfigurations.${settings.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit
            system
            inputs
            settings
            ;
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
                inherit
                  system
                  inputs
                  settings
                  ;
                nihonConfig = config.nihonConfig;
              };
              home-manager.users.${settings.username} = ./home.nix;
            }
          )
        ];
      };
    };
}
