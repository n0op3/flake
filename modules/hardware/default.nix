{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./power-management.nix
    ./filesystems.nix
    ./graphics.nix
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "v4l2loopback"
    "snd-aloop"
    "legion-laptop"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
    lenovo-legion-module
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="hwmon", ATTR{name}=="legion_hwmon", RUN+="${pkgs.coreutils}/bin/chmod -R a+rw /sys%p"
  '';

  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  boot.kernelParams = [ "resume_offset=13740032" ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
