{
  inputs,
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    ./modules/nix
    ./hardware-configuration.nix
    ./system.nix
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
    inputs.catppuccin.nixosModules.catppuccin
  ];

  nihonConfig = {
    gaming.enable = true;
    plymouth.enable = false;
  };
}
