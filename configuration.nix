{ pkgs, system, ... }:
{
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ./modules/bootloader.nix
    ./modules/system-packages.nix
    ./modules/logind.nix
    ./modules/graphical-env.nix
    ./modules/shell.nix
    ./modules/virtualization.nix
    ./modules/users.nix
    ./modules/vr.nix
  ];

  nix.settings = {
    cores = 2;
    max-jobs = 5;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "googleearth-pro-7.3.6.10201"
      "openssl-1.1.1w"
    ];
  };

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.panic" = 10;
    "kernel.panic_on_oops" = 1;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=1G
    MaxRetentionSec=1week
  '';

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 2248 ];
    openFirewall = true;
    settings.PasswordAuthentication = true;
  };

  services.udev.packages = with pkgs; [
    vial
    qmk-udev-rules
  ];

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  services.keyd = {
    enable = true;
    keyboards = {
      laptop = {
        ids = [ "048d:c100:5d4326cd" ];
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
            s = "prevsong";
            d = "playpause";
            f = "nextsong";
          };
        };
      };
    };
  };

  services.pipewire.enable = true;

  services.envfs.enable = true;

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

  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0 power_level=0
    options iwlmvm power_scheme=1
    options iwlmvm bt_coex_active=1
  '';

  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = "${system.hostname}";

    networkmanager = {
      enable = true;
      dns = "none";
      ethernet.macAddress = "permanent";
      wifi = {
        macAddress = "permanent";
        scanRandMacAddress = false;
      };
    };

    nameservers = [
      "1.1.1.1"
    ];

    firewall = rec {
      enable = true;
      checkReversePath = "loose";

      # Minecraft
      allowedTCPPorts = [ 25565 ];

      # Yeelight Station, Minecraft
      allowedUDPPorts = [
        1982
        25565
      ];

      allowedTCPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
        {
          # SimpleX Chat
          from = 30000;
          to = 65535;
        }
        {
          # ALVR
          from = 9943;
          to = 9944;
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
