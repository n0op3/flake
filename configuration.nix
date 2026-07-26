{ ... }: {
  system.stateVersion = "25.11";

  imports = [
    ./system.nix
    ./modules/nix
    ./modules/hardware
    ./modules/users.nix
    ./modules/network.nix
    ./modules/input.nix
    ./modules/bootloader.nix
    ./modules/system-packages.nix
    ./modules/logind.nix
    ./modules/shell.nix
    ./modules/virtualization.nix
    ./modules/desktop/graphical-env.nix
    ./modules/domains/system.nix
    ./modules/desktop/system.nix
  ];

  nihonConfig = {
    gaming.enable = true;
    plymouth.enable = false;
  };
}
