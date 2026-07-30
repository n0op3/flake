{ ... }: {
  time.timeZone = "Europe/Warsaw";

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
