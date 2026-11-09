{ ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/67f7d058-3f62-4ae4-a24a-a3ce08489a96";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/328E-3D2D";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/debee905-2da4-4fe7-a007-c53188ee9a8c";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=4"
      "x-systemd.automount" # mount on first access, don't wait for it during boot
    ];
  };

  boot.resumeDevice = "/dev/disk/by-uuid/67f7d058-3f62-4ae4-a24a-a3ce08489a96";
  swapDevices = [
    {
      device = "/.swapfile";
      size = 18 * 1024;
    }
  ];
}
