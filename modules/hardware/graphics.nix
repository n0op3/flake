{ pkgs, ... }: {
  boot.initrd.kernelModules = [ "nvidia" ];

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
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0
  '';

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
}
