{
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    ./nix-settings.nix
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
  ];

  nihonConfig = {
    gaming.enable = true;
    plymouth.enable = false;
  };
}
