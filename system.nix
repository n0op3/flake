{ pkgs, ... }: {
  time.timeZone = "Europe/Warsaw";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.panic" = 10;
    "kernel.panic_on_oops" = 1;
  };

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true; # Allow running AppImages just by supplying their path
  };

  services = {
    envfs.enable = true;
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;

    tlp = {
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

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    journald.extraConfig = ''
      SystemMaxUse=1G
      MaxRetentionSec=1week
    '';

    earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    openssh = {
      enable = true;
      ports = [ 2248 ];
      openFirewall = true;
      settings.PasswordAuthentication = true;
    };

    locate = {
      enable = true;
      interval = "never";
    };
  };
}
