{
  pkgs,
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    ./nix-settings.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./network.nix
    ./input.nix
    ./modules/bootloader.nix
    ./modules/system-packages.nix
    ./modules/logind.nix
    ./modules/graphical-env.nix
    ./modules/shell.nix
    ./modules/virtualization.nix
    ./modules/users.nix
    ./modules/vr.nix
  ];

  nihonConfig = {
    gaming.enable = true;
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
      CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";

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

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
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
}
