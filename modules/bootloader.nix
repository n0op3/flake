{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Silent boot
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [ "quiet" "udev.log_level=3" "systemd.show_status=auto" ];

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        theme = (pkgs.sleek-grub-theme.override { withStyle = "dark"; });
        splashImage = null;
        timeoutStyle = "hidden";
      };

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };
  };
}
