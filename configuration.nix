{ pkgs, ... }:
{
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ./modules/bootloader.nix
    ./modules/system-packages.nix
    ./modules/logind.nix
    ./modules/graphical-env.nix
    ./modules/shell.nix
    ./modules/users.nix
  ];

  services.udev.packages = with pkgs; [
    vial
    qmk-udev-rules
  ];
  services.tlp.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      laptop = {
        ids = [ "048d:c100:16f6bb0a" ];
        settings = {
          main = {
            capslock = "overload(meta, esc)";
            esc = "capslock";
          };
          alt = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };
  };

  services.locate = {
    enable = true;
    interval = "never";
  };

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  networking.firewall = rec {
    enable = true;
    checkReversePath = "loose";

    # Yeelight Station
    allowedUDPPorts = [ 1982 ];

    allowedTCPPortRanges = [
      {
        # KDE Connect
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  time.timeZone = "Europe/Warsaw";

  programs.appimage = {
    enable = true;
    binfmt = true; # Allow running AppImages just by supplying their path
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # Any missing dynamic libraries for unpackaged programs
    # go here, NOT in environment.systemPackages
  ];
}
