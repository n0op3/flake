{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    musnix.url = "github:musnix/musnix";

    home-manager = {
      url = "github:nix-community/home-manager/f2d3e04e278422c7379e067e323734f3e8c585a7";
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

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
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

    millenium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    catppuccin.url = "github:catppuccin/nix";
    nixpkgs-wine10.url = "github:NixOS/nixpkgs?rev=5e80541a726e08ddbf5f6922d2389891a8c299db";
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
      silentSDDM,
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
          inherit system;
          inherit settings;
          inherit inputs;
          inherit mcsr-nixos;
        };
        modules = [
          ./configuration.nix
          ./modules/mcsr/waywall.nix
          ./modules/music.nix
          catppuccin.nixosModules.catppuccin
          silentSDDM.nixosModules.default
          mcsr-nixos.nixosModules.waywall
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
          }
          musnix.nixosModules.musnix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit mcsr-nixos;
              inherit system;
            };
            home-manager.users.${settings.username} = {
              imports = [
                ./home.nix
                ./modules/hyprland.nix
                ./modules/games.nix
                ./modules/engineering.nix
                ./modules/dev.nix
                ./modules/gamedev.nix
                ./modules/graphics-design.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }

          {
            nixpkgs.overlays = with inputs; [
              mac-style-plymouth.overlays.default
              millenium.overlays.default
            ];
          }
        ];
      };
    };
}
