{
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    ./nix-settings.nix
    ./hardware-configuration.nix
    ./system.nix
    ./modules/network.nix
    ./modules/input.nix
    ./modules/bootloader.nix
    ./modules/system-packages.nix
    ./modules/logind.nix
    ./modules/graphical-env.nix
    ./modules/shell.nix
    ./modules/virtualization.nix
    ./modules/users.nix
  ];

  nihonConfig = {
    gaming.enable = true;
  };
}
