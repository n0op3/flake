{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-wine10.url = "github:NixOS/nixpkgs?rev=5e80541a726e08ddbf5f6922d2389891a8c299db";

    musnix.url = "github:musnix/musnix";
    catppuccin.url = "github:catppuccin/nix";
    millenium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
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
          inherit system;
          inherit settings;
          inherit inputs;
          inherit mcsr-nixos;
        };
        modules = [
          ./cachix.nix
          ./configuration.nix
          ./modules/mcsr/waywall.nix
          ./modules/music.nix
          ./modules/opentabletdriver.nix
          catppuccin.nixosModules.catppuccin
          musnix.nixosModules.musnix
          mcsr-nixos.nixosModules.waywall
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit settings;
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
                ./modules/osint.nix
                ./modules/messengers.nix
                ./modules/home-manager/opencode-workaround.nix
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
