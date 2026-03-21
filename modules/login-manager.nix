{ pkgs, settings, ... }:
{
  systemd.services."autologin-tty1" = {
    description = "Auto-fill username on tty1";
    after = [ "getty.target" ];
    requires = [ "getty.target" ];
    serviceConfig = {
      TTYPath = "/dev/tty1";
      ExecStart = ''
        ${pkgs.util-linux}/bin/agetty --skip-login --login-options ${settings.username} --noclear tty1 linux
      '';
      Restart = "always";
      RestartSec = 0;
      StandardInput = "tty";
      StandardOutput = "tty";
      TTYReset = "yes";
      TTYVHangup = "yes";
      TTYVTDisallocate = "yes";
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services."getty@tty1".enable = false;
}
