{ ... }: {
  system.stateVersion = "25.11";

  home-manager.startAsUserService = true;

  imports = [
    ./system.nix
    ./modules/nix
    ./modules/hardware
    ./modules/users.nix
    ./modules/network.nix
    ./modules/input.nix
    ./modules/boot.nix
    ./modules/system-packages.nix
    ./modules/display-manager.nix
    ./modules/shell.nix
    ./modules/virtualization.nix
    ./modules/domains/system.nix
    ./modules/desktop/system.nix
  ];

  documentation = {
    nixos.enable = false;
    doc.enable = false;
    info.enable = false;
  };

  nihonConfig = {
    gaming.enable = true;
    plymouth.enable = false;
  };
}
