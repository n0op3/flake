{ config, pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.new_feature;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/igpu:/dev/dri/dgpu";

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", KERNELS=="0000:00:02.0", SYMLINK+="dri/igpu"
    SUBSYSTEM=="drm", KERNEL=="card*", KERNELS=="0000:01:00.0", SYMLINK+="dri/dgpu"
  '';

  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0
    options v4l2loopback devices=2 video_nr=1,10 card_label="OBS Cam,droidcam" exclusive_caps=1,1
  '';

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
}
