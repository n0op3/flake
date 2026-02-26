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

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "/run/current-system/sw/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  services.flatpak.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = "nixos-btw";

    networkmanager = {
      enable = true;
      dns = "none";
    };

    nameservers = [
      "1.1.1.3"
      "1.0.0.3"
      "1.1.1.1"
    ];

    firewall = rec {
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
  };

  time.timeZone = "Europe/Warsaw";

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture # Game capture on Wayland
      wlrobs # Wayland window capture
    ];
  };

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
