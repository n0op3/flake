{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;

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
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        splashImage = null;
        configurationLimit = 16;
        timeoutStyle = "hidden";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 0;
    };

    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };
  };
}
