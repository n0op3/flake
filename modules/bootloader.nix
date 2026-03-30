{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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

    loader = {
      timeout = 0;

      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 8;
      # };

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        timeoutStyle = "hidden";
        splashImage = null;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };
  };
}
