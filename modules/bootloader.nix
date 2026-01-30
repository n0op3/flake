{ pkgs, ... }: {
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = (pkgs.sleek-grub-theme.override { withStyle = "dark"; });
    splashImage = null;
    timeoutStyle = "hidden";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
