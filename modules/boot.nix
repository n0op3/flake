{
  config,
  lib,
  pkgs,
  ...
}:
{
  # No backlight restoration
  systemd.services."systemd-backlight@".enable = false;

  boot = lib.mkMerge [
    {
      kernelPackages = pkgs.linuxPackages_7_2;

      kernel.sysctl = {
        "kernel.sysrq" = 1;
        "kernel.panic" = 10;
        "kernel.panic_on_oops" = 1;
      };

      initrd = {
        systemd.enable = true;
        checkJournalingFS = false;
      };

      loader = {
        timeout = 0;

        systemd-boot.enable = true;

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
      };
    }
    (lib.mkIf config.nihonConfig.plymouth.enable {
      # Silent boot
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
        "vt.global_cursor_default=0"
        "systemd.unit=graphical.target"
      ];

      plymouth = {
        enable = true;
        theme = "mac-style";
        themePackages = [ pkgs.mac-style-plymouth ];
      };
    })
  ];
}
