{ ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9bf5522b-489a-40a9-a859-c908c41f9ad7";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8E5B-0723";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/529bbd8c-7656-4238-81eb-d4a69b0e44fe";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=4"
      "x-systemd.automount" # mount on first access, don't wait for it during boot
    ];
  };

  boot.resumeDevice = "/dev/disk/by-uuid/9bf5522b-489a-40a9-a859-c908c41f9ad7";
  swapDevices = [
    {
      device = "/.swapfile";
      size = 18 * 1024;
    }
  ];
}
