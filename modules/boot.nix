{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Disable timesyncd on startup, launch on graphical.target
  systemd.services.systemd-timesyncd = {
    wantedBy = lib.mkForce [ "graphical.target" ];
    unitConfig = {
      Before = lib.mkForce "";
      After = lib.mkForce "display-manager.service";
    };
  };

  # No backlight restoration
  systemd.services."systemd-backlight@".enable = false;

  boot = lib.mkMerge [
    {
      kernelPackages = pkgs.linuxPackages_latest;

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

        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          timeoutStyle = "hidden";
          splashImage = null;
          configurationLimit = 8;
        };

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
