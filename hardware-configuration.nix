{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6e3f1c13-b2d0-428b-87dd-0d5147cdae3c";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/7088-FFE1";
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
      "x-systemd.automount" # mount on first access
    ];
  };

  swapDevices = [
    {
      device = "/.swapfile";
      size = 18 * 1024;
    }
  ];

  boot.kernelParams = [ "resume_offset=13279232" ];
  boot.resumeDevice = "/dev/disk/by-uuid/6e3f1c13-b2d0-428b-87dd-0d5147cdae3c";
  powerManagement.enable = true;

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0
  '';

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
